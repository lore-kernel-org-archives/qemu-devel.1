Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54564C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1B82075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgZS6Xd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1B82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokaP-0000LH-2p
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQC-0006EZ-Cb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQB-0008JU-2x
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQA-0008JB-VG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75DSOPWG53BQMc2DQp8pZrGaf6WLAio2xZatEQc8yH4=;
 b=KgZS6Xd5jxKfp3NbWbLm6BB6Sa8HLmygrTGlxP+hN2WhbcH4v+r7mewGQu9ovllzOhXFzW
 hfIAmt3Xwi2Rbql9CrFpeJgNaIgK3Vz0x8ZE9UZkkYG2Wxx1jl+fZVMB+USGh/8g9bkkQb
 PUaJFMe1ikfd+AbpRMpI9sk+KzZhv7Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-3Tvah6I9MKCEEQrTnwcGkQ-1; Tue, 07 Jan 2020 02:36:57 -0500
Received: by mail-qk1-f197.google.com with SMTP id d1so8965590qkk.15
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilfUa7pwbD2DsrhFhXRw/VkM07xbn4jtSmYjKOWR/YA=;
 b=KpgXOz6kQ9CU/rQQ03eFzsTWlpDoFbvJwxAfi/iPZkVkTwRA6sVkKj75txY2Y6RrzQ
 1ZD5N5giUdQaQMx3DKQPdzSTayDXfkouC+1FGC1gZ56T7IiBkmCwdLe6eR1JXU6+n4Tn
 v4RWTelmKRK2vwVeEeY/GnkMpb0kl5DA74l9zCk/k6VyxZerCn75Uqw8yK7o0hWW4Wvz
 X3dKBH2iiuBYtV9jEHc6Xf0EGUzv/FtLFyOkj+TLgaDg+UuHC0Q3a02SBBoVSsEM0la8
 PPHZZ1z+fFT281abhaCZD90T6ldh55sY1hk9QPUli5PpaCqPPZA1iPPFZsuhiy5qcNje
 BL4g==
X-Gm-Message-State: APjAAAXY3z0Tm1x3EZH+h/kgoIZMxF3vChPk4CKEpgmrDGGvrBESa0+g
 b4SGF2IUyDXyUzWMkHCYTJaSamozj6V0Aznxb40/FlprWHPAFlc6kt0VjTS9pCBwtsJa/A4MUNt
 bRZlvw8OlUrVtq4A=
X-Received: by 2002:a37:8e44:: with SMTP id q65mr86111629qkd.70.1578382616620; 
 Mon, 06 Jan 2020 23:36:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+l3SXlWn8LCdeJOb1ypyIkmqnRvy/c2C0QOGdX2WZO6Dq1ZXTXQQA5mrqvvEsJXuW3KvO6Q==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr86111617qkd.70.1578382616357; 
 Mon, 06 Jan 2020 23:36:56 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r37sm24890198qtj.44.2020.01.06.23.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:36:55 -0800 (PST)
Date: Tue, 7 Jan 2020 02:36:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/32] virtio-mmio: Clear v2 transport state on soft reset
Message-ID: <20200107073451.298261-21-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 3Tvah6I9MKCEEQrTnwcGkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

At the moment when the guest writes a status of 0, we only reset the
virtio core state but not the virtio-mmio state. The virtio-mmio
specification says (v1.1 cs01, 4.2.2.1 Device Requirements:
MMIO Device Register Layout):

    Upon reset, the device MUST clear all bits in InterruptStatus and
    ready bits in the QueueReady register for all queues in the device.

The core already takes care of InterruptStatus by clearing isr, but we
still need to clear QueueReady.

It would be tempting to clean all registers, but since the specification
doesn't say anything more, guests could rely on the registers keeping
their state across reset. Linux for example, relies on this for
GuestPageSize in the legacy MMIO tranport.

Fixes: 44e687a4d9ab ("virtio-mmio: implement modern (v2) personality (virti=
o-1)")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20191213095410.1516119-1-jean-philippe@linaro.org>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 94d934c44b..ef40b7a9b2 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -65,6 +65,19 @@ static void virtio_mmio_stop_ioeventfd(VirtIOMMIOProxy *=
proxy)
     virtio_bus_stop_ioeventfd(&proxy->bus);
 }
=20
+static void virtio_mmio_soft_reset(VirtIOMMIOProxy *proxy)
+{
+    int i;
+
+    if (proxy->legacy) {
+        return;
+    }
+
+    for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
+        proxy->vqs[i].enabled =3D 0;
+    }
+}
+
 static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned siz=
e)
 {
     VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
@@ -378,6 +391,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offs=
et, uint64_t value,
=20
         if (vdev->status =3D=3D 0) {
             virtio_reset(vdev);
+            virtio_mmio_soft_reset(proxy);
         }
         break;
     case VIRTIO_MMIO_QUEUE_DESC_LOW:
--=20
MST


