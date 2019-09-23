Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F10C432C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D23207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bF/gJ9lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D23207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXcL-0005ph-06
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJn-0005jL-M9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJl-00089p-HG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJl-000892-3t
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id g3so7313849pgs.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h1WBZAofTlP3LEJIOv9bQuQl53SA63G846KraTbrjlQ=;
 b=bF/gJ9lIziCS5Hb36tIc7A97PEWu07s9w0ytz3BKRobAvWf/L97VDS0IChUCo2jPPU
 6l0Y2pf9kFUgW0u/4xgfY1b9a4ELaZS4xq4ZBOn2k0QZO1qiYPCFsUNCRMXtkyWCPeV4
 F21Rq2QZSBlp0TM+eMraBd7tIojUaInyzcx+31UjyL53lNQczIpyw0ERVlZyIfgbUssT
 wP0MkQTI7trFFdoSGerQ/GWeJ769Y2T9phfdwYEuwAE5xuT82lg8sQ58kwcUv3T1DIbW
 j5zwyCmCeoD8GRbJ/WefPGDjWFPC01vxbQSPxMwfdi4UT7VTZxP5EvDyQ7n/3MXI7sUp
 Adng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h1WBZAofTlP3LEJIOv9bQuQl53SA63G846KraTbrjlQ=;
 b=IOrzXUdRjC+JRNwHnY41Fjq5W2BcowMsmCPKeiC/NacoEPbHiZB1j2hzLRizhf9vcG
 0fEEQnH9CcDAfeT6Afi3eRwd0d+w60oF2BC/nYKCCpiqYbUGgGERd/szVwE79qSoBBV5
 4SlV3LAqSZeiozTh0XsbSD7KTpcKHSeDSUzHxdBFgTbgnAfQltksfJG+wD9GMatcaFVM
 fQmM6/BOAF9WMtgWi23QR+NW6+WvqT6bmqoI1GeGibqkiJfhHePM/X90f1PbsHVuD5X8
 PypI4C7zfomYi9lHqMKgMxu+8YSll8aarRVsPveb+lowIWmi2cSLT4FSvRYwYr2HlJ5I
 nqDQ==
X-Gm-Message-State: APjAAAVzStf6lTZ9s3cK7Z1YdRoxi9zXSbibxptN8W+Cnn+Dc3Sj+Y3n
 XPmkwgHl3jj93V7JxU9arTU+ng9OkOk=
X-Google-Smtp-Source: APXvYqzhOqNmfXUJeQwDr1c98vbUWm9emqCu/mePttt2RO16iEhgvCEbBunEoSZTy+mghHHppW6zAQ==
X-Received: by 2002:a17:90a:8087:: with SMTP id
 c7mr2020948pjn.56.1569279627596; 
 Mon, 23 Sep 2019 16:00:27 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/16] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
Date: Mon, 23 Sep 2019 16:00:02 -0700
Message-Id: <20190923230004.9231-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
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

All callers pass false to this argument.  Remove it and pass the
constant on to tb_invalidate_phys_page_range__locked.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h | 3 +--
 accel/tcg/translate-all.c | 6 ++----
 exec.c                    | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 64f5fd9a05..31f2117188 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -28,8 +28,7 @@ struct page_collection *page_collection_lock(tb_page_addr_t start,
 void page_collection_unlock(struct page_collection *set);
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
                                   tb_page_addr_t start, int len);
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access);
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..de4b697163 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1983,8 +1983,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
  *
  * Called with mmap_lock held for user-mode emulation
  */
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access)
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end)
 {
     struct page_collection *pages;
     PageDesc *p;
@@ -1996,8 +1995,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
         return;
     }
     pages = page_collection_lock(start, end);
-    tb_invalidate_phys_page_range__locked(pages, p, start, end,
-                                          is_cpu_write_access);
+    tb_invalidate_phys_page_range__locked(pages, p, start, end, 0);
     page_collection_unlock(pages);
 }
 
diff --git a/exec.c b/exec.c
index 7d835b1a2b..b3df826039 100644
--- a/exec.c
+++ b/exec.c
@@ -1012,7 +1012,7 @@ const char *parse_cpu_option(const char *cpu_option)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
-    tb_invalidate_phys_page_range(addr, addr + 1, 0);
+    tb_invalidate_phys_page_range(addr, addr + 1);
     mmap_unlock();
 }
 
@@ -1039,7 +1039,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
         return;
     }
     ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
     rcu_read_unlock();
 }
 
-- 
2.17.1


