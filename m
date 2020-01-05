Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3DBC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A72085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAhh1MHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5bS-0001HG-2W
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Uu-0002p4-EP
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Ut-0004sy-8w
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Ut-0004si-4b
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75DSOPWG53BQMc2DQp8pZrGaf6WLAio2xZatEQc8yH4=;
 b=VAhh1MHtirf8mXwYD4GVOsRqRRy+5Mi8ZfkXggF+q1u9eUfREr62Uinhp/oVXnwt5lGsbw
 c8uvNuPn2V5EsR5YdI/4icIRMA4IIiF7JqM5UUvqG81FBmmtp9sX3wqeW2PG4GR0BeKOB2
 M7Ali3Jm32xloisxfm8jxAxHm9hEnpE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-6I7jbfCbN5eHIA-UCE-AHQ-1; Sun, 05 Jan 2020 07:59:08 -0500
Received: by mail-qt1-f198.google.com with SMTP id e37so32588131qtk.7
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilfUa7pwbD2DsrhFhXRw/VkM07xbn4jtSmYjKOWR/YA=;
 b=p6xYuncH/hbr0R+z0woYbvLW+N0iewTdil0IcUaTm0ETeXG1tqEo0iq0KEDv99XyUc
 780iePeU8skMLdLb13OZOrRLUdBTBUmKAiET2IE24H7J7qIhaxGSbObHhPLm/K2Z3Js9
 XjWp4tljyFZa5+el4DWjDZUITk6RCN8dQCHIlnjzUx54n/CBTAwrmL0G9ECFAzsjJ0nh
 eX9AG9j++qBA3Q5YXcned0ZLUg8e1m3EWu1DjjK0W2H8ZLwv0551pYnwdVuF03IEFQ93
 W6YM6HcGNDma3jNwRHLBBop4430i2+Q74xiMwjv+TP0znpHBONTsofXw9rrE2uxtAFUj
 07aQ==
X-Gm-Message-State: APjAAAWac45FgWG4ju46exloibZflR4Lzl12MUv63EzD0OL3Rk3M57QL
 L/yPqubhr2jcQHRdqqghXMQqeqsEsL0MQ6CX4CxV8TG8WHMFM61bofA4Y49hjHVNrCxyiUt/vNz
 inXeUDVVfkqh+f+M=
X-Received: by 2002:a37:7d01:: with SMTP id y1mr80866506qkc.452.1578229148067; 
 Sun, 05 Jan 2020 04:59:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGujOsx4NP+1CFXxupJzzlOJdssoaxV4zMCAx30PyZDzYQ+eYl2U+ZoxK6yr4TnqcirQvEng==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr80866496qkc.452.1578229147827; 
 Sun, 05 Jan 2020 04:59:07 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id w20sm21866786qtj.4.2020.01.05.04.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:07 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 20/32] virtio-mmio: Clear v2 transport state on soft reset
Message-ID: <20200105125622.27231-21-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 6I7jbfCbN5eHIA-UCE-AHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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


