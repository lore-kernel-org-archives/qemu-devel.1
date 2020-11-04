Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C56AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D283720BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfb+K0T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D283720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAnl-0001bb-QL
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAl5-0005KS-1e
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAl3-0004JW-9c
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mgCjhnq9faNGq2/uhjHeag8wnNyBtF7y3xz069QrTc=;
 b=Mfb+K0T4X1yqneAls8u2p2sQX5zbOhjI3WzZ21hYx9IJYu/EDTo3VU7L80iWw5wQRimIYl
 C5US478M/PrjosfHalV7aupC65WPPZDmEbGVMZxS1+XhgwsIfgsN2AJ8amKAW+dRlu3sG7
 ijJqqkUDCoGOAXkE+cdq/0QjWL8DwPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-xURp4f9JOyqlChtYdOBphw-1; Tue, 03 Nov 2020 23:50:50 -0500
X-MC-Unique: xURp4f9JOyqlChtYdOBphw-1
Received: by mail-wm1-f70.google.com with SMTP id f70so728307wme.7
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6mgCjhnq9faNGq2/uhjHeag8wnNyBtF7y3xz069QrTc=;
 b=VoUJnYLrobDMMJ6/uPPvIhP4C73xnHIopbwtvjDe+uny2QkkNCezMWlSecQOKEMDKN
 wsGRi86/suXO0JsF8G6iqJ9HSfEXp1X+5v37QHSTRT5tLF8QLmDHl889ybLREPpR2hhE
 oo9iedNqf4G5sO5v2Hc2KXRXNN2Aq3o9UbQBCBU3vm7tAq0FTEoVEBgmAFx17XaqIiHk
 fN4Gf9MvOAr+fstaBX43hO8C1k8E6l+BReemzKf0Dca0wLH65m+8qpl7VkBnDIhKDlAZ
 +zXKfoVujsJZ2xI6K3CqX7NG3SWfFfJjQxFVuo06uRSY2fuaCs58fZsj0VfBXFYKGd1U
 3oQg==
X-Gm-Message-State: AOAM533GsOCZMmvZ/CEI14aDiFm/bN+iuFvFAyvmRFew+xJawoEWVW1v
 KTMOEbjjiG1JoIb7L4gj040QS1UFO7kphvkM1DcyX8sw680YYNLhnva0JW1kzvnvjSLXP4N4sk6
 7mqad+eVwmR7rng8=
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr2378256wmf.98.1604465448952;
 Tue, 03 Nov 2020 20:50:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh0SGYHFP/Z3qNjqEkjNqOznbpzFv8Y+lou3y7D4WNZCPT5TcCKgEgw55ihTcpgdYBpFmHeQ==
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr2378246wmf.98.1604465448818;
 Tue, 03 Nov 2020 20:50:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p4sm875018wrf.67.2020.11.03.20.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:50:48 -0800 (PST)
Date: Tue, 3 Nov 2020 23:50:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/38] virtio-mem: Make sure "addr" is always multiples of
 the block size
Message-ID: <20201104044937.226370-3-mst@redhat.com>
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


