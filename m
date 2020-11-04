Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5CC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C309720780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgLGBBrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C309720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNoV-0000Vl-JE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNj1-0000ST-Sz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNiy-0001vK-RJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=LgLGBBrhdYpUVOnxWdmam6frz3YRDMsF26GIqjC/RDsAA+/dnaEGXcJbCruhQRH54Hn1JT
 DoRRJgALT8VkQLEXzNeHvNpTjryV8pyndgWy/8AWSoeiSPIesC0j9x+pWfsvOJIim3ITK2
 k7vKTArxWsv2vnGz9kb/F+AS0sybWGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-O-m-yhI8MQK7bksLZNnSlw-1; Wed, 04 Nov 2020 13:41:34 -0500
X-MC-Unique: O-m-yhI8MQK7bksLZNnSlw-1
Received: by mail-wm1-f70.google.com with SMTP id t201so1564191wmt.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=FFDzC6UseCwfFK/3hZbVkHnRdc+yg2s507jQ+fFis6tCxL2Oh7lsB2NffQ2DA9ft7E
 TuAk9OVMb3CYuF/1O+7zGZeM/aCszAfisscvZyP7rlsgoQvEo9QtnH3nWihwlQ3cVSKY
 mO8L4Xpmq4Iv/aGKMC6b4dkei8ECijMqZWq6g65RVxcqzP+INGVFMNmsSxj9xwqDqe4n
 IK9ygfj/ehpScE/AqrsbgzA6xlIE/lo4KCG48DkmoWcKM0/M7hZABTaPBh3ZhKZiAsP7
 hUXHT1XpBVG5smBaggkEiBOZ7KE7wVCyrLDK3Vwrmi4savOeSdGK7Xyaxx5EHA0ZaIke
 dmcA==
X-Gm-Message-State: AOAM5333coi1FSkA0/j88Y196xy0rBh4zcuJ88yOFwOiFu8TsGdrIqva
 9h7weibBlL0wVB3cbx/5NY0AJXKdgqHsKL6QZZE8SNZLdeZa1PK8rmSMg5hFiWBEcd2S1eZ8BOC
 0IVOJ252a+Dz3xug=
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr5988920wmg.55.1604515293230; 
 Wed, 04 Nov 2020 10:41:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxa/lqinC32R1qAdNqW7fw4dyydl8bIKsQYRQAC5RbimM+ke99QYSIr4KEzfA1a2F9kSUJ7A==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr5988902wmg.55.1604515293075; 
 Wed, 04 Nov 2020 10:41:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y4sm3682702wrp.74.2020.11.04.10.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:32 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/31] memory-device: Support big alignment requirements
Message-ID: <20201104184040.285057-6-mst@redhat.com>
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

Let's warn instead of bailing out - the worst thing that can happen is
that we'll fail hot/coldplug later. The user got warned, and this should
be rare.

This will be necessary for memory devices with rather big (user-defined)
alignment requirements - say a virtio-mem device with a 2G block size -
which will become important, for example, when supporting vfio in the
future.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201008083029.9504-5-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/memory-device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 4bc9cf0917..8a736f1a26 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -119,9 +119,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
 
     /* start of address space indicates the maximum alignment we expect */
     if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
-        error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
-                   align);
-        return 0;
+        warn_report("the alignment (0x%" PRIx64 ") exceeds the expected"
+                    " maximum alignment, memory will get fragmented and not"
+                    " all 'maxmem' might be usable for memory devices.",
+                    align);
     }
 
     memory_device_check_addable(ms, size, &err);
@@ -151,7 +152,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
             return 0;
         }
     } else {
-        if (range_init(&new, range_lob(&as), size)) {
+        if (range_init(&new, QEMU_ALIGN_UP(range_lob(&as), align), size)) {
             error_setg(errp, "can't add memory device, device too big");
             return 0;
         }
-- 
MST


