Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BCCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7EF20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjCsPmuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7EF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORs3-0002e7-0H
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpQ-0005ut-R8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpP-0005ue-GQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpP-0005uF-AK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so16014403wrs.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NOU8+nMEIGED2iJZhktWL6KnvYhctO6T5v6pR87w3Mo=;
 b=mjCsPmuoughxp2LFW8AqP6K9VjuIgM5qLtRrDGoyhOZ827z4tTBSm1EN6iMC/LrnUT
 SjW90UCu66krkF3TGUKx+Zqc/+AqSvmleQmIgr9MbU+S8OuvFkaywELX2NIwMWPESOJw
 RlyJrM3V8bZswbUY7JmLbDWaDYrTZxLaWk0PBPRONIvTqQt6WXvLLABXQDR63H/FNxwa
 NVaSaPEL9LBbPdeWSzWxvUyoLSrXljzGIo+TRLSmkS+AsQnP3k8Rs9wWwDJEUCWbA3uT
 +c1hNLk1x+BuzmXY4c3tQOdGODYc73xeeU3tZYM+6jD5sKCR5D+xXDrfWyia2T6Th6x3
 c08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NOU8+nMEIGED2iJZhktWL6KnvYhctO6T5v6pR87w3Mo=;
 b=NtOhGcTRaLcj9uQpmI1b0+vkYT/m0VEv9SdhzF6uyKH8Qb5g9rNoLWcUS1dR0d2E+x
 ODnwb3UuXeypHkQDAL0l4GJNrc6S2d6l/nKN8YCMX0QOH6MMNN+B4UF16f7QJYLwit2H
 ArwMhaH69OJsJfe5dPeUpmaC8MEQHgjd0XOtkeEwq4crnNP+zHXE86XO875J6M4XDn6E
 rQohsYddezZf4O+tXLI1ZmDhVipAnqjQ9X6kyLsvOx4fkTxT1OjExi2ePanieFOkXveM
 GtbBzDA/Aps3y+qTv6eFXF34x/YstHZlBMEkM/IUTY7v29iOHIBUiAXRYgDEpQKUHKvt
 LWGg==
X-Gm-Message-State: AGi0PuYWQ3OfPm3pksZUebtFYKVvVT0oAewebAqLd+iZBYnFZ3f+Ew0e
 hzlzTVE6MpwjXvCipRJpLLoIGg==
X-Google-Smtp-Source: APiQypKyxfdfMAhXePnNUwkyhPlGQ0fmpP6F7zO+4ZTd3/HfXZdnNXY3r9alCEACwBsycmvnec4WIg==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr20300751wrq.316.1586894798275; 
 Tue, 14 Apr 2020 13:06:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v1sm15855007wrv.19.2020.04.14.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5C4E1FF8F;
 Tue, 14 Apr 2020 21:06:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/17] accel/tcg: Relax va restrictions on 64-bit guests
Date: Tue, 14 Apr 2020 21:06:17 +0100
Message-Id: <20200414200631.12799-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We cannot at present limit a 64-bit guest to a virtual address
space smaller than the host.  It will mostly work to ignore this
limitation, except if the guest uses high bits of the address
space for tags.  But it will certainly work better, as presently
we can wind up failing to allocate the guest stack.

Widen our user-only page tree to the host or abi pointer width.
Remove the workaround for this problem from target/alpha.
Always validate guest addresses vs reserved_va, as there we
control allocation ourselves.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/cpu-all.h    | 23 +++++++++++++++++++----
 target/alpha/cpu-param.h  | 15 ++-------------
 accel/tcg/translate-all.c | 15 +++++++++------
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b4fb5832c4a..c0c2fa3cc56 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -162,12 +162,27 @@ extern unsigned long guest_base;
 extern bool have_guest_base;
 extern unsigned long reserved_va;
 
-#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
-#define GUEST_ADDR_MAX (~0ul)
+/*
+ * Limit the guest addresses as best we can.
+ *
+ * When not using -R reserved_va, we cannot really limit the guest
+ * to less address space than the host.  For 32-bit guests, this
+ * acts as a sanity check that we're not giving the guest an address
+ * that it cannot even represent.  For 64-bit guests... the address
+ * might not be what the real kernel would give, but it is at least
+ * representable in the guest.
+ *
+ * TODO: Improve address allocation to avoid this problem, and to
+ * avoid setting bits at the top of guest addresses that might need
+ * to be used for tags.
+ */
+#if MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32
+# define GUEST_ADDR_MAX_  UINT32_MAX
 #else
-#define GUEST_ADDR_MAX (reserved_va ? reserved_va - 1 : \
-                                    (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
+# define GUEST_ADDR_MAX_  ~0ul
 #endif
+#define GUEST_ADDR_MAX    (reserved_va ? reserved_va - 1 : GUEST_ADDR_MAX_)
+
 #else
 
 #include "exec/hwaddr.h"
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 692aee27ca9..1153992e42a 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -10,22 +10,11 @@
 
 #define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 13
-#ifdef CONFIG_USER_ONLY
-/*
- * ??? The kernel likes to give addresses in high memory.  If the host has
- * more virtual address space than the guest, this can lead to impossible
- * allocations.  Honor the long-standing assumption that only kernel addrs
- * are negative, but otherwise allow allocations anywhere.  This could lead
- * to tricky emulation problems for programs doing tagged addressing, but
- * that's far fewer than encounter the impossible allocation problem.
- */
-#define TARGET_PHYS_ADDR_SPACE_BITS  63
-#define TARGET_VIRT_ADDR_SPACE_BITS  63
-#else
+
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
 #define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
-#endif
+
 #define NB_MMU_MODES 3
 
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9924e66d1f7..e4f703a7e6d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -173,8 +173,13 @@ struct page_collection {
 #define TB_FOR_EACH_JMP(head_tb, tb, n)                                 \
     TB_FOR_EACH_TAGGED((head_tb)->jmp_list_head, tb, n, jmp_list_next)
 
-/* In system mode we want L1_MAP to be based on ram offsets,
-   while in user mode we want it to be based on virtual addresses.  */
+/*
+ * In system mode we want L1_MAP to be based on ram offsets,
+ * while in user mode we want it to be based on virtual addresses.
+ *
+ * TODO: For user mode, see the caveat re host vs guest virtual
+ * address spaces near GUEST_ADDR_MAX.
+ */
 #if !defined(CONFIG_USER_ONLY)
 #if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
 # define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
@@ -182,7 +187,7 @@ struct page_collection {
 # define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
 #endif
 #else
-# define L1_MAP_ADDR_SPACE_BITS  TARGET_VIRT_ADDR_SPACE_BITS
+# define L1_MAP_ADDR_SPACE_BITS  MIN(HOST_LONG_BITS, TARGET_ABI_BITS)
 #endif
 
 /* Size of the L2 (and L3, etc) page tables.  */
@@ -2497,9 +2502,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
     /* This function should never be called with addresses outside the
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
-#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
-#endif
+    assert(end - 1 <= GUEST_ADDR_MAX);
     assert(start < end);
     assert_memory_lock();
 
-- 
2.20.1


