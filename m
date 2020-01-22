Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB60C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3E724672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIOiOLPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3E724672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9wi-0004jG-RC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qK-0004d8-U6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qJ-00082W-N0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qJ-00082G-JG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7X8PjfcFHzdyIHec4OG6du8gOrCYueQPk/uwOaIht1o=;
 b=fIOiOLPoOkR2bK5Xwu4S25bkRG6SBf3L5gXtJlXg5KbE66DakSrLUa2Ljo3vYuO7SxySd3
 12T8wXZOJkg9V/p4UB+FT9p5mVSpGag8RzRil8Xyxd8NRtSapxpjgTkv+VA/8x6lMb/sno
 4FJZD2Z65mtpIR8IR9L8TqjFlAnzvF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-oG6GzJUHM76cUoTRrOO8Nw-1; Wed, 22 Jan 2020 01:50:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id q206so1663941wme.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dKz9Yp7TsPHys5pVT0H9YPlrICr7T8Twac2SXPW2Rdw=;
 b=l1cyxRcus/Tc/4oB7hUo6SfshT2hRZ9ADgdY8sfXnhu9lMaSZzaXqYHpPeeZiYw2A3
 MiSkRPBbZ5yYZ9SfCmoUFv3exBwaRiAq2FYFEUd9O6Lcn5Dmsi5ckvnimdvR9z1f2eDt
 gFTIx3tBB1UZ3L50o8+TYn1iocWbrLsPkL+4o/IGxyq9Bxv/47JnZXV1yZqSKFidlZIj
 GErn7BVAmYKSD7Cp2nGqxXDX4XirW6gelTycAdKHYGuV1Lahi2EkhdgWq4pnwRnmCf49
 NcFg6VJLWvVaQk+9OuFe7CnBce66DBnElTlODhXDY9wHqrgFhVPNEUwz68y34iTTGjGC
 n8kw==
X-Gm-Message-State: APjAAAVZx2KE4dQ+4pS+d+uBp79qapoG9BDgDsRHTLEmujuJbUjfI0ZI
 ra+h0s0/lwTMKQAV9fSX1wACVjAghn9ST/Z1H+MgaQXCHkFUI3BDtw/LFJlH8usGymnL/b8D4cp
 R7aDlZlqJ3BgO/1g=
X-Received: by 2002:adf:d846:: with SMTP id k6mr8781972wrl.337.1579675819757; 
 Tue, 21 Jan 2020 22:50:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpOJO5NWpA77F3tU2elED9HWci00URZEaX8NRsjlDkWTwSs1NUNGRjmuytMjBPdoox4n4m3A==
X-Received: by 2002:adf:d846:: with SMTP id k6mr8781955wrl.337.1579675819545; 
 Tue, 21 Jan 2020 22:50:19 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i5sm2596058wml.31.2020.01.21.22.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:19 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/17] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Message-ID: <20200122064907.512501-11-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: oG6GzJUHM76cUoTRrOO8Nw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Greg Kurz <groug@kaod.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
  #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624)  /mnt/s=
db/qemu/hw/virtio/virtio.c:2327
  #3 0x55a3a571bac7 (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7)  /mnt/s=
db/qemu/hw/9pfs/virtio-9p-device.c:209
  #4 0x55a3a58e7bc6 (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6)  /mnt/s=
db/qemu/hw/virtio/virtio.c:3504
  #5 0x55a3a5ebfb37 (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37)  /mnt/s=
db/qemu/hw/core/qdev.c:876

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117060927.51996-2-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Acked-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 991e175c82..ba35892940 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -218,6 +218,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev=
, Error **errp)
     V9fsVirtioState *v =3D VIRTIO_9P(dev);
     V9fsState *s =3D &v->state;
=20
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s, errp);
 }
--=20
MST


