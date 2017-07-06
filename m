Received: from eggs.gnu.org ([2001:4830:134:3::10]:49408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18r-00036n-RD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18m-0005Kt-RH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18m-0005KY-HB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:23:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667NrkR085585
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:23:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bh4tc1hnc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:23:54 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:42 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:35 +0200
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499325817-9166-7-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 6/8] s390x: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

The response for query-cpu-definitions didn't include the
unavailable-features field, which is used by libvirt to figure
out whether a certain cpu model is usable on the host.

The unavailable features are now computed by obtaining the host CPU
model and comparing it against the known CPU models. The comparison
takes into account the generation, the GA level and the feature
bitmaps. In the case of a CPU generation/GA level mismatch
a feature called "type" is reported to be missing.

As a result, the output of virsh domcapabilities would change
from something like
 ...
     <mode name='custom' supported='yes'>
      <model usable='unknown'>z10EC-base</model>
      <model usable='unknown'>z9EC-base</model>
      <model usable='unknown'>z196.2-base</model>
      <model usable='unknown'>z900-base</model>
      <model usable='unknown'>z990</model>
 ...
to
 ...
     <mode name='custom' supported='yes'>
      <model usable='yes'>z10EC-base</model>
      <model usable='yes'>z9EC-base</model>
      <model usable='no'>z196.2-base</model>
      <model usable='yes'>z900-base</model>
      <model usable='yes'>z990</model>
 ...

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Message-Id: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c | 62 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 63903c2..7cb55dc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -283,10 +283,41 @@ void s390_cpu_list(FILE *f, fprintf_function print)
     }
 }
 
+static S390CPUModel *get_max_cpu_model(Error **errp);
+
 #ifndef CONFIG_USER_ONLY
+static void list_add_feat(const char *name, void *opaque);
+
+static void check_unavailable_features(const S390CPUModel *max_model,
+                                       const S390CPUModel *model,
+                                       strList **unavailable)
+{
+    S390FeatBitmap missing;
+
+    /* check general model compatibility */
+    if (max_model->def->gen < model->def->gen ||
+        (max_model->def->gen == model->def->gen &&
+         max_model->def->ec_ga < model->def->ec_ga)) {
+        list_add_feat("type", unavailable);
+    }
+
+    /* detect missing features if any to properly report them */
+    bitmap_andnot(missing, model->features, max_model->features,
+                  S390_FEAT_MAX);
+    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
+        s390_feat_bitmap_to_ascii(missing, unavailable, list_add_feat);
+    }
+}
+
+struct CpuDefinitionInfoListData {
+    CpuDefinitionInfoList *list;
+    S390CPUModel *model;
+};
+
 static void create_cpu_model_list(ObjectClass *klass, void *opaque)
 {
-    CpuDefinitionInfoList **cpu_list = opaque;
+    struct CpuDefinitionInfoListData *cpu_list_data = opaque;
+    CpuDefinitionInfoList **cpu_list = &cpu_list_data->list;
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
     char *name = g_strdup(object_class_get_name(klass));
@@ -300,7 +331,19 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     info->migration_safe = scc->is_migration_safe;
     info->q_static = scc->is_static;
     info->q_typename = g_strdup(object_class_get_name(klass));
-
+    /* check for unavailable features */
+    if (cpu_list_data->model) {
+        Object *obj;
+        S390CPU *sc;
+        obj = object_new(object_class_get_name(klass));
+        sc = S390_CPU(obj);
+        if (sc->model) {
+            info->has_unavailable_features = true;
+            check_unavailable_features(cpu_list_data->model, sc->model,
+                                       &info->unavailable_features);
+        }
+        object_unref(obj);
+    }
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
@@ -310,11 +353,20 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
 
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *list = NULL;
+    struct CpuDefinitionInfoListData list_data = {
+        .list = NULL,
+    };
 
-    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false, &list);
+    list_data.model = get_max_cpu_model(errp);
+    if (*errp) {
+        error_free(*errp);
+        *errp = NULL;
+    }
 
-    return list;
+    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,
+                         &list_data);
+
+    return list_data.list;
 }
 
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
-- 
2.7.4
