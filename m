Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99CB20820
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlhE/Czc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99CB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt39-0006W7-Fr
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxs-0001UX-4E
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxq-0008Aa-QW
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxq-000895-Fr
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id z12so5989896pgp.9
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FsCp0gCrwtqGaCEDQ93XosqgirYhBXr/1xdf8PdGGas=;
 b=PlhE/CzcglvYxaWY5KpLAyLbBtSarBV8kHwCZKVGE47A8yZagFzO7/CSas0XgIpSF5
 VcpP5cKSlqKYAyNw9y/5vTrSZPWYaeZCexaCvCpVI/+sbZGAcBaPw7Ng4l+R0e7vedPE
 WbClDOtahs9rA1f1fFz87Y0UN/muG9q+3b9MkE87Z6sDlq9UErRN6fHDGq26cLchYMBC
 yXc/USUKBOhG6raPS5uhzR7cDzi+hRKB2rYAJCYxK9++Pq3Pe82naWHsD0Azudcht1Xr
 O4l+xGa/sakos4M0FcG0KsyaMZbdIZbOc6ecEEjtI51lJFL4g9OScv7onBlVC1b6f5OL
 lDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FsCp0gCrwtqGaCEDQ93XosqgirYhBXr/1xdf8PdGGas=;
 b=VW5J0BuDfd9c/d8hMSsqevaWdXq1ak224SK+EQxdvbrYv+K78UxikiPez8HpoSNh3w
 5OwZKrGFEbpyuUXfEF4TXefMMb8BWi1JyB0TCy7oQmqVb82T5Hn99cXwbPxEOkD3VjvZ
 Gkct+LdAKMAUcJ0oE0N/ZMXhSTR43elVIE81MA9eZHQRcxp9tKolrywteHf7INsYE56v
 JH6lPVkt40g9JN6DaM19hSpOjnDyF3Olg4fGNA27gXoXXGMwbM/NMApN1+aWIzEyKADK
 V/NGIo1ApjC0N3Sb85Uyq4YhNjDPc0n0gdtVKPOwoDPDNg/cu/sOyOS8N+06krfIxhn/
 9sBg==
X-Gm-Message-State: APjAAAUpAJPDcujUgqHgG7T4saLLbt2fr1aT/xRVFgu1RVMjm8rfbxK+
 L+Y2kx9B2Yrvo9VY1ppbYrUALfLbBjY=
X-Google-Smtp-Source: APXvYqz8G/ejmhZgF83MNaofzoCabOX/1pPJMgm0el6rkBH/hQ2FQEGTUFIeFByG6p2X95fx1z7cYQ==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr23127705pgg.354.1569124509265; 
 Sat, 21 Sep 2019 20:55:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/20] exec: Cache TARGET_PAGE_MASK for
 TARGET_PAGE_BITS_VARY
Date: Sat, 21 Sep 2019 20:54:45 -0700
Message-Id: <20190922035458.14879-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This eliminates a set of runtime shifts.  It turns out that we
require TARGET_PAGE_MASK more often than TARGET_PAGE_SIZE, so
redefine TARGET_PAGE_SIZE based on TARGET_PAGE_MASK instead of
the other way around.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 8 ++++++--
 exec-vary.c            | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5246770271..2db73c7a27 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -213,19 +213,23 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 typedef struct {
     bool decided;
     int bits;
+    target_long mask;
 } TargetPageBits;
 extern const TargetPageBits target_page;
 # ifdef CONFIG_DEBUG_TCG
 #  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+#  define TARGET_PAGE_MASK (assert(target_page.decided), target_page.mask)
 # else
 #  define TARGET_PAGE_BITS target_page.bits
+#  define TARGET_PAGE_MASK target_page.mask
 # endif
+# define TARGET_PAGE_SIZE  ((int)-TARGET_PAGE_MASK)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
+#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) \
     (((addr) + ~TARGET_PAGE_MASK) & TARGET_PAGE_MASK)
 
diff --git a/exec-vary.c b/exec-vary.c
index 67cdf57a9c..26daf281f2 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -83,5 +83,6 @@ void finalize_target_page_bits(void)
         init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
     init_target_page.decided = true;
+    init_target_page.mask = (target_long)-1 << init_target_page.bits;
 #endif
 }
-- 
2.17.1


