Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9655C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5752222B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdnR6JkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5752222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAnF-0000Rc-8b
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm0-0006VS-De
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAly-0004i4-LF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aTAjTe4Celzp7fll7OULoNskonibl44hj9qWQyy3thE=;
 b=YdnR6JkDKKPiDJIW2IpnMsyjbX1M6GQFog6Y98LcFC00MGtmc/UDedoVaS2d5Lr4roAM6l
 YO1jr6aqfFkAt8P3BXo2LeVxnF2v7ZQCclc5myr1oWMUi3+nJrsaKO55pXMiGUm55XeYCC
 3bVyQjDTiXwUwZA9E05ZTLCgoWZ8JDk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-GS7UyUCuN7CjPwzz7BSQSQ-1; Tue, 03 Nov 2020 23:51:45 -0500
X-MC-Unique: GS7UyUCuN7CjPwzz7BSQSQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so8658813wrf.22
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aTAjTe4Celzp7fll7OULoNskonibl44hj9qWQyy3thE=;
 b=Go+hDhP2Ls7uf734CH8AAUnJhBiRJ7aa4aYAWmGrkZ2pI8hj4MqziFcLOl4Jeo6U0A
 aPaPY3R1rgISYQ7XSNkGC5fvzGDpWUkjm4euwG5BPaGcTm/NktN/DFhI/1qYwZJQBHYV
 j/g1PbFPcHpQFDkd6XX1fePHZm1CKMsBzd7BurWaVo14TxInUX2Zns6gznSJpRdnxTi3
 3zz/B58eowbedqcnGXFD+8GiW51RIPlm4XvjAmZOmAFK0LfRZSAd3468SBcEWznEPJ9O
 UbssfkA428YpaJgA8du4pBHLOx2YbwbzU1jNWnD9AIzTIZgALfj1oBNEs0wkf3V3yRDq
 nS3A==
X-Gm-Message-State: AOAM5310p+zMEtre9IMElK/tWlQgHO3dkWvQC3yh9bZ54yVdjAHoa489
 bIdkDGm5NbF12dHRPGnljQeSB3k0mictW3BY2SsmtX3gIM/q6FGruVdZ5pv+MFhTlg2OpBma0qr
 a8ampnHiylqNq1j0=
X-Received: by 2002:adf:f382:: with SMTP id m2mr1757596wro.342.1604465503876; 
 Tue, 03 Nov 2020 20:51:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY2gJxY8JhVmYi9SaouHrEWqRyOcSHLY0fG2iZHbRVgmt9X+C6uzN7HvwUBoIDUKqYJve0Yw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr1757586wro.342.1604465503750; 
 Tue, 03 Nov 2020 20:51:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e25sm869056wrc.76.2020.11.03.20.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:43 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 22/38] vfio: Don't issue full 2^64 unmap
Message-ID: <20201104044937.226370-23-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
attempting to deal with such region, vfio_listener_region_del() passes a
size of 2^64 to int128_get64() which throws an assertion failure.  Even
ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
since the size field is 64-bit. Split the request in two.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-11-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 35895b18a6..c1fdbf17f2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -950,6 +950,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        if (int128_eq(llsize, int128_2_64())) {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            llsize = int128_rshift(llsize, 1);
+            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
+            if (ret) {
+                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                             "0x%"HWADDR_PRIx") = %d (%m)",
+                             container, iova, int128_get64(llsize), ret);
+            }
+            iova += int128_get64(llsize);
+        }
         ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-- 
MST


