Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1682C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC58A20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px6uYsCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC58A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6by6-0007ES-Ow
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btT-000700-Tc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btS-00011F-Sc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btS-00010x-Ny
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Sbkpo7K4fbQQabaezht/7HSdtDe1em0zHLb8IleaCg=;
 b=Px6uYsCws0IIew7ni92wcOhkvXI3tnIGryZizBZFfW/K+UP/pqukDdrNAUJnDkwkDsEFok
 5f2mjWZTiMsPKWU8YelZoWALpr/Va1V55VkZg7vYUhFPtRNwgPJMdAmRQdexBn55cuyNZm
 xX81Vl/8rAzSNJgT1vVOkZCHku6KsZ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-LwIT6Wr3M7mzf3HeAQPe6g-1; Tue, 25 Feb 2020 10:13:03 -0500
X-MC-Unique: LwIT6Wr3M7mzf3HeAQPe6g-1
Received: by mail-qk1-f197.google.com with SMTP id c206so15297822qkg.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HQCVFXmC4HNrtLa78+UIIIU3F1sBdIpmGro+wxgLStc=;
 b=HEC36zAgkN8m98c2hcAQG4026gUEJ7ZtQYqFhu7/RzDFcEnp9JeOTcHi2qiLsIFJlS
 Uwd6iVNZ0WxlcEd/qWywthVen4hzzVoXtR8RfpX6RKoK5g/OIilzmWQ5QCBzBM3u9TN3
 nsFGsf2kX7Yal6JsIG5Rl4zOqkewyTnn/wWAHVDJMNWYXjyM1q7+xqiAxpCj0JeZLVUF
 PzSil542Jkw7FwlcZdsBn1scHKwG1LGL75YU4lgkFPcYhxXOVYlBshhOelVN4kmZ78J4
 huFjD2HdoBKtVXjSUA2hO2oqDKyNCwpieMBrKmmyKxMbQ2RWFv7RiJ6D6WEV4oCsJ6kS
 4EPw==
X-Gm-Message-State: APjAAAULieMT1CPN7IXClmBd1qdggsRi/miyDpMO7dFreSa8KdSQDLaZ
 B4q6C3Rz10k0QF/x8HG+A6g5lzdpFRZmIT3ozC041Fm3oCCq6RYRmpPPL6SPQg/S9wvp8qzuO/h
 skNOK7jI9COF8gZ0=
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr162295qtu.387.1582643582998; 
 Tue, 25 Feb 2020 07:13:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1YDo7kjGJFWilPV4mKlxk3PPAchZLKewsrdOkSrp1Qt5Z9/pUYoWbE3+pManT7cmZ8kYWOA==
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr162273qtu.387.1582643582790; 
 Tue, 25 Feb 2020 07:13:02 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w2sm7679134qto.73.2020.02.25.07.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:02 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
Message-ID: <20200225151210.647797-8-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Similar to other virtio-devices, rq_vq forgot to delete in
virtio_pmem_unrealize, this patch fix it.  This device has already
maintained a vq pointer, thus we use the new virtio_delete_queue
function directly to do the cleanup.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200225075554.10835-4-pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 97287e923b..43399522f5 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -130,6 +130,7 @@ static void virtio_pmem_unrealize(DeviceState *dev, Err=
or **errp)
     VirtIOPMEM *pmem =3D VIRTIO_PMEM(dev);
=20
     host_memory_backend_set_mapped(pmem->memdev, false);
+    virtio_delete_queue(pmem->rq_vq);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


