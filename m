Received: from eggs.gnu.org ([2001:4830:134:3::10]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dDS3u-0006ym-Vz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dDS3o-0006eD-Vb
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dDS3o-0006do-My
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:28 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 May 2017 10:54:23 +0200
Message-Id: <1495616063-19386-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/s390x/cpu_models: Allow some additional
 feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Currently we only present the plain z900 feature bits to the guest,
but QEMU already emulates some additional features (but not all of
the next CPU generation, so we can not use the next CPU level as
default yet). Since newer Linux kernels are checking the feature bits
and refuse to work if a required feature is missing, it would be nice
to have a way to present more of the supported features when we are
running with the "qemu" CPU.
This patch now adds the supported features to the "full_feat" bitmap,
so that additional features can be enabled on the command line now,
for example with:

 qemu-system-s390x -cpu qemu,stfle=true,ldisp=true,eimm=true,stckf=true

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This is a revised version of my previous patch "Set some additional
 feature bits for the qemu CPU" - but this time, the feature bits are not
 enabled by default, so this version should not create any issues with
 migration, I think. Rationale for not enabling it by default yet: It does
 not make sense to do add all the migration compatibility magic here yet as
 long as we do not provide enough facilities yet for running recent Linux
 kernels, so having just a way to enable the features on the command line
 for further development/experiments should be enough right now.
 Another change wrt. to my original patch: I've now also added the
 additional feature bits that Aurelien suggested.

 target/s390x/cpu_models.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363..654a6bc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -658,6 +658,29 @@ static void check_compatibility(const S390CPUModel *max_model,
                   "available in the configuration: ");
 }
 
+/**
+ * The base TCG CPU model "qemu" is based on the z900. However, we already
+ * can also emulate some additional features of later CPU generations, so
+ * we add these additional feature bits here.
+ */
+static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
+{
+    int i, feats[] = {
+        S390_FEAT_STFLE,
+        S390_FEAT_EXTENDED_IMMEDIATE,
+        S390_FEAT_LONG_DISPLACEMENT,
+        S390_FEAT_LONG_DISPLACEMENT_FAST,
+        S390_FEAT_STORE_CLOCK_FAST,
+        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
+        S390_FEAT_EXECUTE_EXT,
+        S390_FEAT_STFLE_45,
+    };
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], fbm);
+    }
+}
+
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
     static S390CPUModel max_model;
@@ -670,10 +693,11 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 */
+        /* TCG emulates a z900 (with some optional additional features) */
         max_model.def = &s390_cpu_defs[0];
         bitmap_copy(max_model.features, max_model.def->default_feat,
                     S390_FEAT_MAX);
+        add_qemu_cpu_model_features(max_model.features);
     }
     if (!*errp) {
         cached = true;
@@ -925,11 +949,14 @@ static void s390_host_cpu_model_initfn(Object *obj)
 
 static void s390_qemu_cpu_model_initfn(Object *obj)
 {
+    static S390CPUDef s390_qemu_cpu_defs;
     S390CPU *cpu = S390_CPU(obj);
 
     cpu->model = g_malloc0(sizeof(*cpu->model));
-    /* TCG emulates a z900 */
-    cpu->model->def = &s390_cpu_defs[0];
+    /* TCG emulates a z900 (with some optional additional features) */
+    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
+    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
+    cpu->model->def = &s390_qemu_cpu_defs;
     bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
                 S390_FEAT_MAX);
 }
-- 
1.8.3.1
