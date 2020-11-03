Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F386AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671ED20757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMJ1BldB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671ED20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxSR-0000kg-EO
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOB-0003l4-Mo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxO9-0006JR-PU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=gMJ1BldBcONnwywErmCJlwpKjGPSpbZtDpXer1iLUa/s646OZkpeMqiV1bx9meyDhOjInE
 OuWzUqPRGOzfCSKLBymUUhb1NpbQff3ueYUppODW2LiYtaZaPJWdc8cOL3h1eSAQVNOtZ/
 /cjaIOQsJKHxWt1yV6bc5qrshTTdKD4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-dfQUqnVUOH-w1n5bhIRxqA-1; Tue, 03 Nov 2020 09:34:18 -0500
X-MC-Unique: dfQUqnVUOH-w1n5bhIRxqA-1
Received: by mail-wr1-f72.google.com with SMTP id w6so272045wrk.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=SHWmKLzhpm7NhAHVVoGVTXWwZ+i++yuf2TDfuAmjYC1odWvYG0XwnzNHejgqRg/1n6
 NTJ8VJZAtacdCeWTYX0ehvRlLjKIXCZT4goay+Oy1o1GvtaK08g11qR/Ex7K1YNkclnX
 bdNl3HZ0civgWC75/IUg85S+A+J5gFAVtdD4xYEHiPmLqxGOpRz49jCOylEfajY+VzuO
 a4ALWGDyEFEJkhgU7Yj0xHwA8cYWUIe8QM6CARZaCzpiE+u1/psIr5UqdlVsH5Ru155o
 DMG4b777XpPOSQNCtADByaVpxY+Y7iMbVo2esagL23hF2JrVcWkY/DpOU8GsrOHW7Kqa
 iosA==
X-Gm-Message-State: AOAM531gWATwrF/kos2p7sWqBLb2P/MK3hZgeRkbsmAyiPfbrxupr6FR
 Lagl0rM75c/OfkajbxmPFwOSNSpyDQGqD1E5DQBp7NJg8V8FPK8d/eDj3+abAIATLbucuxFhren
 T8wxgEV2UIy0nXpg=
X-Received: by 2002:a7b:c101:: with SMTP id w1mr48925wmi.170.1604414056797;
 Tue, 03 Nov 2020 06:34:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/2WkFi7ZaRYoe3SsHv9nM8ohAUKmhhnQrFY8zjY8vaa7LxsI/6TTm/6ia1kLf7Vos59J/wg==
X-Received: by 2002:a7b:c101:: with SMTP id w1mr48913wmi.170.1604414056652;
 Tue, 03 Nov 2020 06:34:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e2sm27690990wrr.85.2020.11.03.06.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:16 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] memory-device: Support big alignment requirements
Message-ID: <20201103142306.71782-6-mst@redhat.com>
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


