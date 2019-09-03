Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31286C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB0521881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1dYEgil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB0521881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BvQ-0007sC-IM
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNJ-0001oC-Tz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNI-00048N-AE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNI-00047V-4D
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so9394956pgi.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aj30MwE6c+ysYeIySie4exO0JlDEZOZ/8NJJ9sSltgs=;
 b=a1dYEgil7BWMZ0y29yV6Rp7eVYNeM4fbQF+Vs9785ydIr+aWon7aUlt+zK4+un+QLu
 8BVRqpxn/QehlMW0BVarr8N3DVTV6KNlCQE9HnTajORgqKCr3fiUi3XfKrPz6CZNccWx
 I4L2E1PMMrPxpLfcl7Qveck64QyU3EbYrn9Kqw3qi5Q9VLPN/mPwRmoVp/6F1yhHNvKe
 S6A5lFRvzL2tMZjqtUZzE/OP0IPr9cKqTolsi2yL7fP4SDufTIHRr5hqraG5+SxXe8ne
 N25o57zDHK8apUzN6vH0VUZy3V8a+b6D5MLTMiajddVSLdKFMYAAvQVpu8y45DSHpyE3
 BFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aj30MwE6c+ysYeIySie4exO0JlDEZOZ/8NJJ9sSltgs=;
 b=r/4ITothvfOQXCyP1XApQrj9tng2aF9p89h6cLbcFnRE6Gfj8t5zmOth+xh0EGH5tl
 5kZlSWwDlvpVfk9AlIW2NASgPtMjkRyBmVNW61ftXbUOe9DcSMBSDHBfdC6mbF6cvMQQ
 pbj592wgx9RJXKG8Zo9RZ9wyP/gJOr9mmU+UgeNA5poN8TY/QTEjZTMD+1bKaW/n2HN6
 aeYi+UO3g27uueIKsC3084JjzjJnkToGW9ba23DnxlthWBCthYq8TiSOTrzPzu7KXNmA
 YtxYGgsk6oBQyCFumPJTcJc3I9AJwSPyGvr9RblPBzs8cBsE4fItEnFpcTftKB2PqVtv
 OitA==
X-Gm-Message-State: APjAAAXD+Ei61DwCEK6YpzJboDlCAXFtEkdcfE+4AQzUhNlRCWXdqdRc
 ooaAqu5WRPjH1pU6gwSNlw6wXiLbLE4=
X-Google-Smtp-Source: APXvYqyx9wXXdzWKfBmHAkceJrGBgkKOL0eGYtOCPhfPLtYGndyx0i0E4ORaVJNsnlO4AtVu8dB0LQ==
X-Received: by 2002:a65:5a44:: with SMTP id z4mr31136620pgs.41.1567526982852; 
 Tue, 03 Sep 2019 09:09:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:57 -0700
Message-Id: <20190903160858.5296-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 35/36] tcg: Make probe_write() return a pointer
 to the host page
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

... similar to tlb_vaddr_to_host(); however, allow access to the host
page except when TLB_NOTDIRTY or TLB_MMIO is set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190830100959.26615-2-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h |  4 ++--
 accel/tcg/cputlb.c      | 21 ++++++++++++++++-----
 accel/tcg/user-exec.c   |  6 ++++--
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index cbcc85add3..a7893ed16b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -310,8 +310,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                 uintptr_t retaddr);
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
+                  uintptr_t retaddr);
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 707adf7631..cb969d8372 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1078,11 +1078,11 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 /* Probe for whether the specified guest write access is permitted.
  * If it is not permitted then an exception will be taken in the same
  * way as if this were a real write access (and we will not return).
- * Otherwise the function will return, and there will be a valid
- * entry in the TLB for this access.
+ * If the size is 0 or the page requires I/O access, returns NULL; otherwise,
+ * returns the address of the host page similar to tlb_vaddr_to_host().
  */
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                 uintptr_t retaddr)
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
+                  uintptr_t retaddr)
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
@@ -1101,12 +1101,23 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
         tlb_addr = tlb_addr_write(entry);
     }
 
+    if (!size) {
+        return NULL;
+    }
+
     /* Handle watchpoints.  */
-    if ((tlb_addr & TLB_WATCHPOINT) && size > 0) {
+    if (tlb_addr & TLB_WATCHPOINT) {
         cpu_check_watchpoint(env_cpu(env), addr, size,
                              env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
                              BP_MEM_WRITE, retaddr);
     }
+
+    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
+        /* I/O access */
+        return NULL;
+    }
+
+    return (void *)((uintptr_t)addr + entry->addend);
 }
 
 void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 625c33f893..5720bf8056 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,8 +188,8 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     g_assert_not_reached();
 }
 
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                 uintptr_t retaddr)
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
+                  uintptr_t retaddr)
 {
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
@@ -202,6 +202,8 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                      retaddr);
         g_assert_not_reached();
     }
+
+    return size ? g2h(addr) : NULL;
 }
 
 #if defined(__i386__)
-- 
2.17.1


