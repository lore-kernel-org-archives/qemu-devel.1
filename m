Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tco-00030Y-Eh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcl-00083H-Sh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcl-00082v-Iz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:43 -0300
Message-Id: <20170511191843.13784-30-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 29/29] migration/i386: Remove support for
 pre-0.12 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Remove support for versions of the CPU state prior to 11
which is the version used in qemu 0.12 - you'd be pretty
lucky if you got a migration stream to work from anything
that old anyway.  This doesn't affect the machine type
definition in any way.

My main reason for doing this is the hack for sysenter_esp/eip
that uses .get/.put's in state versions less than 7 (that's
prior to somewhere before 0.10).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170405190024.27581-4-dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/machine.c | 115 +++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 81 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0b4756b35f..3cb272948e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -178,44 +178,6 @@ static const VMStateDescription vmstate_fpreg = {
     }
 };
 
-static bool version_is_5(void *opaque, int version_id)
-{
-    return version_id == 5;
-}
-
-#ifdef TARGET_X86_64
-static bool less_than_7(void *opaque, int version_id)
-{
-    return version_id < 7;
-}
-
-static int get_uint64_as_uint32(QEMUFile *f, void *pv, size_t size,
-                                VMStateField *field)
-{
-    uint64_t *v = pv;
-    *v = qemu_get_be32(f);
-    return 0;
-}
-
-static int put_uint64_as_uint32(QEMUFile *f, void *pv, size_t size,
-                                VMStateField *field, QJSON *vmdesc)
-{
-    uint64_t *v = pv;
-    qemu_put_be32(f, *v);
-
-    return 0;
-}
-
-static const VMStateInfo vmstate_hack_uint64_as_uint32 = {
-    .name = "uint64_as_uint32",
-    .get  = get_uint64_as_uint32,
-    .put  = put_uint64_as_uint32,
-};
-
-#define VMSTATE_HACK_UINT32(_f, _s, _t)                                  \
-    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_hack_uint64_as_uint32, uint64_t)
-#endif
-
 static void cpu_pre_save(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -842,7 +804,7 @@ static const VMStateDescription vmstate_mcg_ext_ctl = {
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
-    .minimum_version_id = 3,
+    .minimum_version_id = 11,
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
@@ -865,16 +827,8 @@ VMStateDescription vmstate_x86_cpu = {
         VMSTATE_SEGMENT(env.idt, X86CPU),
 
         VMSTATE_UINT32(env.sysenter_cs, X86CPU),
-#ifdef TARGET_X86_64
-        /* Hack: In v7 size changed from 32 to 64 bits on x86_64 */
-        VMSTATE_HACK_UINT32(env.sysenter_esp, X86CPU, less_than_7),
-        VMSTATE_HACK_UINT32(env.sysenter_eip, X86CPU, less_than_7),
-        VMSTATE_UINTTL_V(env.sysenter_esp, X86CPU, 7),
-        VMSTATE_UINTTL_V(env.sysenter_eip, X86CPU, 7),
-#else
         VMSTATE_UINTTL(env.sysenter_esp, X86CPU),
         VMSTATE_UINTTL(env.sysenter_eip, X86CPU),
-#endif
 
         VMSTATE_UINTTL(env.cr[0], X86CPU),
         VMSTATE_UINTTL(env.cr[2], X86CPU),
@@ -895,46 +849,45 @@ VMStateDescription vmstate_x86_cpu = {
         VMSTATE_UINT64(env.fmask, X86CPU),
         VMSTATE_UINT64(env.kernelgsbase, X86CPU),
 #endif
-        VMSTATE_UINT32_V(env.smbase, X86CPU, 4),
-
-        VMSTATE_UINT64_V(env.pat, X86CPU, 5),
-        VMSTATE_UINT32_V(env.hflags2, X86CPU, 5),
-
-        VMSTATE_UINT32_TEST(parent_obj.halted, X86CPU, version_is_5),
-        VMSTATE_UINT64_V(env.vm_hsave, X86CPU, 5),
-        VMSTATE_UINT64_V(env.vm_vmcb, X86CPU, 5),
-        VMSTATE_UINT64_V(env.tsc_offset, X86CPU, 5),
-        VMSTATE_UINT64_V(env.intercept, X86CPU, 5),
-        VMSTATE_UINT16_V(env.intercept_cr_read, X86CPU, 5),
-        VMSTATE_UINT16_V(env.intercept_cr_write, X86CPU, 5),
-        VMSTATE_UINT16_V(env.intercept_dr_read, X86CPU, 5),
-        VMSTATE_UINT16_V(env.intercept_dr_write, X86CPU, 5),
-        VMSTATE_UINT32_V(env.intercept_exceptions, X86CPU, 5),
-        VMSTATE_UINT8_V(env.v_tpr, X86CPU, 5),
+        VMSTATE_UINT32(env.smbase, X86CPU),
+
+        VMSTATE_UINT64(env.pat, X86CPU),
+        VMSTATE_UINT32(env.hflags2, X86CPU),
+
+        VMSTATE_UINT64(env.vm_hsave, X86CPU),
+        VMSTATE_UINT64(env.vm_vmcb, X86CPU),
+        VMSTATE_UINT64(env.tsc_offset, X86CPU),
+        VMSTATE_UINT64(env.intercept, X86CPU),
+        VMSTATE_UINT16(env.intercept_cr_read, X86CPU),
+        VMSTATE_UINT16(env.intercept_cr_write, X86CPU),
+        VMSTATE_UINT16(env.intercept_dr_read, X86CPU),
+        VMSTATE_UINT16(env.intercept_dr_write, X86CPU),
+        VMSTATE_UINT32(env.intercept_exceptions, X86CPU),
+        VMSTATE_UINT8(env.v_tpr, X86CPU),
         /* MTRRs */
-        VMSTATE_UINT64_ARRAY_V(env.mtrr_fixed, X86CPU, 11, 8),
-        VMSTATE_UINT64_V(env.mtrr_deftype, X86CPU, 8),
+        VMSTATE_UINT64_ARRAY(env.mtrr_fixed, X86CPU, 11),
+        VMSTATE_UINT64(env.mtrr_deftype, X86CPU),
         VMSTATE_MTRR_VARS(env.mtrr_var, X86CPU, MSR_MTRRcap_VCNT, 8),
         /* KVM-related states */
-        VMSTATE_INT32_V(env.interrupt_injected, X86CPU, 9),
-        VMSTATE_UINT32_V(env.mp_state, X86CPU, 9),
-        VMSTATE_UINT64_V(env.tsc, X86CPU, 9),
-        VMSTATE_INT32_V(env.exception_injected, X86CPU, 11),
-        VMSTATE_UINT8_V(env.soft_interrupt, X86CPU, 11),
-        VMSTATE_UINT8_V(env.nmi_injected, X86CPU, 11),
-        VMSTATE_UINT8_V(env.nmi_pending, X86CPU, 11),
-        VMSTATE_UINT8_V(env.has_error_code, X86CPU, 11),
-        VMSTATE_UINT32_V(env.sipi_vector, X86CPU, 11),
+        VMSTATE_INT32(env.interrupt_injected, X86CPU),
+        VMSTATE_UINT32(env.mp_state, X86CPU),
+        VMSTATE_UINT64(env.tsc, X86CPU),
+        VMSTATE_INT32(env.exception_injected, X86CPU),
+        VMSTATE_UINT8(env.soft_interrupt, X86CPU),
+        VMSTATE_UINT8(env.nmi_injected, X86CPU),
+        VMSTATE_UINT8(env.nmi_pending, X86CPU),
+        VMSTATE_UINT8(env.has_error_code, X86CPU),
+        VMSTATE_UINT32(env.sipi_vector, X86CPU),
         /* MCE */
-        VMSTATE_UINT64_V(env.mcg_cap, X86CPU, 10),
-        VMSTATE_UINT64_V(env.mcg_status, X86CPU, 10),
-        VMSTATE_UINT64_V(env.mcg_ctl, X86CPU, 10),
-        VMSTATE_UINT64_ARRAY_V(env.mce_banks, X86CPU, MCE_BANKS_DEF * 4, 10),
+        VMSTATE_UINT64(env.mcg_cap, X86CPU),
+        VMSTATE_UINT64(env.mcg_status, X86CPU),
+        VMSTATE_UINT64(env.mcg_ctl, X86CPU),
+        VMSTATE_UINT64_ARRAY(env.mce_banks, X86CPU, MCE_BANKS_DEF * 4),
         /* rdtscp */
-        VMSTATE_UINT64_V(env.tsc_aux, X86CPU, 11),
+        VMSTATE_UINT64(env.tsc_aux, X86CPU),
         /* KVM pvclock msr */
-        VMSTATE_UINT64_V(env.system_time_msr, X86CPU, 11),
-        VMSTATE_UINT64_V(env.wall_clock_msr, X86CPU, 11),
+        VMSTATE_UINT64(env.system_time_msr, X86CPU),
+        VMSTATE_UINT64(env.wall_clock_msr, X86CPU),
         /* XSAVE related fields */
         VMSTATE_UINT64_V(env.xcr0, X86CPU, 12),
         VMSTATE_UINT64_V(env.xstate_bv, X86CPU, 12),
-- 
2.11.0.259.g40922b1
