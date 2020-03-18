Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB1C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993A12076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNRvSnLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993A12076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfPn-0005tk-Lc
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFl-00084W-Kw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFj-0004N3-14
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFi-0004MA-QA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2SZloJALWARRXQrRWIcseEswJ8GCx7hIkZZF9kViZ0=;
 b=VNRvSnLYOm3XFnnKmrc7tbqY2w6DtZbMlijnI+DtaQKzSPNj4U7EGsKd10MJlyw0k3Ok76
 C+dnmnHEO7t0pI4EaDis0F8l38SBxOaTeD3F5mvj9fsVzK5V8UKwnD+YzbXnF6UIeefpgt
 lTIXXxs/+50aRS2SM7dveh2zNViUBEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-G3E_0nHuOfqcHmQqXvPhuw-1; Wed, 18 Mar 2020 16:25:19 -0400
X-MC-Unique: G3E_0nHuOfqcHmQqXvPhuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A649C100726D;
 Wed, 18 Mar 2020 20:25:11 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA32D60BF1;
 Wed, 18 Mar 2020 20:25:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 09/11] nbd/server: introduce NBDExtentArray
Date: Wed, 18 Mar 2020 16:23:39 -0400
Message-Id: <20200318202341.6961-10-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Introduce NBDExtentArray class, to handle extents list creation in more
controlled way and with fewer OUT parameters in functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20200205112041.6003-9-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 nbd/server.c | 210 +++++++++++++++++++++++++++++----------------------
 1 file changed, 118 insertions(+), 92 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3106aaf3b4..f90bb33a75 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1909,27 +1909,98 @@ static int coroutine_fn nbd_co_send_sparse_read(NBD=
Client *client,
     return ret;
 }
=20
+typedef struct NBDExtentArray {
+    NBDExtent *extents;
+    unsigned int nb_alloc;
+    unsigned int count;
+    uint64_t total_length;
+    bool can_add;
+    bool converted_to_be;
+} NBDExtentArray;
+
+static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
+{
+    NBDExtentArray *ea =3D g_new0(NBDExtentArray, 1);
+
+    ea->nb_alloc =3D nb_alloc;
+    ea->extents =3D g_new(NBDExtent, nb_alloc);
+    ea->can_add =3D true;
+
+    return ea;
+}
+
+static void nbd_extent_array_free(NBDExtentArray *ea)
+{
+    g_free(ea->extents);
+    g_free(ea);
+}
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
+
+/* Further modifications of the array after conversion are abandoned */
+static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
+{
+    int i;
+
+    assert(!ea->converted_to_be);
+    ea->can_add =3D false;
+    ea->converted_to_be =3D true;
+
+    for (i =3D 0; i < ea->count; i++) {
+        ea->extents[i].flags =3D cpu_to_be32(ea->extents[i].flags);
+        ea->extents[i].length =3D cpu_to_be32(ea->extents[i].length);
+    }
+}
+
 /*
- * Populate @extents from block status. Update @bytes to be the actual
- * length encoded (which may be smaller than the original), and update
- * @nb_extents to the number of extents used.
- *
- * Returns zero on success and -errno on bdrv_block_status_above failure.
+ * Add extent to NBDExtentArray. If extent can't be added (no available sp=
ace),
+ * return -1.
+ * For safety, when returning -1 for the first time, .can_add is set to fa=
lse,
+ * further call to nbd_extent_array_add() will crash.
+ * (to avoid the situation, when after failing to add an extent (returned =
-1),
+ * user miss this failure and add another extent, which is successfully ad=
ded
+ * (array is full, but new extent may be squashed into the last one), then=
 we
+ * have invalid array with skipped extent)
  */
+static int nbd_extent_array_add(NBDExtentArray *ea,
+                                uint32_t length, uint32_t flags)
+{
+    assert(ea->can_add);
+
+    if (!length) {
+        return 0;
+    }
+
+    /* Extend previous extent if flags are the same */
+    if (ea->count > 0 && flags =3D=3D ea->extents[ea->count - 1].flags) {
+        uint64_t sum =3D (uint64_t)length + ea->extents[ea->count - 1].len=
gth;
+
+        if (sum <=3D UINT32_MAX) {
+            ea->extents[ea->count - 1].length =3D sum;
+            ea->total_length +=3D length;
+            return 0;
+        }
+    }
+
+    if (ea->count >=3D ea->nb_alloc) {
+        ea->can_add =3D false;
+        return -1;
+    }
+
+    ea->total_length +=3D length;
+    ea->extents[ea->count] =3D (NBDExtent) {.length =3D length, .flags =3D=
 flags};
+    ea->count++;
+
+    return 0;
+}
+
 static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
-                                  uint64_t *bytes, NBDExtent *extents,
-                                  unsigned int *nb_extents)
+                                  uint64_t bytes, NBDExtentArray *ea)
 {
-    uint64_t remaining_bytes =3D *bytes;
-    NBDExtent *extent =3D extents, *extents_end =3D extents + *nb_extents;
-    bool first_extent =3D true;
-
-    assert(*nb_extents);
-    while (remaining_bytes) {
+    while (bytes) {
         uint32_t flags;
         int64_t num;
-        int ret =3D bdrv_block_status_above(bs, NULL, offset, remaining_by=
tes,
-                                          &num, NULL, NULL);
+        int ret =3D bdrv_block_status_above(bs, NULL, offset, bytes, &num,
+                                          NULL, NULL);
=20
         if (ret < 0) {
             return ret;
@@ -1938,60 +2009,37 @@ static int blockstatus_to_extents(BlockDriverState =
*bs, uint64_t offset,
         flags =3D (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
                 (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
=20
-        if (first_extent) {
-            extent->flags =3D flags;
-            extent->length =3D num;
-            first_extent =3D false;
-        } else if (flags =3D=3D extent->flags) {
-            /* extend current extent */
-            extent->length +=3D num;
-        } else {
-            if (extent + 1 =3D=3D extents_end) {
-                break;
-            }
-
-            /* start new extent */
-            extent++;
-            extent->flags =3D flags;
-            extent->length =3D num;
+        if (nbd_extent_array_add(ea, num, flags) < 0) {
+            return 0;
         }
+
         offset +=3D num;
-        remaining_bytes -=3D num;
+        bytes -=3D num;
     }
=20
-    extents_end =3D extent + 1;
-
-    for (extent =3D extents; extent < extents_end; extent++) {
-        extent->flags =3D cpu_to_be32(extent->flags);
-        extent->length =3D cpu_to_be32(extent->length);
-    }
-
-    *bytes -=3D remaining_bytes;
-    *nb_extents =3D extents_end - extents;
-
     return 0;
 }
=20
-/* nbd_co_send_extents
+/*
+ * nbd_co_send_extents
  *
- * @length is only for tracing purposes (and may be smaller or larger
- * than the client's original request). @last controls whether
- * NBD_REPLY_FLAG_DONE is sent. @extents should already be in
- * big-endian format.
+ * @ea is converted to BE by the function
+ * @last controls whether NBD_REPLY_FLAG_DONE is sent.
  */
 static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
-                               NBDExtent *extents, unsigned int nb_extents=
,
-                               uint64_t length, bool last,
-                               uint32_t context_id, Error **errp)
+                               NBDExtentArray *ea,
+                               bool last, uint32_t context_id, Error **err=
p)
 {
     NBDStructuredMeta chunk;
-
     struct iovec iov[] =3D {
         {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
-        {.iov_base =3D extents, .iov_len =3D nb_extents * sizeof(extents[0=
])}
+        {.iov_base =3D ea->extents, .iov_len =3D ea->count * sizeof(ea->ex=
tents[0])}
     };
=20
-    trace_nbd_co_send_extents(handle, nb_extents, context_id, length, last=
);
+    nbd_extent_array_convert_to_be(ea);
+
+    trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_len=
gth,
+                              last);
     set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_BLOCK_STATUS,
                  handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len)=
;
@@ -2009,39 +2057,27 @@ static int nbd_co_send_block_status(NBDClient *clie=
nt, uint64_t handle,
 {
     int ret;
     unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_E=
XTENTS;
-    NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
-    uint64_t final_length =3D length;
+    g_autoptr(NBDExtentArray) ea =3D nbd_extent_array_new(nb_extents);
=20
-    ret =3D blockstatus_to_extents(bs, offset, &final_length, extents,
-                                 &nb_extents);
+    ret =3D blockstatus_to_extents(bs, offset, length, ea);
     if (ret < 0) {
-        g_free(extents);
         return nbd_co_send_structured_error(
                 client, handle, -ret, "can't get block status", errp);
     }
=20
-    ret =3D nbd_co_send_extents(client, handle, extents, nb_extents,
-                              final_length, last, context_id, errp);
-
-    g_free(extents);
-
-    return ret;
+    return nbd_co_send_extents(client, handle, ea, last, context_id, errp)=
;
 }
=20
 /*
- * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
- * final extent may exceed the original @length. Store in @length the
- * byte length encoded (which may be smaller or larger than the
- * original), and return the number of extents used.
+ * Populate @ea from a dirty bitmap. Unless @dont_fragment, the
+ * final extent may exceed the original @length.
  */
-static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t of=
fset,
-                                      uint64_t *length, NBDExtent *extents=
,
-                                      unsigned int nb_extents,
-                                      bool dont_fragment)
+static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
+                              uint64_t offset, uint64_t length,
+                              NBDExtentArray *ea, bool dont_fragment)
 {
     uint64_t begin =3D offset, end =3D offset;
-    uint64_t overall_end =3D offset + *length;
-    unsigned int i =3D 0;
+    uint64_t overall_end =3D offset + length;
     BdrvDirtyBitmapIter *it;
     bool dirty;
=20
@@ -2050,8 +2086,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap=
 *bitmap, uint64_t offset,
     it =3D bdrv_dirty_iter_new(bitmap);
     dirty =3D bdrv_dirty_bitmap_get_locked(bitmap, offset);
=20
-    assert(begin < overall_end && nb_extents);
-    while (begin < overall_end && i < nb_extents) {
+    while (begin < overall_end) {
         bool next_dirty =3D !dirty;
=20
         if (dirty) {
@@ -2071,9 +2106,10 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitma=
p *bitmap, uint64_t offset,
             end =3D overall_end;
         }
=20
-        extents[i].length =3D cpu_to_be32(end - begin);
-        extents[i].flags =3D cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
-        i++;
+        if (nbd_extent_array_add(ea, end - begin,
+                                 dirty ? NBD_STATE_DIRTY : 0) < 0) {
+            break;
+        }
         begin =3D end;
         dirty =3D next_dirty;
     }
@@ -2083,8 +2119,6 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap=
 *bitmap, uint64_t offset,
     bdrv_dirty_bitmap_unlock(bitmap);
=20
     assert(offset < end);
-    *length =3D end - offset;
-    return i;
 }
=20
 static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
@@ -2092,20 +2126,12 @@ static int nbd_co_send_bitmap(NBDClient *client, ui=
nt64_t handle,
                               uint32_t length, bool dont_fragment, bool la=
st,
                               uint32_t context_id, Error **errp)
 {
-    int ret;
     unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_E=
XTENTS;
-    NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
-    uint64_t final_length =3D length;
+    g_autoptr(NBDExtentArray) ea =3D nbd_extent_array_new(nb_extents);
=20
-    nb_extents =3D bitmap_to_extents(bitmap, offset, &final_length, extent=
s,
-                                   nb_extents, dont_fragment);
+    bitmap_to_extents(bitmap, offset, length, ea, dont_fragment);
=20
-    ret =3D nbd_co_send_extents(client, handle, extents, nb_extents,
-                              final_length, last, context_id, errp);
-
-    g_free(extents);
-
-    return ret;
+    return nbd_co_send_extents(client, handle, ea, last, context_id, errp)=
;
 }
=20
 /* nbd_co_receive_request
--=20
2.21.1


