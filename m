Received: from eggs.gnu.org ([2001:4830:134:3::10]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRg-0007qp-Vg
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRf-0003a2-J4
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:08 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRf-0003Yw-CV
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:07 -0400
Received: by mail-pg0-x243.google.com with SMTP id v18so3986547pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:39 -0700
Message-Id: <20170604173509.29684-40-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 39/69] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1495704132-5675-1-git-send-email-thuth@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363..e5e005a 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -658,6 +658,30 @@ static void check_compatibility(const S390CPUModel *max_model,
                   "available in the configuration: ");
 }
 
+/**
+ * The base TCG CPU model "qemu" is based on the z900. However, we already
+ * can also emulate some additional features of later CPU generations, so
+ * we add these additional feature bits here.
+ */
+static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
+{
+    static const int feats[] = {
+        S390_FEAT_STFLE,
+        S390_FEAT_EXTENDED_IMMEDIATE,
+        S390_FEAT_LONG_DISPLACEMENT,
+        S390_FEAT_LONG_DISPLACEMENT_FAST,
+        S390_FEAT_STORE_CLOCK_FAST,
+        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
+        S390_FEAT_EXECUTE_EXT,
+        S390_FEAT_STFLE_45,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], fbm);
+    }
+}
+
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
     static S390CPUModel max_model;
@@ -670,10 +694,11 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
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
@@ -925,11 +950,14 @@ static void s390_host_cpu_model_initfn(Object *obj)
 
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
2.9.4
