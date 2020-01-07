Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860CEC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEF7207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9ct+Xcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEF7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojwD-00078G-Jv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojP5-0004bX-KM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojP4-0007XG-HJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojP4-0007Wz-CG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMvJhEP2LlmkkK5OqUcX3Hea5Sokrq83L2n0JELoweI=;
 b=Y9ct+XcwJiQC/imycXOpu/HO9khtT1Y88tF2pW6BW93YukcB0UCaXXpOIaXGkaJAObz1NW
 i2a9b696bEk16NysyyCveuAltBqoYyOerLrNJGYH+AC5phFCgSGmyWcJ5U+8r4rcRSx4Pc
 /SEL9RHwZJXKr92mhAEplBa4/Dm8RIM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-i2jC-62pOhqrjGIzyDgrsQ-1; Tue, 07 Jan 2020 02:35:48 -0500
Received: by mail-qk1-f200.google.com with SMTP id l7so16546045qke.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MZOXCGQ//jaCo4R+sHDCJUpSHTnIinHqd1QfSjM9oh0=;
 b=XFr74cYx6Fj8lKJPKFFROI3a4nVEP/cBgMfCVEtB1zQ4RLgKAWTbEyuzhAzXwCc0mj
 bLNhrqvb6vhvCEHHikyBnsP9YlCaZrVo+7ULcn9/cinuHzphuoBVj0Obzk85TPQgyvBZ
 NtlTUu+QztUhFDDCJDuGeBu/88D8Uil4aLcXYi9Bj5NmzsgVLIDzojzGHnq/kHQloaPe
 uw8idZHxbzmny2BIkySqFhpFJ04IJ4gdkjEK3tmHTfzfjIHJ5ESyeMr+h94x/PmDoSlZ
 IKYYI77T1OGIe1RlkNtdToeXqmvHyhMaXvDb069PamuQVOW0wbt5rwKPTa/zaXX58PIO
 dteQ==
X-Gm-Message-State: APjAAAU58hJ8emhigI5aXWdCYQz0BAx4ULupE0ee2G3dA2FAr7m1XVsV
 MMC3a/paEX8R34emxxSg6nhI3RwPcvB+YcLtLtsJhvtiz1OVrJ7tUSlZksWB5VOtbpimV1lrxlx
 c+/U9aZXuBjGnC+4=
X-Received: by 2002:ac8:242f:: with SMTP id c44mr78996053qtc.346.1578382547794; 
 Mon, 06 Jan 2020 23:35:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyR7xt0JiL9+zmugKMMLof0eL2+o8nL+0WdanrXzF3RHvH0T/wl9N+KMYU2yfUJ7ePzcrN82w==
X-Received: by 2002:ac8:242f:: with SMTP id c44mr78996043qtc.346.1578382547606; 
 Mon, 06 Jan 2020 23:35:47 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id m21sm22113021qka.117.2020.01.06.23.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:46 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/32] virtio: update queue size on guest write
Message-ID: <20200107073451.298261-8-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: i2jC-62pOhqrjGIzyDgrsQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some guests read back queue size after writing it.
Update the size immediatly upon write otherwise
they get confused.

In particular this is the case for seabios.

Reported-by: Roman Kagan <rkagan@virtuozzo.com>
Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..e5c759e19e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, hwa=
ddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_SIZE:
         proxy->vqs[vdev->queue_sel].num =3D val;
+        virtio_queue_set_num(vdev, vdev->queue_sel,
+                             proxy->vqs[vdev->queue_sel].num);
         break;
     case VIRTIO_PCI_COMMON_Q_MSIX:
         msix_vector_unuse(&proxy->pci_dev,
--=20
MST


