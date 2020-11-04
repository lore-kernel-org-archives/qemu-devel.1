Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B7C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2367208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+stbv1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2367208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAzF-0002B2-VP
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlu-0006Pq-9D
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlq-0004fb-QR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERBcIzJjq9q9CekQaOnDD1IPGOplWp3LnON28jdWCRA=;
 b=C+stbv1o6EIkLykzaL7ieaEjYtKgwD0G/DwfEg3mHDzZCWDiZsukm2Y1BVTZVawqqmQZTU
 z4+nYAiGcTYgL8T0MxFQi+b7cE4eUVd2Z6f+ZFtWpZjm8BTlX68DEVpGD0t7F9bLvTlrtq
 uDczm0XvmMww3lhfR3iisNJaz2gjiO4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-UkrgpNhrMwmlvpDqmWbqPQ-1; Tue, 03 Nov 2020 23:51:40 -0500
X-MC-Unique: UkrgpNhrMwmlvpDqmWbqPQ-1
Received: by mail-wr1-f70.google.com with SMTP id q15so8709790wrw.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ERBcIzJjq9q9CekQaOnDD1IPGOplWp3LnON28jdWCRA=;
 b=DipnoZsuPaNPmkFlLnQKvuQtXiWJgdCFngp+PqnpFWB5Lh7v6ZqbI8AYsv65w7bt3Y
 MKziDbyu69pgcvl2aGVNV62L9fhnHeMEiCnEcfDljvD+T+U1VWcU4UEUFr4pGJwu0paz
 hrqGZctabapVaWd8o7MIEMZbDD1qS3ftxdzhDQMrQG04qyt88fm7n++zN7szHnUfbjJ5
 YzNpPF2KRl6Pcld2pp/KH0JDWVQOhCS7UQO6AmZ759N2VNTGL9a6/ccSlmgsoFGyGOzr
 QlFe0n/JG8Y7rh/xBb40f6STpcI0KZIs1ShyCV/BWSL3mwYlyhc1MZ6Z/sOA58sFPfco
 jDXg==
X-Gm-Message-State: AOAM530I9VZw6ptpKAE6zWQKhypzRiqv5M5AE2XoA0Pl29crH5q/YFxB
 vH8La88s8YbKpwROfjNAhb/+RAknfzoNC+aCQ3vnNz7dWw3dzX8r7lmbIt9HU7w7dw/eLB+lEX1
 WwVu2ncUbiCU58Fk=
X-Received: by 2002:adf:e549:: with SMTP id z9mr22622952wrm.359.1604465498996; 
 Tue, 03 Nov 2020 20:51:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynNy+x/v/WjC0HLUAAn67O9C3TV5DxhZlQdpja+7vezCSzoHYDheVxdpoDB5+OExfxXPGA5g==
X-Received: by 2002:adf:e549:: with SMTP id z9mr22622941wrm.359.1604465498878; 
 Tue, 03 Nov 2020 20:51:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y200sm894471wmc.23.2020.11.03.20.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:38 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/38] vfio: Set IOMMU page size as per host supported page
 size
Message-ID: <20201104044937.226370-21-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Set IOMMU supported page size mask same as host Linux supported page
size mask.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-9-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e18ea2cf91..35895b18a6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -789,6 +789,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             int128_get64(llend),
                             iommu_idx);
 
+        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
+                                                     container->pgsizes,
+                                                     &err);
+        if (ret) {
+            g_free(giommu);
+            goto fail;
+        }
+
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
-- 
MST


