Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33F1223EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkfj6NfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33F1223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxZ5-0000tE-Va
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOv-0004wj-1q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOs-0006Zz-Fq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LJXuyrvNWCkVg8E30mdyIeR8YxS8TNHSTHiQCqv2NOU=;
 b=Gkfj6NfS8YvtHcX5wpmrkpsOOJfPtOKATGtDXKRJeiWARGgjf05wfWXOpQ11OE/2JuGkQW
 rNK1gSn/MdDGvapFr16sOEHzRSj413Axj2cg2E0x5EWW2uKDN8MyEclY2FT1zOtafG4p5b
 EmL3YQxXw4GiSyZ71NqMuo18lu6WUbQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-4Unm8fPeOK2__Uo-8rIyuA-1; Tue, 03 Nov 2020 09:35:01 -0500
X-MC-Unique: 4Unm8fPeOK2__Uo-8rIyuA-1
Received: by mail-wr1-f69.google.com with SMTP id j15so7902483wrd.16
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LJXuyrvNWCkVg8E30mdyIeR8YxS8TNHSTHiQCqv2NOU=;
 b=qhJacq3fdodejOaERngF4l+RmS/DhgDgvzuzuzNb6a9vD5dKBuRvyj2AwZnGJc2nEf
 bdBSvrvAAbSTFGZP4x7BGF/soaaVfuqViplRwVwfxUZK3tFfdFer7HOUYYXche2xSPTa
 zeCRvXGv3W98pLtDAdUXCGGB3CW2alwv9GE8ij70RUuYY9EfTiLRWHn/JChBxTGARtz0
 wqcNpr8u/wufD/41dlV7qmnqid6sdY7v6eE1E12Eeh5ZzukMAo5LHJQ56qkkr7+XUeec
 9RDeui6ru0yfmrVLlGN35YI4/JeF4ggGhWfr86GKv9165xhonyIBnlsrrVmw78SUuBHK
 Y5aw==
X-Gm-Message-State: AOAM530KzFtwGPVp7a4UQ9NNx5gsGVLtkrj7KSxONgZSZqzB+4m3P+ds
 HUegJeo+6aqkFnqEtdSpeqKxons5u56X+amskD2Up4GhaCgddJLRS6a6HEMaOrS0pPfCfuZnjwF
 essbL3DUe9CV3W4k=
X-Received: by 2002:adf:a501:: with SMTP id i1mr26015669wrb.162.1604414100539; 
 Tue, 03 Nov 2020 06:35:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzohVDXeJgY2Uzuxu26uTMiTy5ypxNWqaQkgURHFuYyTC+1Q8EDjSpZmPBBwVGslSigcWGcdQ==
X-Received: by 2002:adf:a501:: with SMTP id i1mr26015650wrb.162.1604414100395; 
 Tue, 03 Nov 2020 06:35:00 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id k84sm3135206wmf.42.2020.11.03.06.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:59 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/38] vfio: Don't issue full 2^64 unmap
Message-ID: <20201103142306.71782-23-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
index 35895b18a6..7e9d1a17b7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -950,6 +950,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        if (llsize == int128_2_64()) {
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


