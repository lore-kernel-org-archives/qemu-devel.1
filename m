Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4219020784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4219020784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJu0i-0003jQ-EB
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJtyS-0007zg-4C
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJtyR-0004co-2Q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:12 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:40230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJtyQ-0004c9-Sb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:11 -0400
Received: from player687.ha.ovh.net (unknown [10.110.115.233])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 179B11602B6
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 09:09:08 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 98C9510FD5675;
 Thu,  2 Apr 2020 07:09:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 2/4] target/ppc: Extend ppc_radix64_check_prot() with a
 'partition_scoped' bool
Date: Thu,  2 Apr 2020 09:08:45 +0200
Message-Id: <20200402070847.5921-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200402070847.5921-1-clg@kaod.org>
References: <20200402070847.5921-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 10345894246136384486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.100
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This prepares ground for partition-scoped Radix translation.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-radix64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 0f615feb580a..52c22219b657 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -105,7 +105,8 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, int=
 rwx, vaddr eaddr,
=20
=20
 static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pt=
e,
-                                   int *fault_cause, int *prot)
+                                   int *fault_cause, int *prot,
+                                   bool partition_scoped)
 {
     CPUPPCState *env =3D &cpu->env;
     const int need_prot[] =3D { PAGE_READ, PAGE_WRITE, PAGE_EXEC };
@@ -121,11 +122,11 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 int rwx, uint64_t pte,
     }
=20
     /* Determine permissions allowed by Encoded Access Authority */
-    if ((pte & R_PTE_EAA_PRIV) && msr_pr) { /* Insufficient Privilege */
+    if (!partition_scoped && (pte & R_PTE_EAA_PRIV) && msr_pr) {
         *prot =3D 0;
-    } else if (msr_pr || (pte & R_PTE_EAA_PRIV)) {
+    } else if (msr_pr || (pte & R_PTE_EAA_PRIV) || partition_scoped) {
         *prot =3D ppc_radix64_get_prot_eaa(pte);
-    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) */
+    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) && !partition_scoped =
*/
         *prot =3D ppc_radix64_get_prot_eaa(pte);
         *prot &=3D ppc_radix64_get_prot_amr(cpu); /* Least combined perm=
issions */
     }
@@ -250,7 +251,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
                                 g_raddr, g_page_size, &fault_cause, &pte=
_addr);
=20
     if (!(pte & R_PTE_VALID) ||
-        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot)) {
+        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, fals=
e)) {
         /* No valid pte or access denied due to protection */
         if (cause_excp) {
             ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
--=20
2.21.1


