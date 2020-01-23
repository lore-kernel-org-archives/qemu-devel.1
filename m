Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BFF2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKebEUJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BFF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf4t-0005fo-T7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrQ-000524-54
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrO-0003PH-QS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrO-0003NM-Jn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t23so2642906wmi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a3Vb+m8pIg/1dpP/XvEglAqzMTsZNDlRtfXxmF7Em2c=;
 b=BKebEUJcRdIDLzX4bvuH2hSYhArhNnEu3syt5szEd5qZoSD0Jwl83Cwc0shkTOX6XU
 0PR+QdilFtuPW19HFsL88DfNNjhioI/MokSeihtNUoAGuMIO9qIzANhELNmha1AWOaIZ
 TrrAdKsKX3FkkUrwjVN4T7W2PtO1aNWwPzBxUaQv/DB+Htqt9OMSbBhxavtRlXo96jt3
 lw0X+6LlFZ3dh73Xd7CN0lFNK+xhH9pn1ee7Gtx1X/7Vd/aqoqtcF44rsMhi586XYhg5
 hl9K2Wr9/+GOGQTvMvijFEC7ydDWcZx86puDgV4tVmI2pHUrckAx/MAzBqZpbWXQDTO1
 XCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=a3Vb+m8pIg/1dpP/XvEglAqzMTsZNDlRtfXxmF7Em2c=;
 b=iwz4zqnO/W/TRN4HavXJG3ldYZoLJvPJ+6sVW+ljJQ7nfCMde7bu4Bijs+XLV7R62w
 mgzmSDfZ+CcmL9eVxsWMVs/EB4zRFZKvypRCh+dBj457mPtq0BnzOQqKZQcLTqx4BlKr
 CgH/+vB80SlQ8hmjZW6tq71IlRESCmeKvCfBanvRtpGCPRasJEW3mklJNGAyj8LWap2M
 uepJWy0ccNAnyh8vW1SQZS8Uhi83TmBfQSIJXYFR+Bl/jOJQ4u36IzzLTfAQRMWq2wIi
 91f1p6U2EvulovpqEi5w6NKlollgT1dt0ajB6RphkVa2NGq8hZ/BwkgAfoF/RpykEWFb
 WRig==
X-Gm-Message-State: APjAAAUmXHKvB11DM5G+JA1focdc8YjAXuELPMFkyXtky4QGuHxhmja5
 r4ArwUS1J7URL5wCmmhHcte1J5ez
X-Google-Smtp-Source: APXvYqwpjt+zUCLrMp5EktQ2/r5SpanmA/igmsQC9I+RDMA6oLPp+OZRcdStGR8Ld1RD7tKMK5k5Ig==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr4286053wmi.128.1579787365492; 
 Thu, 23 Jan 2020 05:49:25 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/59] virtio-scsi: delete vqs in unrealize to avoid memleaks
Date: Thu, 23 Jan 2020 14:48:24 +0100
Message-Id: <1579787342-27146-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This patch fix memleaks when attaching/detaching virtio-scsi device, the
memory leak stack is as follow:

Direct leak of 21504 byte(s) in 3 object(s) allocated from:
  #0 0x7f491f2f2970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f491e94649d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x564d0f3919fa (./x86_64-softmmu/qemu-system-x86_64+0x2c3e9fa)  /mnt/sdb/qemu/hw/virtio/virtio.c:2333
  #3 0x564d0f2eca55 (./x86_64-softmmu/qemu-system-x86_64+0x2b99a55)  /mnt/sdb/qemu/hw/scsi/virtio-scsi.c:912
  #4 0x564d0f2ece7b (./x86_64-softmmu/qemu-system-x86_64+0x2b99e7b)  /mnt/sdb/qemu/hw/scsi/virtio-scsi.c:924
  #5 0x564d0f39ee47 (./x86_64-softmmu/qemu-system-x86_64+0x2c4be47)  /mnt/sdb/qemu/hw/virtio/virtio.c:3531
  #6 0x564d0f980224 (./x86_64-softmmu/qemu-system-x86_64+0x322d224)  /mnt/sdb/qemu/hw/core/qdev.c:865

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200117075547.60864-2-pannengyuan@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4bc73a3..858b3aa 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -943,7 +943,13 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    int i;
 
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
+    for (i = 0; i < vs->conf.num_queues; i++) {
+        virtio_del_queue(vdev, i + 2);
+    }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
 }
-- 
1.8.3.1



