Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcl-0002xU-7Z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tck-00082c-3D
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcj-00082O-Qd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:42 -0300
Message-Id: <20170511191843.13784-29-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] vmstatification: i386 FPReg
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

Convert the fpreg save/restore to use VMSTATE_ macros rather than
.get/.put.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170405190024.27581-3-dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/machine.c | 52 +++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index bf9567cbd4..0b4756b35f 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -136,38 +136,46 @@ static const VMStateDescription vmstate_mtrr_var = {
 #define VMSTATE_MTRR_VARS(_field, _state, _n, _v)                    \
     VMSTATE_STRUCT_ARRAY(_field, _state, _n, _v, vmstate_mtrr_var, MTRRVar)
 
-static int get_fpreg(QEMUFile *f, void *opaque, size_t size,
-                     VMStateField *field)
+typedef struct x86_FPReg_tmp {
+    FPReg *parent;
+    uint64_t tmp_mant;
+    uint16_t tmp_exp;
+} x86_FPReg_tmp;
+
+static void fpreg_pre_save(void *opaque)
 {
-    FPReg *fp_reg = opaque;
-    uint64_t mant;
-    uint16_t exp;
+    x86_FPReg_tmp *tmp = opaque;
 
-    qemu_get_be64s(f, &mant);
-    qemu_get_be16s(f, &exp);
-    fp_reg->d = cpu_set_fp80(mant, exp);
-    return 0;
+    /* we save the real CPU data (in case of MMX usage only 'mant'
+       contains the MMX register */
+    cpu_get_fp80(&tmp->tmp_mant, &tmp->tmp_exp, tmp->parent->d);
 }
 
-static int put_fpreg(QEMUFile *f, void *opaque, size_t size,
-                     VMStateField *field, QJSON *vmdesc)
+static int fpreg_post_load(void *opaque, int version)
 {
-    FPReg *fp_reg = opaque;
-    uint64_t mant;
-    uint16_t exp;
-    /* we save the real CPU data (in case of MMX usage only 'mant'
-       contains the MMX register */
-    cpu_get_fp80(&mant, &exp, fp_reg->d);
-    qemu_put_be64s(f, &mant);
-    qemu_put_be16s(f, &exp);
+    x86_FPReg_tmp *tmp = opaque;
 
+    tmp->parent->d = cpu_set_fp80(tmp->tmp_mant, tmp->tmp_exp);
     return 0;
 }
 
-static const VMStateInfo vmstate_fpreg = {
+static const VMStateDescription vmstate_fpreg_tmp = {
+    .name = "fpreg_tmp",
+    .post_load = fpreg_post_load,
+    .pre_save  = fpreg_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(tmp_mant, x86_FPReg_tmp),
+        VMSTATE_UINT16(tmp_exp, x86_FPReg_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_fpreg = {
     .name = "fpreg",
-    .get  = get_fpreg,
-    .put  = put_fpreg,
+    .fields = (VMStateField[]) {
+        VMSTATE_WITH_TMP(FPReg, x86_FPReg_tmp, vmstate_fpreg_tmp),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static bool version_is_5(void *opaque, int version_id)
-- 
2.11.0.259.g40922b1
