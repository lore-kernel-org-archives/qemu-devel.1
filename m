Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E76C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DDB206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgbPE+NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DDB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNmK-0005P0-Ax
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNiu-0000CB-MK
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNit-0001us-2E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=SgbPE+NBCiAh55BSlz51GOZeYegwmNdW/S3YuI89Ui1uPvSayl9CTpUcWUwqTQa6S36MkH
 baYRMDBbs33cUCNeSyXUvByo0TZnVMM8kXFDKkZdpmPUMxRrflgWnFmso6uBi1fRxV/YBS
 omLSA+YYM+2UTSevzmdKl360reXNsj4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-gfFJRv1tOwe0zFmAzvTS5g-1; Wed, 04 Nov 2020 13:41:28 -0500
X-MC-Unique: gfFJRv1tOwe0zFmAzvTS5g-1
Received: by mail-wr1-f71.google.com with SMTP id h11so6640263wrq.20
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aiHSSZpWVmtRhYn18w/DUuKk+CQD6Uz5cJmFPDvNuls=;
 b=Rv+cET4uEenu5WP4OdKX+qucb6y8WxqWr9JSrMzBLQ+YafyQjYHhdgLdJ/0iqsbmIl
 7jx4XngxMuzuTWy2ihLRyZVUBGlZ0DOXbcm9xkqYgC43M4Je+jUwxtySvctLBHL52aFO
 QXJk0uOGp7GMqBsgahg08ITdWPXuBkmiV4fty791RNwCcTqhORUftmP6B3HUTqh+YKvp
 Z4s45JJJ2YszD66MZcW/ijo2prOf3txE/Ujv8EMNBlSeDwwBwpbn0L51AuESUY4GH7PZ
 FhlHnBXSbCXbgutXhu9jzOjI1F7iEi74F5r2l7jjFI4gPRUNceYabFlreOcfCLxpDwjR
 dIrA==
X-Gm-Message-State: AOAM5302z/NSnB/5KEbEsqoVG0h2VSbE6xOhYLTGBYQNH3YgSu3pIG2n
 tI/rCEO5JM6y8TqTE808siF80Kor6H/kueFLajSK9o5RbK3xRwN9uY4j637aOrwUN59TeEtc+3a
 51JQYZnANI0h9cn0=
X-Received: by 2002:a1c:7515:: with SMTP id o21mr6343179wmc.5.1604515287185;
 Wed, 04 Nov 2020 10:41:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZoOuGeTcPScXfx4NnoV4Fb3cypRPKzFPIH5tkFVUAE8MgySqu9yqfEv1wRtH/tODisnTrTg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr6343162wmc.5.1604515287001;
 Wed, 04 Nov 2020 10:41:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z5sm3859713wrw.87.2020.11.04.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:26 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/31] virtio-mem: Make sure "usable_region_size" is always
 multiples of the block size
Message-ID: <20201104184040.285057-4-mst@redhat.com>
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


