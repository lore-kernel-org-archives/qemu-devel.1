Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2F620873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbCnU1ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2F620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6cy-0000fr-Q5
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ui-0007Tk-7f
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ug-00042Z-UW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Ug-00042D-Or
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g24so9816023wmh.5
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VpK7DgB24L4FBN+Cv8MDDt0jG1tSba2F0aG6/IXjc+c=;
 b=LbCnU1ZRv9oIe+RislOCKhs5ufeTZyJcaziK9nPnrBR3KthTPqIpcX34vjdHDozppm
 UJR4LrtaTZ7W2ejIUQKAUyDuHhzVJFihFeU7nVbjwIoNNIfr/DkNvP5OgtXWuG/6Obbk
 RcvrAwKorky/8M4HHW0nBMzljKbd9y5+R3SiU+FkNSyWU99tqH210N0ft1IYxDf8v2Er
 j9ittXMRFiHsQplJK+VCXCM82/KNH7Jd/mTakwpNVOCt8U0pWKs+hvmP7g0leY2OlmWX
 VJ7VvvS2k5r4bCEsVknCq2JoUs1XuqMKTNSdDq5bxua5WBhECORUpE9U0P43yl4Y7v29
 VX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpK7DgB24L4FBN+Cv8MDDt0jG1tSba2F0aG6/IXjc+c=;
 b=TzV95ClcDDH4NFwX2a0steakIZ7d9yDtf2cMGI+spv+YZ0YjV+1xmZfsKrCe3RhVWv
 77dpvRZI0YN3TExtNehhV7SNmgiX6MrvdwytMl2QSUQNq0qzosvd/WmB9bwqfEtkVLwA
 mZ/7/EpbTW6C9T1z2p/aWstQ/jC8YMeGZ7E5AgkLzYVvDrItk7rkGbaBbst4JnFfrM6P
 UVF0xtCl5KR79POUNZc2LQdoIm/qKWmlyKmm6hNoHimC+oUyq7srLMS4vo4UV+3AfAh/
 Za1PNnmzBzxx2IFAKFbGlPI+3AgJU3+L+kSYu+LDZIDMkAMmiE4/p3mZ+EG7GLUxUmF0
 yIUw==
X-Gm-Message-State: APjAAAWG3qWSK0wEfCcTrlXOjKcuGZm1Xr+bLV0Jp3eT3X6RedIDzPFY
 QrJx4Y+JlY93jFvHrBb6UROpHgH0BXajuA==
X-Google-Smtp-Source: APXvYqzeXgUU5i2m9F5Mev+hmjKSeN+qkQLndg8zEWhT7xq46ApJd0E5yrslia1ohpV3zSfh1ezTrA==
X-Received: by 2002:a1c:234c:: with SMTP id j73mr386073wmj.51.1572274781548;
 Mon, 28 Oct 2019 07:59:41 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/12] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Date: Mon, 28 Oct 2019 15:59:28 +0100
Message-Id: <20191028145937.10914-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: peter.maydell@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Use ROUND_UP() to define, which is a little bit easy to read.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191013021145.16011-2-richardw.yang@linux.intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ad9ab85eb3..255bb186ac 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -220,7 +220,7 @@ extern int target_page_bits;
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
-#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
@@ -228,9 +228,8 @@ extern int target_page_bits;
 extern uintptr_t qemu_host_page_size;
 extern intptr_t qemu_host_page_mask;
 
-#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
-#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
-                                    qemu_real_host_page_mask)
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
 
 /* same as PROT_xxx */
 #define PAGE_READ      0x0001
-- 
2.17.1


