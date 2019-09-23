Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C007C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABFF21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uh7DC6M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABFF21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXVO-0007pL-M4
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJo-0005kB-HU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJm-0008AQ-M6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJm-00089y-A1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id y22so10153179pfr.3
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Fy8yqGvXJfEtemqcYdzYU9XShb4v7XS8MjArgMABc6w=;
 b=Uh7DC6M4fZGv0z+2vD70cpe39Z/CcwRdC5TWSZMpLxDgRH3zdsH/nTiIQKQowcqoRs
 So9Sh/D+dKzaLJxlP4ESNzSa+R97yG44+I6ynK41HU6bklBucFWfTWII/vq9ZKmUHdze
 BDxl3/O6ddErC5kbccJ0IeZttVhg+G5C15XSwaM2HpRgVc6b0+bSm9u63qqL/1tY+gNn
 kxZDyUDnJH47GksZKxejMA4Y75iROr+PgOPI/sRsuvICMMKCpnEbFkcyDXBc73FWGlxJ
 luvY2gwEv7XkRk7PBW4euFoP5ornrj0LiL6nk+MCEXTBw9KjnMp/NZw3eaGX1o3dP8Ly
 Vieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Fy8yqGvXJfEtemqcYdzYU9XShb4v7XS8MjArgMABc6w=;
 b=FKXKgFTC+/tJOmhqYimtVgoq8V+nu6n62QSiUR1S0RQ4iobHjPYxvnJONaKvZ0JXj1
 mTeO5DzV/41Unz11IwOrrt4xd8zQGFQik9vEzq+iuLQpKUHftr78US0CafYKOSy0Scaq
 kmDKxN1XtowVGPPvieNAg7tFkOlkw0WvEPlBTSIgZOMMd3+vgYNsef4FSmOJhQPVqYVM
 MIIlst34i8BqNbR1iK38S0kQkifV2pH45sD1uWRgaJmjZOVSQ6bWcJJ8JR/vkMJOMOEX
 5+JzdP79WzOPoM8MQ60FIN8PxQQeTnXNJSr9pxj4m/yWOdiaR1At4SjN0eyiDdzTov4h
 nAFg==
X-Gm-Message-State: APjAAAWobTAi+kXCOVnUljYZPOOoLZVyPjYdcMNEvE0u5RuyPIjA0rzI
 MTT5iuOynGo8rr5EUoOIpJztmUIQTrU=
X-Google-Smtp-Source: APXvYqw90MZayWlW0+DamggFyoSddng1+In5/zc/TN8TukxgCFFGpMHRgkN7HmH8QwiJCvIvfxQ4nA==
X-Received: by 2002:a62:2f84:: with SMTP id v126mr2173907pfv.167.1569279628832; 
 Mon, 23 Sep 2019 16:00:28 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/16] cputlb: Pass retaddr to tb_invalidate_phys_page_fast
Date: Mon, 23 Sep 2019 16:00:03 -0700
Message-Id: <20190923230004.9231-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Rather than rely on cpu->mem_io_pc, pass retaddr down directly.

Within tb_invalidate_phys_page_range__locked, the is_cpu_write_access
parameter is non-zero exactly when retaddr would be non-zero, so that
is a simple replacement.

Recognize that current_tb_not_found is true only when mem_io_pc
(and now retaddr) are also non-zero, so remove a redundant test.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h |  3 ++-
 accel/tcg/cputlb.c        |  6 +-----
 accel/tcg/translate-all.c | 39 +++++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 31f2117188..135c1ea96a 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -27,7 +27,8 @@ struct page_collection *page_collection_lock(tb_page_addr_t start,
                                              tb_page_addr_t end);
 void page_collection_unlock(struct page_collection *set);
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
-                                  tb_page_addr_t start, int len);
+                                  tb_page_addr_t start, int len,
+                                  uintptr_t retaddr);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0ca6ee60b3..ea5d12c59d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1093,11 +1093,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         struct page_collection *pages
             = page_collection_lock(ram_addr, ram_addr + size);
-
-        /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
-        cpu->mem_io_pc = retaddr;
-
-        tb_invalidate_phys_page_fast(pages, ram_addr, size);
+        tb_invalidate_phys_page_fast(pages, ram_addr, size, retaddr);
         page_collection_unlock(pages);
     }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index de4b697163..db77fb221b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1889,7 +1889,7 @@ static void
 tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                                       PageDesc *p, tb_page_addr_t start,
                                       tb_page_addr_t end,
-                                      int is_cpu_write_access)
+                                      uintptr_t retaddr)
 {
     TranslationBlock *tb;
     tb_page_addr_t tb_start, tb_end;
@@ -1897,9 +1897,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 #ifdef TARGET_HAS_PRECISE_SMC
     CPUState *cpu = current_cpu;
     CPUArchState *env = NULL;
-    int current_tb_not_found = is_cpu_write_access;
+    bool current_tb_not_found = retaddr != 0;
+    bool current_tb_modified = false;
     TranslationBlock *current_tb = NULL;
-    int current_tb_modified = 0;
     target_ulong current_pc = 0;
     target_ulong current_cs_base = 0;
     uint32_t current_flags = 0;
@@ -1931,24 +1931,21 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         if (!(tb_end <= start || tb_start >= end)) {
 #ifdef TARGET_HAS_PRECISE_SMC
             if (current_tb_not_found) {
-                current_tb_not_found = 0;
-                current_tb = NULL;
-                if (cpu->mem_io_pc) {
-                    /* now we have a real cpu fault */
-                    current_tb = tcg_tb_lookup(cpu->mem_io_pc);
-                }
+                current_tb_not_found = false;
+                /* now we have a real cpu fault */
+                current_tb = tcg_tb_lookup(retaddr);
             }
             if (current_tb == tb &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
-                /* If we are modifying the current TB, we must stop
-                its execution. We could be more precise by checking
-                that the modification is after the current PC, but it
-                would require a specialized function to partially
-                restore the CPU state */
-
-                current_tb_modified = 1;
-                cpu_restore_state_from_tb(cpu, current_tb,
-                                          cpu->mem_io_pc, true);
+                /*
+                 * If we are modifying the current TB, we must stop
+                 * its execution. We could be more precise by checking
+                 * that the modification is after the current PC, but it
+                 * would require a specialized function to partially
+                 * restore the CPU state.
+                 */
+                current_tb_modified = true;
+                cpu_restore_state_from_tb(cpu, current_tb, retaddr, true);
                 cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                                      &current_flags);
             }
@@ -2042,7 +2039,8 @@ void tb_invalidate_phys_range(target_ulong start, target_ulong end)
  * Call with all @pages in the range [@start, @start + len[ locked.
  */
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
-                                  tb_page_addr_t start, int len)
+                                  tb_page_addr_t start, int len,
+                                  uintptr_t retaddr)
 {
     PageDesc *p;
 
@@ -2069,7 +2067,8 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
         }
     } else {
     do_invalidate:
-        tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
+        tb_invalidate_phys_page_range__locked(pages, p, start, start + len,
+                                              retaddr);
     }
 }
 #else
-- 
2.17.1


