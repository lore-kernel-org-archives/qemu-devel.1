Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F7DC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D3B2085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzufamW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D3B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5Ys-0006WP-1T
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5TY-0000jY-Hf
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5TX-0003ji-Hy
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5TX-0003jU-Dz
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9epneyHKkAEq5gGDVE/gbeFue8BzwP7OkBM6QzY9Yk=;
 b=UzufamW7/NaGKuvlszzqtO/7/T4KLz14A0I503vwUWc5LDfpeH2QCWEbkXgdLdqyqE3A5p
 ohpN+60YL4ZcyAbUgdSS1j+JShox6NGUvI9KPBdUfnbd1MrWCbRJVn1TV1kkaXNMxufPWt
 8Zcu/Dv18NSWEwhwFX+7nt0p0Nib5rM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-H1kk4p0HNcmSGrbDBngf8A-1; Sun, 05 Jan 2020 07:57:45 -0500
Received: by mail-qt1-f198.google.com with SMTP id d9so28195440qtq.13
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iiaP0RxMw50Y4u2HruPOoUKc+xP0ZRMmYrMUAAr8Wgg=;
 b=CQJhmcA4PbtgQbhoAi3b6V6mUtRWar0NeztRWY7mM8bPWeegqavF7idproqjJgVhnM
 4WVceFRPbY1FwPCzL/5kpJm7L0ThQ1zd1aKsRSZJUiBgj0sR6b/l9W8icKUnAfOmP49f
 e9qUolsKu5VHKkV+aFGMa/7+4Vz0HW1PNF6cmSYd9ChZVAYCp9zW1Ma2D8IvKiG5cBAI
 3jNBK+K895RXs95rt2Qu/YPC4BwMCfMgYymMJuUpI7zXYXMeuviNb+km1D2vnJGn0x6i
 b6luMYk7esOJPWRyUNwE1hC9ADGWWHQcWykYy6QP59cqxacFggiNNbvSvhUg+nV+izue
 Vn8w==
X-Gm-Message-State: APjAAAWoIqC5ENBxpYvjT2YkKelo0W0Q9UfXMCCEUJMbFX8cOzXGk7Xw
 OtZvD6cdNMaGxgPLZRe4CJ5vje6daLzhA06Yl9HKxipCsU3QKoN9yG6gH1m+Gh6QjnO4cTJBXeP
 p5u2VFRoiQQ4ij0M=
X-Received: by 2002:aed:256d:: with SMTP id w42mr70505959qtc.385.1578229064939; 
 Sun, 05 Jan 2020 04:57:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMjtSTRO/gE7LEGLDi8SRZHAY/yO7moOX9NXEKTKs6dCNIDksAhfQVOwEKtkr4iuZX1tqXyg==
X-Received: by 2002:aed:256d:: with SMTP id w42mr70505953qtc.385.1578229064794; 
 Sun, 05 Jan 2020 04:57:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id w20sm21865250qtj.4.2020.01.05.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:44 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/32] virtio-input: convert to new virtio_delete_queue
Message-ID: <20200105125622.27231-6-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: H1kk4p0HNcmSGrbDBngf8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems cleaner than using VQ index values.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/input/virtio-input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index ec54e46ad6..9c013afddb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -280,6 +280,7 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
     Error *local_err =3D NULL;
=20
     if (vic->unrealize) {
@@ -289,8 +290,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vinput->evt);
+    virtio_delete_queue(vinput->sts);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


