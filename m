Received: from eggs.gnu.org ([2001:4830:134:3::10]:49368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvqAR-0003OW-6x
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvqAP-0001G1-Gf
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvqAP-0001Fl-8m
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:29 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  5 Apr 2017 20:00:22 +0100
Message-Id: <20170405190024.27581-2-dgilbert@redhat.com>
In-Reply-To: <20170405190024.27581-1-dgilbert@redhat.com>
References: <20170405190024.27581-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] migration/i386: Remove old non-softfloat
 64bit FP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Long long ago, we used to support storing the x86 FP registers in
a 64bit format.

Then c31da136a0bf8caad70c348f5ffc283206e9c7fc in v0.14-rc0 removed
the last support for writing that in the migration format.
Even before that, it was only used if you had softfloat disabled
 (i.e. !USE_X86LDOUBLE) so in practice use of it in even earlier
qemu is unlikely for most users.

Kill it off, it's complicated, and possibly broken.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/i386/machine.c | 107 +++-----------------------------------------------
 1 file changed, 6 insertions(+), 101 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 78ae2f9..bf9567c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -136,36 +136,6 @@ static const VMStateDescription vmstate_mtrr_var = {
 #define VMSTATE_MTRR_VARS(_field, _state, _n, _v)                    \
     VMSTATE_STRUCT_ARRAY(_field, _state, _n, _v, vmstate_mtrr_var, MTRRVar)
 
-static int put_fpreg_error(QEMUFile *f, void *opaque, size_t size,
-                           VMStateField *field, QJSON *vmdesc)
-{
-    fprintf(stderr, "call put_fpreg() with invalid arguments\n");
-    exit(0);
-    return 0;
-}
-
-/* XXX: add that in a FPU generic layer */
-union x86_longdouble {
-    uint64_t mant;
-    uint16_t exp;
-};
-
-#define MANTD1(fp)	(fp & ((1LL << 52) - 1))
-#define EXPBIAS1 1023
-#define EXPD1(fp)	((fp >> 52) & 0x7FF)
-#define SIGND1(fp)	((fp >> 32) & 0x80000000)
-
-static void fp64_to_fp80(union x86_longdouble *p, uint64_t temp)
-{
-    int e;
-    /* mantissa */
-    p->mant = (MANTD1(temp) << 11) | (1LL << 63);
-    /* exponent + sign */
-    e = EXPD1(temp) - EXPBIAS1 + 16383;
-    e |= SIGND1(temp) >> 16;
-    p->exp = e;
-}
-
 static int get_fpreg(QEMUFile *f, void *opaque, size_t size,
                      VMStateField *field)
 {
@@ -200,76 +170,6 @@ static const VMStateInfo vmstate_fpreg = {
     .put  = put_fpreg,
 };
 
-static int get_fpreg_1_mmx(QEMUFile *f, void *opaque, size_t size,
-                           VMStateField *field)
-{
-    union x86_longdouble *p = opaque;
-    uint64_t mant;
-
-    qemu_get_be64s(f, &mant);
-    p->mant = mant;
-    p->exp = 0xffff;
-    return 0;
-}
-
-static const VMStateInfo vmstate_fpreg_1_mmx = {
-    .name = "fpreg_1_mmx",
-    .get  = get_fpreg_1_mmx,
-    .put  = put_fpreg_error,
-};
-
-static int get_fpreg_1_no_mmx(QEMUFile *f, void *opaque, size_t size,
-                              VMStateField *field)
-{
-    union x86_longdouble *p = opaque;
-    uint64_t mant;
-
-    qemu_get_be64s(f, &mant);
-    fp64_to_fp80(p, mant);
-    return 0;
-}
-
-static const VMStateInfo vmstate_fpreg_1_no_mmx = {
-    .name = "fpreg_1_no_mmx",
-    .get  = get_fpreg_1_no_mmx,
-    .put  = put_fpreg_error,
-};
-
-static bool fpregs_is_0(void *opaque, int version_id)
-{
-    X86CPU *cpu = opaque;
-    CPUX86State *env = &cpu->env;
-
-    return (env->fpregs_format_vmstate == 0);
-}
-
-static bool fpregs_is_1_mmx(void *opaque, int version_id)
-{
-    X86CPU *cpu = opaque;
-    CPUX86State *env = &cpu->env;
-    int guess_mmx;
-
-    guess_mmx = ((env->fptag_vmstate == 0xff) &&
-                 (env->fpus_vmstate & 0x3800) == 0);
-    return (guess_mmx && (env->fpregs_format_vmstate == 1));
-}
-
-static bool fpregs_is_1_no_mmx(void *opaque, int version_id)
-{
-    X86CPU *cpu = opaque;
-    CPUX86State *env = &cpu->env;
-    int guess_mmx;
-
-    guess_mmx = ((env->fptag_vmstate == 0xff) &&
-                 (env->fpus_vmstate & 0x3800) == 0);
-    return (!guess_mmx && (env->fpregs_format_vmstate == 1));
-}
-
-#define VMSTATE_FP_REGS(_field, _state, _n)                               \
-    VMSTATE_ARRAY_TEST(_field, _state, _n, fpregs_is_0, vmstate_fpreg, FPReg), \
-    VMSTATE_ARRAY_TEST(_field, _state, _n, fpregs_is_1_mmx, vmstate_fpreg_1_mmx, FPReg), \
-    VMSTATE_ARRAY_TEST(_field, _state, _n, fpregs_is_1_no_mmx, vmstate_fpreg_1_no_mmx, FPReg)
-
 static bool version_is_5(void *opaque, int version_id)
 {
     return version_id == 5;
@@ -356,6 +256,10 @@ static int cpu_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    if (env->fpregs_format_vmstate) {
+        error_report("Unsupported old non-softfloat CPU state");
+        return -EINVAL;
+    }
     /*
      * Real mode guest segments register DPL should be zero.
      * Older KVM version were setting it wrongly.
@@ -943,7 +847,8 @@ VMStateDescription vmstate_x86_cpu = {
         VMSTATE_UINT16(env.fpus_vmstate, X86CPU),
         VMSTATE_UINT16(env.fptag_vmstate, X86CPU),
         VMSTATE_UINT16(env.fpregs_format_vmstate, X86CPU),
-        VMSTATE_FP_REGS(env.fpregs, X86CPU, 8),
+
+        VMSTATE_STRUCT_ARRAY(env.fpregs, X86CPU, 8, 0, vmstate_fpreg, FPReg),
 
         VMSTATE_SEGMENT_ARRAY(env.segs, X86CPU, 6),
         VMSTATE_SEGMENT(env.ldt, X86CPU),
-- 
2.9.3
