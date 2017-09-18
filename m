Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtyzF-0001xb-DJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtyzB-0000E9-D3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40400
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtyzB-0000Df-6n
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8IGOaHC128039
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 12:33:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d2ex0upgq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 12:33:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 17:33:26 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 18:33:22 +0200
Message-Id: <20170918163322.206581-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Jing Liu <liujbjl@linux.vnet.ibm.com>

This patch is the s390 implementation of guest crash information, similar
to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") and
the related commits. We will detect several crash reasons, with the
"disabled wait" being the most important one, since this is used by all
s390 guests as a "panic like" notification.

Demonstrate the these ways with examples as follows.

  1. crash-information QOM property;

  Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
  to execute "qom-get" command, and might get the result like,

  (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
  {"return": {"psw_addr": 1105350, "psw_mask": 562956395872256, "reason":
   "disabled wait", "type": "kvm-s390"}}

  2. GUEST_PANICKED event reporting;

  Run qemu with a socket option, and telnet or nc to that,
  -chardev socket,id=qmp,port=4444,host=localhost,server \
  -mon chardev=qmp,mode=control,pretty=on \
  Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
  information will be reported on a guest crash event like,

  {
      "timestamp": {
          "seconds": 1499931739,
          "microseconds": 961296
      },
      "event": "GUEST_PANICKED",
      "data": {
          "action": "pause",
          "info": {
              "psw_addr": 1105350,
              "reason": "disabled wait",
              "psw_mask": 562956395872256,
              "type": "kvm-s390"
          }
      }
  }

  3. log;

  Run qemu with the parameters: -D <logfile> -d guest_errors, to
  specify the logfile and log item. The results might be,

  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Guest crashed
  KVM-S390 crash parameters: (0x2000180000000 0x10ddc6)
  KVM-S390 crash reason: disabled wait
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 qapi/run-state.json | 19 ++++++++++++++++--
 target/s390x/cpu.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h  |  6 ++++++
 target/s390x/kvm.c  | 29 +++++++++++++++++++++------
 vl.c                |  6 ++++++
 5 files changed, 109 insertions(+), 8 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index d36ff49..3bf65ea 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -320,10 +320,12 @@
 #
 # An enumeration of the guest panic information types
 #
+# @kvm-s390: s390 guest panic information type (Since: 2.11)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v'] }
+  'data': [ 'hyper-v', 'kvm-s390' ] }
 
 ##
 # @GuestPanicInformation:
@@ -335,7 +337,8 @@
 {'union': 'GuestPanicInformation',
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
- 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
+ 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
+           'kvm-s390': 'GuestPanicInformationKVMS390' } }
 
 ##
 # @GuestPanicInformationHyperV:
@@ -350,3 +353,15 @@
            'arg3': 'uint64',
            'arg4': 'uint64',
            'arg5': 'uint64' } }
+
+##
+# @GuestPanicInformationKVMS390:
+#
+# KVM-S390 specific guest panic information (PSW)
+#
+# Since: 2.11
+##
+{'struct': 'GuestPanicInformationKVMS390',
+ 'data': { 'psw_mask': 'uint64',
+           'psw_addr': 'uint64',
+           'reason': 'str' } }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 74b3e4f..bfaee04 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -35,6 +35,8 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/visitor.h"
+#include "qapi-visit.h"
+#include "sysemu/hw_accel.h"
 #include "exec/exec-all.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
@@ -276,6 +278,58 @@ static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
     cpu->id = value;
 }
 
+static GuestPanicInformation *s390x_cpu_get_crash_info(CPUState *cs)
+{
+    GuestPanicInformation *panic_info;
+    S390CPU *cpu = S390_CPU(cs);
+
+    cpu_synchronize_state(cs);
+    panic_info = g_malloc0(sizeof(GuestPanicInformation));
+
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_KVM_S390;
+    panic_info->u.kvm_s390.psw_mask = cpu->env.psw.mask;
+    panic_info->u.kvm_s390.psw_addr = cpu->env.psw.addr;
+
+    switch (cs->exception_index) {
+    case EXCP_CRASH_PGM:
+        panic_info->u.kvm_s390.reason = g_strdup("program interrupt loop");
+        break;
+    case EXCP_CRASH_EXT:
+        panic_info->u.kvm_s390.reason = g_strdup("external interrupt loop");
+        break;
+    case EXCP_CRASH_WAITPSW:
+        panic_info->u.kvm_s390.reason = g_strdup("disabled wait");
+        break;
+    case EXCP_CRASH_OPEREXC:
+        panic_info->u.kvm_s390.reason = g_strdup("operation exception loop");
+        break;
+    default:
+        panic_info->u.kvm_s390.reason = g_strdup("unknown crash reason");
+        break;
+    }
+
+    return panic_info;
+}
+
+static void s390x_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
+{
+    CPUState *cs = CPU(obj);
+    GuestPanicInformation *panic_info;
+
+    if (!cs->crash_occurred) {
+        error_setg(errp, "No crash occured");
+        return;
+    }
+
+    panic_info = s390x_cpu_get_crash_info(cs);
+
+    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                     errp);
+    qapi_free_GuestPanicInformation(panic_info);
+}
+
 static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -291,6 +345,8 @@ static void s390_cpu_initfn(Object *obj)
     cs->exception_index = EXCP_HLT;
     object_property_add(OBJECT(cpu), "id", "int64_t", s390x_cpu_get_id,
                         s390x_cpu_set_id, NULL, NULL, NULL);
+    object_property_add(obj, "crash-information", "GuestPanicInformation",
+                        s390x_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     qemu_get_timedate(&tm, 0);
@@ -517,6 +573,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
+    cc->get_crash_info = s390x_cpu_get_crash_info;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 0bd97a5..dba32db 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -396,6 +396,12 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
+/* Crash cases. */
+#define EXCP_CRASH_PGM 9
+#define EXCP_CRASH_EXT 10
+#define EXCP_CRASH_WAITPSW 11
+#define EXCP_CRASH_OPEREXC 12
+
 #define INTERRUPT_EXT        (1 << 0)
 #define INTERRUPT_TOD        (1 << 1)
 #define INTERRUPT_CPUTIMER   (1 << 2)
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d07763f..950ea42 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1941,15 +1941,31 @@ static bool is_special_wait_psw(CPUState *cs)
     return cs->kvm_run->psw_addr == 0xfffUL;
 }
 
-static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
+static void unmanageable_intercept(S390CPU *cpu, int32_t reason, int pswoffset)
 {
     CPUState *cs = CPU(cpu);
+    const char *str;
 
+    switch (reason) {
+    case EXCP_CRASH_PGM:
+        str = "program interrupt";
+        break;
+    case EXCP_CRASH_EXT:
+        str = "external interrupt";
+        break;
+    case EXCP_CRASH_OPEREXC:
+        str = "operation exception loop";
+        break;
+    default:
+        str = "unknown crash reason";
+        break;
+    }
     error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
                  str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
                  ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
     s390_cpu_halt(cpu);
-    qemu_system_guest_panicked(NULL);
+    cs->exception_index = reason;
+    qemu_system_guest_panicked(cpu_get_crash_info(cs));
 }
 
 /* try to detect pgm check loops */
@@ -1979,7 +1995,7 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
         !(oldpsw.mask & PSW_MASK_PSTATE) &&
         (newpsw.mask & PSW_MASK_ASC) == (oldpsw.mask & PSW_MASK_ASC) &&
         (newpsw.mask & PSW_MASK_DAT) == (oldpsw.mask & PSW_MASK_DAT)) {
-        unmanageable_intercept(cpu, "operation exception loop",
+        unmanageable_intercept(cpu, EXCP_CRASH_OPEREXC,
                                offsetof(LowCore, program_new_psw));
         return EXCP_HALTED;
     }
@@ -2000,12 +2016,12 @@ static int handle_intercept(S390CPU *cpu)
             r = handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
-            unmanageable_intercept(cpu, "program interrupt",
+            unmanageable_intercept(cpu, EXCP_CRASH_PGM,
                                    offsetof(LowCore, program_new_psw));
             r = EXCP_HALTED;
             break;
         case ICPT_EXT_INT:
-            unmanageable_intercept(cpu, "external interrupt",
+            unmanageable_intercept(cpu, EXCP_CRASH_EXT,
                                    offsetof(LowCore, external_new_psw));
             r = EXCP_HALTED;
             break;
@@ -2016,7 +2032,8 @@ static int handle_intercept(S390CPU *cpu)
                 if (is_special_wait_psw(cs)) {
                     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
                 } else {
-                    qemu_system_guest_panicked(NULL);
+                    cs->exception_index = EXCP_CRASH_WAITPSW;
+                    qemu_system_guest_panicked(cpu_get_crash_info(cs));
                 }
             }
             r = EXCP_HALTED;
diff --git a/vl.c b/vl.c
index 9e62e92..354513a 100644
--- a/vl.c
+++ b/vl.c
@@ -1825,6 +1825,12 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.hyper_v.arg3,
                           info->u.hyper_v.arg4,
                           info->u.hyper_v.arg5);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_KVM_S390) {
+            qemu_log_mask(LOG_GUEST_ERROR, "KVM-S390 crash parameters: (%#"
+                          PRIx64" %#"PRIx64")\nKVM-S390 crash reason: %s\n",
+                          info->u.kvm_s390.psw_mask,
+                          info->u.kvm_s390.psw_addr,
+                          info->u.kvm_s390.reason);
         }
         qapi_free_GuestPanicInformation(info);
     }
-- 
2.9.4
