Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQa-0008Hw-9M
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEHQY-0000fI-4I
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:08 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:35061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEHQX-0000cu-Qs
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:13:06 -0500
Date: Tue, 6 Dec 2016 15:12:12 +0000
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20161206151212.2a93fc31@squid.athome>
In-Reply-To: <20161104140424.51369668@squid.athome>
References: <1478194258-75276-1-git-send-email-julian@codesourcery.com>
	<1478194258-75276-3-git-send-email-julian@codesourcery.com>
	<CAFEAcA_cOWiLFEg37PhaU+hnrjRGnJc_g1cFc6FXgbXnOpFnVw@mail.gmail.com>
	<20161104140424.51369668@squid.athome>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/uPnJhDN6eXSFjpawfi.zVMH"
Subject: Re: [Qemu-devel] [PATCH 2/5] Fix Thumb-1 BE32 execution and
 disassembly.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

--MP_/uPnJhDN6eXSFjpawfi.zVMH
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 4 Nov 2016 14:04:24 +0000
Julian Brown <julian@codesourcery.com> wrote:

> On Fri, 4 Nov 2016 13:30:12 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On 3 November 2016 at 17:30, Julian Brown <julian@codesourcery.com>
> > wrote:  
> > > Thumb-1 code has some issues in BE32 mode (as currently
> > > implemented). In short, since bytes are swapped within words at
> > > load time for BE32 executables, this also swaps pairs of adjacent
> > > Thumb-1 instructions.
> > >
> > > This patch un-swaps those pairs of instructions again, both for
> > > execution, and for disassembly.
> > >
> > > Signed-off-by: Julian Brown <julian@codesourcery.com>
> > > ---
> > >  disas/arm.c           | 46
> > > +++++++++++++++++++++++++++++++++++-----------
> > > include/disas/bfd.h   |  1 + target-arm/arm_ldst.h | 10 +++++++++-
> > >  target-arm/cpu.c      |  4 ++++
> > >  4 files changed, 49 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/disas/arm.c b/disas/arm.c
> > > index 93c6503..4807ba3 100644
> > > --- a/disas/arm.c
> > > +++ b/disas/arm.c
> > > @@ -3863,10 +3863,11 @@ print_insn_arm (bfd_vma pc, struct
> > > disassemble_info *info) int           is_data = false;
> > >    unsigned int size = 4;
> > >    void         (*printer) (bfd_vma, struct disassemble_info *,
> > > long);
> > > -  int little;
> > > +  int little, is_thumb1_be32 = false;
> > >
> > >    little = (info->endian == BFD_ENDIAN_LITTLE);
> > >    is_thumb |= (pc & 1);
> > > +  is_thumb1_be32 = (info->flags & INSN_ARM_THUMB1_BE32) != 0;
> > >    pc &= ~(bfd_vma)1;
> > >
> > >    if (force_thumb)
> > > @@ -3915,11 +3916,22 @@ print_insn_arm (bfd_vma pc, struct
> > > disassemble_info *info) info->bytes_per_chunk = 2;
> > >        size = 2;
> > >
> > > -      status = info->read_memory_func (pc, (bfd_byte *)b, 2,
> > > info);
> > > -      if (little)
> > > -       given = (b[0]) | (b[1] << 8);
> > > -      else
> > > -       given = (b[1]) | (b[0] << 8);
> > > +      if (is_thumb1_be32) {
> > > +          status = info->read_memory_func(pc & ~3, (bfd_byte *)b,
> > > 4, info);
> > > +          assert(little);
> > > +          if ((pc & 2) == 0) {
> > > +              given = b[2] | (b[3] << 8);
> > > +          } else {
> > > +              given = b[0] | (b[1] << 8);
> > > +          }
> > > +      } else {
> > > +          status = info->read_memory_func(pc, (bfd_byte *)b, 2,
> > > info);
> > > +          if (little) {
> > > +              given = (b[0]) | (b[1] << 8);
> > > +          } else {    
> >   
> > > +              given = (b[1]) | (b[0] << 8);
> > > +          }
> > > +      }    
> > 
> > Could we do this instead by changing the read_memory_func() so that
> > it did the appropriate XORing of addresses ? (Chaining through to
> > the original read_memory_func would be a bit irritating as you'd
> > need to find a place to stash that function pointer where you
> > could get at it again from the new read_memory_func.)  
> 
> Hmm, not sure. I'll try to think about whether that can be done
> nicely.

How about this? I've kept the INSN_ARM_THUMB1_BE32 flag, but it's not
100% certain if it's still required. There's probably less
function-pointer trickery with it left in.

Thanks,

Julian
--MP_/uPnJhDN6eXSFjpawfi.zVMH
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-Fix-Thumb-1-BE32-execution-and-disassembly.patch"

>From 852098f65becab24648adce97f93d0c87aa474cd Mon Sep 17 00:00:00 2001
From: Julian Brown <julian@codesourcery.com>
Date: Wed, 5 Oct 2016 09:26:44 -0700
Subject: [PATCH 2/4] Fix Thumb-1 BE32 execution and disassembly.

Thumb-1 code has some issues in BE32 mode (as currently implemented). In
short, since bytes are swapped within words at load time for BE32
executables, this also swaps pairs of adjacent Thumb-1 instructions.

This patch un-swaps those pairs of instructions again, both for execution,
and for disassembly.
---
 disas.c               |  1 +
 include/disas/bfd.h   |  7 +++++++
 target-arm/arm_ldst.h | 10 +++++++++-
 target-arm/cpu.c      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index 67f116a..506e56f 100644
--- a/disas.c
+++ b/disas.c
@@ -190,6 +190,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 
     s.cpu = cpu;
     s.info.read_memory_func = target_read_memory;
+    s.info.read_memory_inner_func = NULL;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
     s.info.print_address_func = generic_print_address;
diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index 8a3488c..5c1e1c5 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -291,6 +291,7 @@ typedef struct disassemble_info {
      The bottom 16 bits are for the internal use of the disassembler.  */
   unsigned long flags;
 #define INSN_HAS_RELOC	0x80000000
+#define INSN_ARM_THUMB1_BE32 0x00010000
   PTR private_data;
 
   /* Function used to get bytes to disassemble.  MEMADDR is the
@@ -302,6 +303,12 @@ typedef struct disassemble_info {
     (bfd_vma memaddr, bfd_byte *myaddr, int length,
 	     struct disassemble_info *info);
 
+  /* A place to stash the real read_memory_func if read_memory_func wants to
+     do some funky address arithmetic or similar (e.g. for ARM BE32 mode).  */
+  int (*read_memory_inner_func)
+    (bfd_vma memaddr, bfd_byte *myaddr, int length,
+             struct disassemble_info *info);
+
   /* Function which should be called if we get an error that we can't
      recover from.  STATUS is the errno value from read_memory_func and
      MEMADDR is the address that we were trying to read.  INFO is a
diff --git a/target-arm/arm_ldst.h b/target-arm/arm_ldst.h
index a76d89f..01587b3 100644
--- a/target-arm/arm_ldst.h
+++ b/target-arm/arm_ldst.h
@@ -39,7 +39,15 @@ static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
 static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
                                      bool sctlr_b)
 {
-    uint16_t insn = cpu_lduw_code(env, addr);
+    uint16_t insn;
+#ifndef CONFIG_USER_ONLY
+    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
+       within each word.  Undo that now.  */
+    if (sctlr_b) {
+        addr ^= 2;
+    }
+#endif
+    insn = cpu_lduw_code(env, addr);
     if (bswap_code(sctlr_b)) {
         return bswap16(insn);
     }
diff --git a/target-arm/cpu.c b/target-arm/cpu.c
index 6afb0d9..6099d50 100644
--- a/target-arm/cpu.c
+++ b/target-arm/cpu.c
@@ -409,6 +409,30 @@ print_insn_thumb1(bfd_vma pc, disassemble_info *info)
   return print_insn_arm(pc | 1, info);
 }
 
+static int arm_read_memory_func(bfd_vma memaddr, bfd_byte *myaddr,
+                                int length, struct disassemble_info *info)
+{
+    assert(info->read_memory_inner_func);
+
+    if ((info->flags & INSN_ARM_THUMB1_BE32) != 0 && length == 2) {
+        int status;
+        unsigned char b[4];
+        assert(info->endian == BFD_ENDIAN_LITTLE);
+        status = info->read_memory_inner_func(memaddr & ~3, (bfd_byte *)b, 4,
+                                              info);
+        if ((memaddr & 2) == 0) {
+            myaddr[0] = b[2];
+            myaddr[1] = b[3];
+        } else {
+            myaddr[0] = b[0];
+            myaddr[1] = b[1];
+        }
+        return status;
+    } else {
+        return info->read_memory_inner_func(memaddr, myaddr, length, info);
+    }
+}
+
 static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
@@ -424,6 +448,10 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
     } else if (env->thumb) {
         info->print_insn = print_insn_thumb1;
+        info->flags &= ~INSN_ARM_THUMB1_BE32;
+        if (arm_sctlr_b(env)) {
+            info->flags |= INSN_ARM_THUMB1_BE32;
+        }
     } else {
         info->print_insn = print_insn_arm;
     }
@@ -434,6 +462,10 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->endian = BFD_ENDIAN_BIG;
 #endif
     }
+    if (info->read_memory_inner_func == NULL) {
+        info->read_memory_inner_func = info->read_memory_func;
+        info->read_memory_func = arm_read_memory_func;
+    }
 }
 
 static void arm_cpu_initfn(Object *obj)
-- 
1.9.1


--MP_/uPnJhDN6eXSFjpawfi.zVMH--
