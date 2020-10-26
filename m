Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7352C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395472222C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="C+cEi/VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395472222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4CM-0002nD-D6
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net>)
 id 1kX4Bl-0002Js-BB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:13:37 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:52529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net>)
 id 1kX4Bj-0005vP-OZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=jaanafTkjnT9BbTRRApXu/QeiKkgwYKMKutp+gyNGPI=;
 b=C+cEi/VW8mQ9uaQyUry5bwTa1lDLQplGzSv6z2zPH5PH+/4tHqGG+f7S0u/6troeRe0l
 zsSrWTZDvH3GJl3/yug+2/9DxymK5V4/gRBW67X22d5rhJyaQ5j4bCSJ3Qg3ma5WY01Yjb
 Lly6udbOezuCxfw+BzrrhVpdzytxAWXvY=
Received: by filterdrecv-p3las1-bf7bc68d5-fmkt4 with SMTP id
 filterdrecv-p3las1-bf7bc68d5-fmkt4-19-5F96E79C-8E
 2020-10-26 15:13:32.665192997 +0000 UTC m=+422065.423749127
Received: from felipe-franciosi-cent7-umvm1.dev.nutanix.com (unknown)
 by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP
 id W-jp9stEQvCIceFl7tuICw Mon, 26 Oct 2020 15:13:32.538 +0000 (UTC)
From: Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH] virtio: skip guest index check on device load
Date: Mon, 26 Oct 2020 15:13:32 +0000 (UTC)
Message-Id: <20201026151328.77611-1-felipe@nutanix.com>
X-Mailer: git-send-email 2.18.4
X-SG-EID: =?us-ascii?Q?W9goRmNI2M6BaZDnSanVWLdj2DuGbkuGfTWZsqFIAk59ONbkkaLXMDCghpkcaI?=
 =?us-ascii?Q?PehS=2FLuf7=2F3t083SnZbMEjVxFPrrK521N5u7r+e?=
 =?us-ascii?Q?7gR2ZIIk++M23YxqkvjCwQFt2W5uyP2wMCHFym2?=
 =?us-ascii?Q?AQVeWr=2Fjk5XodB2P8URd+X08wBcCROglJjjCPEz?=
 =?us-ascii?Q?a5wczAk5c0d061q1si7TvWpISrhwMlTO0YqeItO?=
 =?us-ascii?Q?l0+PaXhxqFcdZejBgJ7cj0b2KSzcSfLWyZmowwR?=
 =?us-ascii?Q?Q4eKU90A+X61rfIIjbR+w=3D=3D?=
To: qemu-devel@nongnu.org
X-Entity-ID: IZcDqzhM+W+fx+coAjH1TQ==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+19088175-f42a-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:13:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H2=-0.001,
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
 hw/virtio/virtio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f8f865aff..0561bdb857 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3136,8 +3136,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     RCU_READ_LOCK_GUARD();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
-            uint16_t nheads;
-
             /*
              * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
              * only the region cache needs to be set up.  Legacy devices need
@@ -3157,16 +3155,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
-            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
-            /* Check it isn't doing strange things with descriptor numbers. */
-            if (nheads > vdev->vq[i].vring.num) {
-                error_report("VQ %d size 0x%x Guest index 0x%x "
-                             "inconsistent with Host index 0x%x: delta 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vring_avail_idx(&vdev->vq[i]),
-                             vdev->vq[i].last_avail_idx, nheads);
-                return -1;
-            }
             vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
             vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);
 
-- 
2.18.4


