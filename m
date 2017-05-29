Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHd-0006UB-VR
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-000765-IL
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00072r-4t
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:40 +0200
Message-Id: <20170529192440.5990-30-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 29/29] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

At the same time fix the TCG version of get_max_cpu_model to return the
maximum model like on KVM. Remove the long-displacement facility from
the additional features as it is included in the z800.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/cpu_models.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e5e005a430..5f2c195d53 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -668,7 +668,6 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
     static const int feats[] = {
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
-        S390_FEAT_LONG_DISPLACEMENT,
         S390_FEAT_LONG_DISPLACEMENT_FAST,
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
@@ -694,9 +693,9 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 (with some optional additional features) */
-        max_model.def = &s390_cpu_defs[0];
-        bitmap_copy(max_model.features, max_model.def->default_feat,
+        /* TCG emulates a z800 (with some optional additional features) */
+        max_model.def = s390_find_cpu_def(0x2066, 7, 3, NULL);
+        bitmap_copy(max_model.features, max_model.def->full_feat,
                     S390_FEAT_MAX);
         add_qemu_cpu_model_features(max_model.features);
     }
@@ -954,8 +953,9 @@ static void s390_qemu_cpu_model_initfn(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cpu->model = g_malloc0(sizeof(*cpu->model));
-    /* TCG emulates a z900 (with some optional additional features) */
-    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
+    /* TCG emulates a z800 (with some optional additional features) */
+    memcpy(&s390_qemu_cpu_defs, s390_find_cpu_def(0x2066, 7, 3, NULL),
+           sizeof(s390_qemu_cpu_defs));
     add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
     cpu->model->def = &s390_qemu_cpu_defs;
     bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
-- 
2.11.0
