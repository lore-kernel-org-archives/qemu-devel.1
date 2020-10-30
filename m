Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA6CC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11A82076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCAgmYUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11A82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVJN-0007Ul-H2
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8s-0003o7-2p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8n-0007H7-AV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6Xr3YozF4IKRpFrhD0A/HyzyCVetEbDlqfMsE4vvfI=;
 b=JCAgmYUo/KvXnGnW0Vq1xN5YrKCS0QzjvChkESFVHZpvJwctYg0SNJ1K4BTESKLnyC3jkN
 oUvNU2kYp3hRxbz3euOjaEwKOO4n1qislJUR9VzvfUaGtk5j/fQAW2eB7ZypnbsnNXDdU4
 6S3xHnps+22W33SqsDHxg3V+JY3nmww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-VNtCPUKrOA61vRHvJ9iOfA-1; Fri, 30 Oct 2020 10:12:20 -0400
X-MC-Unique: VNtCPUKrOA61vRHvJ9iOfA-1
Received: by mail-wr1-f70.google.com with SMTP id h8so2712714wrt.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l6Xr3YozF4IKRpFrhD0A/HyzyCVetEbDlqfMsE4vvfI=;
 b=WO/jlhJb8M4Wpl8CqE/W7F/gE+CE9w7rETq38cfzJ1FNEoWHI7C4K3a+wylq6oApyC
 ZUkcefGomEU5Li6i6izpbD/XIATq9JrA2JXvEivUiFeZSQe/apw+RCVG5wTGkUApiPmH
 VgVMNWkCgS1tZzmCENAWgdJusxsKiEFH21mwrcjpN6LocXm/3pns14oRY08/1985JSAr
 xYK/CzFuZHlsPc2lDOAvt5Pu+ro7dYsRvv+ztElYC78gIw28UpOAltA97Oq36IyBtD+n
 hvM/SpyX0Ym29AxrJXpchXZPLIQYeS5kzNqv+Y7nm5OB2A7oYNGoBgUxKzuohKA6UiOe
 dDqw==
X-Gm-Message-State: AOAM5305PVXe2qOJ84yZ1Ld8xj9y2XR2uIpXobOTa7cR4f0wG8X4/VU1
 48FfPfnzUohgmUCvuNJjmYTjdxZvKFpSXnAy7AleTXMuW0Bc5/1JoS4+9bj6GcC7f5WInlwp8Pa
 TXTa8VXc3ec6VPPk=
X-Received: by 2002:adf:e892:: with SMTP id d18mr3620631wrm.103.1604067138891; 
 Fri, 30 Oct 2020 07:12:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfdnUb2d32ttTtm/PYVoQtbPY8uGtcVL12j/NYgBMoAc4PMSRACN7d5AyVvcQspH/JJnefDg==
X-Received: by 2002:adf:e892:: with SMTP id d18mr3620590wrm.103.1604067138633; 
 Fri, 30 Oct 2020 07:12:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j9sm7394525wrr.49.2020.10.30.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:18 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] pci: Disallow improper BAR registration for type 1
Message-ID: <20201030141136.1013521-13-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
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


