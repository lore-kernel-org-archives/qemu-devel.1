Received: from eggs.gnu.org ([2001:4830:134:3::10]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRKmb-00048W-NX
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRKmX-0005bS-Lw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:02:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fRKmX-0005av-HJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D65F27D85A
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 17:02:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-1.ams2.redhat.com [10.36.117.1])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 94EC01D084
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 17:02:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Jun 2018 19:02:31 +0200
Message-Id: <20180608170231.27912-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We banned use of certain g_assert_FOO() functions outside tests, and
made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
purge existing uses.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ide/ahci.c                 |  2 +-
 hw/ppc/spapr_ovec.c           | 12 ++++++------
 hw/usb/dev-smartcard-reader.c |  2 +-
 qom/object.c                  | 10 +++++-----
 util/qht.c                    |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 24dbad5125..75cccbea47 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -387,7 +387,7 @@ static uint64_t ahci_mem_read(void *opaque, hwaddr addr, unsigned size)
     if (ofst + size <= 4) {
         val = lo >> (ofst * 8);
     } else {
-        g_assert_cmpint(size, >, 1);
+        g_assert(size > 1);
 
         /* If the 64bit read is unaligned, we will produce undefined
          * results. AHCI does not support unaligned 64bit reads. */
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c35ba..318bf33de4 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -113,7 +113,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov)
 void spapr_ovec_set(sPAPROptionVector *ov, long bitnr)
 {
     g_assert(ov);
-    g_assert_cmpint(bitnr, <, OV_MAXBITS);
+    g_assert(bitnr < OV_MAXBITS);
 
     set_bit(bitnr, ov->bitmap);
 }
@@ -121,7 +121,7 @@ void spapr_ovec_set(sPAPROptionVector *ov, long bitnr)
 void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr)
 {
     g_assert(ov);
-    g_assert_cmpint(bitnr, <, OV_MAXBITS);
+    g_assert(bitnr < OV_MAXBITS);
 
     clear_bit(bitnr, ov->bitmap);
 }
@@ -129,7 +129,7 @@ void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr)
 bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
 {
     g_assert(ov);
-    g_assert_cmpint(bitnr, <, OV_MAXBITS);
+    g_assert(bitnr < OV_MAXBITS);
 
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
@@ -186,7 +186,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector)
     int i;
 
     g_assert(table_addr);
-    g_assert_cmpint(vector, >=, 1); /* vector numbering starts at 1 */
+    g_assert(vector >= 1);      /* vector numbering starts at 1 */
 
     addr = vector_addr(table_addr, vector);
     if (!addr) {
@@ -195,7 +195,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector)
     }
 
     vector_len = ldub_phys(&address_space_memory, addr++) + 1;
-    g_assert_cmpint(vector_len, <=, OV_MAXBYTES);
+    g_assert(vector_len <= OV_MAXBYTES);
     ov = spapr_ovec_new();
 
     for (i = 0; i < vector_len; i++) {
@@ -225,7 +225,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
      * encoding/sizing expected in ibm,client-architecture-support
      */
     vec_len = (lastbit == OV_MAXBITS) ? 1 : lastbit / BITS_PER_BYTE + 1;
-    g_assert_cmpint(vec_len, <=, OV_MAXBYTES);
+    g_assert(vec_len <= OV_MAXBYTES);
     /* guest expects vector len encoded as vec_len - 1, since the length byte
      * is assumed and not included, and the first byte of the vector
      * is assumed as well
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 2131e33d27..13d0befd9c 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -786,7 +786,7 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
         DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
     }
     if (len) {
-        g_assert_nonnull(data);
+        assert(data);
         memcpy(p->abData, data, len);
     }
     ccid_reset_error_status(s);
diff --git a/qom/object.c b/qom/object.c
index cb7a8cd589..794bd9a3f5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -295,7 +295,7 @@ static void type_initialize(TypeImpl *ti)
         GSList *e;
         int i;
 
-        g_assert_cmpint(parent->class_size, <=, ti->class_size);
+        g_assert(parent->class_size <= ti->class_size);
         memcpy(ti->class, parent->class, parent->class_size);
         ti->class->interfaces = NULL;
         ti->class->properties = g_hash_table_new_full(
@@ -372,9 +372,9 @@ static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
     g_assert(type != NULL);
     type_initialize(type);
 
-    g_assert_cmpint(type->instance_size, >=, sizeof(Object));
+    g_assert(type->instance_size >= sizeof(Object));
     g_assert(type->abstract == false);
-    g_assert_cmpint(size, >=, type->instance_size);
+    g_assert(size >= type->instance_size);
 
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
@@ -475,7 +475,7 @@ static void object_finalize(void *data)
     object_property_del_all(obj);
     object_deinit(obj, ti);
 
-    g_assert_cmpint(obj->ref, ==, 0);
+    g_assert(obj->ref == 0);
     if (obj->free) {
         obj->free(obj);
     }
@@ -917,7 +917,7 @@ void object_unref(Object *obj)
     if (!obj) {
         return;
     }
-    g_assert_cmpint(obj->ref, >, 0);
+    g_assert(obj->ref > 0);
 
     /* parent always holds a reference to its children */
     if (atomic_fetch_dec(&obj->ref) == 1) {
diff --git a/util/qht.c b/util/qht.c
index ff4d2e6974..55b0738cd1 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -759,7 +759,7 @@ static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
         return;
     }
 
-    g_assert_cmpuint(new->n_buckets, !=, old->n_buckets);
+    g_assert(new->n_buckets != old->n_buckets);
     qht_map_iter__all_locked(ht, old, qht_map_copy, new);
     qht_map_debug__all_locked(new);
 
-- 
2.17.1
