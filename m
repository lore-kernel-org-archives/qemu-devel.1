Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D14CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56ECB21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSQ0wPaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ECB21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuKV-00038B-77
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq2-0004m7-Id
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq1-0007G9-9h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtq1-0007Fa-3T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id w18so1044229wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x4NCzYC99zoESCZyFO/budr+59cfbMJoRMt7ZJOzWZo=;
 b=OSQ0wPaQ3ag3mCuDwABCaH20SIneB8V1zyejbabQKTWq7Ug+37t2WRuqGJpiEJiYwd
 9t2iQxebV4ZFzAKHz0cjv2ToxfPSc0eOx1sgeSvCfkYZaemK98Und2KkAmYVdo2eoMfG
 L+UI9YZihO/3JQK1XjGqRLcI+3m7emphnCWMrIcIFlMCSt5MBm4UKNTtaIKHYYsxeztM
 BDRyUxEG7NWqlgC+w+Ac5Cp1vPDRIt1oG4OYOhGOJErXrwN135vQDc9m7IcQiKqL56l+
 o3y/A0avVRGbXQSOzQvyjehKxsXerusqC7eUj912hjBB02TIdErkwF0lIkJl2BUmiHnH
 +l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x4NCzYC99zoESCZyFO/budr+59cfbMJoRMt7ZJOzWZo=;
 b=khsZTc7lcHsgG3Mw0sFol+FsNIgMEKD/fI7/NF408mnnEfYq+aGtR7Dp09Bdp7O607
 fDOI0Av1O0W5GS6cAQee0MY4KlAV0P/rINvS12gUF4gsMd2XATVJbugm605HPrLMzShh
 LzxBgcaTB3J85k61w2uUA5gwLo4W9SljDMAmLsY5+pkbCO8LNDTaJ7HjPXXxx7TNJskB
 3O6ULUvZj/jEMpGyHYPCl+VvjJsKFQ66LP1kSJC+a1Dyr8KZ9uW3kV6Bkv7FhruUwUuy
 Et0xExQ0ZbiCbER5W+sGjM1RheOF8VGcvvE6lbDMME5o6LLmBlm/gWzJlueyiARDM3o4
 5Uqw==
X-Gm-Message-State: APjAAAU6GrNEYVz+LZDTtbxh24GXWQI0AeeJnhxHTkPPRnD8OASCra2w
 hidwJAUXBGWFJjCawlXaH+/0qA==
X-Google-Smtp-Source: APXvYqwAke9lzwZunW+MG1xkw0LqOdBwqFcQ6CBr2CHhQFUV076Fy7Etk7EFCNGdqcA3F23NXniyzw==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr1419556wrj.284.1571987803926; 
 Fri, 25 Oct 2019 00:16:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm2558155wrg.15.2019.10.25.00.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2EA6F1FFB1;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 26/73] cputlb: document get_page_addr_code
Date: Fri, 25 Oct 2019 07:36:26 +0100
Message-Id: <20191025063713.23374-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 04795c49bf4..e4206cb1735 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -504,7 +504,15 @@ void mmap_lock(void);
 void mmap_unlock(void);
 bool have_mmap_lock(void);
 
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
+/**
+ * get_page_addr_code() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                target_ulong addr)
 {
     return addr;
 }
@@ -512,8 +520,18 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
-/* cputlb.c */
-tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
+/**
+ * get_page_addr_code() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
-- 
2.20.1


