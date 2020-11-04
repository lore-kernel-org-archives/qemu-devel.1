Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4FBC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E4B2222B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNP+eZGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E4B2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAuA-0003b5-IZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlE-0005cd-A4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlC-0004Nj-EZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=FNP+eZGtfevvx84RS8dib/AQTR78nVsb2wOHnS3F81GXPpFLaDK1LTApWItgC7JNt+oSTY
 ttkVLmnTmQuhr53+fUe3SKSG2ZLPd9VEDKucx16x0udQHFAISdY7J+BnMZaizJT8ZyFUk6
 O2MPG5QVtE7N5TzawXwDOj0absMvX2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-wR2tFf37MbSCtZ9RjgKgXw-1; Tue, 03 Nov 2020 23:50:59 -0500
X-MC-Unique: wR2tFf37MbSCtZ9RjgKgXw-1
Received: by mail-wr1-f71.google.com with SMTP id u1so6473662wri.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sdg1XQq2wWnBWKWHjU6hAJQnpSiiinwLqOwmCIMoYHk=;
 b=qPP8Ru+IN3aTBAEeZsvs9mg4BTK81rjlU7RgXmLs8piJZeNrcAhKCop/YES4KV2r2S
 9MHZXPWgiq3RlJ7/oU1ZcXy9c+iRlJSbsfAH/nzhHmLKsXWk3Rk3Am8wsuBLOHDfDdkF
 Zhr6Ty+thZVf0vBtRbhZWn2tpF8ryQ9FvqUcpJ4UvqTlyyItzzLFgt9OAayKRXBxf5wh
 YzdV6CdEG2UPCKnf86CIC7cac7i7wbPr8oZj4rAhwQhC3FSX3tIS9s79RFj1A1JkNdUB
 wE5LbAA3uDLZIClmKtFwZXh6ccTTUuOjFUR6+9xISHNLfhP1K8cNR0pEtMSixj6YbElM
 EBfw==
X-Gm-Message-State: AOAM531Mp1uzHclvV9AP3x9cbmnWAKbT0qMaeRkIcor8yrAGpuyRXYDu
 //sEx29qC75yUuBXEIhktCVg2XW/X4KhaPg5Bq9MOEDZCN7hUoo/VcXOOxxj9Gv5hcjwEckDh+S
 LLVjAYBUdu86F8cM=
X-Received: by 2002:adf:e287:: with SMTP id v7mr11744596wri.252.1604465458033; 
 Tue, 03 Nov 2020 20:50:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDJs7OBHgH3OXB8HBckW2FQUU2Yp+YgQhuC5NvTqtTAjZiAo6XCuyAdwzcgwMDC9hlfvW6IQ==
X-Received: by 2002:adf:e287:: with SMTP id v7mr11744581wri.252.1604465457923; 
 Tue, 03 Nov 2020 20:50:57 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t11sm803380wmf.35.2020.11.03.20.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:50:57 -0800 (PST)
Date: Tue, 3 Nov 2020 23:50:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/38] memory-device: Support big alignment requirements
Message-ID: <20201104044937.226370-6-mst@redhat.com>
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


