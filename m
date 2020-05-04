Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F487C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1614F206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUxUy2m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1614F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcRF-0001dt-6B
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9Y-0003IA-Qi
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9X-0008OX-EP
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pj1uHiegKcsUZCaq6FfRPIoZitXmODiLZa/viD4waC0=;
 b=AUxUy2m2cnqJ3edvOZm8PZx4vtZ3c2jFFnJvf+izhybmulGvCzv2iEqWY1jebZ8rjALHhN
 toHF8aNn5yLYFMKNMWLrytj1iknaMaexK4c4g0JgMsaScdZ1ULTv4q9dIxIlPgezZ/4vqP
 Bhdgy57iOuVAYpfttYgPc9oWwOSZuA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-n4REQS6WNWasS69FPNHVGQ-1; Mon, 04 May 2020 10:29:40 -0400
X-MC-Unique: n4REQS6WNWasS69FPNHVGQ-1
Received: by mail-wm1-f71.google.com with SMTP id w2so4993968wmc.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rmx3ZXSO8zrSOq3lTewsvFGussmCJbclHSwavQ1LcnQ=;
 b=aXzi28WbWY1HLcjyCyubxO6fgxGz99xnivOh7+6HhyLkBeLWswvn+5vHQI1yslyyZF
 PIE643UQSPsZ7a9ohAGLPNx4Uqy1tAqRGDDUD8YImmJSUXJLPKEo0ktdqPDjkvbVSmJf
 x25qsry0pnBNUYRg5r+LbCmgoC06s4eNNgtWjQyWO1ge+ZlHOLPnbO/v5OprwhgqgZQz
 aePf/uvJQ1pqMHO/uywRkuo3aq/u20QIPefyE1ARPCPWrUJggR5Vi/U1ZGOgFNn2fRU2
 lc3KmkNtGencKz+arDKlH0fjelLG7VVB91YOyv19JbcmCpKNz2Nt6OGLl2+9Pw8u55rg
 hgEQ==
X-Gm-Message-State: AGi0PubDJ/vqbxZxhm1jDRH+mRBC7M///H3VEwyEDwuNOB+gwyh16AGf
 DHar4r9H5CgpGA0W3fq70NIhWC3W307/Uil05vuFmyttFFpoJ3XmTKSEFwVhWUtiKA1sr1WHTb2
 ror1HlGtqRxExet8=
X-Received: by 2002:adf:f606:: with SMTP id t6mr7336338wrp.321.1588602578884; 
 Mon, 04 May 2020 07:29:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoTLGaFqOI2OxQoWfuPdv3XBHb9hR+89vG81T6klD1qhZ31j3io7LWPtKyiTD9gNU+HZZ9cw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr7336320wrp.321.1588602578625; 
 Mon, 04 May 2020 07:29:38 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 g25sm13335649wmh.24.2020.05.04.07.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:38 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] virtio-pci: update virtio pci bar layout documentation
Message-ID: <20200504142814.157589-11-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

The modern io bar was never documented.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Message-Id: <20200422215455.10244-2-anthoine.bourgeois@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/virtio/virtio-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4cb784389c..d028c17c24 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1705,6 +1705,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Er=
ror **errp)
      *
      *   region 0   --  virtio legacy io bar
      *   region 1   --  msi-x bar
+     *   region 2   --  virtio modern io bar (off by default)
      *   region 4+5 --  virtio modern memory (64bit) bar
      *
      */
--=20
MST


