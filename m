Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7116CC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9948024727
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="x2PQldZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9948024727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlpb-0003gB-GX
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net>)
 id 1kXln9-0001WN-HJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:47:08 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:41009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net>)
 id 1kXln7-0002PM-TR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=CxdGetPoWN5kysRq2tcwCqLPNfKeYBjEcKXaYEWH2YA=;
 b=x2PQldZb3btnl+3WXP6qPPkFWoMq3B72n0OjK4ZRm2AuWrMjte4E8rPG6CHm6nsBhrx8
 MURTS4bFr6kbB6uPpU9Cm6lo6o3y30R4TfvEvY0cBxPYCkZD5q4UGNgZAS2rEiSydLrILY
 as/Qoht9q2r+Yui2r1EZcJxA9FgKHroSI=
Received: by filterdrecv-p3iad2-64988c98cc-xvhnm with SMTP id
 filterdrecv-p3iad2-64988c98cc-xvhnm-18-5F997657-7A
 2020-10-28 13:47:03.68792397 +0000 UTC m=+406327.240209723
Received: from felipe-franciosi-cent7-umvm1.dev.nutanix.com (unknown)
 by ismtpd0007p1sjc2.sendgrid.net (SG) with ESMTP
 id 9zPCkjl6RGSCJdS4hJZNZg Wed, 28 Oct 2020 13:47:03.468 +0000 (UTC)
From: Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH v2] virtio: skip guest index check on device load
Date: Wed, 28 Oct 2020 13:47:03 +0000 (UTC)
Message-Id: <20201028134643.110698-1-felipe@nutanix.com>
X-Mailer: git-send-email 2.18.4
X-SG-EID: =?us-ascii?Q?W9goRmNI2M6BaZDnSanVWLdj2DuGbkuGfTWZsqFIAk59ONbkkaLXMDCghpkcaI?=
 =?us-ascii?Q?PehS=2FLuf7=2F3t083SnZbMEjV3S3WjvDtVUADFpIf?=
 =?us-ascii?Q?bF0ixgKOWMYer7lTKKDzgHmIMNvcLfFMhIb=2FlaR?=
 =?us-ascii?Q?Gl0w5lVR1T1i6M=2FwWNjowRaYREYMlAs=2F9QjKkpO?=
 =?us-ascii?Q?5mgFKoiHznHvuAv5+XaYkA=2FxKpXTGcmLSlyVYqH?=
 =?us-ascii?Q?AptQwhOZbkfAdnUDVAKrKv07jxyS35tvIrqEg2v?=
 =?us-ascii?Q?ivynv=2FcWsRyRQcilRCtzw=3D=3D?=
To: qemu-devel@nongnu.org
X-Entity-ID: IZcDqzhM+W+fx+coAjH1TQ==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 09:47:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU must be careful when loading device state off migration streams to
prevent a malicious source from exploiting the emulator. Overdoing these
checks has the side effect of allowing a guest to "pin itself" in cloud
environments by messing with state which is entirely in its control.

Similarly to what f3081539 achieved in usb_device_post_load(), this
commit removes such a check from virtio_load(). Worth noting, the result
of a load without this check is the same as if a guest enables a VQ with
invalid indexes to begin with. That is, the virtual device is set in a
broken state (by the datapath handler) and must be reset.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
v2: Keep the check around for logging.

 hw/virtio/virtio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f8f865aff..ceb58fda6c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio.h"
@@ -3160,12 +3161,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-                error_report("VQ %d size 0x%x Guest index 0x%x "
-                             "inconsistent with Host index 0x%x: delta 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vring_avail_idx(&vdev->vq[i]),
-                             vdev->vq[i].last_avail_idx, nheads);
-                return -1;
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "VQ %d size 0x%x Guest index 0x%x "
+                              "inconsistent with Host index 0x%x: delta 0x%x",
+                              i, vdev->vq[i].vring.num,
+                              vring_avail_idx(&vdev->vq[i]),
+                              vdev->vq[i].last_avail_idx, nheads);
             }
             vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
             vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);
-- 
2.18.4


