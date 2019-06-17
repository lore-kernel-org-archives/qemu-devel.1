Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD90C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB572084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqmm+rB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB572084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcszE-0001wL-AW
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiG-0003S9-1g
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-00080D-Cw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiE-0007yK-4G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so6864258wme.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DxzFr+PxhxGUlwpP3ZW+DROYq2bJOJKyGjaM0kFUnOU=;
 b=aqmm+rB2hNupjoWQ41jh5K3g53Yk+UP4Uifqa6F3MA6r5aWXX98PfSZs337HqQfsJe
 NKOsFpZ6gN5fj93bfHfbvkE6KDKOnq8owxPhqBQOmjoSD/atUUpwEkPd3ZM0mho1/aYl
 7BEDbRlYEuXr2QrTpr07C9QYMLKnsFlHcrsOIYhAFafqSG7oDoX+HJ8zfue0+puiGIgD
 8so2i+XEk5NSocR6wnuuW4SsngiBu+Evny+/XvBRJ1Fczb3yALg7fczmN5RwbGBfN73b
 +DNJR4qc+4Q8XtQg4qwecYR93Be9SLQFoPdVM309TjHn0iofp2WzIvmBAkopQJQUALJ8
 xZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxzFr+PxhxGUlwpP3ZW+DROYq2bJOJKyGjaM0kFUnOU=;
 b=SPWJlUQqSPvFtQhFBD/prRVkAYBXA2SWPiqcpjtkTAJpEoFShkcG4v7ed7pqunXgFM
 VHUmyxvNXDqwDVieGrzGWEyNF8hxVrhnXj8bzCbgq2p8qZZyrraFCIGcL81NC6rb3a1C
 N4bNe16PRZuRKJKcizlbRVKlPkIi5k3it4VHz9FE0Zj0Cay41GR8+I/2I1kXR0E4WGL+
 Tao0l+K8fcmhTqo6/IDlqzgqhwEkIdIgV6PfPlC/gB25VGnzagWoBy2MXaB63brQRAsQ
 c5x91//VqLKOCsLw1gcxMEcxNkaFsv2Pf8exykPUwNwiERbOXy5DB+1kE3qH6fLxZ92f
 R0QA==
X-Gm-Message-State: APjAAAV3/aBNbJnis6qIfOlcJqwwZJ4A1lFLMJJ/u5qAM9FVgGseutAl
 UFh7FKXJALgoZ3HjK/1be/zI8WQ35SCjYQ==
X-Google-Smtp-Source: APXvYqyawAWBDguC3SXa8/3eR97g8pe9f0+l5pXzLXUWpqEexmmj/7VO8mm5SAX0M8xoaaNtSIj6eQ==
X-Received: by 2002:a1c:f515:: with SMTP id t21mr20392549wmh.39.1560782059272; 
 Mon, 17 Jun 2019 07:34:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:52 +0100
Message-Id: <20190617143412.5734-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 04/24] hw/arm/boot: Honour image size field in
 AArch64 Image format kernels
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since Linux v3.17, the kernel's Image header includes a field image_size,
which gives the total size of the kernel including unpopulated data
sections such as the BSS). If this is present, then return it from
load_aarch64_image() as the true size of the kernel rather than
just using the size of the Image file itself. This allows the code
which calculates where to put the initrd to avoid putting it in
the kernel's BSS area.

This means that we should be able to reliably load kernel images
which are larger than 128MB without accidentally putting the
initrd or dtb in locations that clash with the kernel itself.

Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Message-id: 20190516144733.32399-5-peter.maydell@linaro.org
---
 hw/arm/boot.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a0e1110719e..b2f93f6beff 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -911,6 +911,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
                                    hwaddr *entry, AddressSpace *as)
 {
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
+    uint64_t kernel_size = 0;
     uint8_t *buffer;
     int size;
 
@@ -938,7 +939,10 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
          * is only valid if the image_size is non-zero.
          */
         memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
-        if (hdrvals[1] != 0) {
+
+        kernel_size = le64_to_cpu(hdrvals[1]);
+
+        if (kernel_size != 0) {
             kernel_load_offset = le64_to_cpu(hdrvals[0]);
 
             /*
@@ -956,12 +960,21 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
         }
     }
 
+    /*
+     * Kernels before v3.17 don't populate the image_size field, and
+     * raw images have no header. For those our best guess at the size
+     * is the size of the Image file itself.
+     */
+    if (kernel_size == 0) {
+        kernel_size = size;
+    }
+
     *entry = mem_base + kernel_load_offset;
     rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
 
     g_free(buffer);
 
-    return size;
+    return kernel_size;
 }
 
 static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
-- 
2.20.1


