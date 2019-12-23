Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B655C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E935D20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvKf8mhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E935D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijQzT-0002pq-Fr
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQmx-0004um-Lz
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQmw-0005fd-F4
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31952
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQmw-0005fW-AE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75DSOPWG53BQMc2DQp8pZrGaf6WLAio2xZatEQc8yH4=;
 b=MvKf8mhdtAVS1YDci5jzkmolEDoLljx6ImgTYT2W1WWb/us8t8gx7L0+fPcNy1CDW6/N6G
 IzvwmU31/Ym88Duy7ExaLRj25v4be0TrZ4k5juJEM3olGq3h7+SY85ONUXBWJWPpzdTDJ0
 jAjdDgJ+VQLUF9oLBZeQkLf4wGl11xs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-_H6PHU9xN1O2uiYDMDvANw-1; Mon, 23 Dec 2019 11:42:32 -0500
Received: by mail-qv1-f72.google.com with SMTP id z9so7330438qvo.10
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilfUa7pwbD2DsrhFhXRw/VkM07xbn4jtSmYjKOWR/YA=;
 b=IYYKEyDbxuqT/sbb5UtOBlio9PlGnSQNSZzUvgpoDkwLZuW/KlBON7aKFH2S0omveN
 7fOSgHB2ZLrGcbnUyJDPKngfrJ9+hxLgkZB1vTHx7/7XmO65TRwPJI7B+8POuKUQT9wW
 II+HtiFeAi7hhCl3dR8UlsrNcQrvjXC/VgBVBxc+OMWleAZX2CxW7E5hmbLICKic1kDm
 TzvKrCIMcD+NgusSLqg6w543qumj06OwJxFgv6hmd8iBd0hbyAoubYJwid2FdSaqmzfl
 Z3sHddaR541gnQmxGHuY9P/2EYRxEXjRm2PlW1aKc0kPTyIm01I3oxCkoL1lRa8kw/vO
 6icg==
X-Gm-Message-State: APjAAAXpvASqtjzFB/ePREJ88VH65PCCaKbM1a7ki2GdZdx4plzGF2jV
 thgDdrluQdrv5LeY4NcOa/IvckpPhJCBCxOR3kXK9Ktp0/EMpKrJznVlrrShg0QZKJ4K9W6lARW
 PyXw7lrmTVd4VYok=
X-Received: by 2002:ac8:328a:: with SMTP id z10mr19131609qta.355.1577119351673; 
 Mon, 23 Dec 2019 08:42:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgA4gSFsFchqkW35q4m2V42nxLf2JhEV27Fy/v84oc0sCxhBykdm5RPtblKf1utTgjfWIFGQ==
X-Received: by 2002:ac8:328a:: with SMTP id z10mr19131601qta.355.1577119351494; 
 Mon, 23 Dec 2019 08:42:31 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 u4sm5838216qkh.59.2019.12.23.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:42:30 -0800 (PST)
Date: Mon, 23 Dec 2019 11:42:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/27] virtio-mmio: Clear v2 transport state on soft reset
Message-ID: <20191223141536.72682-21-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: _H6PHU9xN1O2uiYDMDvANw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


