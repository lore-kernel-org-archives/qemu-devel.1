Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF902067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOkBfQrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF902067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl4m-0002sa-PQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1V-0005Ao-2h
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1Q-0001Lg-9J
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdSt1fYq3b/MNQ0x5ZZmdB8fAeuVH3A8AbIAmGm6Cls=;
 b=AOkBfQrpRMp5w4jHCd5UO1jFJ8gavpIuO0L2yKh7nE6PFRk5nQpprEyjiPSy1DP4tp72ep
 iz9xZ4P4iME3QA+RxUkEnN4QzusEXjAOtWargdyfB8lmKVTGIQJa4QKCcmUTdjExD0vwou
 XvvEYk2uwWhbZa2G9fPcPTILUrjoHX0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-XtqLDnsuPgysA0YZJi1FaA-1; Fri, 12 Jun 2020 10:51:05 -0400
X-MC-Unique: XtqLDnsuPgysA0YZJi1FaA-1
Received: by mail-wm1-f72.google.com with SMTP id p24so2034088wma.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vdSt1fYq3b/MNQ0x5ZZmdB8fAeuVH3A8AbIAmGm6Cls=;
 b=k2083f0Leji0TzpMnmKGBCe1TZjNxXucwAT14K0PF5oMtabWORbT9DwoGqgcsX6tV6
 gfeVbaBPJNKPjfpKTOZFjPzegfY+f9RR3H3LrnRpHoWus7lUwuiqvRI+4zTjHzkrNzaX
 9aX6A0XGuLqgKjRutBhU1KYdZl7NuBE8QXFmz96mgq4muJ4ifaGhNY9xfaPWM9OJo6Bn
 KlXyT6uNENpGObCMduoSQ5ktRAOhRfC6R5WdNKDlRROR19VJDo3Dqj3LBX2LnjPLbC8g
 uPadamjyox+8Q82D3gg3lX5Ns5EXw3boMxwYPKK+MizqGbqYFlPJrLwD/BTKYSvscMXl
 bnow==
X-Gm-Message-State: AOAM533nFoz9MkCnZB2qRY90GysYHEA0XuGTOIqbbwpBMExMpj6BHt30
 UAHb7oxtwaqQ1NuRxFXaJm95GjktdHdWAyRBduefQkTjzbAvmczzTfzhU6ffVCmBx8GP7yKtsa8
 GlsuXaaa8mdmqnWo=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr15261033wrt.298.1591973464608; 
 Fri, 12 Jun 2020 07:51:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUrM0ojZqr4grEpvjtvfOK0JdYEVvnKKk4HAiZBjZ13lYSduGzYrm8lOvzsEDAqrttN7GfaQ==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr15261013wrt.298.1591973464451; 
 Fri, 12 Jun 2020 07:51:04 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id e10sm10343278wrn.11.2020.06.12.07.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:03 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/58] msix: allow qword MSI-X table accesses
Message-ID: <20200612141917.9446-2-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PCI spec says:

For all accesses to MSI-X Table and MSI-X PBA fields, software must use
aligned full DWORD or aligned full QWORD transactions; otherwise, the
result is undefined.

However, since MSI-X was converted to use memory API, QEMU
started blocking qword transactions, only allowing DWORD
ones. Guests do not seem to use QWORD accesses, but let's
be spec compliant.

Fixes: 95524ae8dc8f ("msix: convert to memory API")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci/msix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..e6a5559038 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -199,6 +199,9 @@ static const MemoryRegionOps msix_table_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
@@ -227,6 +230,9 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
-- 
MST


