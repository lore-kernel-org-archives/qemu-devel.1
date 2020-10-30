Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03327C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5133D20825
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrzXhAdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5133D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVLb-0001SU-64
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8p-0003ko-JR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8g-0007Gr-4D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQbV+eeH0Jal8wQ3qnCI4bc8h7HSMGkH1TuPaMitNA4=;
 b=ZrzXhAdSZLfwy/MiubA2A466KuFbSriDmKP3EzRRU5coPqfBwMpN7KGlZhcFQ7Z7glQ41u
 pwdaPjxVbZGPnIyOzLMddFWmUtD4WeciQ/u32//hdzXZWs6gSJNqQLVXiUAOVu9rcdUeNy
 FEHahum/0Wjrv00mg0HORnXauznD0lQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-x38lNmS3PgKJFA258oCA6A-1; Fri, 30 Oct 2020 10:12:18 -0400
X-MC-Unique: x38lNmS3PgKJFA258oCA6A-1
Received: by mail-wr1-f70.google.com with SMTP id u1so438427wri.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OQbV+eeH0Jal8wQ3qnCI4bc8h7HSMGkH1TuPaMitNA4=;
 b=OLguExaIpH5R37Go0QOUCc/o65H/Gt6z5GQkSpCxAIKStHYbqktYFnGX0jesyB4sb6
 2pji4i4EAX08bvbCIt1RELnW43jeed5BUOm1q+sTD7wTINo6a3yx7LjzH7uOB326RRSk
 Ju+fJqlRjrNG51kfEAd52X9l/BAW30kZcHS9EZko2q4oZmo7FLn0n8mY49P/NDBr84CV
 aecFwfQcVhCeso1HsYMaKATH5FbsRYIHeITIGqIjpatCaCIiz82tAFT/EOhvL2IBsJGF
 ULr9oFn5O9UUQYFfkZylyeWaN2rs1mzppdkHAeM7mT0tzKXOrXYzYW9cWOEzvIJVgMbL
 jtGw==
X-Gm-Message-State: AOAM530Rbg62KHSwsn2zHN3ASFQSVFFtiGuqG0Yl+LqgA4X8QfdOOYYh
 fvl+UeTZFw/xNgwOMXVnpE90ikN8dCFYAYFUVynSqiUXMAQ8AyKBLH2HewVvyqtcgKeNUQwJciX
 XG+wnXcSn09TFr7U=
X-Received: by 2002:adf:f90f:: with SMTP id b15mr3446882wrr.343.1604067136512; 
 Fri, 30 Oct 2020 07:12:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeKwql4grIXbCG102LUAkCgmz3vxKB9/n7D9FrORDWmRxPH//XyZpPV2rGKGklAFjvUFKF7g==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr3446858wrr.343.1604067136337; 
 Fri, 30 Oct 2020 07:12:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y2sm4616786wmi.21.2020.10.30.07.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:15 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] pci: Change error_report to assert(3)
Message-ID: <20201030141136.1013521-12-mst@redhat.com>
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
 Ben Widawsky <ben.widawsky@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

Asserts are used for developer bugs. As registering a bar of the wrong
size is not something that should be possible for a user to achieve,
this is a developer bug.

While here, use the more obvious helper function.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Message-Id: <20201015181411.89104-1-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dc4019865b..e5b7c9a42b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1151,11 +1151,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
-    if (size & (size-1)) {
-        error_report("ERROR: PCI region size must be pow2 "
-                    "type=0x%x, size=0x%"FMT_PCIBUS"", type, size);
-        exit(1);
-    }
+    assert(is_power_of_2(size));
 
     r = &pci_dev->io_regions[region_num];
     r->addr = PCI_BAR_UNMAPPED;
-- 
MST


