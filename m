Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E30C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCD720725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBiDn9QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCD720725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTrM-000615-JY
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmk-0000mp-ET
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmi-0000is-By
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQbV+eeH0Jal8wQ3qnCI4bc8h7HSMGkH1TuPaMitNA4=;
 b=GBiDn9QBqPRRJ/Lib6MpD/DlwFA+xydmAjyi5EGrV4Jf7jYaN05j9hN852IFuDuHhEdX6Z
 ES3LrqQOdG/c5mTR+XK0mF5yp/s9dnKRaa3acdbJ6QOyPkgowVTbIWgdxxnWLZ+JHuGNPB
 DhtNAv1tYIOX6Cva/J1FWXd3CBj/hOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-y0TTm1enMpuOeqckdSNrcA-1; Fri, 30 Oct 2020 08:45:33 -0400
X-MC-Unique: y0TTm1enMpuOeqckdSNrcA-1
Received: by mail-wr1-f69.google.com with SMTP id 2so2625606wrd.14
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OQbV+eeH0Jal8wQ3qnCI4bc8h7HSMGkH1TuPaMitNA4=;
 b=HHcf8OMFnLHaZ38sggNOIMNeLP+Z7AmV5Sk49vhvejn7wFe7xrjf6icmgunExpYlSE
 8xyAD23QdBk619CL1IPAOXR55eG5oqOvoFclPUdFroQR1U8tHK5ry6zQ6lbXfacR/urN
 +OsDPM+4+zyRsXeFgZfPDfpgdkIarzuHsI4P7Qv3mHr2ThMBUsCc+4tevyk2qnZyjlSP
 XTXpsc3gji2aAn5p3TKbowWrcbemej/FhEu/8rNOlCqnQUuregSH2nxh7G2/TRl95de3
 gX87w5wGQ1ujpYK9sL3pjwDvlg4iz08lK1GUSHAc1vpgdZ8z0wOnBgXAE3jBUVvXSebD
 L1/w==
X-Gm-Message-State: AOAM532iw9KWc4Hd4A5UiDbQ2ZJZLToNkMfWaaa7m/xPPcLa8eRFYq6u
 dmFvbgMmQxSQi0ZE153nLFI5louPJozGSHjEwe3y8Dk/vEaYgMtmVcek1Wywcr8o9bnbf20+zAQ
 3aGdIIJP0UCCysEc=
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr2838921wrr.377.1604061931747; 
 Fri, 30 Oct 2020 05:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZmzFpF57+XWqVg8AINqODziGkq6JddLydZIZsQfLOevVkt4QbThXM8uqJ4myB+LYrHm5NIg==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr2838904wrr.377.1604061931601; 
 Fri, 30 Oct 2020 05:45:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j9sm10601842wrp.59.2020.10.30.05.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:30 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] pci: Change error_report to assert(3)
Message-ID: <20201030124454.854286-12-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

Asserts are used for developer bugs. As registering a bar of the wrong
size is not something that should be possible for a user to achieve,
this is a developer bug.

While here, use the more obvious helper function.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Message-Id: <20201015181411.89104-1-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dc4019865b..e5b7c9a42b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1151,11 +1151,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
-    if (size & (size-1)) {
-        error_report("ERROR: PCI region size must be pow2 "
-                    "type=0x%x, size=0x%"FMT_PCIBUS"", type, size);
-        exit(1);
-    }
+    assert(is_power_of_2(size));
 
     r = &pci_dev->io_regions[region_num];
     r->addr = PCI_BAR_UNMAPPED;
-- 
MST


