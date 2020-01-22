Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E80AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2A02465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiaITZmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2A02465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuA1t-0002ya-UQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qT-0004mi-GT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qS-00087y-HW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qS-00087V-ED
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MaCdSCC18sa84xXKLha22neuWnQ0FyF+hqtGDwgw+w=;
 b=NiaITZmdEc6liMgCHla5+v3NcjZf5bS7/SDF83yXjUNeKz9eDb2qWOsdkJcqjmhWiguO7z
 IkzPeEJ7iiXi2CtSoerkxh10/KBG/ffRgZykwKeM+0GWXTMnHSUVeDycyhe6z93knjRvCI
 qw6d6Eq0nRWSHofsqiUqDTghFmDIVKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-Wx9wPHuJPYauqPf8VLB1CA-1; Wed, 22 Jan 2020 01:50:30 -0500
Received: by mail-wm1-f71.google.com with SMTP id c4so1662816wmb.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JmSFm2DvEaju83wiB8EwbENmzUyJC9M0V+2bn9XbrpU=;
 b=OLMtT4WNpAOBwSqJtjRW+XYvdFPeh35i9mkf0iQ2WlkOrAWKYyfT2fF7duMLT7hT6j
 1Y7ks10nLJxU9YA0xOjKjKAn9Vm/M/IygV1f1Nw67lmm0nej+SVQWSemXCpslFAO16nH
 X20rLb4B+fGrA2vvjO0FXhupwPg7qoHqq8oIF4p4mA8urfsVlgQQm3GCxgvhNRvWUqP1
 /+iiBDAMZ2O7CvnqjEOGvhBJ1HoiSJIOo4icYXBWg8QpYDqZB6724Wcida6KqnbUTVDr
 YG1awJs8CHrBjLsdL3hGGutdq6ZHQUiOPLVGZqy3nQ3+wUKG9I2xMVrtwb3SOEPAiNTO
 TPyQ==
X-Gm-Message-State: APjAAAVuE7dhFVcaZfOYFiRqKyvZFClWEpFLuqarop8vTU1orst5WW4n
 Wt4KMGH42dSzxb6JHy1btHHBx+toCn2jCUomYGjf950LBIJa0AyVqBLzD1JcsClM6X7jTAV0ZnX
 KkOs4QtPUafHHyrM=
X-Received: by 2002:adf:fd07:: with SMTP id e7mr9257554wrr.21.1579675828449;
 Tue, 21 Jan 2020 22:50:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/HrlNqG6YM++k5ZW2aqsZjD8ga4Q+R886x/rU91Zg3OHn+KL/GNKmbOHUUoWAAeNKqTrODw==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr9257538wrr.21.1579675828282;
 Tue, 21 Jan 2020 22:50:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i10sm56892035wru.16.2020.01.21.22.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:27 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/17] virtio-scsi: convert to new virtio_delete_queue
Message-ID: <20200122064907.512501-14-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Wx9wPHuJPYauqPf8VLB1CA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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


