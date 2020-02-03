Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C10C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C188220658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QCIRfKUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C188220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVHm-0007j6-Va
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUyF-0003ue-Fg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUyE-0003t6-6R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:31 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50999 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUyD-0003R2-Rw; Mon, 03 Feb 2020 01:12:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBt1QNVz9sT7; Mon,  3 Feb 2020 17:11:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710294;
 bh=3iAC76bwztBry20u5fNvLcGtCULA+alfuoS+B5Ni6nE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QCIRfKUNQcaoaM/Y6taYimvUqCWJnheJSUFan5C3jwNFodkifBu4187KwXRozwOB3
 RRMs5KV6K5UtLHIe/rbCiLP6wZFoIi/zzDN8kpfV/OnvIUO/G0ly1It6QIjt40lxZB
 jj6q1Ev+31oSjxDgD3Izm7Io7ITj7AV7+sJ76gzw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 31/35] target/ppc: Use probe_access for LSW, STSW
Date: Mon,  3 Feb 2020 17:11:19 +1100
Message-Id: <20200203061123.59150-32-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use a minimum number of mmu lookups for the contiguous bytes
that are accessed.  If the lookup succeeds, we can finish the
operation with host addresses only.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200129235040.24022-2-richard.henderson@linaro.org>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mem_helper.c | 148 ++++++++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e8e2a8ac2a..508d472a2f 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -56,6 +56,32 @@ static inline target_ulong addr_add(CPUPPCState *env, =
target_ulong addr,
     }
 }
=20
+static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint3=
2_t nb,
+                              MMUAccessType access_type, int mmu_idx,
+                              uintptr_t raddr)
+{
+    void *host1, *host2;
+    uint32_t nb_pg1, nb_pg2;
+
+    nb_pg1 =3D -(addr | TARGET_PAGE_MASK);
+    if (likely(nb <=3D nb_pg1)) {
+        /* The entire operation is on a single page.  */
+        return probe_access(env, addr, nb, access_type, mmu_idx, raddr);
+    }
+
+    /* The operation spans two pages.  */
+    nb_pg2 =3D nb - nb_pg1;
+    host1 =3D probe_access(env, addr, nb_pg1, access_type, mmu_idx, radd=
r);
+    addr =3D addr_add(env, addr, nb_pg1);
+    host2 =3D probe_access(env, addr, nb_pg2, access_type, mmu_idx, radd=
r);
+
+    /* If the two host pages are contiguous, optimize.  */
+    if (host2 =3D=3D host1 + nb_pg1) {
+        return host1;
+    }
+    return NULL;
+}
+
 void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     for (; reg < 32; reg++) {
@@ -84,23 +110,65 @@ void helper_stmw(CPUPPCState *env, target_ulong addr=
, uint32_t reg)
 static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
                    uint32_t reg, uintptr_t raddr)
 {
-    int sh;
+    int mmu_idx;
+    void *host;
+    uint32_t val;
=20
-    for (; nb > 3; nb -=3D 4) {
-        env->gpr[reg] =3D cpu_ldl_data_ra(env, addr, raddr);
-        reg =3D (reg + 1) % 32;
-        addr =3D addr_add(env, addr, 4);
+    if (unlikely(nb =3D=3D 0)) {
+        return;
     }
-    if (unlikely(nb > 0)) {
-        env->gpr[reg] =3D 0;
-        for (sh =3D 24; nb > 0; nb--, sh -=3D 8) {
-            env->gpr[reg] |=3D cpu_ldub_data_ra(env, addr, raddr) << sh;
-            addr =3D addr_add(env, addr, 1);
+
+    mmu_idx =3D cpu_mmu_index(env, false);
+    host =3D probe_contiguous(env, addr, nb, MMU_DATA_LOAD, mmu_idx, rad=
dr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; nb > 3; nb -=3D 4) {
+            env->gpr[reg] =3D (uint32_t)ldl_be_p(host);
+            reg =3D (reg + 1) % 32;
+            host +=3D 4;
+        }
+        switch (nb) {
+        default:
+            return;
+        case 1:
+            val =3D ldub_p(host) << 24;
+            break;
+        case 2:
+            val =3D lduw_be_p(host) << 16;
+            break;
+        case 3:
+            val =3D (lduw_be_p(host) << 16) | (ldub_p(host + 2) << 8);
+            break;
+        }
+    } else {
+        /* Slow path -- at least some of the operation requires i/o.  */
+        for (; nb > 3; nb -=3D 4) {
+            env->gpr[reg] =3D cpu_ldl_mmuidx_ra(env, addr, mmu_idx, radd=
r);
+            reg =3D (reg + 1) % 32;
+            addr =3D addr_add(env, addr, 4);
+        }
+        switch (nb) {
+        default:
+            return;
+        case 1:
+            val =3D cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
+            break;
+        case 2:
+            val =3D cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            break;
+        case 3:
+            val =3D cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            addr =3D addr_add(env, addr, 2);
+            val |=3D cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
+            break;
         }
     }
+    env->gpr[reg] =3D val;
 }
=20
-void helper_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb, uint32=
_t reg)
+void helper_lsw(CPUPPCState *env, target_ulong addr,
+                uint32_t nb, uint32_t reg)
 {
     do_lsw(env, addr, nb, reg, GETPC());
 }
@@ -130,17 +198,57 @@ void helper_lswx(CPUPPCState *env, target_ulong add=
r, uint32_t reg,
 void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
                  uint32_t reg)
 {
-    int sh;
+    uintptr_t raddr =3D GETPC();
+    int mmu_idx;
+    void *host;
+    uint32_t val;
=20
-    for (; nb > 3; nb -=3D 4) {
-        cpu_stl_data_ra(env, addr, env->gpr[reg], GETPC());
-        reg =3D (reg + 1) % 32;
-        addr =3D addr_add(env, addr, 4);
+    if (unlikely(nb =3D=3D 0)) {
+        return;
     }
-    if (unlikely(nb > 0)) {
-        for (sh =3D 24; nb > 0; nb--, sh -=3D 8) {
-            cpu_stb_data_ra(env, addr, (env->gpr[reg] >> sh) & 0xFF, GET=
PC());
-            addr =3D addr_add(env, addr, 1);
+
+    mmu_idx =3D cpu_mmu_index(env, false);
+    host =3D probe_contiguous(env, addr, nb, MMU_DATA_STORE, mmu_idx, ra=
ddr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; nb > 3; nb -=3D 4) {
+            stl_be_p(host, env->gpr[reg]);
+            reg =3D (reg + 1) % 32;
+            host +=3D 4;
+        }
+        val =3D env->gpr[reg];
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
+        for (; nb > 3; nb -=3D 4) {
+            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            reg =3D (reg + 1) % 32;
+            addr =3D addr_add(env, addr, 4);
+        }
+        val =3D env->gpr[reg];
+        switch (nb) {
+        case 1:
+            cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
+            break;
+        case 2:
+            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            break;
+        case 3:
+            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            addr =3D addr_add(env, addr, 2);
+            cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
+            break;
         }
     }
 }
--=20
2.24.1


