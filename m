Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA4B21881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvfjo5sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA4B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BxJ-0001pC-KN
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNG-0001iq-HI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNF-00044q-7x
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNF-00043R-28
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id d1so9401959pgp.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ASZrnUVNw1EnObJqzoqrzFIEtS3wN2N/5E4ps5Lqe9o=;
 b=zvfjo5sYhkdyjbZXsCQqzQI06vNlQLyxCL6wsheClkvO9XYP806S/26y3uC/n6N2yX
 7zoxztX0ErHjY20eS+woLGII9ptmmJtjkJIVVQH5tfYc5V/Fs6LUoct1GjVLv0/3vihD
 M5vNxNvE27nVn2oMj+/UeiYq3iecJ+o9AZ9OU0hB1NgBgmUVQLmvE4GOT/jn1KqsmT0V
 uhJHe39og0Q+6tBn9FVCLgv7JOMaKQYOVlmumYLraorXFk5Y4eRbLjsN5cu/AZE10wBE
 y+BFB8isoiEYRmXW4gN+LseS38OmtmQ9yvLVcSao0bFRP08taI6XCFuFHtN23gawcGX7
 LLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ASZrnUVNw1EnObJqzoqrzFIEtS3wN2N/5E4ps5Lqe9o=;
 b=KVc9lhYvuu10+GOU4IXvnN5wXHQUOhl+aEaHSxvfuOhIn6Eb8hDEHsUNH3+8xbGOTx
 r4IAmkcUTzo1/0FVk1osQe80/rXi/2lha+YdqFU35IICIgX8mhYIi8j8wSekdeVv+dVV
 wc0HXOEyA0G+saioPs64Uhj8KvuY0C/T+ax/8eA2+oI0ubFmCNA1hGVu5uJXdQhWOdes
 AkVfPmYZsLATt4NWF1tgmTJjJjWfhN2J24VGds8avkHqZWLZhPgJfpSzUdDONaHzrNJJ
 T3doVZwnnAUMoZNvUpB7t24/ePG5N14rC+TMKUlAnJ5x7DW+AqnDdiIqSoYXeg5xVcHf
 N0cA==
X-Gm-Message-State: APjAAAV5/Ra5NJ2Rxhc0z2tLJiqfJFsFISwWMGsaTzd0Ra1w+IlLSc02
 I0FKTArhPQ3JlZawXE3zkuCVEHuF0SU=
X-Google-Smtp-Source: APXvYqwgaae8XFw9JDoSWQY05X7PcNI7q3o+M7CyVk+mhNZRBuNx5Y60/1JEv6gw/iiF/NNu6+8CSw==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr30803106pgv.437.1567526979192; 
 Tue, 03 Sep 2019 09:09:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:54 -0700
Message-Id: <20190903160858.5296-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 32/36] mips/tcg: Call probe_write() for
 CONFIG_USER_ONLY as well
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's call it also for CONFIG_USER_ONLY. While at it, add a FIXME and get
rid of one local variable.

MIPS code probably needs a bigger refactoring in regards of
ensure_writable_pages(), similar to s390x, so for example, watchpoints
can be handled reliably later. The actually accessed addresses should
be probed only, not full pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190826075112.25637-6-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/op_helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 34bcc8d884..08d9a4f9f1 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4537,16 +4537,14 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
                                          int mmu_idx,
                                          uintptr_t retaddr)
 {
-#if !defined(CONFIG_USER_ONLY)
-    target_ulong page_addr;
+    /* FIXME: Probe the actual accesses (pass and use a size) */
     if (unlikely(MSA_PAGESPAN(addr))) {
         /* first page */
         probe_write(env, addr, 0, mmu_idx, retaddr);
         /* second page */
-        page_addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, page_addr, 0, mmu_idx, retaddr);
+        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+        probe_write(env, addr, 0, mmu_idx, retaddr);
     }
-#endif
 }
 
 void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
-- 
2.17.1


