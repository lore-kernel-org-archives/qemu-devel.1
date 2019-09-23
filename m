Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA4FC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455BB20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="am+XxRM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455BB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXSa-0004li-5H
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJe-0005aR-S8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJc-000848-OI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:22 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJa-00082r-Qo
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id q21so10116973pfn.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZrzbwlEBbf7uMlVZ6ux04nTJ7ryFvejwhV3RoIkuh+Y=;
 b=am+XxRM+JrVixgKCMDimb2Q7W2/kA98/Ptb7MWISR3xysxT1SxJd0eMEMwREVhqqwq
 TJ1k7En2xDfdGNRRtjpE8+2boRhCIf5BWxh28x6Ft4MPHMF78RlQkVvPskqoQI5y7ZrP
 tB7DDgjfPbWgoD6ZG0YmcVUKHUNEw9Vg+jH3Kl49sAJPVm4P7lnkEomnoKI+hl74nrt+
 +GPbj1OdaVOhiEfqasSB7SJzpSBnu+nxB09MMYQlp7WZFXJ30Xbj2RWnj74GaXJQeWjp
 Btssdx9x+mhXTUg9R/68Ewjh3O9JHXZrRsWW3DVSpKwmsOtNu+BZoQ7vo86hJkTru8HD
 hvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZrzbwlEBbf7uMlVZ6ux04nTJ7ryFvejwhV3RoIkuh+Y=;
 b=Ax9jBDeS6gUA7e6PIkAjOjBvM9NBFMQ2kBwaVc0gcZzc1KtGyT+MgMjmkwv+qYSRNN
 tLqTpqst/0jTLaJiv5ADBd203cCMMq3Hj8mJaPapuRF5Yz+bOu8ySYVfpl9wNouIBm/Y
 1ZtJKFhDUm72BhizXF75/GLrtOxZGAbMot/iaMpx6lI+vAa6oacdxOFvoAMuBGkTMbN6
 HGmbH6We54md8Mt2F0v8P/mNdgiv93B446qV1HeNPHVPjiglZiTbkMg1opHPNuMzO199
 oiglhia2lUMFVGwlXUP3fjKRhD5GnxOwYctkhPY1aoRqX0ZKkL94/KuD2R+jNgVXD99w
 r4dw==
X-Gm-Message-State: APjAAAWCP5NMarVLmJnPxpnjRR1U90TxM6oX/IzHYh9XjBgkXQQnjmqN
 eJZyHmsM+ykF1oIzwnoErLqDvVE5Xkk=
X-Google-Smtp-Source: APXvYqzrTiiZXJnWMJsgoJDyMYc8ECFY4zupYUk1qjGN0QwO/3svaGnNVXsZbONN0ZiOfp2Xee+75w==
X-Received: by 2002:a63:fc60:: with SMTP id r32mr2359913pgk.160.1569279617065; 
 Mon, 23 Sep 2019 16:00:17 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/16] cputlb: Introduce TLB_BSWAP
Date: Mon, 23 Sep 2019 15:59:54 -0700
Message-Id: <20190923230004.9231-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

Handle bswap on ram directly in load/store_helper.  This fixes a
bug with the previous implementation in that one cannot use the
I/O path for RAM.

Fixes: a26fc6f5152b47f1
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  4 ++-
 accel/tcg/cputlb.c     | 62 ++++++++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e0c8dc540c..d148bded35 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -335,12 +335,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT | TLB_BSWAP)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 430ba4a69d..f634edb4f4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -737,8 +737,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         address |= TLB_INVALID_MASK;
     }
     if (attrs.byte_swap) {
-        /* Force the access through the I/O slow path.  */
-        address |= TLB_MMIO;
+        address |= TLB_BSWAP;
     }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
@@ -901,10 +900,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -947,10 +942,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1133,8 +1124,8 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
                              wp_access, retaddr);
     }
 
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
-        /* I/O access */
+    /* Reject I/O access, or other required slow-path.  */
+    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
         return NULL;
     }
 
@@ -1344,6 +1335,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
     /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         CPUIOTLBEntry *iotlbentry;
+        bool need_swap;
 
         /* For anything that is unaligned, recurse through full_load.  */
         if ((addr & (size - 1)) != 0) {
@@ -1357,17 +1349,22 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_READ, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
+        need_swap = size > 1 && (tlb_addr & TLB_BSWAP);
+
         /* Handle I/O access.  */
-        return io_readx(env, iotlbentry, mmu_idx, addr,
-                        retaddr, access_type, op);
+        if (likely(tlb_addr & TLB_MMIO)) {
+            return io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
+                            access_type, op ^ (need_swap * MO_BSWAP));
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        if (unlikely(need_swap)) {
+            return load_memop(haddr, op ^ MO_BSWAP);
+        }
+        return load_memop(haddr, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1394,7 +1391,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     return load_memop(haddr, op);
 }
@@ -1592,6 +1588,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         CPUIOTLBEntry *iotlbentry;
+        bool need_swap;
 
         /* For anything that is unaligned, recurse through byte stores.  */
         if ((addr & (size - 1)) != 0) {
@@ -1605,16 +1602,24 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_WRITE, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
+        need_swap = size > 1 && (tlb_addr & TLB_BSWAP);
+
         /* Handle I/O access.  */
-        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
+        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+            io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
+                      op ^ (need_swap * MO_BSWAP));
+            return;
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        if (unlikely(need_swap)) {
+            store_memop(haddr, val, op ^ MO_BSWAP);
+        } else {
+            store_memop(haddr, val, op);
+        }
         return;
     }
 
@@ -1683,7 +1688,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     store_memop(haddr, val, op);
 }
-- 
2.17.1


