Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A27CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A760206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKHdQx3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A760206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0ex-0003Ej-JM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tf-0004zz-CK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Te-0001bm-70
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:07 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:42378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Te-0001bU-3H
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:06 -0400
Received: by mail-qt1-x836.google.com with SMTP id w14so3450665qto.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VpK7DgB24L4FBN+Cv8MDDt0jG1tSba2F0aG6/IXjc+c=;
 b=NKHdQx3WHGsT1oovR+8zWm0MC0caxY7W2vBEDb8/QV/jg+IEudIICMPSugi1BDWdIk
 bX7J0lpZxdAk1DPNxkqlpmheARYeiHCgo79up1+lYQsDOvHhDwYNFqy8tb6C/xGBh6rx
 D1bLqDumpRBteAVV+NXp+iysNDrYJUrS4lL/LG6FUXer+wzleqZ/2PiNAA70kgx/UxFW
 P5anqgU1K9WEAZ3DfETLkb0gA2zrj+39mR1yOQWdwz4NAJoH31zLi3NiYRIBZu5fm3Y6
 Saa8fRCmJM3vup4adb4rmo7BAdC4ltb/p8SUVL3syLAHxeO+pXxkzF5Ofze27L+XYroa
 W6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpK7DgB24L4FBN+Cv8MDDt0jG1tSba2F0aG6/IXjc+c=;
 b=GXHExrxnO2kKX24Rtku7/r09NMWSPCNdCbG+snBuEsVqhnzTmbGcRDeUyOLaAS4i5I
 e3kI2qMxqzPB/Qj4Blu19WtVsC0QTZNb8uKNGWrHOmmjY2uoOuavRH6zCeEq1DkQG/bn
 8CxnL1MYLxptBOSXPLUxHfI0gm4s0dkB/s7Ag4zseL+uI4sDxhj+de7XbfRnzSI9YE/S
 3Upyu8UZOYdsXzf1apoWZSqm4sxfCbJVrJ9Bf7dxRByr/V67vjj/9OHZuguuItkoXwJh
 Jvs7icOGn9cKBcTvpdtRpoH7HPHSCtJjVxoBYPd4ng/QNC0L4GS81OuF9skfUkFrC3Hb
 RIwg==
X-Gm-Message-State: APjAAAUbJIxypvteYzV/+YXwmJ+84ZIlLSfv5BhwlrE1iW7P0cXMzp/M
 +/p67UawBrWn7BH7bs8XvkfjjuIxNQE=
X-Google-Smtp-Source: APXvYqwIHIBLDOPwWurOLFm3bDOzPKAeGbanb91b+DXJxcXkaiRXZuwTg2eGYosWrQt8IBI84bpf4g==
X-Received: by 2002:ad4:4583:: with SMTP id x3mr3500514qvu.162.1572013325031; 
 Fri, 25 Oct 2019 07:22:05 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Date: Fri, 25 Oct 2019 10:21:50 -0400
Message-Id: <20191025142159.12459-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::836
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


