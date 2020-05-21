Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92AB20814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn2ybyc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92AB20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrAM-0003cJ-SD
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqps-0007xW-NT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqpq-0002Yq-BT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:32 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net
 (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1F1020823;
 Thu, 21 May 2020 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590089189;
 bh=OLinQC9iMGghSpuw/kVjTtdK+MSS8ybD0n5V6iGg1R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mn2ybyc5RdBn3P9lPA+JIa0Jo3DN94gHiKwtjQptGdwW5ZJqnrLnVXzmvybaAKoEv
 UzcIWpKiGMXhIgU5G0u9xGmoo+uvNjJN48OxRr5m8L82iYMte3K5x+RN1Oe/YOlJcN
 P/Rl6hcJ+gHh4IRDkbRX58V8RAehPqMHIlS7ZKsQ=
From: Stefano Stabellini <sstabellini@kernel.org>
To: groug@kaod.org
Subject: [PATCH v2 2/3] xen/9pfs: yield when there isn't enough room on the
 ring
Date: Thu, 21 May 2020 12:26:26 -0700
Message-Id: <20200521192627.15259-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:26:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: sstabellini@kernel.org, paul@xen.org, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Instead of truncating replies, which is problematic, wait until the
client reads more data and frees bytes on the reply ring.

Do that by calling qemu_coroutine_yield(). The corresponding
qemu_coroutine_enter_if_inactive() is called from xen_9pfs_bh upon
receiving the next notification from the client.

We need to be careful to avoid races in case xen_9pfs_bh and the
coroutine are both active at the same time. In xen_9pfs_bh, wait until
either the critical section is over (ring->co == NULL) or until the
coroutine becomes inactive (qemu_coroutine_yield() was called) before
continuing. Then, simply wake up the coroutine if it is inactive.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
Changes in v2:
- add comments on barriers
---
 hw/9pfs/xen-9p-backend.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index fc197f6c8a..3c84c86ab8 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -37,6 +37,7 @@ typedef struct Xen9pfsRing {
 
     struct iovec *sg;
     QEMUBH *bh;
+    Coroutine *co;
 
     /* local copies, so that we can read/write PDU data directly from
      * the ring */
@@ -198,16 +199,20 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+    ring->co = qemu_coroutine_self();
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
 
+again:
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
     buf_size = iov_size(ring->sg, num);
     if (buf_size  < size) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
-                buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+        qemu_coroutine_yield();
+        goto again;
     }
+    ring->co = NULL;
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
 
     *piov = ring->sg;
     *pniov = num;
@@ -292,6 +297,20 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
 static void xen_9pfs_bh(void *opaque)
 {
     Xen9pfsRing *ring = opaque;
+    bool wait;
+
+again:
+    wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
+    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
+    smp_rmb();
+    if (wait) {
+        cpu_relax();
+        goto again;
+    }
+
+    if (ring->co != NULL) {
+        qemu_coroutine_enter_if_inactive(ring->co);
+    }
     xen_9pfs_receive(ring);
 }
 
-- 
2.17.1


