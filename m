Received: from eggs.gnu.org ([2001:4830:134:3::10]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dB0zV-0007iM-9T
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dB0zQ-0004L4-3A
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dB0zP-0004Ks-Pg
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:35:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 May 2017 17:35:37 +0200
Message-Id: <1495035337-13337-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>, mmarek@suse.com, mbenes@suse.cz, Aurelien Jarno <aurelien@aurel32.net>

Currently we only present the plain z900 feature bits to the guest,
but QEMU already emulates some additional features (but not all of
the next CPU generation, so we can not use the next CPU level as
default yet). Since newer Linux kernels are checking the feature bits
and refuse to work if a required feature is missing, we should present
as much of the supported features as possible when we are running
with the default "qemu" CPU.
This patch now adds the "stfle", "extended immediate" and "stckf"
facility bits to the "qemu" CPU, which are already supported facilities.
It is unfortunately still not enough to run e.g. recent Fedora kernels,
but at least it's a first step into the right direction.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363..18789ab 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -658,6 +658,24 @@ static void check_compatibility(const S390CPUModel *max_model,
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
+        S390_FEAT_STORE_CLOCK_FAST
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
@@ -670,10 +688,11 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 */
+        /* TCG emulates a z900 (with some additional features) */
         max_model.def = &s390_cpu_defs[0];
         bitmap_copy(max_model.features, max_model.def->default_feat,
                     S390_FEAT_MAX);
+        add_qemu_cpu_model_features(max_model.features);
     }
     if (!*errp) {
         cached = true;
@@ -925,11 +944,15 @@ static void s390_host_cpu_model_initfn(Object *obj)
 
 static void s390_qemu_cpu_model_initfn(Object *obj)
 {
+    static S390CPUDef s390_qemu_cpu_defs;
     S390CPU *cpu = S390_CPU(obj);
 
     cpu->model = g_malloc0(sizeof(*cpu->model));
-    /* TCG emulates a z900 */
-    cpu->model->def = &s390_cpu_defs[0];
+    /* TCG emulates a z900 (with some additional features) */
+    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
+    add_qemu_cpu_model_features(s390_qemu_cpu_defs.default_feat);
+    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
+    cpu->model->def = &s390_qemu_cpu_defs;
     bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
                 S390_FEAT_MAX);
 }
-- 
1.8.3.1
