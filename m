Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52210C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D390C206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LpcT5Ftw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D390C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuKs-0001hh-Jg
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:27:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1N-0006TH-Pu
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1M-0005iA-N0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35301 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu1M-00057V-1N; Fri, 26 Apr 2019 02:07:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tr1VGkz9sP1; Fri, 26 Apr 2019 16:06:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258800;
	bh=CrJ6LiThzdFhZvdEPZF9mDmfrXA+5OXeE4aXebuaLcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpcT5FtwJSyT1jbEUy1ye7QOiKdeMXWRyL2shhrIobv6cB3r2K6V3lX8anE9fsdgW
	ulOm5Ycn4iH+CY7VrvY/pPlRyaPTDdpgKQ2jmYixyLtDW17Pg6kfwwTPlr6Cv8rpVV
	PRUbwSrd1yUE0PZ6raH9O4FQXD32OiQoZs1xC+QA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:26 +1000
Message-Id: <20190426060627.18153-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 35/36] ppc/hash32: Rework R and C bit updates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060626.tbPCU8mWe6ULXbRWxJwZ48HIloP6qGoXZonW29TV08U@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

With MT-TCG, we are now running translation in a racy way, thus
we need to mimic hardware when it comes to updating the R and
C bits, by doing byte stores.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash32.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3f4dee835e..55cf156a0b 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -345,6 +345,24 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu=
, hwaddr pteg_off,
     return -1;
 }
=20
+static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_=
t pte1)
+{
+    target_ulong base =3D ppc_hash32_hpt_base(cpu);
+    hwaddr offset =3D pte_offset + 6;
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+}
+
+static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_=
t pte1)
+{
+    target_ulong base =3D ppc_hash32_hpt_base(cpu);
+    hwaddr offset =3D pte_offset + 7;
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+}
+
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
                                      target_ulong sr, target_ulong eaddr=
,
                                      ppc_hash_pte32_t *pte)
@@ -403,7 +421,6 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr, int rwx,
     hwaddr pte_offset;
     ppc_hash_pte32_t pte;
     int prot;
-    uint32_t new_pte1;
     const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
=20
@@ -519,20 +536,20 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
=20
     /* 8. Update PTE referenced and changed bits if necessary */
=20
-    new_pte1 =3D pte.pte1 | HPTE32_R_R; /* set referenced bit */
-    if (rwx =3D=3D 1) {
-        new_pte1 |=3D HPTE32_R_C; /* set changed (dirty) bit */
-    } else {
-        /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit
-         */
-        prot &=3D ~PAGE_WRITE;
-    }
-
-    if (new_pte1 !=3D pte.pte1) {
-        ppc_hash32_store_hpte1(cpu, pte_offset, new_pte1);
+    if (!(pte.pte1 & HPTE32_R_R)) {
+        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
     }
+    if (!(pte.pte1 & HPTE32_R_C)) {
+        if (rwx =3D=3D 1) {
+            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
+        } else {
+            /*
+             * Treat the page as read-only for now, so that a later writ=
e
+             * will pass through this function again to set the C bit
+             */
+            prot &=3D ~PAGE_WRITE;
+        }
+     }
=20
     /* 9. Determine the real address from the PTE */
=20
--=20
2.20.1


