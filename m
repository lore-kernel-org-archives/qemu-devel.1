Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90340C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C29E21835
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0cv-0000Nl-CO
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Q5-0000zB-KQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0Q1-000493-Pf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0Q1-00047R-0F
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76BB883F3D;
 Fri, 11 Oct 2019 19:17:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4807B5D6C8;
 Fri, 11 Oct 2019 19:17:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 21/21] migration: Support gtree migration
Date: Fri, 11 Oct 2019 20:16:46 +0100
Message-Id: <20191011191646.226814-22-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 19:17:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Introduce support for GTree migration. A custom save/restore
is implemented. Each item is made of a key and a data.

If the key is a pointer to an object, 2 VMSDs are passed into
the GTree VMStateField.

When putting the items, the tree is traversed in sorted order by
g_tree_foreach.

On the get() path, gtrees must be allocated using the proper
key compare, key destroy and value destroy. This must be handled
beforehand, for example in a pre_load method.

Tests are added to test save/dump of structs containing gtrees
including the virtio-iommu domain/mappings scenario.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20191011121724.433-1-eric.auger@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  uintptr_t fixup for test on 32bit
---
 include/migration/vmstate.h |  40 ++++
 migration/trace-events      |   5 +
 migration/vmstate-types.c   | 152 +++++++++++++
 tests/test-vmstate.c        | 421 ++++++++++++++++++++++++++++++++++++
 4 files changed, 618 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1fbfd099dd..b9ee563aa4 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -224,6 +224,7 @@ extern const VMStateInfo vmstate_info_unused_buffer;
 extern const VMStateInfo vmstate_info_tmp;
 extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
+extern const VMStateInfo vmstate_info_gtree;
=20
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -754,6 +755,45 @@ extern const VMStateInfo vmstate_info_qtailq;
     .start        =3D offsetof(_type, _next),                           =
   \
 }
=20
+/*
+ * For migrating a GTree whose key is a pointer to _key_type and the
+ * value, a pointer to _val_type
+ * The target tree must have been properly initialized
+ * _vmsd: Start address of the 2 element array containing the data vmsd
+ *        and the key vmsd, in that order
+ * _key_type: type of the key
+ * _val_type: type of the value
+ */
+#define VMSTATE_GTREE_V(_field, _state, _version, _vmsd,                =
       \
+                        _key_type, _val_type)                           =
       \
+{                                                                       =
       \
+    .name         =3D (stringify(_field)),                              =
         \
+    .version_id   =3D (_version),                                       =
         \
+    .vmsd         =3D (_vmsd),                                          =
         \
+    .info         =3D &vmstate_info_gtree,                              =
         \
+    .start        =3D sizeof(_key_type),                                =
         \
+    .size         =3D sizeof(_val_type),                                =
         \
+    .offset       =3D offsetof(_state, _field),                         =
         \
+}
+
+/*
+ * For migrating a GTree with direct key and the value a pointer
+ * to _val_type
+ * The target tree must have been properly initialized
+ * _vmsd: data vmsd
+ * _val_type: type of the value
+ */
+#define VMSTATE_GTREE_DIRECT_KEY_V(_field, _state, _version, _vmsd, _val=
_type) \
+{                                                                       =
       \
+    .name         =3D (stringify(_field)),                              =
         \
+    .version_id   =3D (_version),                                       =
         \
+    .vmsd         =3D (_vmsd),                                          =
         \
+    .info         =3D &vmstate_info_gtree,                              =
         \
+    .start        =3D 0,                                                =
         \
+    .size         =3D sizeof(_val_type),                                =
         \
+    .offset       =3D offsetof(_state, _field),                         =
         \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/migration/trace-events b/migration/trace-events
index 858d415d56..6dee7b5389 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -71,6 +71,11 @@ get_qtailq_end(const char *name, const char *reason, i=
nt val) "%s %s/%d"
 put_qtailq(const char *name, int version_id) "%s v%d"
 put_qtailq_end(const char *name, const char *reason) "%s %s"
=20
+get_gtree(const char *field_name, const char *key_vmsd_name, const char =
*val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=3D%d"
+get_gtree_end(const char *field_name, const char *key_vmsd_name, const c=
har *val_vmsd_name, int ret) "%s(%s/%s) %d"
+put_gtree(const char *field_name, const char *key_vmsd_name, const char =
*val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=3D%d"
+put_gtree_end(const char *field_name, const char *key_vmsd_name, const c=
har *val_vmsd_name, int ret) "%s(%s/%s) %d"
+
 # qemu-file.c
 qemu_file_fclose(void) ""
=20
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index bee658a1b2..7236cf92bc 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -691,3 +691,155 @@ const VMStateInfo vmstate_info_qtailq =3D {
     .get  =3D get_qtailq,
     .put  =3D put_qtailq,
 };
+
+struct put_gtree_data {
+    QEMUFile *f;
+    const VMStateDescription *key_vmsd;
+    const VMStateDescription *val_vmsd;
+    QJSON *vmdesc;
+    int ret;
+};
+
+static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer da=
ta)
+{
+    struct put_gtree_data *capsule =3D (struct put_gtree_data *)data;
+    QEMUFile *f =3D capsule->f;
+    int ret;
+
+    qemu_put_byte(f, true);
+
+    /* put the key */
+    if (!capsule->key_vmsd) {
+        qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
+    } else {
+        ret =3D vmstate_save_state(f, capsule->key_vmsd, key, capsule->v=
mdesc);
+        if (ret) {
+            capsule->ret =3D ret;
+            return true;
+        }
+    }
+
+    /* put the data */
+    ret =3D vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmd=
esc);
+    if (ret) {
+        capsule->ret =3D ret;
+        return true;
+    }
+    return false;
+}
+
+static int put_gtree(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field, QJSON *vmdesc)
+{
+    bool direct_key =3D (!field->start);
+    const VMStateDescription *key_vmsd =3D direct_key ? NULL : &field->v=
msd[1];
+    const VMStateDescription *val_vmsd =3D &field->vmsd[0];
+    const char *key_vmsd_name =3D direct_key ? "direct" : key_vmsd->name=
;
+    struct put_gtree_data capsule =3D {
+        .f =3D f,
+        .key_vmsd =3D key_vmsd,
+        .val_vmsd =3D val_vmsd,
+        .vmdesc =3D vmdesc,
+        .ret =3D 0};
+    GTree **pval =3D pv;
+    GTree *tree =3D *pval;
+    uint32_t nnodes =3D g_tree_nnodes(tree);
+    int ret;
+
+    trace_put_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
+    qemu_put_be32(f, nnodes);
+    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
+    qemu_put_byte(f, false);
+    ret =3D capsule.ret;
+    if (ret) {
+        error_report("%s : failed to save gtree (%d)", field->name, ret)=
;
+    }
+    trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret)=
;
+    return ret;
+}
+
+static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field)
+{
+    bool direct_key =3D (!field->start);
+    const VMStateDescription *key_vmsd =3D direct_key ? NULL : &field->v=
msd[1];
+    const VMStateDescription *val_vmsd =3D &field->vmsd[0];
+    const char *key_vmsd_name =3D direct_key ? "direct" : key_vmsd->name=
;
+    int version_id =3D field->version_id;
+    size_t key_size =3D field->start;
+    size_t val_size =3D field->size;
+    int nnodes, count =3D 0;
+    GTree **pval =3D pv;
+    GTree *tree =3D *pval;
+    void *key, *val;
+    int ret =3D 0;
+
+    /* in case of direct key, the key vmsd can be {}, ie. check fields *=
/
+    if (!direct_key && version_id > key_vmsd->version_id) {
+        error_report("%s %s",  key_vmsd->name, "too new");
+        return -EINVAL;
+    }
+    if (!direct_key && version_id < key_vmsd->minimum_version_id) {
+        error_report("%s %s",  key_vmsd->name, "too old");
+        return -EINVAL;
+    }
+    if (version_id > val_vmsd->version_id) {
+        error_report("%s %s",  val_vmsd->name, "too new");
+        return -EINVAL;
+    }
+    if (version_id < val_vmsd->minimum_version_id) {
+        error_report("%s %s",  val_vmsd->name, "too old");
+        return -EINVAL;
+    }
+
+    nnodes =3D qemu_get_be32(f);
+    trace_get_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
+
+    while (qemu_get_byte(f)) {
+        if ((++count) > nnodes) {
+            ret =3D -EINVAL;
+            break;
+        }
+        if (direct_key) {
+            key =3D (void *)(uintptr_t)qemu_get_be64(f);
+        } else {
+            key =3D g_malloc0(key_size);
+            ret =3D vmstate_load_state(f, key_vmsd, key, version_id);
+            if (ret) {
+                error_report("%s : failed to load %s (%d)",
+                             field->name, key_vmsd->name, ret);
+                goto key_error;
+            }
+        }
+        val =3D g_malloc0(val_size);
+        ret =3D vmstate_load_state(f, val_vmsd, val, version_id);
+        if (ret) {
+            error_report("%s : failed to load %s (%d)",
+                         field->name, val_vmsd->name, ret);
+            goto val_error;
+        }
+        g_tree_insert(tree, key, val);
+    }
+    if (count !=3D nnodes) {
+        error_report("%s inconsistent stream when loading the gtree",
+                     field->name);
+        return -EINVAL;
+    }
+    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret)=
;
+    return ret;
+val_error:
+    g_free(val);
+key_error:
+    if (!direct_key) {
+        g_free(key);
+    }
+    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret)=
;
+    return ret;
+}
+
+
+const VMStateInfo vmstate_info_gtree =3D {
+    .name =3D "gtree",
+    .get  =3D get_gtree,
+    .put  =3D put_gtree,
+};
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index e80c4c6143..1e5be1d4ff 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -812,6 +812,423 @@ static void test_load_q(void)
     qemu_fclose(fload);
 }
=20
+/* interval (key) */
+typedef struct TestGTreeInterval {
+    uint64_t low;
+    uint64_t high;
+} TestGTreeInterval;
+
+#define VMSTATE_INTERVAL                               \
+{                                                      \
+    .name =3D "interval",                                \
+    .version_id =3D 1,                                   \
+    .minimum_version_id =3D 1,                           \
+    .fields =3D (VMStateField[]) {                       \
+        VMSTATE_UINT64(low, TestGTreeInterval),        \
+        VMSTATE_UINT64(high, TestGTreeInterval),       \
+        VMSTATE_END_OF_LIST()                          \
+    }                                                  \
+}
+
+/* mapping (value) */
+typedef struct TestGTreeMapping {
+    uint64_t phys_addr;
+    uint32_t flags;
+} TestGTreeMapping;
+
+#define VMSTATE_MAPPING                               \
+{                                                     \
+    .name =3D "mapping",                                \
+    .version_id =3D 1,                                  \
+    .minimum_version_id =3D 1,                          \
+    .fields =3D (VMStateField[]) {                      \
+        VMSTATE_UINT64(phys_addr, TestGTreeMapping),  \
+        VMSTATE_UINT32(flags, TestGTreeMapping),      \
+        VMSTATE_END_OF_LIST()                         \
+    },                                                \
+}
+
+static const VMStateDescription vmstate_interval_mapping[2] =3D {
+    VMSTATE_MAPPING,   /* value */
+    VMSTATE_INTERVAL   /* key   */
+};
+
+typedef struct TestGTreeDomain {
+    int32_t  id;
+    GTree    *mappings;
+} TestGTreeDomain;
+
+typedef struct TestGTreeIOMMU {
+    int32_t  id;
+    GTree    *domains;
+} TestGTreeIOMMU;
+
+/* Interval comparison function */
+static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user=
_data)
+{
+    TestGTreeInterval *inta =3D (TestGTreeInterval *)a;
+    TestGTreeInterval *intb =3D (TestGTreeInterval *)b;
+
+    if (inta->high < intb->low) {
+        return -1;
+    } else if (intb->high < inta->low) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+/* ID comparison function */
+static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
+{
+    uint ua =3D GPOINTER_TO_UINT(a);
+    uint ub =3D GPOINTER_TO_UINT(b);
+    return (ua > ub) - (ua < ub);
+}
+
+static void destroy_domain(gpointer data)
+{
+    TestGTreeDomain *domain =3D (TestGTreeDomain *)data;
+
+    g_tree_destroy(domain->mappings);
+    g_free(domain);
+}
+
+static int domain_preload(void *opaque)
+{
+    TestGTreeDomain *domain =3D opaque;
+
+    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                       NULL, g_free, g_free);
+    return 0;
+}
+
+static int iommu_preload(void *opaque)
+{
+    TestGTreeIOMMU *iommu =3D opaque;
+
+    iommu->domains =3D g_tree_new_full((GCompareDataFunc)int_cmp,
+                                     NULL, NULL, destroy_domain);
+    return 0;
+}
+
+static const VMStateDescription vmstate_domain =3D {
+    .name =3D "domain",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .pre_load =3D domain_preload,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_INT32(id, TestGTreeDomain),
+        VMSTATE_GTREE_V(mappings, TestGTreeDomain, 1,
+                        vmstate_interval_mapping,
+                        TestGTreeInterval, TestGTreeMapping),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_iommu =3D {
+    .name =3D "iommu",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .pre_load =3D iommu_preload,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_INT32(id, TestGTreeIOMMU),
+        VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
+                                   &vmstate_domain, TestGTreeDomain),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+uint8_t first_domain_dump[] =3D {
+    /* id */
+    0x00, 0x0, 0x0, 0x6,
+    0x00, 0x0, 0x0, 0x2, /* 2 mappings */
+    0x1, /* start of a */
+    /* a */
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
+    /* map_a */
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
+    0x00, 0x00, 0x00, 0x01,
+    0x1, /* start of b */
+    /* b */
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
+    /* map_b */
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x02,
+    0x0, /* end of gtree */
+    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely=
 */
+};
+
+static TestGTreeDomain *create_first_domain(void)
+{
+    TestGTreeDomain *domain;
+    TestGTreeMapping *map_a, *map_b;
+    TestGTreeInterval *a, *b;
+
+    domain =3D g_malloc0(sizeof(TestGTreeDomain));
+    domain->id =3D 6;
+
+    a =3D g_malloc0(sizeof(TestGTreeInterval));
+    a->low =3D 0x1000;
+    a->high =3D 0x1FFF;
+
+    b =3D g_malloc0(sizeof(TestGTreeInterval));
+    b->low =3D 0x4000;
+    b->high =3D 0x4FFF;
+
+    map_a =3D g_malloc0(sizeof(TestGTreeMapping));
+    map_a->phys_addr =3D 0xa000;
+    map_a->flags =3D 1;
+
+    map_b =3D g_malloc0(sizeof(TestGTreeMapping));
+    map_b->phys_addr =3D 0xe0000;
+    map_b->flags =3D 2;
+
+    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,=
 NULL,
+                                        (GDestroyNotify)g_free,
+                                        (GDestroyNotify)g_free);
+    g_tree_insert(domain->mappings, a, map_a);
+    g_tree_insert(domain->mappings, b, map_b);
+    return domain;
+}
+
+static void test_gtree_save_domain(void)
+{
+    TestGTreeDomain *first_domain =3D create_first_domain();
+
+    save_vmstate(&vmstate_domain, first_domain);
+    compare_vmstate(first_domain_dump, sizeof(first_domain_dump));
+    destroy_domain(first_domain);
+}
+
+struct match_node_data {
+    GTree *tree;
+    gpointer key;
+    gpointer value;
+};
+
+struct tree_cmp_data {
+    GTree *tree1;
+    GTree *tree2;
+    GTraverseFunc match_node;
+};
+
+static gboolean match_interval_mapping_node(gpointer key,
+                                            gpointer value, gpointer dat=
a)
+{
+    TestGTreeMapping *map_a, *map_b;
+    TestGTreeInterval *a, *b;
+    struct match_node_data *d =3D (struct match_node_data *)data;
+    char *str =3D g_strdup_printf("dest");
+
+    g_free(str);
+    a =3D (TestGTreeInterval *)key;
+    b =3D (TestGTreeInterval *)d->key;
+
+    map_a =3D (TestGTreeMapping *)value;
+    map_b =3D (TestGTreeMapping *)d->value;
+
+    assert(a->low =3D=3D b->low);
+    assert(a->high =3D=3D b->high);
+    assert(map_a->phys_addr =3D=3D map_b->phys_addr);
+    assert(map_a->flags =3D=3D map_b->flags);
+    g_tree_remove(d->tree, key);
+    return true;
+}
+
+static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
+{
+    struct tree_cmp_data *tp =3D (struct tree_cmp_data *)data;
+    struct match_node_data d =3D {tp->tree2, key, value};
+
+    g_tree_foreach(tp->tree2, tp->match_node, &d);
+    g_tree_remove(tp->tree1, key);
+    return false;
+}
+
+static void compare_trees(GTree *tree1, GTree *tree2,
+                          GTraverseFunc function)
+{
+    struct tree_cmp_data tp =3D {tree1, tree2, function};
+
+    g_tree_foreach(tree1, diff_tree, &tp);
+    assert(g_tree_nnodes(tree1) =3D=3D 0);
+    assert(g_tree_nnodes(tree2) =3D=3D 0);
+}
+
+static void diff_domain(TestGTreeDomain *d1, TestGTreeDomain *d2)
+{
+    assert(d1->id =3D=3D d2->id);
+    compare_trees(d1->mappings, d2->mappings, match_interval_mapping_nod=
e);
+}
+
+static gboolean match_domain_node(gpointer key, gpointer value, gpointer=
 data)
+{
+    uint64_t id1, id2;
+    TestGTreeDomain *d1, *d2;
+    struct match_node_data *d =3D (struct match_node_data *)data;
+
+    id1 =3D (uint64_t)(uintptr_t)key;
+    id2 =3D (uint64_t)(uintptr_t)d->key;
+    d1 =3D (TestGTreeDomain *)value;
+    d2 =3D (TestGTreeDomain *)d->value;
+    assert(id1 =3D=3D id2);
+    diff_domain(d1, d2);
+    g_tree_remove(d->tree, key);
+    return true;
+}
+
+static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
+{
+    assert(iommu1->id =3D=3D iommu2->id);
+    compare_trees(iommu1->domains, iommu2->domains, match_domain_node);
+}
+
+static void test_gtree_load_domain(void)
+{
+    TestGTreeDomain *dest_domain =3D g_malloc0(sizeof(TestGTreeDomain));
+    TestGTreeDomain *orig_domain =3D create_first_domain();
+    QEMUFile *fload, *fsave;
+    char eof;
+
+    fsave =3D open_test_file(true);
+    qemu_put_buffer(fsave, first_domain_dump, sizeof(first_domain_dump))=
;
+    g_assert(!qemu_file_get_error(fsave));
+    qemu_fclose(fsave);
+
+    fload =3D open_test_file(false);
+
+    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
+    eof =3D qemu_get_byte(fload);
+    g_assert(!qemu_file_get_error(fload));
+    g_assert_cmpint(orig_domain->id, =3D=3D, dest_domain->id);
+    g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
+
+    diff_domain(orig_domain, dest_domain);
+    destroy_domain(orig_domain);
+    destroy_domain(dest_domain);
+    qemu_fclose(fload);
+}
+
+uint8_t iommu_dump[] =3D {
+    /* iommu id */
+    0x00, 0x0, 0x0, 0x7,
+    0x00, 0x0, 0x0, 0x2, /* 2 domains */
+    0x1,/* start of domain 5 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x0, 0x0, 0x5, /* key =3D 5 */
+        0x00, 0x0, 0x0, 0x5, /* domain1 id */
+        0x00, 0x0, 0x0, 0x1, /* 1 mapping */
+        0x1, /* start of mappings */
+            /* c */
+            0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+            0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0xFF,
+            /* map_c */
+            0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
+            0x00, 0x0, 0x0, 0x3,
+            0x0, /* end of domain1 mappings*/
+    0x1,/* start of domain 6 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x0, 0x0, 0x6, /* key =3D 6 */
+        0x00, 0x0, 0x0, 0x6, /* domain6 id */
+            0x00, 0x0, 0x0, 0x2, /* 2 mappings */
+            0x1, /* start of a */
+            /* a */
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
+            /* map_a */
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
+            0x00, 0x00, 0x00, 0x01,
+            0x1, /* start of b */
+            /* b */
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
+            /* map_b */
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
+            0x00, 0x00, 0x00, 0x02,
+            0x0, /* end of domain6 mappings*/
+    0x0, /* end of domains */
+    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely=
 */
+};
+
+static TestGTreeIOMMU *create_iommu(void)
+{
+    TestGTreeIOMMU *iommu =3D g_malloc0(sizeof(TestGTreeIOMMU));
+    TestGTreeDomain *first_domain =3D create_first_domain();
+    TestGTreeDomain *second_domain;
+    TestGTreeMapping *map_c;
+    TestGTreeInterval *c;
+
+    iommu->id =3D 7;
+    iommu->domains =3D g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
+                                     NULL,
+                                     destroy_domain);
+
+    second_domain =3D g_malloc0(sizeof(TestGTreeDomain));
+    second_domain->id =3D 5;
+    second_domain->mappings =3D g_tree_new_full((GCompareDataFunc)interv=
al_cmp,
+                                              NULL,
+                                              (GDestroyNotify)g_free,
+                                              (GDestroyNotify)g_free);
+
+    g_tree_insert(iommu->domains, GUINT_TO_POINTER(6), first_domain);
+    g_tree_insert(iommu->domains, (gpointer)0x0000000000000005, second_d=
omain);
+
+    c =3D g_malloc0(sizeof(TestGTreeInterval));
+    c->low =3D 0x1000000;
+    c->high =3D 0x1FFFFFF;
+
+    map_c =3D g_malloc0(sizeof(TestGTreeMapping));
+    map_c->phys_addr =3D 0xF000000;
+    map_c->flags =3D 0x3;
+
+    g_tree_insert(second_domain->mappings, c, map_c);
+    return iommu;
+}
+
+static void destroy_iommu(TestGTreeIOMMU *iommu)
+{
+    g_tree_destroy(iommu->domains);
+    g_free(iommu);
+}
+
+static void test_gtree_save_iommu(void)
+{
+    TestGTreeIOMMU *iommu =3D create_iommu();
+
+    save_vmstate(&vmstate_iommu, iommu);
+    compare_vmstate(iommu_dump, sizeof(iommu_dump));
+    destroy_iommu(iommu);
+}
+
+static void test_gtree_load_iommu(void)
+{
+    TestGTreeIOMMU *dest_iommu =3D g_malloc0(sizeof(TestGTreeIOMMU));
+    TestGTreeIOMMU *orig_iommu =3D create_iommu();
+    QEMUFile *fsave, *fload;
+    char eof;
+    int ret;
+
+    fsave =3D open_test_file(true);
+    qemu_put_buffer(fsave, iommu_dump, sizeof(iommu_dump));
+    g_assert(!qemu_file_get_error(fsave));
+    qemu_fclose(fsave);
+
+    fload =3D open_test_file(false);
+    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
+    ret =3D qemu_file_get_error(fload);
+    eof =3D qemu_get_byte(fload);
+    ret =3D qemu_file_get_error(fload);
+    g_assert(!ret);
+    g_assert_cmpint(orig_iommu->id, =3D=3D, dest_iommu->id);
+    g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
+
+    diff_iommu(orig_iommu, dest_iommu);
+    destroy_iommu(orig_iommu);
+    destroy_iommu(dest_iommu);
+    qemu_fclose(fload);
+}
+
 typedef struct TmpTestStruct {
     TestStruct *parent;
     int64_t diff;
@@ -932,6 +1349,10 @@ int main(int argc, char **argv)
                     test_arr_ptr_prim_0_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
+    g_test_add_func("/vmstate/gtree/save/savedomain", test_gtree_save_do=
main);
+    g_test_add_func("/vmstate/gtree/load/loaddomain", test_gtree_load_do=
main);
+    g_test_add_func("/vmstate/gtree/save/saveiommu", test_gtree_save_iom=
mu);
+    g_test_add_func("/vmstate/gtree/load/loadiommu", test_gtree_load_iom=
mu);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
     g_test_run();
=20
--=20
2.23.0


