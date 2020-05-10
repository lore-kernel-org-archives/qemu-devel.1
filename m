Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F43C54E8B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394FB2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nPnznth+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394FB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqnC-00012W-92
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ad0e5a9b6abde52502aa40b30661d29aebe1590a@lizzy.crudebyte.com>)
 id 1jXqhi-0006Ah-3Z
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:29:34 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ad0e5a9b6abde52502aa40b30661d29aebe1590a@lizzy.crudebyte.com>)
 id 1jXqhh-0005RE-BT
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vmF7NmnttbFuaHeIWeCyzKORtLSbSPMZue6Yg+i6MrE=; b=nPnzn
 th+MlUrV0bY0+I2y7fObjOQ/LThcRxE2ZOW1h1Aoy9PIgYXzNbBwt9lEL1YGhgZ4GhDVVme3yoTs/
 mEmdSz0p3eLR8I2mhggB3Z9U3nEoI8aH+CYETj2jxItnsTKKYKLArBlku1WTBFg68fSGIqQFDQwjB
 F5rM55E6JP5ihJ4oYg4YBsuLEo9NV/x6PTbaLnfC61zbCz5UXdqSj7qsi3K574Sjkp0mdIbm78JgK
 gU2OJHOP0bUGRNoJciNntwTvpI8uY1Uw9rA2wmnb0ZlNTZQ9IPCcW/BqsGKomfN43DynYScHDQFA8
 GReJ9YmstH0Wxe3XaiWoG5lMnMiHg==;
Message-Id: <ad0e5a9b6abde52502aa40b30661d29aebe1590a.1589132512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1589132512.git.qemu_oss@crudebyte.com>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 10 May 2020 19:05:02 +0200
Subject: [PATCH 1/2] xen-9pfs: Fix log messages of reply errors
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ad0e5a9b6abde52502aa40b30661d29aebe1590a@lizzy.crudebyte.com;
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

If delivery of some 9pfs response fails for some reason, log the
error message by mentioning the 9P protocol reply type, not by
client's request type. The latter could be misleading that the
error occurred already when handling the request input.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/xen-9p-backend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 18fe5b7c92..f04caabfe5 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -137,7 +137,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
     ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
     if (ret < 0) {
         xen_pv_printf(&xen_9pfs->xendev, 0,
-                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
+                      "Failed to encode VirtFS reply type %d\n",
+                      pdu->id + 1);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
@@ -201,9 +202,9 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
 
     buf_size = iov_size(ring->sg, num);
     if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu, less than minimum\n",
-                pdu->id, *size, buf_size);
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
+                      "%zu bytes, buffer has %zu, less than minimum\n",
+                      pdu->id + 1, *size, buf_size);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
-- 
2.20.1


