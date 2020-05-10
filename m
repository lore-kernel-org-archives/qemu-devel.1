Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46DC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955182080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="dxVKdtdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqhT-0005cL-OM
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com>)
 id 1jXqgi-00058O-8l
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:28:32 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com>)
 id 1jXqgg-0004CT-Lx
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=dbVxlY5uoYntWjDm7o4KOAqYCxACWT1Q7BS/wBPpRow=; b=dxVKd
 tddrilngLhFYKXN9vBoZnGCdqMz0mWtO6/91q1SzvZQwwVnLUzXuXB6i+2BhB4VjYxwbgk2rnt7Cm
 IiOjUYrzpIVwAJ51Y99yUhtSJh5MTj98NSpSAlskPLGEOgMd+4zb2DNCOBsdupSFF7TiecppSdI7y
 F4bF8t7kVKVXgzv1IsZgEPttF9JyKe2NuCwC/7loehbdLZ9u/ZQkn9SFphokEypcgoSpfBjF/akEG
 GDpSQCGzCE9ceTTm2CPOQ9CrPBgPTUFmm92okgorx2+cfCCloO0cIxCTXNEKjjiCYkv+K9bF0EyEp
 Asa8n389ErXSs3ZaMoY8EPZzj54Fw==;
Message-Id: <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac.1589132512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1589132512.git.qemu_oss@crudebyte.com>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 10 May 2020 19:18:21 +0200
Subject: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=54f3b9c9f05a77ccdd6103bd46c828fcb675cbac@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:00:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit SHA-1 16724a173049ac29c7b5ade741da93a0f46edff7 introduced
truncating the response to the currently available transport buffer
size, which was supposed to fix an 9pfs error on Xen boot where
transport buffer might still be smaller than required for response.

Unfortunately this change broke small reads (with less than 12
bytes).

To address both concerns, check the actual response type and only
truncate reply for Rreaddir responses, and only if truncated reply
would at least return one payload byte to client. Use Rreaddir's
precise header size (11) for this instead of P9_IOHDRSZ.

Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7
Fixes: https://bugs.launchpad.net/bugs/1877688
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 35 +++++++++++++++++++++++++++--------
 hw/9pfs/xen-9p-backend.c   | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 536447a355..57e4d92ecb 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -154,15 +154,34 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     VirtQueueElement *elem = v->elems[pdu->idx];
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
-    if (buf_size < P9_IOHDRSZ) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+    if (pdu->id + 1 == P9_RREAD) {
+        /* size[4] Rread tag[2] count[4] data[count] */
+        const size_t hdr_size = 11;
+        /*
+         * If current transport buffer size is smaller than actually required
+         * for this Rreaddir response, then truncate the response to the
+         * currently available transport buffer size, however only if it would
+         * at least allow to return 1 payload byte to client.
+         */
+        if (buf_size < hdr_size + 1) {
+            VirtIODevice *vdev = VIRTIO_DEVICE(v);
 
-        virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
-                     pdu->id + 1, *size, buf_size);
-    }
-    if (buf_size < *size) {
-        *size = buf_size;
+            virtio_error(vdev,
+                         "VirtFS reply type %d needs %zu bytes, buffer has "
+                         "%zu, less than minimum (%zu)",
+                         pdu->id + 1, *size, buf_size, hdr_size + 1);
+        }
+        if (buf_size < *size) {
+            *size = buf_size;
+        }
+    } else {
+        if (buf_size < *size) {
+            VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+            virtio_error(vdev,
+                         "VirtFS reply type %d needs %zu bytes, buffer has %zu",
+                         pdu->id + 1, *size, buf_size);
+        }
     }
 
     *piov = elem->in_sg;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index f04caabfe5..98f340d24b 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -201,15 +201,35 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
 
     buf_size = iov_size(ring->sg, num);
-    if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
-                      "%zu bytes, buffer has %zu, less than minimum\n",
-                      pdu->id + 1, *size, buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
-    }
-    if (buf_size  < *size) {
-        *size = buf_size;
+    if (pdu->id + 1 == P9_RREAD) {
+        /* size[4] Rread tag[2] count[4] data[count] */
+        const size_t hdr_size = 11;
+        /*
+         * If current transport buffer size is smaller than actually required
+         * for this Rreaddir response, then truncate the response to the
+         * currently available transport buffer size, however only if it would
+         * at least allow to return 1 payload byte to client.
+         */
+        if (buf_size < hdr_size + 1) {
+            xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d "
+                          "needs %zu bytes, buffer has %zu, less than "
+                          "minimum (%zu)\n",
+                          pdu->id + 1, *size, buf_size, hdr_size + 1);
+            xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+            xen_9pfs_disconnect(&xen_9pfs->xendev);
+        }
+        if (buf_size < *size) {
+            *size = buf_size;
+        }
+    } else {
+        if (buf_size < *size) {
+            xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d "
+                         "needs %zu bytes, buffer has %zu\n", pdu->id + 1,
+                          *size, buf_size);
+
+            xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
+            xen_9pfs_disconnect(&xen_9pfs->xendev);
+        }
     }
 
     *piov = ring->sg;
-- 
2.20.1


