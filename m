Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12BC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAED2192A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAqcHY80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAED2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBv7d-0007oS-Es
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6Q-000665-Es
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6O-0001f1-Hm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6O-0001cs-Cw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:24 -0400
Received: by mail-pg1-x541.google.com with SMTP id x7so639014pgh.5
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ME4wdyObWWzU36JOWOP068GfXM/kHUGKiy3+FE+Caek=;
 b=nAqcHY80e4ejxIJMyR8NQ/oenp6q+JKoqoSjzsnDo3V0irsukHBJXuIFSZMeH2FA91
 nqThih0v1cRFxjbr0+jn2U6EUvJt+351gAGkWdsQAusWjD+k7ZaTRrMfVcBzFUqudBDs
 22boIFp7rItiG50EB5sHmTOm72nPPhIJS06g+UEHGhfUS73ZT/FP6OTlWitNLXQlBEzr
 7TVgPHIA4hzZx87mHNTDbqn3DTtgSD9DTLzNLd578xOMPPNqmAivDyftR8KhKM84zPxh
 OVkWZsWp3ZHMK9Ce/V6QQEVWr58hC6Lnr3t+DW6KHbHRF0DdT54SXtBgkpMQSNF8FK7z
 LIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ME4wdyObWWzU36JOWOP068GfXM/kHUGKiy3+FE+Caek=;
 b=nU5XCeWwXbqhto6JeU5oamSSXxTywmXgW6mm5lolLlmn26B1EiR7DOqggSL5AMxzVd
 VeFi/l2VU+9eCpMlD50VHsizCC/ZGbB2tIJ6kRp7lrWHJSDsnITp0m86q2W8CRiPiSdI
 /4ZOw7Z630bQ0sbqSj3+XmZW7RHwkpkqJ3UV0sHzCCDlzKGZiJ8fJwFdtbZ8JZBH8QzN
 jt5ucceGpM5Ngu8oOA221MKBTZlra12d2ivv/EfJ//t2yZMV6/GCTQQpH1kuBcnxj2RX
 Immfv2yJ6TyCD+nIqXX+f5WOIelmrwkYnL2okQWLnMBluTZpN2Vjc+Q30/BOgnOuK31E
 maJw==
X-Gm-Message-State: ANhLgQ26GrGurwQBKKAYmJF1gs+xc7ZpaBFw65gdeS+BsAXTabOLp9cx
 3tubebmVIU3TfBmQye0euEnr+4TlD7w=
X-Google-Smtp-Source: ADFU+vuGqUilr1XU/ok4yOfa9+P48hgRWQbcNbgdR/RVEKSyJehZgAE/NEzq/VEolA//OnSo/40W9A==
X-Received: by 2002:a62:7cc9:: with SMTP id x192mr767250pfc.176.1583909062988; 
 Tue, 10 Mar 2020 23:44:22 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] accel/tcg: Add block comment for probe_access
Date: Tue, 10 Mar 2020 23:44:05 -0700
Message-Id: <20200311064420.30606-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 350c4b451b..d656a1f05c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -330,6 +330,23 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+/**
+ * probe_access:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @size: size of the access
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @retaddr: return address for unwinding
+ *
+ * Look up the guest virtual address @addr.  Raise an exception if the
+ * page does not satisfy @access_type.  Raise an exception if the
+ * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
+ * page as dirty.
+ *
+ * Finally, return the host address for a page that is backed by RAM,
+ * or NULL if the page requires I/O.
+ */
 void *probe_access(CPUArchState *env, target_ulong addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-- 
2.20.1


