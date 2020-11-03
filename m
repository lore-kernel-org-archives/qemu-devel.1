Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F501C55179
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9772922370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk02C4Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9772922370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxPn-0005Hz-KV
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxO7-0003bc-BU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxO4-0006HB-Hj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=Mk02C4EeP3zhFv9KHp8cBLoVwpzs9fzOY8MkEHcv70nLumXR6ieXvAfQCb2y1dLQ1XVxnD
 RSA2w8Rn72y0dDJYtXxXRpPsARKs8RTbevhKcLO63btMboht9RmV7FUOAuBW3IBpXV7mwZ
 9ShFXvni3kDAURCDOz7LM6Qs9b0koMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-cDcgaWI4NIWQ6XM2-hfbnQ-1; Tue, 03 Nov 2020 09:34:13 -0500
X-MC-Unique: cDcgaWI4NIWQ6XM2-hfbnQ-1
Received: by mail-wr1-f69.google.com with SMTP id h11so4934180wrq.20
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=GrBRDN8gf0WsMudE4Jk7TTRxk1MsVWJY2t75uLeVBeKN7TaSSiV9slJh4925LI5Btl
 G2YxohWP6zvvytBqdnmktB0Qi2yHiHDfZF/5T4TfOQdx0UvMltEWSJL1RfgoslpTtqh+
 EPZaidJre5RJ9Ro+usm3GrVk/qJ/aeG4xCVRl2uCETjI8UoenAPf6M7SdhgXWqrnLze7
 U2eFPCShqbfyCsM2eoMuxwh5IdugiC5/4K3ewSI32WKnGzPNN6xtKq8+1dkU9kK3lw9N
 u39cyvSO74t+N2ygajeovKlt+EySQZTZiemdrqWAXuGg+C8TY4+2LsBGFHoXdLvfSPSe
 wDYg==
X-Gm-Message-State: AOAM532P/7TTjME4ncx8MMJ1Tpjuv61FelcGnOTDyy2VNADHDAO73UZS
 W/kLv2VWmYEgyLrLTuvkgsUPy2t4VKhXpxCppxniaFUCYu6IsuupaduACBrV4kw5myDzdQsBGAF
 sTIID1FtbrJiL9Mw=
X-Received: by 2002:adf:e490:: with SMTP id i16mr28287959wrm.178.1604414051702; 
 Tue, 03 Nov 2020 06:34:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGGsk6g63+jKOJzWvHqq8KRyUMrgNFre8YYwivm/4PfpwZBS9rbGCeiuS8a4vsA9F7KGPibg==
X-Received: by 2002:adf:e490:: with SMTP id i16mr28287939wrm.178.1604414051511; 
 Tue, 03 Nov 2020 06:34:11 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e5sm25074409wrw.93.2020.11.03.06.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:10 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/38] virtio-mem: Make sure "usable_region_size" is always
 multiples of the block size
Message-ID: <20201103142306.71782-4-mst@redhat.com>
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
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

The spec states:
  "The device MUST set addr, region_size, usable_region_size, plugged_size,
   requested_size to multiples of block_size."

With block sizes > 256MB, we currently wouldn't guarantee that for the
usable_region_size.

Note that we cannot exceed the region_size, as we already enforce the
alignment there properly.

Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201008083029.9504-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 70200b4eac..461ac68ee8 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -227,6 +227,9 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
     uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
                            requested_size + VIRTIO_MEM_USABLE_EXTENT);
 
+    /* The usable region size always has to be multiples of the block size. */
+    newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
+
     if (!requested_size) {
         newsize = 0;
     }
-- 
MST


