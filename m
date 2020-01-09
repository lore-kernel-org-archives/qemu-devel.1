Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A0C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2592D206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7+pey/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2592D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNxP-000820-PM
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt7-00034n-FJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt4-0006Pm-Gw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:33 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNt4-0006Oi-Ao
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:30 -0500
Received: by mail-pj1-x1043.google.com with SMTP id r67so478243pjb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Otsrpp3foKLNa1SqB84R8O87zHmU0sZwfC3eLGqWD8=;
 b=l7+pey/eFmdAM/QTyGWQo+Ehd9CIHQROPHKV0opg1OXFqLPK3FiB2IaXrg9GhnTf1r
 I3zwqx5qP3Nkx7pz+RTM1VIkFfVTgi2oml0KFhUFS/KHhwm4TYrveaDAlp7AkPT5KAsp
 wpX1h/tRbc14yqnGdLDe0Uyq/uz5S8AH8wkAq0RlpblpOlr8JFJlXfT23MwFshR4JON1
 bQAZSUODOmEw7EJIFc0silViTUe+iilJuQQfLEhUFspwFb7ZKDTFN1HnHtuy9MGrzYdx
 IgUr3yFMSZBwfmEgs7Cfuc2PY+4f6nF8i179cTprNz0aB88HQls0X883JDskoyDeGUOS
 KsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Otsrpp3foKLNa1SqB84R8O87zHmU0sZwfC3eLGqWD8=;
 b=P2ujKTaKnUjtWJClzkB5mcKyzXkcXX/Yo5ewXSnyRxJmo0Zxi0UcxLAFUzkCiotBtK
 qigjFqaISmGzfT/bpP6zwgVV1Qf1/kpnZiGazRXEj3hDvMOpPdv9WjjqttwTWnuSWcfr
 nZaRi3k3aXce77wi3psQpvn+2EIWCGAXDW+oIcV0E6OtlBX9npMex5VvK68Wuv4eX77m
 GYO7pcwTJNC7KwoKcdzGGuek+xTeGtcsPJrVDyhiswxD7iCEJy5uxWB0L7ag4AGFofZV
 c6KGpjJNSMltec6VgbF8aBZ6bIWeBxqEVVLTUQ8FjvA0cAAk2W82cijt8ObaXi7i0XPt
 Herw==
X-Gm-Message-State: APjAAAXuY1UIgktfWOyC/u79DvtzJ+4vzoX5DbPM5OlbWQ5EQF1OTJEc
 pa28L+RarY+bVy4fmro36P4ufU89vvH8/w==
X-Google-Smtp-Source: APXvYqzEq9EPGkmd0JZXFcehwH3kk3gxzfUMC9v5NVGRlkgJR1X2cknFPGG7wficvX/DdWF4WVFuSQ==
X-Received: by 2002:a17:902:8207:: with SMTP id
 x7mr8907127pln.286.1578538169014; 
 Wed, 08 Jan 2020 18:49:29 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] cputlb: Partially merge tlb_dyn_init into tlb_init
Date: Thu,  9 Jan 2020 13:49:05 +1100
Message-Id: <20200109024907.2730-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merge into the only caller, but at the same time split
out tlb_mmu_init to initialize a single tlb entry.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e60e501334..c7c34b185b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -97,22 +97,6 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
     desc->window_max_entries = max_entries;
 }
 
-static void tlb_dyn_init(CPUArchState *env)
-{
-    int i;
-
-    for (i = 0; i < NB_MMU_MODES; i++) {
-        CPUTLBDesc *desc = &env_tlb(env)->d[i];
-        size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
-
-        tlb_window_reset(desc, get_clock_realtime(), 0);
-        desc->n_used_entries = 0;
-        env_tlb(env)->f[i].mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
-        env_tlb(env)->f[i].table = g_new(CPUTLBEntry, n_entries);
-        env_tlb(env)->d[i].iotlb = g_new(CPUIOTLBEntry, n_entries);
-    }
-}
-
 /**
  * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
  * @desc: The CPUTLBDesc portion of the TLB
@@ -247,6 +231,17 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     tlb_mmu_flush_locked(desc, fast);
 }
 
+static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
+{
+    size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
+
+    tlb_window_reset(desc, now, 0);
+    desc->n_used_entries = 0;
+    fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
+    fast->table = g_new(CPUTLBEntry, n_entries);
+    desc->iotlb = g_new(CPUIOTLBEntry, n_entries);
+}
+
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
 {
     env_tlb(env)->d[mmu_idx].n_used_entries++;
@@ -260,13 +255,17 @@ static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int64_t now = get_clock_realtime();
+    int i;
 
     qemu_spin_init(&env_tlb(env)->c.lock);
 
     /* Ensure that cpu_reset performs a full flush.  */
     env_tlb(env)->c.dirty = ALL_MMUIDX_BITS;
 
-    tlb_dyn_init(env);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
+    }
 }
 
 /* flush_all_helper: run fn across all cpus
-- 
2.20.1


