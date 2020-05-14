Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4ECF206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gSZAjMcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ECF206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJOL-0003ys-U4
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com>)
 id 1jZJNg-0003Oe-K5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:18:56 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com>)
 id 1jZJNe-0006PH-J2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=wS4qczauhBOj6sgHwbdGA4ceIYc4fObuVM5GVKolD5s=; b=gSZAj
 McONRy/opbqxtmuMKE8MymZZmYAj7Kk4gjYOnxwfUmomAQ63jVpgMmb5v2Ga/SBymsHF6u1yIEOMg
 gE6jLeUZMIYRVSP0TFGVQs0MKlYioU+7JtXp/5ON1HoPE2ZtPjc2KWEnt3M3jYHzSpi0OiwJ1Xk+6
 v6e00Oag0o2JFBOUbLFjyB4UZmWyVkEy3mn8q2yVwLbxFXLzIpFjNw0cInyMDhQAw1KqTKzMQIv72
 yVSO+QPT+YMlr1qLeK0YhK2/lEr84Nd8IDtPqMlzjPskM5dIk8pEFK8KtMGjhbhyPoj9x69zpYvSy
 1Ax43yZde+Jr9uIEtv2wXkNhmvsBQ==;
Message-Id: <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290.1589481482.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1589481482.git.qemu_oss@crudebyte.com>
References: <cover.1589481482.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 14 May 2020 20:26:04 +0200
Subject: [PATCH 1/1] virtio-9pfs: don't truncate response
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=2cc8d6c4ae9fa8210c48c349b207dfb68cb15290@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 14:49:51
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
truncating the response to the currently available transport buffer size,
which was supposed to fix an 9pfs error on Xen boot where transport buffer
might still be smaller than required for response.

Unfortunately this change broke small reads (with less than 12 bytes).

To fix this introduced bug for virtio at least, let's revert this change
for the virtio transport. Unlike with Xen, we should never come into
this situation with virtio that the available transport buffer would be
too small for delivering any response to client. So truncating the buffer
is not necessary with virtio in the first place.

This bug still needs to be addressed for Xen appropriately though.

Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7 (for virtio only)
Fixes: https://bugs.launchpad.net/bugs/1877688 (for virtio only)
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 536447a355..bb6154945a 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -154,16 +154,13 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     VirtQueueElement *elem = v->elems[pdu->idx];
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
-    if (buf_size < P9_IOHDRSZ) {
+    if (buf_size < *size) {
         VirtIODevice *vdev = VIRTIO_DEVICE(v);
 
         virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
+                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
                      pdu->id + 1, *size, buf_size);
     }
-    if (buf_size < *size) {
-        *size = buf_size;
-    }
 
     *piov = elem->in_sg;
     *pniov = elem->in_num;
-- 
2.20.1


