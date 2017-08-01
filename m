Received: from eggs.gnu.org ([2001:4830:134:3::10]:59610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrc-0004Q9-7p
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZra-0007FK-8Q
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:44 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZra-0007Er-1p
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:42 -0400
Received: by mail-wr0-x243.google.com with SMTP id o33so1802788wrb.1
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:41 -0700 (PDT)
Received: from 640k.lan (94-39-192-75.adsl-ull.clienti.tiscali.it.
	[94.39.192.75]) by smtp.gmail.com with ESMTPSA id
	u187sm1724160wmd.26.2017.08.01.09.17.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Aug 2017 09:17:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:17 +0200
Message-Id: <1501604245-33460-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/17] bt: stop the sdp memory allocation
 craziness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Clang static analyzer reports a memory leak.  Actually, the allocated
memory escapes here:

        record->attribute_list[record->attributes].pair = data;

but clang is correct that the memory might leak if len is zero.  We
know it isn't; assert that it is the case.

The craziness doesn't end there.  The memory is freed by
bt_l2cap_sdp_close_ch:

       g_free(sdp->service_list[i].attribute_list->pair);

which actually should have been written like this:

       g_free(sdp->service_list[i].attribute_list[0].pair);

The attribute_list is sorted with qsort; but indeed the first
entry of attribute_list should point to "data" even after the qsort,
because the first record has id SDP_ATTR_RECORD_HANDLE, whose
numeric value is zero.

But hang on.  The qsort function is

    static int sdp_attributeid_compare(
                const struct sdp_service_attribute_s *a,
                const struct sdp_service_attribute_s *b)
    {
        return (int) b->attribute_id - a->attribute_id;
    }

but no one ever writes attribute_id.  So it only works if qsort is
stable, and who knows what else is broken, but we can fix it by
setting attribute_id in the while loop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/bt/sdp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index f67b3b8..3cb60b9 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -580,7 +580,7 @@ static void bt_l2cap_sdp_close_ch(void *opaque)
     int i;
 
     for (i = 0; i < sdp->services; i ++) {
-        g_free(sdp->service_list[i].attribute_list->pair);
+        g_free(sdp->service_list[i].attribute_list[0].pair);
         g_free(sdp->service_list[i].attribute_list);
         g_free(sdp->service_list[i].uuid);
     }
@@ -720,6 +720,8 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
         len += sdp_attr_max_size(&def->attributes[record->attributes ++].data,
                         &record->uuids);
     }
+
+    assert(len > 0);
     record->uuids = pow2ceil(record->uuids);
     record->attribute_list =
             g_malloc0(record->attributes * sizeof(*record->attribute_list));
@@ -730,12 +732,14 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
     record->attributes = 0;
     uuid = record->uuid;
     while (def->attributes[record->attributes].data.type) {
+        int attribute_id = def->attributes[record->attributes].id;
         record->attribute_list[record->attributes].pair = data;
+        record->attribute_list[record->attributes].attribute_id = attribute_id;
 
         len = 0;
         data[len ++] = SDP_DTYPE_UINT | SDP_DSIZE_2;
-        data[len ++] = def->attributes[record->attributes].id >> 8;
-        data[len ++] = def->attributes[record->attributes].id & 0xff;
+        data[len ++] = attribute_id >> 8;
+        data[len ++] = attribute_id & 0xff;
         len += sdp_attr_write(data + len,
                         &def->attributes[record->attributes].data, &uuid);
 
@@ -749,10 +753,15 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
         data += len;
     }
 
-    /* Sort the attribute list by the AttributeID */
+    /* Sort the attribute list by the AttributeID.  The first must be
+     * SDP_ATTR_RECORD_HANDLE so that bt_l2cap_sdp_close_ch can free
+     * the buffer.
+     */
     qsort(record->attribute_list, record->attributes,
                     sizeof(*record->attribute_list),
                     (void *) sdp_attributeid_compare);
+    assert(record->attribute_list[0].pair == data);
+
     /* Sort the searchable UUIDs list for bisection */
     qsort(record->uuid, record->uuids,
                     sizeof(*record->uuid),
-- 
1.8.3.1
