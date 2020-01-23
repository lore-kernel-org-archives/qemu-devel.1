Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878F9C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5084524655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKTkr3ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5084524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWlH-0006Jq-6r
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdi-0006SQ-OI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdh-0008ON-QF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdh-0008OD-Nj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MaCdSCC18sa84xXKLha22neuWnQ0FyF+hqtGDwgw+w=;
 b=OKTkr3ws/Qk/kXTHbIkCAOsQaxsUuFJ5fHk1LfJVCMARy9quCspG/wUy3wpOT9qdaLTPBP
 dd3aFhlj2LxmsSj+/pV4q9rKuY38jvMIpSM6CrgJAqbJsLdtKKH/Yb4uquc/gbOAL2lTFr
 OMHD7JwK0ac2u7chVvqGsbVMCeH0BEQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-iUGiP2cdPkm6IAhHvB2Ugg-1; Thu, 23 Jan 2020 02:10:51 -0500
Received: by mail-wm1-f70.google.com with SMTP id z2so243758wmf.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JmSFm2DvEaju83wiB8EwbENmzUyJC9M0V+2bn9XbrpU=;
 b=KDDjHhyWk1fwT6inegnUgQa5Yyyh/t8DEegXYKc283ufy7Fm7H4nTOnH2+qw0zvRD+
 Fv2K6s4KaZuFfE+e3XLKYGj/UYG9p5kJNesESEEpPmqVyO4oLKANR413QjIGEi2s+RyE
 H2M+BQy15oHDohouAd78pWEzcvc5lVA+fBiiNRxeuCzWdZ3by/RqiU0ajGYz3QUEb9XF
 U+QZ7BqqiNdZ0LBisghNSon/DjVeZ42pxRpn1ep4eG1Nc5dqanLqhIPluFCoiSla1L4q
 AZd0aGF8cRtLipoV33KiWGMdEj9fSDRUPr/ctODvomirWtjmM9g1oTcQ5/lkQ9xlDg69
 yGNA==
X-Gm-Message-State: APjAAAUzijHBjqHPOQN79jbDyPcaD86NDcKDMzHAxOp1PvMfAIPeU33Z
 vAiWpfW9RWWFaIbiWRJhZmJ4z+ywXmlilpiA/8zs5Q1xvVgL5vxqAcoOuyrVJS6EzFCGPvOLRWZ
 nbcwT4BZfV9c90vo=
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2462251wmg.20.1579763450158; 
 Wed, 22 Jan 2020 23:10:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX91Oz/AP/cCNyEUMSD0zZcgLNBF6XWbTUBwQc5ZFDUR+UVkZ6rwBzgLfrEU8xe0L/TMHwCQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2462238wmg.20.1579763449993; 
 Wed, 22 Jan 2020 23:10:49 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 p5sm1781351wrt.79.2020.01.22.23.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:49 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 13/18] virtio-scsi: convert to new virtio_delete_queue
Message-ID: <20200123070913.626488-14-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: iUGiP2cdPkm6IAhHvB2Ugg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Use virtio_delete_queue to make it more clear.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117075547.60864-3-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 858b3aaccb..d3af42ef92 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -945,10 +945,10 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
     int i;
=20
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vs->ctrl_vq);
+    virtio_delete_queue(vs->event_vq);
     for (i =3D 0; i < vs->conf.num_queues; i++) {
-        virtio_del_queue(vdev, i + 2);
+        virtio_delete_queue(vs->cmd_vqs[i]);
     }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
--=20
MST


