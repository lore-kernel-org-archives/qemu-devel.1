Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B2D2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVdRFqo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B2D2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAqI-0005BA-23
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAl9-0005To-Iw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAl7-0004MV-Su
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=XVdRFqo0Im53KZbAeyZkMjLckdirJs6harZaqtjthTHB/2QHyIDiJWeyM5RUpnjFzC5O/D
 uGqpszM1iroN2hMZgB6OiulWlnWjSOreTrYr2kuuJh/A3M42Kvk0rTNyTI7FsNoepfibWs
 I/XwzCv8mm3XUQ0QHB88kkX2TERLmU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-EXnVke99PNe2PjaGMcoKlg-1; Tue, 03 Nov 2020 23:50:54 -0500
X-MC-Unique: EXnVke99PNe2PjaGMcoKlg-1
Received: by mail-wr1-f72.google.com with SMTP id e11so1221718wrw.14
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=XyFzSy7CMqfWVjALXCaUpa6qdCYyR+o5LdNFKrA1wG7wVpaD92a3WzCHYSGRPKBrrc
 yknuVRL/C9ap/In7rXmAaDXsUDxdrY7HK/zmmyY6R+yGJpkOAmt/adGicR4sDlVDXc5W
 B/Yso+B8bbY0OgG0WYFhiINqRlE0m3h9ouzNUcLgGKQmew0p609VpKe0xsv+dOsDjihX
 09Kgxk12+4bFWKgXc8A9/OgcDJWjXIsiUoK7UFx17yfI+SQDaOaOZ8RLrHnlS/wtmChW
 K3GF2Bs4sCDAstNpWtfwV6gjhKcPw8sLR4vwGweQDlVsIjvro9hQC4c8ikWTgl+I3i7s
 jm4A==
X-Gm-Message-State: AOAM531x1Ks7uTrsQwXbv8feED5NyW5lKuwQjzVFNlpKU13qGbACWzr+
 8IghsAH5W465j+cvvzkxHuUou9CIWxChrL38UZ+R5ygRYpEgqWF5tlCbKGcUcCvI4HFQvACGVMw
 7BvphxpVzePmsFCo=
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr28127011wrw.243.1604465451615; 
 Tue, 03 Nov 2020 20:50:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWBU6G6H7aKVRlvxEpplsVFD3joQUH1nzVqW7v0tMF4otcMd0D9boa0u1yAv3wzU4S0mgeAg==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr28127005wrw.243.1604465451504; 
 Tue, 03 Nov 2020 20:50:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j9sm859958wrp.59.2020.11.03.20.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:50:50 -0800 (PST)
Date: Tue, 3 Nov 2020 23:50:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/38] virtio-mem: Make sure "usable_region_size" is always
 multiples of the block size
Message-ID: <20201104044937.226370-4-mst@redhat.com>
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


