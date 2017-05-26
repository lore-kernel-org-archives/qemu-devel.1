Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dEE8p-0007sU-Pg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dEE8k-0002hs-Ov
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dEE8k-0002hg-FW
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:14:46 -0400
References: <1495704132-5675-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b8b5569d-db2a-2c6c-f4c2-6647bb1444e5@redhat.com>
Date: Fri, 26 May 2017 14:14:40 +0200
MIME-Version: 1.0
In-Reply-To: <1495704132-5675-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 25.05.2017 11:22, Thomas Huth wrote:
> Currently we only present the plain z900 feature bits to the guest,
> but QEMU already emulates some additional features (but not all of
> the next CPU generation, so we can not use the next CPU level as
> default yet). Since newer Linux kernels are checking the feature bits
> and refuse to work if a required feature is missing, it would be nice
> to have a way to present more of the supported features when we are
> running with the "qemu" CPU.
> This patch now adds the supported features to the "full_feat" bitmap,
> so that additional features can be enabled on the command line now,
> for example with:
> 
>  qemu-system-s390x -cpu qemu,stfle=true,ldisp=true,eimm=true,stckf=true>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Mark feats array with "static const"
> 
>  target/s390x/cpu_models.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 8d27363..e5e005a 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -658,6 +658,30 @@ static void check_compatibility(const S390CPUModel *max_model,
>                    "available in the configuration: ");
>  }
>  
> +/**
> + * The base TCG CPU model "qemu" is based on the z900. However, we already
> + * can also emulate some additional features of later CPU generations, so
> + * we add these additional feature bits here.
> + */
> +static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
> +{
> +    static const int feats[] = {
> +        S390_FEAT_STFLE,
> +        S390_FEAT_EXTENDED_IMMEDIATE,
> +        S390_FEAT_LONG_DISPLACEMENT,
> +        S390_FEAT_LONG_DISPLACEMENT_FAST,
> +        S390_FEAT_STORE_CLOCK_FAST,
> +        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
> +        S390_FEAT_EXECUTE_EXT,
> +        S390_FEAT_STFLE_45,
> +    };
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(feats); i++) {
> +        set_bit(feats[i], fbm);
> +    }
> +}
> +
>  static S390CPUModel *get_max_cpu_model(Error **errp)
>  {
>      static S390CPUModel max_model;
> @@ -670,10 +694,11 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>      if (kvm_enabled()) {
>          kvm_s390_get_host_cpu_model(&max_model, errp);
>      } else {
> -        /* TCG emulates a z900 */
> +        /* TCG emulates a z900 (with some optional additional features) */
>          max_model.def = &s390_cpu_defs[0];
>          bitmap_copy(max_model.features, max_model.def->default_feat,
>                      S390_FEAT_MAX);
> +        add_qemu_cpu_model_features(max_model.features);
>      }
>      if (!*errp) {
>          cached = true;
> @@ -925,11 +950,14 @@ static void s390_host_cpu_model_initfn(Object *obj)
>  
>  static void s390_qemu_cpu_model_initfn(Object *obj)
>  {
> +    static S390CPUDef s390_qemu_cpu_defs;
>      S390CPU *cpu = S390_CPU(obj);
>  
>      cpu->model = g_malloc0(sizeof(*cpu->model));
> -    /* TCG emulates a z900 */
> -    cpu->model->def = &s390_cpu_defs[0];
> +    /* TCG emulates a z900 (with some optional additional features) */
> +    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
> +    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
> +    cpu->model->def = &s390_qemu_cpu_defs;
>      bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
>                  S390_FEAT_MAX);

That should work for the general case, at least for now.

arch_query_cpu_model_baseline() will still drop the additional featues.

Another option would be to directly bump up the CPU model to a z9, with
missing base features (for now). Which looks cleaner in my eyes:


>From 59c944c6fef87808e4456ba9565ace7772d236d7 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 26 May 2017 13:54:27 +0200
Subject: [PATCH] s390x/cpu_models: Allow some additional feature bits
for the
 "qemu" CPU

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 13 +++++++++++
 target/s390x/cpu.h         |  2 ++
 target/s390x/cpu_models.c  | 55
+++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fdd4384..3963a84 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -454,6 +454,19 @@ DEFINE_CCW_MACHINE(2_10, "2.10", true);

 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
+    static const int feats[] = {
+        S390_FEAT_GROUP_PLO,
+        S390_FEAT_ESAN3,
+        S390_FEAT_ZARCH,
+    };
+    S390FeatBitmap qemu_features = {};
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], qemu_features);
+    }
+    s390_set_qemu_cpu_model_compat(0x2064, 7, 1, qemu_features);
+
     ccw_machine_2_10_instance_options(machine);
 }

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 240b8a5..8a11104 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -637,6 +637,8 @@ void s390_cpu_model_register_props(Object *obj);
 void s390_cpu_model_class_register_props(ObjectClass *oc);
 void s390_realize_cpu_model(CPUState *cs, Error **errp);
 ObjectClass *s390_cpu_class_by_name(const char *name);
+void s390_set_qemu_cpu_model_compat(uint16_t type, uint8_t gen, uint8_t
ec_ga,
+                                    S390FeatBitmap features);

 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363..04643d7 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -658,6 +658,28 @@ static void check_compatibility(const S390CPUModel
*max_model,
                   "available in the configuration: ");
 }

+static void get_max_qemu_cpu_model_features(S390FeatBitmap features)
+{
+    static const int feats[] = {
+        S390_FEAT_GROUP_PLO,
+        S390_FEAT_ESAN3,
+        S390_FEAT_ZARCH,
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
+        set_bit(feats[i], features);
+    }
+}
+
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
     static S390CPUModel max_model;
@@ -670,10 +692,9 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 */
-        max_model.def = &s390_cpu_defs[0];
-        bitmap_copy(max_model.features, max_model.def->default_feat,
-                    S390_FEAT_MAX);
+        /* QEMU emulates a z9 but with some missing base features */
+        max_model.def = s390_find_cpu_def(0x2094, 9, 1, NULL);
+        get_max_qemu_cpu_model_features(max_model.features);
     }
     if (!*errp) {
         cached = true;
@@ -923,15 +944,27 @@ static void s390_host_cpu_model_initfn(Object *obj)
 }
 #endif

+static uint16_t qemu_type;
+static uint8_t qemu_gen;
+static uint8_t qemu_ec_ga;
+static S390FeatBitmap qemu_features;
+
+void s390_set_qemu_cpu_model_compat(uint16_t type, uint8_t gen, uint8_t
ec_ga,
+                                    S390FeatBitmap features)
+{
+    qemu_type = type;
+    qemu_gen = gen;
+    qemu_ec_ga = ec_ga;
+    bitmap_copy(qemu_features, features, S390_FEAT_MAX);
+}
+
 static void s390_qemu_cpu_model_initfn(Object *obj)
 {
     S390CPU *cpu = S390_CPU(obj);

     cpu->model = g_malloc0(sizeof(*cpu->model));
-    /* TCG emulates a z900 */
-    cpu->model->def = &s390_cpu_defs[0];
-    bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
-                S390_FEAT_MAX);
+    cpu->model->def = s390_find_cpu_def(qemu_type, qemu_gen,
qemu_ec_ga, NULL);
+    bitmap_copy(cpu->model->features, qemu_features, S390_FEAT_MAX);
 }

 static void s390_cpu_model_finalize(Object *obj)
@@ -1064,6 +1097,12 @@ static void register_types(void)
                               s390_cpu_defs[i].full_feat);
     }

+    /* QEMU emulates a z9 but with some missing base features */
+    qemu_type = 0x2094;
+    qemu_gen = 9;
+    qemu_ec_ga = 1;
+    get_max_qemu_cpu_model_features(qemu_features);
+
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         char *base_name = s390_base_cpu_type_name(s390_cpu_defs[i].name);
         TypeInfo ti_base = {
-- 
2.9.3




-- 

Thanks,

David
