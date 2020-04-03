Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D341C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1247F206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1247F206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMvk-0001bv-1n
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jKMt2-0006oU-7b
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jKMt0-00006o-Jg
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:01:32 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:59141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jKMt0-0008Sw-Dd
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:01:30 -0400
Received: from player697.ha.ovh.net (unknown [10.110.208.160])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9E53F15BFFD
 for <qemu-devel@nongnu.org>; Fri,  3 Apr 2020 16:01:28 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id E626F111A01E2;
 Fri,  3 Apr 2020 14:01:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v4 3/4] target/ppc: Rework ppc_radix64_walk_tree() for
 partition-scoped translation
Date: Fri,  3 Apr 2020 16:00:55 +0200
Message-Id: <20200403140056.59465-4-clg@kaod.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403140056.59465-1-clg@kaod.org>
References: <20200403140056.59465-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 4735535011420933094
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeigdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.120.239
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

The ppc_radix64_walk_tree() routine walks through the nested radix
tables to look for a PTE.

Split it in two and introduce a new routine ppc_radix64_next_level()
which we will use for partition-scoped Radix translation when
translating the process tree addresses. The prototypes are slightly
change to use a 'AddressSpace *' parameter, instead of a 'PowerPCCPU *'
which is not required, and to return an error code instead of a PTE
value. It clarifies error handling in the callers.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-radix64.c | 79 ++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 11b3c6d48c65..2400da41e06c 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -163,44 +163,67 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int=
 rwx, uint64_t pte,
     }
 }
=20
-static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
-                                      uint64_t base_addr, uint64_t nls,
-                                      hwaddr *raddr, int *psize,
-                                      int *fault_cause, hwaddr *pte_addr=
)
+static int ppc_radix64_next_level(AddressSpace *as, vaddr eaddr,
+                                  uint64_t *pte_addr, uint64_t *nls,
+                                  int *psize, uint64_t *pte, int *fault_=
cause)
 {
-    CPUState *cs =3D CPU(cpu);
     uint64_t index, pde;
=20
-    if (nls < 5) { /* Directory maps less than 2**5 entries */
+    if (*nls < 5) { /* Directory maps less than 2**5 entries */
         *fault_cause |=3D DSISR_R_BADCONFIG;
-        return 0;
+        return 1;
     }
=20
     /* Read page <directory/table> entry from guest address space */
-    index =3D eaddr >> (*psize - nls); /* Shift */
-    index &=3D ((1UL << nls) - 1); /* Mask */
-    pde =3D ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
-    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
+    pde =3D ldq_phys(as, *pte_addr);
+    if (!(pde & R_PTE_VALID)) {         /* Invalid Entry */
         *fault_cause |=3D DSISR_NOPTE;
-        return 0;
+        return 1;
     }
=20
-    *psize -=3D nls;
+    *pte =3D pde;
+    *psize -=3D *nls;
+    if (!(pde & R_PTE_LEAF)) { /* Prepare for next iteration */
+        *nls =3D pde & R_PDE_NLS;
+        index =3D eaddr >> (*psize - *nls);       /* Shift */
+        index &=3D ((1UL << *nls) - 1);           /* Mask */
+        *pte_addr =3D (pde & R_PDE_NLB) + (index * sizeof(pde));
+    }
+    return 0;
+}
=20
-    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
-    if (pde & R_PTE_LEAF) {
-        uint64_t rpn =3D pde & R_PTE_RPN;
-        uint64_t mask =3D (1UL << *psize) - 1;
+static int ppc_radix64_walk_tree(AddressSpace *as, vaddr eaddr,
+                                 uint64_t base_addr, uint64_t nls,
+                                 hwaddr *raddr, int *psize, uint64_t *pt=
e,
+                                 int *fault_cause, hwaddr *pte_addr)
+{
+    uint64_t index, pde, rpn , mask;
=20
-        /* Or high bits of rpn and low bits to ea to form whole real add=
r */
-        *raddr =3D (rpn & ~mask) | (eaddr & mask);
-        *pte_addr =3D base_addr + (index * sizeof(pde));
-        return pde;
+    if (nls < 5) { /* Directory maps less than 2**5 entries */
+        *fault_cause |=3D DSISR_R_BADCONFIG;
+        return 1;
     }
=20
-    /* Next Level of Radix Tree */
-    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PD=
E_NLS,
-                                 raddr, psize, fault_cause, pte_addr);
+    index =3D eaddr >> (*psize - nls);    /* Shift */
+    index &=3D ((1UL << nls) - 1);       /* Mask */
+    *pte_addr =3D base_addr + (index * sizeof(pde));
+    do {
+        int ret;
+
+        ret =3D ppc_radix64_next_level(as, eaddr, pte_addr, &nls, psize,=
 &pde,
+                                     fault_cause);
+        if (ret) {
+            return ret;
+        }
+    } while (!(pde & R_PTE_LEAF));
+
+    *pte =3D pde;
+    rpn =3D pde & R_PTE_RPN;
+    mask =3D (1UL << *psize) - 1;
+
+    /* Or high bits of rpn and low bits to ea to form whole real addr */
+    *raddr =3D (rpn & ~mask) | (eaddr & mask);
+    return 0;
 }
=20
 static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t =
*pate)
@@ -230,6 +253,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
     uint64_t offset, size, prtbe_addr, prtbe0, pte;
     int fault_cause =3D 0;
     hwaddr pte_addr;
+    int ret;
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
@@ -246,11 +270,12 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
=20
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
-    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
+    ret =3D ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK,
                                 prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
-                                g_raddr, g_page_size, &fault_cause, &pte=
_addr);
+                                g_raddr, g_page_size, &pte, &fault_cause=
,
+                                &pte_addr);
=20
-    if (!(pte & R_PTE_VALID) ||
+    if (ret ||
         ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, fals=
e)) {
         /* No valid pte or access denied due to protection */
         if (cause_excp) {
--=20
2.25.1


