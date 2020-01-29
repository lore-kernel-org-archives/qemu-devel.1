Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0352070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wasyW8lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0352070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53181 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwx88-0007be-Tk
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6d-0005yo-AS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6c-0001ra-07
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:47 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwx6b-0001pk-Qc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:45 -0500
Received: by mail-pf1-x441.google.com with SMTP id 185so497754pfv.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qyfFVuPo0F6BFeJ8jXlvXMSw2kK/b7kOhlz/lPj6CW4=;
 b=wasyW8lczuJDXuFCGuK87RFtGHo2fiX/qHP4QFWT5uOLKqeej16kyCfcznIpOzsBv1
 SyT3NWKNVpQZu4roVe+U2VCClqjOPSgicYjnAblP8AgjducFq4Ol+4rKzv7ou56vLd6j
 v71MK6YLGFcovaxGBA8oDdwCJBy1RzM9kvBylR0U5SfE2CxF1qPG0BE1MNynUXnijqc8
 4A47r+lRxX8/Z7poZLOvyQ33QybW/g+ZepcJrpkDGobiEf1p3Gs9afq9+JBD7seDOVsX
 k0NSX6awFobRSjuqV+vzlJwxtVVWfkdODDXkVEF3ASRn6SJl86sQKqUtul+Vq2NjWwnF
 eDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qyfFVuPo0F6BFeJ8jXlvXMSw2kK/b7kOhlz/lPj6CW4=;
 b=TKbIqzusQOI4W/sQ9sCG8NPcCdmQ9yYNX9QaHlxxnKvFYdDfzGftR935MDNI7aGOYm
 CVu7C9enu+U6u9S1Q08VvpNcY3wnzZwhXrgnEpXgNg88jusl4KulMt3gMolrxxaAQrzD
 pwMuJYNrxUZvIC2zCnskATE7CujA+lM+9iWme+1PpmHMOFtXvTYhzHD8IqC5oZkSaFn7
 xgLtguJiuEs7VyliIQacxbEXbNTcsUEAYLqhv6QcQ4J/PLcCVVYe+4m1ORdFClc5Jkcr
 rKXbNn59sV/2aoqs+0La20t6iI0WAr0SSErHzQxsaLP/+VcME+Vx0vLvNJi+R/tI7EVs
 LlIw==
X-Gm-Message-State: APjAAAW4YD3z0XMXIhSZ9Eqyfy31GnhceGvsOkf57HDgSfANj/FQG2cw
 mBzVF4pxrsA5oqZZrx54UQ9hB6rBkEM=
X-Google-Smtp-Source: APXvYqxVwNqNiRVK4W15aA9wFuyCT9DJsBYp0WrqCiOdBFRpw590VjVVdrHabUI9kY+OP6jKmcmOsg==
X-Received: by 2002:a62:fc93:: with SMTP id e141mr2029742pfh.262.1580341844438; 
 Wed, 29 Jan 2020 15:50:44 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id 13sm3740195pfi.78.2020.01.29.15.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:50:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/ppc: Use probe_access for LSW, STSW
Date: Wed, 29 Jan 2020 15:50:37 -0800
Message-Id: <20200129235040.24022-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a minimum number of mmu lookups for the contiguous bytes
that are accessed.  If the lookup succeeds, we can finish the
operation with host addresses only.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 148 ++++++++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e8e2a8ac2a..508d472a2f 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -56,6 +56,32 @@ static inline target_ulong addr_add(CPUPPCState *env, target_ulong addr,
     }
 }
 
+static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
+                              MMUAccessType access_type, int mmu_idx,
+                              uintptr_t raddr)
+{
+    void *host1, *host2;
+    uint32_t nb_pg1, nb_pg2;
+
+    nb_pg1 = -(addr | TARGET_PAGE_MASK);
+    if (likely(nb <= nb_pg1)) {
+        /* The entire operation is on a single page.  */
+        return probe_access(env, addr, nb, access_type, mmu_idx, raddr);
+    }
+
+    /* The operation spans two pages.  */
+    nb_pg2 = nb - nb_pg1;
+    host1 = probe_access(env, addr, nb_pg1, access_type, mmu_idx, raddr);
+    addr = addr_add(env, addr, nb_pg1);
+    host2 = probe_access(env, addr, nb_pg2, access_type, mmu_idx, raddr);
+
+    /* If the two host pages are contiguous, optimize.  */
+    if (host2 == host1 + nb_pg1) {
+        return host1;
+    }
+    return NULL;
+}
+
 void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     for (; reg < 32; reg++) {
@@ -84,23 +110,65 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
                    uint32_t reg, uintptr_t raddr)
 {
-    int sh;
+    int mmu_idx;
+    void *host;
+    uint32_t val;
 
-    for (; nb > 3; nb -= 4) {
-        env->gpr[reg] = cpu_ldl_data_ra(env, addr, raddr);
-        reg = (reg + 1) % 32;
-        addr = addr_add(env, addr, 4);
+    if (unlikely(nb == 0)) {
+        return;
     }
-    if (unlikely(nb > 0)) {
-        env->gpr[reg] = 0;
-        for (sh = 24; nb > 0; nb--, sh -= 8) {
-            env->gpr[reg] |= cpu_ldub_data_ra(env, addr, raddr) << sh;
-            addr = addr_add(env, addr, 1);
+
+    mmu_idx = cpu_mmu_index(env, false);
+    host = probe_contiguous(env, addr, nb, MMU_DATA_LOAD, mmu_idx, raddr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; nb > 3; nb -= 4) {
+            env->gpr[reg] = (uint32_t)ldl_be_p(host);
+            reg = (reg + 1) % 32;
+            host += 4;
+        }
+        switch (nb) {
+        default:
+            return;
+        case 1:
+            val = ldub_p(host) << 24;
+            break;
+        case 2:
+            val = lduw_be_p(host) << 16;
+            break;
+        case 3:
+            val = (lduw_be_p(host) << 16) | (ldub_p(host + 2) << 8);
+            break;
+        }
+    } else {
+        /* Slow path -- at least some of the operation requires i/o.  */
+        for (; nb > 3; nb -= 4) {
+            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            reg = (reg + 1) % 32;
+            addr = addr_add(env, addr, 4);
+        }
+        switch (nb) {
+        default:
+            return;
+        case 1:
+            val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
+            break;
+        case 2:
+            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            break;
+        case 3:
+            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            addr = addr_add(env, addr, 2);
+            val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
+            break;
         }
     }
+    env->gpr[reg] = val;
 }
 
-void helper_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb, uint32_t reg)
+void helper_lsw(CPUPPCState *env, target_ulong addr,
+                uint32_t nb, uint32_t reg)
 {
     do_lsw(env, addr, nb, reg, GETPC());
 }
@@ -130,17 +198,57 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
 void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
                  uint32_t reg)
 {
-    int sh;
+    uintptr_t raddr = GETPC();
+    int mmu_idx;
+    void *host;
+    uint32_t val;
 
-    for (; nb > 3; nb -= 4) {
-        cpu_stl_data_ra(env, addr, env->gpr[reg], GETPC());
-        reg = (reg + 1) % 32;
-        addr = addr_add(env, addr, 4);
+    if (unlikely(nb == 0)) {
+        return;
     }
-    if (unlikely(nb > 0)) {
-        for (sh = 24; nb > 0; nb--, sh -= 8) {
-            cpu_stb_data_ra(env, addr, (env->gpr[reg] >> sh) & 0xFF, GETPC());
-            addr = addr_add(env, addr, 1);
+
+    mmu_idx = cpu_mmu_index(env, false);
+    host = probe_contiguous(env, addr, nb, MMU_DATA_STORE, mmu_idx, raddr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; nb > 3; nb -= 4) {
+            stl_be_p(host, env->gpr[reg]);
+            reg = (reg + 1) % 32;
+            host += 4;
+        }
+        val = env->gpr[reg];
+        switch (nb) {
+        case 1:
+            stb_p(host, val >> 24);
+            break;
+        case 2:
+            stw_be_p(host, val >> 16);
+            break;
+        case 3:
+            stw_be_p(host, val >> 16);
+            stb_p(host + 2, val >> 8);
+            break;
+        }
+    } else {
+        for (; nb > 3; nb -= 4) {
+            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            reg = (reg + 1) % 32;
+            addr = addr_add(env, addr, 4);
+        }
+        val = env->gpr[reg];
+        switch (nb) {
+        case 1:
+            cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
+            break;
+        case 2:
+            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            break;
+        case 3:
+            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            addr = addr_add(env, addr, 2);
+            cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
+            break;
         }
     }
 }
-- 
2.20.1


