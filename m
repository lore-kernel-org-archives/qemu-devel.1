Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A645F20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCw93670"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A645F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw6R-0006hT-IQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvrI-00038B-Lv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvrH-0001At-7m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:28:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvrH-00018S-1O
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75DSOPWG53BQMc2DQp8pZrGaf6WLAio2xZatEQc8yH4=;
 b=bCw93670+cKN95kV1tGrsJIdEP+XnOy1/gNZgO9cOSY/UH93ZFIYEZxcxjyUuwfjKIsBJB
 JoxEkQoDOYubQikQBvpz95cdtaQ0zrx2kzsxEHyjjXFhksDrvR204bBnEPqECUXdhdYhOq
 FCTBgCP8nXlHy+H2+nHfsUUQ3QQJbyk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-qT_j1qUPM5aF4VeMou0eBg-1; Thu, 19 Dec 2019 08:28:46 -0500
Received: by mail-qk1-f198.google.com with SMTP id n128so3603113qke.19
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilfUa7pwbD2DsrhFhXRw/VkM07xbn4jtSmYjKOWR/YA=;
 b=Ef7bBZp6vnpmW+e4AlJ9Odhx5bwo5T4ep8DpiUCufhmWyxmumdBsX9zvaSTwtkAvJ8
 3vQvuc2O1ZPHcKgLxsbgcvitHSShCXF5SJV/I18efDXI60Cs0FeQKfhSSPT7CWAxDA/t
 jezBngeGhti46yQrrH2r2JXBFJ44vGgF8kTMsrIMvrpnuF31yzaBV8L6L7LAlyxwJtEy
 yjTRVyDtiki+ZO/0r6a2/DP9jKhw8HGdvOpbymskcBwhQERyS1tchci7dgu7SQl0fDB4
 5OYycfGwt3yOBynx3p4kBPeSLhCnb7DZIwYY526aLFT2cMYaYn8ysnR3SzbjVyau7An2
 TRPw==
X-Gm-Message-State: APjAAAWSz62qSNRDQM2u4aNWjGSuqYouNZiOEMvodnT1rjG7YZ9d2ABX
 SlSDQ80QqTm9wKcig+1l7v7Twp4f86/bagIuAz6dByK4zeNn7ZKlfQSm64Mb5LFXR8++871GCLR
 bMBbzO5/Y467rjow=
X-Received: by 2002:ad4:59c2:: with SMTP id el2mr7209425qvb.152.1576762125891; 
 Thu, 19 Dec 2019 05:28:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKyddGWs+xFzcbGcIZNKYRgVlVtE005Yc3m9Xih4kCiABUio0P6iSUjYdg0PBEUcsYYfgBaw==
X-Received: by 2002:ad4:59c2:: with SMTP id el2mr7209407qvb.152.1576762125640; 
 Thu, 19 Dec 2019 05:28:45 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id i6sm1707884qkk.7.2019.12.19.05.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:28:44 -0800 (PST)
Date: Thu, 19 Dec 2019 08:28:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] virtio-mmio: Clear v2 transport state on soft reset
Message-ID: <20191219132621.16595-21-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: qT_j1qUPM5aF4VeMou0eBg-1
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


