Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4ADC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C522080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwXjVYKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C522080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorsi-00008F-R4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorkC-0006si-0m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iork8-0004qt-Ft
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iork8-0004qf-CH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMvJhEP2LlmkkK5OqUcX3Hea5Sokrq83L2n0JELoweI=;
 b=HwXjVYKtTxLKB5jypIKQvNLq1YNAKCl3PQyIxWyGx3QkC9+NATHKfdcA7zBXM252BBhyZA
 Ijpt10Rj4oKRvPw/xCFxHzixbG4o5QF0ettpobmUsamNv34LwEpW+DVrVVpqEyUeRXIxOg
 5Ta3EiPu8wHoPd36WmHLBM2adar2K7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-vfW3MQemN3uN2eDAm30wwQ-1; Tue, 07 Jan 2020 11:30:06 -0500
Received: by mail-qv1-f69.google.com with SMTP id e14so249326qvr.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MZOXCGQ//jaCo4R+sHDCJUpSHTnIinHqd1QfSjM9oh0=;
 b=f7Kcec5mhR8raQHwY0h5bSqhzaq0rCj+Mb5iC0EqGQkOG75ZRZKtc0+Y5HX6wKbOjr
 /UNvnMx+tbqGml8PBo8a+eW0KdN4PxtEXGlCdIU48poUPxhDMeE9Xtiid1E6jU9gZjYF
 meuS2zBjUs7YXfA278bZnyrWUQD9aDDp/jURiiJHXsYGTCaXlyKfRwznXZTaJsBFd5Ez
 upt+VdL1ONm5SAyzfttah3XQLnrpLcdsIZFlC/kEO34sjS8tHrSsDfxXUNM29LrONrni
 9VISSc5pb/y5Cg+q0FeWRB6yrAfB/c6lmWg0JPWYRA3agNVy2AjbhdpGWaWqxfLEehIV
 JiwQ==
X-Gm-Message-State: APjAAAVd35dLuYmellueABBxd7XlDltvzEJ0hdqRCL84ULyKKdlvXE5Y
 BCDbYnrTWXjnA+4kYS/sFn75M94wtC+q8h+YDb0qwr5ZiM0ZjKPAjF1ly2gpQODmKU4+/oGiZoT
 zjwVeRqnjy6DcP+k=
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr100179qkj.233.1578414605924; 
 Tue, 07 Jan 2020 08:30:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGsVoKBcSWCFdgfIIfI28zOC1QlKjZXWrsT0GxD3tkpfdtTmTPTGVDXV9d+iLi46gFCwFs6w==
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr100152qkj.233.1578414605662; 
 Tue, 07 Jan 2020 08:30:05 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id m27sm114800qta.21.2020.01.07.08.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:05 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/32] virtio: update queue size on guest write
Message-ID: <20200107162850.411448-8-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: vfW3MQemN3uN2eDAm30wwQ-1
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


