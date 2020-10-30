Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21989C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF09206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj+dZb1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF09206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYU0w-0008Gb-0h
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmm-0000nO-1l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmk-0000k2-4F
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6Xr3YozF4IKRpFrhD0A/HyzyCVetEbDlqfMsE4vvfI=;
 b=Rj+dZb1cnyhHVDVA3llTOQmF8EnC7twtBYZc7lWJxlvS6jlYtEYVDF7DwWHoSE1BnHS7D2
 vNr8WwObkSBdt2g2sMNms3zAdfa2+D4Px0pPC24q3g05WfJ65zrs4oFx9y07Pvzw5oR+Eg
 Chi1Rp0mw3hIOqv5DTNwPuanyW38Fl8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-1gqGr0d4P6apkzAijwHwhg-1; Fri, 30 Oct 2020 08:45:35 -0400
X-MC-Unique: 1gqGr0d4P6apkzAijwHwhg-1
Received: by mail-wr1-f69.google.com with SMTP id q15so2613928wrw.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l6Xr3YozF4IKRpFrhD0A/HyzyCVetEbDlqfMsE4vvfI=;
 b=ZkSvUGgaJN4dp5UP+leIInkjWnxtqymjRRRneqFLZiswOT+d4q275QQzEzM3TMSBf6
 2XJeAYiR7g/hTmJ5PwyMm+seDP6ISsHka6eBJss994pfjnBpcheNLLbnLvfu9b2BKknE
 Tbc54fg6oFie3r5BtkPjaUEXv6yhg6hr8aAGUkele5R2narTXi1JSSZXDQxYgJ60CvOl
 UOHiX6xDokeRT59zb1yYL6CnPYP1NSkRupMqEvaXQUa3Vvm6vNciYM407ivUKNIVFtQE
 ijBjQCCW4/5ulovtlg7JNwhdxATs+JkeFLdKw39SOz762rItXsF+I7mvOieqExf46Xzv
 gm8w==
X-Gm-Message-State: AOAM531/dfOhKxnjukz0qu+ChvKxTC6g3D6v75PJi5ziYA73i+ebQK86
 kCfn2qB00qCeTrbTzfilHKwul0pG2rNvk0DWcFdJ1QaGyXAo0+s60U9+wruVVOyntKXmyM/4qJ5
 Cv+uRecwAhG8iHRw=
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr2908742wrm.79.1604061933960;
 Fri, 30 Oct 2020 05:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKriC5/odzbgXjmhIsEptvw7i0gYvqxcwi6uAUNEO5v+vf374JoW67otf1/m/0BT9BsSXypA==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr2908729wrm.79.1604061933823;
 Fri, 30 Oct 2020 05:45:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c8sm9682361wrv.26.2020.10.30.05.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:33 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] pci: Disallow improper BAR registration for type 1
Message-ID: <20201030124454.854286-13-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 Ben Widawsky <ben.widawsky@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

Prevent future developers working on root complexes, root ports, or
bridges that also wish to implement a BAR for those, from shooting
themselves in the foot. PCI type 1 headers only support 2 base address
registers. It is incorrect and difficult to figure out what is wrong
with the device when this mistake is made. With this, it is immediate
and obvious what has gone wrong.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Message-Id: <20201015181411.89104-2-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e5b7c9a42b..0131d9d02c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1148,11 +1148,17 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     uint32_t addr; /* offset in pci config space */
     uint64_t wmask;
     pcibus_t size = memory_region_size(memory);
+    uint8_t hdr_type;
 
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
 
+    /* A PCI bridge device (with Type 1 header) may only have at most 2 BARs */
+    hdr_type =
+        pci_dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+    assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
+
     r = &pci_dev->io_regions[region_num];
     r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
-- 
MST


