Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956A3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E390A2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQLHxNQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E390A2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVJC-00079I-TE
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8t-0003pI-HD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8r-0007Hk-Ax
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0O00/al7cwQGWZwwOP6NLGwTcTYmOVWX7BhS/dcA4E=;
 b=LQLHxNQSzW3VeNodyJ5moxkw8cJY6i+LB0PxAK2pE7fGl2wnzAsxeUIrF+cq43W2Y+Eo85
 /c17p02jwlH5wFXBVpQ3/5Unl8TnVDdoIFF2k0Y3i/i5wpZ5vPxkLg9UHEJ7Ihqdf4OG40
 npFVExakoJ5TKmAQMa3hAcWGzcah+oU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-0iXj627ONi2OBktI-Bue_g-1; Fri, 30 Oct 2020 10:12:28 -0400
X-MC-Unique: 0iXj627ONi2OBktI-Bue_g-1
Received: by mail-wm1-f70.google.com with SMTP id t21so664749wmt.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=d0O00/al7cwQGWZwwOP6NLGwTcTYmOVWX7BhS/dcA4E=;
 b=hLWfqELOjrcDBZyfN7TuDJ8N4L1VOqSd1YugzDwRMCECRN3WqZBkNsXV4ruyvnZaSD
 eSO5t2/IvQia/GYamTc27aLSIYHWDK0Jr7ZmfYbw39ljb3cUaDv1KIpX71K6tT97RuPG
 Q479w+Xqz5D66PVJcLAS1bDa6xCIGhmQ+AMlYCtXlLrJFNbpaiwfiUGSg3DcsLd5Pmxi
 DD9pVWnVxdLEJ1osoyXrqHi+mMQ6zU+2R9KMqLb/HeixTj7sbwu+U8ioz9E1cMva8Nyf
 oNRtcXD94fpcWp1OHzrqTlyCAW0/rHkVHv7JyYRCeJ5UWXrgElTQcT2Ifuuf77req9RX
 x77A==
X-Gm-Message-State: AOAM5312OS4vU/z3bYwz72Zh1W05W/atSJlSxGmOdc3PSBzPB+1S0v8I
 1rIW8WRfqUGqahVwcPuNI43vIf7si6K/QvbUWtlFHR0Asa0u7Sx+o3JfbzFfill9wtCKxnC9uEM
 WUdKisHR3LciyxyI=
X-Received: by 2002:a1c:4646:: with SMTP id t67mr3036968wma.40.1604067146761; 
 Fri, 30 Oct 2020 07:12:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcTcYNgqIFZ0NNodQZDD9IwI+YtMCFvbOWX+sYeS8Vc9t8Afe/H296/0mB688FAqZA7kKPqg==
X-Received: by 2002:a1c:4646:: with SMTP id t67mr3036929wma.40.1604067146524; 
 Fri, 30 Oct 2020 07:12:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id b4sm2655071wro.57.2020.10.30.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:25 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] intel_iommu: Fix two misuse of "0x%u" prints
Message-ID: <20201030141136.1013521-16-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Dave magically found this.  Fix them with "0x%x".

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20201019173922.100270-1-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 749eb6ad63..70ac837733 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2665,7 +2665,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     if (addr + size > DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
-                          " size=0x%u", __func__, addr, size);
+                          " size=0x%x", __func__, addr, size);
         return (uint64_t)-1;
     }
 
@@ -2716,7 +2716,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     if (addr + size > DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
-                          " size=0x%u", __func__, addr, size);
+                          " size=0x%x", __func__, addr, size);
         return;
     }
 
-- 
MST


