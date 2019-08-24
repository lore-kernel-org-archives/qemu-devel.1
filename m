Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC8C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA032133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRBBH0kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA032133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1dps-0007uC-8o
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgh-0001N6-I5
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgg-00036S-FK
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:46383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dge-00034S-FE
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id q139so9018181pfc.13
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MaPRheG1y5rukm0xNUMPfKKNGnqQD10OMwv720v5bPI=;
 b=IRBBH0kEUItTpr7/5DkK7rpgZWXEMN/EWz9awnmHsbyDiZF8PoyFGAOliB9eS7W/VZ
 XA3M8IrxfIBQ7b8+M3km6ObNNEtgl8q2dSJB0n5ivnabU7X9YWQSN7x8Dpnmla9M8oPS
 qC05fD8ey5UIYzT7p3naFjR/pcouqOSyJOR4uzk1YuG8TsUwxrKNdS2oMD7w2ikECJBF
 lDn/ku0lrbQWo9e/kvar6E8oJP+6R5GsOIZqcbG7Ekm3W3XxH91A4y6hC/Drxojsf9dZ
 XjJ724JDTPhzNi41pW2JdyZEGpA+QpiNui1J4LTBfslHIw7J2IjIyKygp95ouN4HUn2D
 gaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MaPRheG1y5rukm0xNUMPfKKNGnqQD10OMwv720v5bPI=;
 b=VJ7ms3BE0QuAt7QalE9H+tIysIjZm0hDMhladWpZsNrxTUqTtXfQg332pnAPxObrRm
 8Kj/bZHFuMtY2/2wip9h0y/bKJnH8LHaFhC/115uJYeM67pZGDNhmxOKMqL1sRzzQZC3
 z0PGz4rsN/qH8urdW0ysoSHCwuaUnmpxwZP3uWAKlKLWPa48Zg5A163Ry5HPZieqLRKn
 Nau4xlDmx+S2iIWB9Mv1RmiiH5sydc1iEapEvRhjiQJ8E3FTe64V5+QBDDl5UDj3+IKY
 69uBtuGYrff+orM1QRJ+lknSG6MF2512t38jXaVDjEm6Q7CT6U5TLVzwak1DLK3WcBbs
 af/A==
X-Gm-Message-State: APjAAAU2Z+CEE/V+1HdFMghgB6j5HdAtautrvYthDbnV+pQc9gz32JTy
 EkBYBuxEmHmHLtgf+/7JNSo1Ua8nOAc=
X-Google-Smtp-Source: APXvYqzjc/xBh9AjrsE6+yDJ8tu4HdnfIRO97xLtLKHBVR3+ZixgU8VfcfA7Jq50fItF3eCIZ0HeUg==
X-Received: by 2002:a17:90a:17aa:: with SMTP id
 q39mr12013875pja.106.1566682501676; 
 Sat, 24 Aug 2019 14:35:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:35:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:51 -0700
Message-Id: <20190824213451.31118-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
References: <20190824213451.31118-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH 6/6] tcg: Check for watchpoints in probe_write()
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
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let size > 0 indicate a promise to write to those bytes.
Check for write watchpoints in the probed range.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190823100741.9621-10-david@redhat.com>
[rth: Recompute index after tlb_fill; check TLB_WATCHPOINT.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f7a414a131..7fc7aa9482 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1086,13 +1086,24 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = tlb_addr_write(entry);
 
-    if (!tlb_hit(tlb_addr_write(entry), addr)) {
-        /* TLB entry is for a different page */
+    if (unlikely(!tlb_hit(tlb_addr, addr))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            /* TLB resize via tlb_fill may have moved the entry. */
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
+        tlb_addr = tlb_addr_write(entry);
+    }
+
+    /* Handle watchpoints.  */
+    if ((tlb_addr & TLB_WATCHPOINT) && size > 0) {
+        cpu_check_watchpoint(env_cpu(env), addr, size,
+                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
+                             BP_MEM_WRITE, retaddr);
     }
 }
 
-- 
2.17.1


