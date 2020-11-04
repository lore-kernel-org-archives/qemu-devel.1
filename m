Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B938206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfR6NPiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B938206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNkS-0001yt-N3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNis-00007K-Aj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNiq-0001tw-EA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mgCjhnq9faNGq2/uhjHeag8wnNyBtF7y3xz069QrTc=;
 b=KfR6NPiKD6ueigNk5zHcx/GkgHSBQZ5as2GWis8zGmTL6IRjkahZaAVpqnmikAKmhR96UD
 vIgp8YOU84FCTESvj8HvBf9p7VC1kpFmvK1bX1y8eyokN2eRx320gQd0mK7H5Tz59yaSXJ
 oqWZsGy3SOYea4s3vc29gakB/P3supE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-eJDnAk8DNqWjXY7HLmD2pg-1; Wed, 04 Nov 2020 13:41:25 -0500
X-MC-Unique: eJDnAk8DNqWjXY7HLmD2pg-1
Received: by mail-wr1-f69.google.com with SMTP id m20so9617515wrb.21
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6mgCjhnq9faNGq2/uhjHeag8wnNyBtF7y3xz069QrTc=;
 b=CWVU34Aubi2MSsCDpLmxgM34FTNtOc6YSTTyQJgWhZBDglk1+HuWx9fzIqBeZu38/n
 PoxA1iMZ2BJ5QpNjRLW1R9Qlhu/lRt8gVjFbeleJ0NEIjieCXlMGKJEkYrqmVfIPa6Nd
 EpotFKWgcaBRb9XXWIi3m1rXMAkQV39nQgVC+Dkgm462c3h9xw1TQXUG8csMbNo5xuBB
 wZEq24Vr74eaNv0nu2mCKThIC/yiAeTrErgX8v3QjR1LHhL1mJgc36tpOYFccVm0r1dC
 gmctVcIEUrAHkq7ncxlO44YD39rLosGTmBp9dHR5bpE8pe2LHkbbtWsA3BCvF9yImDk0
 WvPw==
X-Gm-Message-State: AOAM5336je6Th4IfJYwR/7hNy48yXM9uCNI+3ZcRfoCAJTUsP6D+dfj5
 Fo0nWn9oP55tuD4ewyVxu4VRJHfcGoMPE+NrCrn3bAMrxdiCq0Cr6UZcEjr2G/uRqCoBpdK1kOs
 8RRIAKjXtY3TwXTI=
X-Received: by 2002:a5d:5701:: with SMTP id a1mr33507557wrv.414.1604515284232; 
 Wed, 04 Nov 2020 10:41:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJna2NsDHXZbX+en4FhfrT+SuGKLaHeTNlHBFGf/A7uo9rvx9dMRLm1qRiZJBK+AkWhYJb6Q==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr33507534wrv.414.1604515284058; 
 Wed, 04 Nov 2020 10:41:24 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u195sm3451875wmu.18.2020.11.04.10.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:23 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/31] virtio-mem: Make sure "addr" is always multiples of
 the block size
Message-ID: <20201104184040.285057-3-mst@redhat.com>
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

In some cases, we currently don't guarantee that for "addr": For example,
when starting a VM with 4 GiB boot memory and a virtio-mem device with a
block size of 2 GiB, "memaddr"/"addr" will be auto-assigned to
0x140000000 (5 GiB).

We'll try to improve auto-assignment for memory devices next, to avoid
bailing out in case memory device code selects a bad address.

Note: The Linux driver doesn't support such big block sizes yet.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201008083029.9504-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7c8ca9f28b..70200b4eac 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -449,6 +449,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
                    ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
                    VIRTIO_MEM_BLOCK_SIZE_PROP, vmem->block_size);
         return;
+    } else if (!QEMU_IS_ALIGNED(vmem->addr, vmem->block_size)) {
+        error_setg(errp, "'%s' property has to be multiples of '%s' (0x%" PRIx64
+                   ")", VIRTIO_MEM_ADDR_PROP, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                   vmem->block_size);
+        return;
     } else if (!QEMU_IS_ALIGNED(memory_region_size(&vmem->memdev->mr),
                                 vmem->block_size)) {
         error_setg(errp, "'%s' property memdev size has to be multiples of"
-- 
MST


