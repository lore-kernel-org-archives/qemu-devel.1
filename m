Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2ECC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBFC2465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYf8RSbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFC2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9zA-0008JO-CG
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qQ-0004hf-5N
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qP-00085F-0M
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qO-00084R-Q8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBcIJ+XtEg+ynI5J149ubW51ZuYdwReRoLvMT6MynBM=;
 b=dYf8RSbDOy632XLLONucymBeaYGfti5k3ZbXSrhcbLgIEQjcaLyOG4mLtb/YI1/54D7ALO
 u48zdnAjrG8L1nxwK/hyGPvjRizTrGyUAjvzmHRrrwP5+18geoEda22SZWK4rkCh7Hqt3B
 69PkwkmNyPDAhEFE1vtX67Aya0VDzAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-NrMUa8CyOhKLtK0YiKxmIg-1; Wed, 22 Jan 2020 01:50:23 -0500
Received: by mail-wm1-f71.google.com with SMTP id 18so1657700wmp.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=crW7LUnM5y+vbTajSaV+13MSOoh5cZCcUuqLsKZn8gg=;
 b=Im5Hk4eMduQNqK63iPH8wVMfMPLyq0YxBKe/ppJSDMnCMV+4gMjsg8igevN41wbXbd
 usttl8C1THq5EDOdqfxk47q66SEf88JY3qj0ADcn0A6BA8fnnjpDdMCgbWbJU84j6AnF
 WAxMuBQbTqGLCZTEUl7ESmZUp83o+mo2d/qUoTbSgeP7ijzkMu39XEpV/xPbyMEN7chL
 8GcWPV9ye2w6DoBSTW8TtCx0hPMDOS8nM0E93Mzc7jIzu3E9Ft/hJHnGy7gq1f019L19
 nEWqmEy891lti3k/qiOlV4Kmijn0DbLXGPOg5iIC8WyizPYXbhXdSCBungzS2JiAKaXe
 e3vg==
X-Gm-Message-State: APjAAAWvs4g4UgL7mGqkBTN/MHVnjm/UgJ5AcHjfoQt94LIK9rsiOT/6
 08d5WmScBK7smMXDI+f18GnTy6fu5+fObUrfemjPe/3qUC3swi2PG6dRiB8OQxxAouSdfauQZ06
 XR+SjzzZfEGWCYCE=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr1140154wmf.113.1579675822565; 
 Tue, 21 Jan 2020 22:50:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqylqNhmgy8OVwow7xFMvLaWSzp3Mr254uSpCFDkAC+WWb4R1DohOOOHf2Z8VW1oIa6k613c1A==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr1140135wmf.113.1579675822358; 
 Tue, 21 Jan 2020 22:50:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 g2sm55877810wrw.76.2020.01.21.22.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:21 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/17] virtio-9p-device: convert to new virtio_delete_queue
Message-ID: <20200122064907.512501-12-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: NrMUa8CyOhKLtK0YiKxmIg-1
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
 Pan Nengyuan <pannengyuan@huawei.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Use virtio_delete_queue to make it more clear.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117060927.51996-3-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index ba35892940..1d1c50409c 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -218,7 +218,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev=
, Error **errp)
     V9fsVirtioState *v =3D VIRTIO_9P(dev);
     V9fsState *s =3D &v->state;
=20
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(v->vq);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s, errp);
 }
--=20
MST


