Received: from eggs.gnu.org ([2001:4830:134:3::10]:44175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLjbZ-0003dv-Co
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 01:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLjbW-0003J6-6e
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 01:15:33 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLjbW-0003Ia-04
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 01:15:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id s66so3999214pfs.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 22:15:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 15 Jun 2017 22:15:26 -0700
Message-Id: <20170616051526.6814-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2] target/s390x: Enforce instruction features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Introduce a synthetic feature (type MISC) to handle disabling of
the enforcing of features at translation time.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_features.c     | 4 +++-
 target/s390x/cpu_features_def.h | 1 +
 target/s390x/cpu_models.c       | 5 +++++
 target/s390x/translate.c        | 9 +++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 42fd9d7..8d542c0 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -24,7 +24,7 @@
     }
 
 /* indexed by feature number for easy lookup */
-static const S390FeatDef s390_features[] = {
+static const S390FeatDef s390_features[S390_FEAT_MAX] = {
     FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
     FEAT_INIT("zarch", S390_FEAT_TYPE_STFL, 1, "z/Architecture architectural mode"),
     FEAT_INIT("dateh", S390_FEAT_TYPE_STFL, 3, "DAT-enhancement facility"),
@@ -251,6 +251,8 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-256"),
 
     FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512-DRNG"),
+
+    FEAT_INIT("tcg-all-insns", S390_FEAT_TYPE_MISC, 0, "Enable all insns supported by TCG"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index aa5ab8d..0726c54 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -225,6 +225,7 @@ typedef enum {
     S390_FEAT_PCC_XTS_EAES_128,
     S390_FEAT_PCC_XTS_EAES_256,
     S390_FEAT_PPNO_SHA_512_DRNG,
+    S390_FEAT_TCG_ALL_INSNS,
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 478bcc6..641552e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -685,6 +685,11 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_STFLE_45,
+
+        /* There are other features that are only partially implemented.
+           We do not advertise those above.  Indicate that we should not
+           enforce PGM_OPERATION for insns without the feature bit set.  */
+        S390_FEAT_TCG_ALL_INSNS,
     };
     int i;
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index af18ffb..69c1f94 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -55,6 +55,7 @@ typedef struct DisasFields DisasFields;
 
 struct DisasContext {
     struct TranslationBlock *tb;
+    const unsigned long *features;
     const DisasInsn *insn;
     DisasFields *fields;
     uint64_t ex_value;
@@ -5600,6 +5601,12 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
     }
 #endif
 
+    /* Check for insn feature enabled.  */
+    if (s->features && !test_bit(insn->fac, s->features)) {
+        gen_program_exception(s, PGM_OPERATION);
+        return EXIT_NORETURN;
+    }
+
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
         int spec = insn->spec, excp = 0, r;
@@ -5726,6 +5733,8 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     }
 
     dc.tb = tb;
+    dc.features = (s390_has_feat(S390_FEAT_TCG_ALL_INSNS)
+                   ? NULL : cpu->model->features);
     dc.pc = pc_start;
     dc.cc_op = CC_OP_DYNAMIC;
     dc.ex_value = tb->cs_base;
-- 
2.9.4
