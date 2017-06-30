Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1dQvvc-0006oa-HD
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1dQvvX-0003Kn-JC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:25:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46772
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1dQvvX-0003K5-CF
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:25:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5UDOBUh020555
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 09:25:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bdk8bjvth-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 09:25:37 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Fri, 30 Jun 2017 14:25:35 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 15:25:33 +0200
Message-Id: <1498829133-20598-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, david@redhat.com

The response for query-cpu-definitions didn't include the
unavailable-features field, which is used by libvirt to figure
out whether a certain cpu model is usable on the host.

The unavailable features are now computed by obtaining the host CPU
model and comparing its feature bitmap with the feature bitmaps of
the known CPU models.

I.e. the output of virsh domcapabilities would change from
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
---
 target/s390x/cpu_models.c | 51 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 63903c2..dc3371f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -283,14 +283,43 @@ void s390_cpu_list(FILE *f, fprintf_function print)
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
+    /* detect missing features if any to properly report them */
+    bitmap_andnot(missing, model->features, max_model->features,
+                  S390_FEAT_MAX);
+    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
+        s390_feat_bitmap_to_ascii(missing,
+                                  unavailable,
+                                  list_add_feat);
+    }
+}
+
+struct CpuDefinitionInfoListData {
+    CpuDefinitionInfoList *list;
+    Error **errp;
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
     S390CPUClass *scc = S390_CPU_CLASS(klass);
+    Object *obj;
+    S390CPU *sc;
+    S390CPUModel *scm;
 
     /* strip off the -s390-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
@@ -300,21 +329,33 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     info->migration_safe = scc->is_migration_safe;
     info->q_static = scc->is_static;
     info->q_typename = g_strdup(object_class_get_name(klass));
-
+    /* check for unavailable features */
+    obj = object_new(object_class_get_name(klass));
+    sc = S390_CPU(obj);
+    scm = get_max_cpu_model(cpu_list_data->errp);
+    if (scm && sc->model) {
+        info->has_unavailable_features = true;
+        check_unavailable_features(scm, sc->model, &info->unavailable_features);
+    }
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
     entry->next = *cpu_list;
     *cpu_list = entry;
+    object_unref(obj);
 }
 
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *list = NULL;
+    struct CpuDefinitionInfoListData list_data = {
+        .list = NULL,
+        .errp = errp,
+    };
 
-    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false, &list);
+    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,
+                         &list_data);
 
-    return list;
+    return list_data.list;
 }
 
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
-- 
1.9.1
