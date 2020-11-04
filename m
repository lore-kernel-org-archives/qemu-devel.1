Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D385C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0561920780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THNjZiUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNsC-0007HS-Mu
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjj-0001bO-Ij
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjh-00025X-2N
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERBcIzJjq9q9CekQaOnDD1IPGOplWp3LnON28jdWCRA=;
 b=THNjZiUXEC4EoUpC8rJmqLrL9Uvt6L2fIE0zuGrXXCqI3Urv69VuKll8L3WtMFs9TpBcfK
 hasc460VaU/G9ZIDVwPO+jA47KFhYeYtzm9KTci0lva7Ly3wCqWoU/K7mr+W729iazZR+W
 50RWbbr+vTItTlbfy0yIOt4R/6bZMPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-sW8t2nM3M_WYz60qklD0sQ-1; Wed, 04 Nov 2020 13:42:18 -0500
X-MC-Unique: sW8t2nM3M_WYz60qklD0sQ-1
Received: by mail-wm1-f70.google.com with SMTP id z7so1550324wme.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ERBcIzJjq9q9CekQaOnDD1IPGOplWp3LnON28jdWCRA=;
 b=HQXL7RiiJTc+fev83tZqeLS1+X7jXxIANjIZh7x270RJ5Pi7jPmWaFayVjGvlWKzWy
 m68mSA8+5sty7aWnGta7oYI2kcaKd8fIPnGLRSPezMiCBKnP62vXBfoXgRrFy/x1BOYc
 yY4Fqcq6GDPssM0nLosHyDYZFlObIcoB6NwPYD2c0vAGkIL3YZ+p5uILhJucQ7wlwRzo
 XORFL1sBQ9CoxDAXonvw9S/hJzAYmdcYX1LeLcQXcuShq5voHUGDIXCI9ul3eRorv9mS
 Z5H38V2W3ivf9hK5QkcFeuqC2bm7/eAuib58djI3JaESQAFD+Vzzhx2wrk9XOdXrU/nn
 E59w==
X-Gm-Message-State: AOAM530Ud46APGVGowHPe6oP7+rTiRQGCSErcfUTa3uD1zVC3t5So4wZ
 B4NI6zcd6llGqF42JV0CjboxJSmf8CG1kKAOX5MpgfjIRWWmM5pZQH687YmNqrUQvCRqjFDzTaD
 Tsz70nyEn9V3wsFU=
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr471808wru.369.1604515336901;
 Wed, 04 Nov 2020 10:42:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB+77Nkj2DFjSawGEVkCUgAstahf3UZpnzlQlmp4I7Xo/KNL7JfHsPc78osHoaDxN/0hXUkQ==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr471795wru.369.1604515336767;
 Wed, 04 Nov 2020 10:42:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 90sm3954979wrl.30.2020.11.04.10.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:16 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 20/31] vfio: Set IOMMU page size as per host supported page
 size
Message-ID: <20201104184040.285057-21-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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


