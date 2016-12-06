Received: from eggs.gnu.org ([2001:4830:134:3::10]:33646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQY-0008GE-60
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQV-0000eS-8D
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:06 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEHQV-0000dc-2O
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:03 -0500
Date: Tue, 6 Dec 2016 15:12:29 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20161206151229.7ad5410e@squid.athome>
In-Reply-To: <9b6b35db-c7b1-dad3-980f-bcaa418baaaa@redhat.com>
References: <1478194258-75276-1-git-send-email-julian@codesourcery.com>
	<1478194258-75276-5-git-send-email-julian@codesourcery.com>
	<CAFEAcA9Qj04PR191iaJj0x1YpyJUVtVbVzko0GD3PsNGj6_FVQ@mail.gmail.com>
	<20161103232039.42e2ea11@squid.athome>
	<9b6b35db-c7b1-dad3-980f-bcaa418baaaa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/S3bfDpjc.xN3F+lhSQIonXs"
Subject: Re: [Qemu-devel] [PATCH 4/5] ARM BE32 watchpoint fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

--MP_/S3bfDpjc.xN3F+lhSQIonXs
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 4 Nov 2016 09:55:17 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 04/11/2016 00:20, Julian Brown wrote:
> > On Thu, 3 Nov 2016 23:14:05 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> >> On 3 November 2016 at 17:30, Julian Brown <julian@codesourcery.com>
> >> wrote:  
> >>> In BE32 mode, sub-word size watchpoints can fail to trigger
> >>> because the address of the access is adjusted in the opcode
> >>> helpers before being compared with the watchpoint registers.
> >>> This patch reversed the address adjustment before performing the
> >>> comparison.
> >>>
> >>> Signed-off-by: Julian Brown <julian@codesourcery.com>
> >>> ---
> >>>  exec.c | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/exec.c b/exec.c
> >>> index 4c84389..eadab54 100644
> >>> --- a/exec.c
> >>> +++ b/exec.c
> >>> @@ -2047,6 +2047,19 @@ static void check_watchpoint(int offset,
> >>> int len, MemTxAttrs attrs, int flags) return;
> >>>      }
> >>>      vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
> >>> +#if defined(TARGET_ARM) && !defined(CONFIG_USER_ONLY)
> >>> +    /* In BE32 system mode, target memory is stored byteswapped
> >>> (FIXME:
> >>> +       relative to a little-endian host system), and by the time
> >>> we reach here
> >>> +       (via an opcode helper) the addresses of subword accesses
> >>> have been
> >>> +       adjusted to account for that, which means that watchpoints
> >>> will not
> >>> +       match.  Undo the adjustment here.  */
> >>> +    if (arm_sctlr_b(env)) {
> >>> +        if (len == 1)
> >>> +            vaddr ^= 3;
> >>> +        else if (len == 2)
> >>> +            vaddr ^= 2;
> >>> +    }
> >>> +#endif    
> >>
> >> No target-CPU specific code in exec.c, please...  
> > 
> > Yeah, I'd imagine not. I struggled with this one. Any suggestions
> > for a better way to do this?  
> 
> You can add a function pointer to CPUClass and call it from here.
> It's how cc->debug_check_watchpoint is being called already.

How's this? There's still some grubbiness, but it's mostly confined to
the ARM backend code.

Thanks,

Julian
--MP_/S3bfDpjc.xN3F+lhSQIonXs
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0003-ARM-BE32-watchpoint-fix.patch"

>From 7d9e9ab88060ab05faedff26b24f513e72c4795b Mon Sep 17 00:00:00 2001
From: Julian Brown <julian@codesourcery.com>
Date: Tue, 11 Oct 2016 02:00:40 -0700
Subject: [PATCH 3/4] ARM BE32 watchpoint fix.

In BE32 mode, sub-word size watchpoints can fail to trigger because the
address of the access is adjusted in the opcode helpers before being
compared with the watchpoint registers.  This patch reverses the address
adjustment before performing the comparison with the help of a new CPUClass
hook.
---
 exec.c                 |  1 +
 include/qom/cpu.h      |  1 +
 qom/cpu.c              |  6 ++++++
 target-arm/cpu.c       |  3 +++
 target-arm/internals.h |  5 +++++
 target-arm/op_helper.c | 22 ++++++++++++++++++++++
 6 files changed, 38 insertions(+)

diff --git a/exec.c b/exec.c
index 3d867f1..1c65e22 100644
--- a/exec.c
+++ b/exec.c
@@ -2090,6 +2090,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
         return;
     }
     vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+    vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
             && (wp->flags & flags)) {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 0d18b58..c100ec2 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -195,6 +195,7 @@ typedef struct CPUClass {
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
+    vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
 } CPUClass;
 
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190..9ad07c8 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -383,6 +383,11 @@ static int64_t cpu_common_get_arch_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
+static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
+{
+    return addr;
+}
+
 static void cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -407,6 +412,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     k->cpu_exec_enter = cpu_common_noop;
     k->cpu_exec_exit = cpu_common_noop;
     k->cpu_exec_interrupt = cpu_common_exec_interrupt;
+    k->adjust_watchpoint_address = cpu_adjust_watchpoint_address;
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     /*
diff --git a/target-arm/cpu.c b/target-arm/cpu.c
index 6099d50..a609211 100644
--- a/target-arm/cpu.c
+++ b/target-arm/cpu.c
@@ -1650,6 +1650,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
+#if !defined(CONFIG_USER_ONLY)
+    cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
+#endif
 
     cc->disas_set_info = arm_disas_set_info;
 }
diff --git a/target-arm/internals.h b/target-arm/internals.h
index 3edccd2..132f8d0 100644
--- a/target-arm/internals.h
+++ b/target-arm/internals.h
@@ -437,6 +437,11 @@ void hw_breakpoint_update_all(ARMCPU *cpu);
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
+/* Adjust addresses (in BE32 mode) before testing against watchpoint
+ * addresses.
+ */
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
+
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
diff --git a/target-arm/op_helper.c b/target-arm/op_helper.c
index cd94216..dc92e49 100644
--- a/target-arm/op_helper.c
+++ b/target-arm/op_helper.c
@@ -1216,6 +1216,28 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return check_watchpoints(cpu);
 }
 
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* In BE32 system mode, target memory is stored byteswapped (FIXME:
+     * relative to a little-endian host system), and by the time we reach here
+     * (via an opcode helper) the addresses of subword accesses have been
+     * adjusted to account for that, which means that watchpoints will not
+     * match.  Undo the adjustment here.
+     */
+    if (arm_sctlr_b(env)) {
+        if (len == 1) {
+            addr ^= 3;
+        } else if (len == 2) {
+            addr ^= 2;
+        }
+    }
+
+    return addr;
+}
+
 void arm_debug_excp_handler(CPUState *cs)
 {
     /* Called by core code when a watchpoint or breakpoint fires;
-- 
1.9.1


--MP_/S3bfDpjc.xN3F+lhSQIonXs--
