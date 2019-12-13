Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F2B21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5Pp56bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F2B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iflsF-0000c1-HE
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iflrc-0000A7-DF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iflra-0002Gi-3H
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:24:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iflrZ-0002En-N9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576247052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zj2wVrIh8KQNhFA65bESMfJP7roYgy+mFo3n5QglPhQ=;
 b=Z5Pp56bDZjCGYD8Njs1oRlq2vyG2iH0J5q9a2NNc7gnThbIpC/3bdNMW51pKPM7/swXaTj
 vGla6gO3igcOSHqmHnn6vWStgDJLdDU0CE2gwgw0JMiRKbI+UmzKu9EMcfHmwSkveflqJN
 AomN6kRxdYixIrfuJFWXBojskcgMvaI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-HWAvGZezMlGrQe6SSrllNQ-1; Fri, 13 Dec 2019 09:24:08 -0500
Received: by mail-qv1-f72.google.com with SMTP id x22so1762864qvc.18
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=sanExUpcAf7TPhNumiJmyXjhA8u9u6QpSUASPDnjn/0=;
 b=cCgaSlaFbSsZvoJObnW1VGVk8hir2KBlyM0r2SNqn33ZyHd1JmdmdH45nOT+63xC2o
 wHoztA2QOiS4vSuXyAPqFo2UY/BhAfF5pgw7GmD1w/F+vTEfHg2OkSYD4XuigsketORJ
 c2chEb1CRYOMDYbK86ExvViiv9iEsBgbkXuVA7HOPjnODEfAFtdu/TpeuuvmCKoVJcZA
 WwJN0K8Z8puSKwjq9gTajJT/TyiyopSmkspJ3bvxUGYwXHdwTERm31QR4P+yETYgGa8O
 S9oTVoBbJXYoprPkNfasl0XfI0z2UVdE59Z17NOhR0NZoaN42BIN4/7tGFIu/xpz8zD7
 AQMQ==
X-Gm-Message-State: APjAAAUzqVk1uWd8M3Mxa9qapub5lxwSeWis01Z9hW31NSidBtb5xDv+
 2YmrvRjYHmx0eeYeOCOAyIlLRVAZx4Z05YxEg6HoNPtKMl/ZISfmHNuI8j4b84EBGMpbDHfquJF
 LdFAStM4dOusEjAI=
X-Received: by 2002:a37:6706:: with SMTP id b6mr12959008qkc.461.1576247047437; 
 Fri, 13 Dec 2019 06:24:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLWjfw6jptdpPaRDRdzXNuPoPBB3I+XUOkYu/8THWHjzmwLt0ZWNZT+nzbG95goC5DYAGEaA==
X-Received: by 2002:a37:6706:: with SMTP id b6mr12958993qkc.461.1576247047170; 
 Fri, 13 Dec 2019 06:24:07 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id w1sm1785155qtk.31.2019.12.13.06.24.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 06:24:06 -0800 (PST)
Date: Fri, 13 Dec 2019 09:24:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: update queue size on guest write
Message-ID: <20191213142358.345301-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: HWAvGZezMlGrQe6SSrllNQ-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some guests read back queue size after writing it.
Update the size immediatly upon write otherwise
they get confused.

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


