Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF1C282DA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCC62175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCC62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY4V-0006UE-1T
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:16:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0r-0003Xl-4b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0q-0003dB-1l
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:45 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0p-0003bD-NW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: by mail-qt1-f170.google.com with SMTP id v20so9301315qtv.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=Jyhe3p/Ccar9reziLeUONHcFyVAWXVN3KHZsF7qYEs4=;
	b=UK2boDX5LF2KfE+AMDvCGGifFwt0De+WQcJxjIwS9Kf8WM+zHDu1StR1bnVpg9c2YL
	lNkRq1tPCKKp4K01MW5SxbMRyqyH73T8+++71lbsm8nDs+O8y3dRo4/FSmhXDQTKBsQ5
	MYR/txX0aaZDLb6Xr7C6qz+unm+aDxz31xzO28j7JRpEk0D7M3uC7epQWnhSYCURCH3T
	+Wk4QNPec/TRpEoZZOWJCA8OeNr1/SkeQl8UZhsk9+DDhL5KLI1CPPQF3/URjKpRLy46
	gyy12LM7d1v+PQe1/y5iqLn1ob2grWrWUGoRVS6XldUeCj4fDcXVcGgx0eZbR+9vFiO4
	CcSQ==
X-Gm-Message-State: APjAAAV5CDizSTJFJm1uy/Qp5DXsLLNIU7LS9VwxlwpBEKMfwMHUPMV+
	NJPXo2IazHzIw9p1MHvMBHHV0OL+iys=
X-Google-Smtp-Source: APXvYqy+FuqRKRzrQxWCIuKehAuKtIf2UISbVIF57fTB/vtmbEqP54sEToAfz7qY/1BD0Uq5E8YcUA==
X-Received: by 2002:ac8:5518:: with SMTP id j24mr13865716qtq.183.1554505963007;
	Fri, 05 Apr 2019 16:12:43 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	v129sm12839272qka.77.2019.04.05.16.12.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:42 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <155364147432.16467.15898335025013220939.stgit@gimli.home>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.170
Subject: [Qemu-devel] [PULL 2/5] intel_iommu: Correct caching-mode error
 message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, &lt@redhat.com,
	Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Williamson@redhat.com,
	Alex@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231240.znrGdfhJELp5WdipWuyEORjqUeNwCtBTx2aFGXKE7VE@z>

From: Alex Williamson <alex.williamson@redhat.com>

If we try to use the intel-iommu device with vfio-pci devices without
caching mode enabled, we're told:

  qemu-system-x86_64: We need to set caching-mode=1 for intel-iommu to enable
  device assignment with IOMMU protection.

But to enable caching mode, the option is actually "caching-mode=on".

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <155364147432.16467.15898335025013220939.stgit@gimli.home>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Williamson &lt;<a href="mailto:alex.williamson@redhat.com" target="_blank" rel="noreferrer">alex.williamson@redhat.com</a>&gt;<br>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 055a1e865d..146cd16dd2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2919,7 +2919,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     IntelIOMMUState *s = vtd_as->iommu_state;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set caching-mode=1 for intel-iommu to enable "
+        error_report("We need to set caching-mode=on for intel-iommu to enable "
                      "device assignment with IOMMU protection.");
         exit(1);
     }
-- 
MST


