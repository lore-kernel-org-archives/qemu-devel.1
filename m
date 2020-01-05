Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA880C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D332085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq03FMvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D332085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5YP-0005uh-5u
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Ti-0000zV-Ma
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Th-0003oI-MD
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Th-0003oA-Iy
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMvJhEP2LlmkkK5OqUcX3Hea5Sokrq83L2n0JELoweI=;
 b=Eq03FMvsqiHo2lOMUcELnttnxFqac1eFRkAS84ztnzKg1l8szOrfL9460sZnfLo2OpSKqB
 CCgNVQjgAweuKKAV+bfmP00d3gUpxgsE5LPOEK6KgT9WQaEEMPuA92TRzAeP88Xhv4EkLZ
 G4ZDlaEvqV/AoNRdr8uSB+x3dCDq4qQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-T6W2fuNgPDC80NAjY1idnA-1; Sun, 05 Jan 2020 07:57:55 -0500
Received: by mail-qk1-f197.google.com with SMTP id 143so27747943qkg.12
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MZOXCGQ//jaCo4R+sHDCJUpSHTnIinHqd1QfSjM9oh0=;
 b=HNPAqiy/6U/b29JgTjaLNDhM1a9E6KlfbIHRO8H3sCSw26OJknUSLkHxhSCKL2nHNt
 gKQ27HXbUxNTflZCQTkmMTg4nd1yGVmzNrkczFcC9gzFnPNQ7jW+jgh+FBTpOiYElqrT
 CtHcW3Tr20JgO6nVXtAR63G+88yYLd6cS5Lm75IGqdTKF3BigYtTkNYaDXbTJutLBDaK
 jQvHRNLHodNkcX816zej8qX4oaRFmAciog0TmdiChU12vqzxQDbsx1tH808gfi+ElUtq
 +E5lC3RJtvJfTtEGeVTJKeuLdmhZp7NQTufIkucggz+jvOMn6nkAC5wBp5HgI2qB1lh8
 5+5g==
X-Gm-Message-State: APjAAAW+/jhHn52k92Hg4prmwfiZrdK94adom6MW8GkDMlsSdh7iarr/
 bYelb79b3rxF06SlnXvz9rX9O0XhmKTBfxWCXH3rEEHEvFyt2umHVffnoPBv1hY82cZbsSOw+hj
 /h5yqg9bDcviFf1w=
X-Received: by 2002:a05:620a:782:: with SMTP id
 2mr79975012qka.169.1578229075252; 
 Sun, 05 Jan 2020 04:57:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1Qk4YhcGCoYf6m/vD0doiqUD1Z1VuqEi61vXLMweISvyLQ0KnwPSR3E1lAv4n5G6zbYeSxA==
X-Received: by 2002:a05:620a:782:: with SMTP id
 2mr79974995qka.169.1578229075040; 
 Sun, 05 Jan 2020 04:57:55 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id b24sm12925295qtp.82.2020.01.05.04.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:54 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/32] virtio: update queue size on guest write
Message-ID: <20200105125622.27231-8-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: T6W2fuNgPDC80NAjY1idnA-1
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


