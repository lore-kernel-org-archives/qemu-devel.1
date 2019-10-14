Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89DC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0565A2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPXzwCdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0565A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy5n-0001QJ-OK
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvQ-0007PM-0U
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-00069U-JJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvO-00065t-A6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id 3so16262930wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WimkXAC+2b42fYTOEN4XhY4stl9WHM4N3+w4ZNeNDzc=;
 b=hPXzwCdmON6epOUgNhdwW3Qk8pK0p6/+ZG/O257wOMqPy/3J0JKVvJKtS4CF3+EbEN
 P8ixXU0W3HtbuwxABeexE++Qv1/l5LM6zs2ABeiaWb+U6rb63ejDv5uNYQQYAwg48evP
 5jFl5axmQsgnvePslNz0bXT6nntEkCNzeQzoEiiV7ipP99lyoTAkEZH7Q7QJqieaqvVN
 534WtadIE+XmJ6GunSYzjLlAAX9B0VJuSzsAEkcwBNa4+N0MluHpwasZs43BsBB7qDR0
 eg8WV5sB4HNok6bEuHM0Bp056TEOdaYi0/9Yn8KcPKEhYO1XFFpxu7rMTpaPLgrcmdUo
 gIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WimkXAC+2b42fYTOEN4XhY4stl9WHM4N3+w4ZNeNDzc=;
 b=BJqSOQZw5EFL0yCr79tewcFqK8u7Wrc+E9Dgy9x3+AKCKMHTO01kKvzY6rhW6fx3vK
 yNbkqfb+eqk9drngJsOOfhriwW/ag2JgCdYv37DCZN10mjyKf0/zlXNe73SR88d8nt+b
 PoSzEVsX0UNo/IeGMDKOosP8arfbO+DTTjaPPhZIQejTqT5ftLl4IJyeqZMxCwSyDjMQ
 3NXAvm/1RwkL/VQwhkt7PQwKbR6tFCgxVqizh+n4vwXmXL/7yUgB8PqlXI+IzgxO5oUr
 KOkTxfUSYDstGlVBWvEaCbBBQlC0W10M8oIFy0LFozG8gslPi5f1OXBP9inRS/bGlxFa
 C8Eg==
X-Gm-Message-State: APjAAAWeGBbiBlOeopW7Xp7Nni1IF+4afmXQJNV8s49LZNRgUBDtY4iZ
 QTaolcpLfZsfgT1JdZi1bTVtJA==
X-Google-Smtp-Source: APXvYqyg6S7eRHpW5YYf9b17CVzv023myF4awV3v3fmWzCtjoQl9V0dr0Chci8LHbCGKM0p1cnziCg==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr13844399wmc.144.1571050199353; 
 Mon, 14 Oct 2019 03:49:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm16777480wml.26.2019.10.14.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDA6C1FF91;
 Mon, 14 Oct 2019 11:49:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 12/55] cputlb: introduce get_page_addr_code_hostp
Date: Mon, 14 Oct 2019 11:49:05 +0100
Message-Id: <20191014104948.4291-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will be used by plugins to get the host address
of instructions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c      | 14 +++++++++++++-
 include/exec/exec-all.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1210d8f243..9cf9e6455e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1051,7 +1051,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
  * NOTE: This function will trigger an exception if the page is
  * not executable.
  */
-tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp)
 {
     uintptr_t mmu_idx = cpu_mmu_index(env, true);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1077,13 +1078,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 
     if (unlikely(entry->addr_code & TLB_MMIO)) {
         /* The region is not backed by RAM.  */
+        if (hostp) {
+            *hostp = NULL;
+        }
         return -1;
     }
 
     p = (void *)((uintptr_t)addr + entry->addend);
+    if (hostp) {
+        *hostp = p;
+    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+{
+    return get_page_addr_code_hostp(env, addr, NULL);
+}
+
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUIOTLBEntry *iotlbentry, uintptr_t retaddr)
 {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 6352316de1..ba2f501f0f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #include "exec/tb-context.h"
+#include "exec/cpu_ldst.h"
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
@@ -499,6 +500,26 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 {
     return addr;
 }
+
+/**
+ * get_page_addr_code_hostp() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ *
+ * If @hostp is non-NULL, sets *@hostp to the host address where @addr's content
+ * is kept.
+ */
+static inline tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env,
+                                                      target_ulong addr,
+                                                      void **hostp)
+{
+    if (hostp) {
+        *hostp = g2h(addr);
+    }
+    return addr;
+}
 #else
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
@@ -516,6 +537,23 @@ static inline void mmap_unlock(void) {}
  */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
+/**
+ * get_page_addr_code_hostp() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * See get_page_addr_code() (full-system version) for documentation on the
+ * return value.
+ *
+ * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
+ * to the host address where @addr's content is kept.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp);
+
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
 
-- 
2.20.1


