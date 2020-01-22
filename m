Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC03C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B032087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+RxQOp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B032087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu68M-0000L3-NQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu660-00064o-ET
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65z-0002ra-7H
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:20 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65z-0002rO-0t
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:19 -0500
Received: by mail-pg1-x543.google.com with SMTP id 4so2634695pgd.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DOpEwK3gCWb7kYmz3HJItlWdtjpnT0EgenDFNDj5Ga0=;
 b=E+RxQOp+TlOk5Zqy8vCX1+1cFbNmhCLiP/ry759CWWLVjC9QAszy+BuEOjcC4HXYtr
 7q22SI+39kFanWUNuqSSWjnvvhqfUaoHuMlulQ2gwKirMjeHSSrA0MraogNJ+ps+cgpe
 iQrLal6iLSnevwe+I7ji6QCIfjgd2d0B43EtdGh5SOuWlvSpCSIU58SKR67butd0iH8/
 A72qkxrzv/UOf47kugKTc03QFnRTf4mE76nnEqP5/AKZqgSc7Mu5ahtF1fKgYNNsiaWo
 6z148nV7vN08ZZkR70zWVVdyiGXKqBIZHga9/mea/NrxHHwfQCj6a/daFn5X23jbT19I
 zt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DOpEwK3gCWb7kYmz3HJItlWdtjpnT0EgenDFNDj5Ga0=;
 b=kUarf+oA3HX4AQY1Um4jBJ2vNzEa3z4MjFpsPKbi/iVaw9/00TAB+1HY/7s4Qd/4OM
 +YdRarFvrddwqAttbIFyAUUq4BvRoY1Jw5By8KJSTQy7L+0pnXNHdAEbISjgx6A8I5kU
 8TeNZw0A72Fh7NvJQrB0G8lFJsJHGyfnE++3DtMI/Oj2k3gQdk0ChSr38imOxSelWMI3
 lOoO+cdQOA08Dzp9PTTeExH7KPTfBRgqcZU9g1veg9YCk6/SWE0xoe9tHGYonMJlSzth
 ZSHOMYuY1kPqxDwEsDyLH7wbP5k+MAwsGd94vGzaF10JYBEAC5/94p1nTvjKEP/v7RzP
 GC2A==
X-Gm-Message-State: APjAAAWzBIrgrm7F4H+yvjGJ3AqIt+tAMuGY1+twBXPoSWPd/fsMjQXn
 jlgSrQtyik1tNgoWJmXmmhTzCrDfGcc=
X-Google-Smtp-Source: APXvYqwGjY+RCd2+RrYCWF39TEf1w4GMhmitehSNJpCVFprVo4leTFVnVqOsI7gqDnRYugle4Y3FZQ==
X-Received: by 2002:a63:ce55:: with SMTP id r21mr8567582pgi.156.1579661417808; 
 Tue, 21 Jan 2020 18:50:17 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] cputlb: Hoist timestamp outside of loops over tlbs
Date: Tue, 21 Jan 2020 16:49:45 -1000
Message-Id: <20200122024946.28484-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not call get_clock_realtime() in tlb_mmu_resize_locked,
but hoist outside of any loop over a set of tlbs.  This is
only two (indirect) callers, tlb_flush_by_mmuidx_async_work
and tlb_flush_page_locked, so not onerous.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5a35386224..e3b5750c3b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -137,12 +137,12 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
  * high), since otherwise we are likely to have a significant amount of
  * conflict misses.
  */
-static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
+                                  int64_t now)
 {
     size_t old_size = tlb_n_entries(fast);
     size_t rate;
     size_t new_size = old_size;
-    int64_t now = get_clock_realtime();
     int64_t window_len_ms = 100;
     int64_t window_len_ns = window_len_ms * 1000 * 1000;
     bool window_expired = now > desc->window_begin_ns + window_len_ns;
@@ -222,12 +222,13 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
+                                        int64_t now)
 {
     CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
     CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
 
-    tlb_mmu_resize_locked(desc, fast);
+    tlb_mmu_resize_locked(desc, fast, now);
     tlb_mmu_flush_locked(desc, fast);
 }
 
@@ -310,6 +311,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     CPUArchState *env = cpu->env_ptr;
     uint16_t asked = data.host_int;
     uint16_t all_dirty, work, to_clean;
+    int64_t now = get_clock_realtime();
 
     assert_cpu_is_self(cpu);
 
@@ -324,7 +326,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     for (work = to_clean; work != 0; work &= work - 1) {
         int mmu_idx = ctz32(work);
-        tlb_flush_one_mmuidx_locked(env, mmu_idx);
+        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
     }
 
     qemu_spin_unlock(&env_tlb(env)->c.lock);
@@ -446,7 +448,7 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
         tlb_debug("forcing full flush midx %d ("
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   midx, lp_addr, lp_mask);
-        tlb_flush_one_mmuidx_locked(env, midx);
+        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
     } else {
         if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
             tlb_n_used_entries_dec(env, midx);
-- 
2.20.1


