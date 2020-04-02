Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E60C10F26
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CEF2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CEF2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJtzt-0001qu-4t
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 03:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJtyg-0008VK-BY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJtye-0004pU-HR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:26 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:36174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJtye-0004p3-81
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:09:24 -0400
Received: from player687.ha.ovh.net (unknown [10.108.35.119])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id BD959277DE6
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 09:09:22 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 54FFA10FD5774;
 Thu,  2 Apr 2020 07:09:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 4/4] target/ppc: Add support for Radix partition-scoped
 translation
Date: Thu,  2 Apr 2020 09:08:47 +0200
Message-Id: <20200402070847.5921-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200402070847.5921-1-clg@kaod.org>
References: <20200402070847.5921-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 10349834897520692198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.247
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

The Radix tree translation model currently supports process-scoped
translation for the PowerNV machine (Hypervisor mode) and for the
pSeries machine (Guest mode). Guests running under an emulated
Hypervisor (PowerNV machine) require a new type of Radix translation,
called partition-scoped, which is missing today.

The Radix tree translation is a 2 steps process. The first step,
process-scoped translation, converts an effective Address to a guest
real address, and the second step, partition-scoped translation,
converts a guest real address to a host real address.

There are difference cases to covers :

* Hypervisor real mode access: no Radix translation.

* Hypervisor or host application access (quadrant 0 and 3) with
  relocation on: process-scoped translation.

* Guest OS real mode access: only partition-scoped translation.

* Guest OS real or guest application access (quadrant 0 and 3) with
  relocation on: both process-scoped translation and partition-scoped
  translations.

* Hypervisor access in quadrant 1 and 2 with relocation on: both
  process-scoped translation and partition-scoped translations.

The radix tree partition-scoped translation is performed using tables
pointed to by the first double-word of the Partition Table Entries and
process-scoped translation uses tables pointed to by the Process Table
Entries (second double-word of the Partition Table Entries).

Both partition-scoped and process-scoped translations process are
identical and thus the radix tree traversing code is largely reused.
However, errors in partition-scoped translations generate hypervisor
exceptions.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         |   3 +
 target/ppc/excp_helper.c |   3 +-
 target/ppc/mmu-radix64.c | 166 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f4a5304d4356..6b6dd7e483f1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -463,6 +463,9 @@ typedef struct ppc_v3_pate_t {
 #define DSISR_AMR                0x00200000
 /* Unsupported Radix Tree Configuration */
 #define DSISR_R_BADCONFIG        0x00080000
+#define DSISR_ATOMIC_RC          0x00040000
+/* Unable to translate address of (guest) pde or process/page table entr=
y */
+#define DSISR_PRTABLE_FAULT      0x00020000
=20
 /* SRR1 error code fields */
=20
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1acc3786de0e..f05297966472 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -506,9 +506,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception       =
     */
     case POWERPC_EXCP_TRACE:     /* Trace exception                     =
     */
         break;
+    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
+        msr |=3D env->error_code;
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception    =
     */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception   =
     */
-    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
     case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception   =
     */
     case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 4091041c65d7..5f6f9346534c 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -103,6 +103,27 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, in=
t rwx, vaddr eaddr,
     }
 }
=20
+static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+                                  hwaddr g_raddr, uint32_t cause)
+{
+    CPUState *cs =3D CPU(cpu);
+    CPUPPCState *env =3D &cpu->env;
+
+    if (rwx =3D=3D 2) { /* H Instruction Storage Interrupt */
+        cs->exception_index =3D POWERPC_EXCP_HISI;
+        env->spr[SPR_ASDR] =3D g_raddr;
+        env->error_code =3D cause;
+    } else { /* H Data Storage Interrupt */
+        cs->exception_index =3D POWERPC_EXCP_HDSI;
+        if (rwx =3D=3D 1) { /* Write -> Store */
+            cause |=3D DSISR_ISSTORE;
+        }
+        env->spr[SPR_HDSISR] =3D cause;
+        env->spr[SPR_HDAR] =3D eaddr;
+        env->spr[SPR_ASDR] =3D g_raddr;
+        env->error_code =3D 0;
+    }
+}
=20
 static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pt=
e,
                                    int *fault_cause, int *prot,
@@ -240,6 +261,36 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t =
lpid, ppc_v3_pate_t *pate)
     return true;
 }
=20
+static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
+                                              vaddr eaddr, hwaddr g_radd=
r,
+                                              ppc_v3_pate_t pate,
+                                              hwaddr *h_raddr, int *h_pr=
ot,
+                                              int *h_page_size, bool pde=
_addr,
+                                              bool cause_excp)
+{
+    int fault_cause =3D 0;
+    hwaddr pte_addr;
+    uint64_t pte;
+
+    *h_page_size =3D PRTBE_R_GET_RTS(pate.dw0);
+    pte =3D ppc_radix64_walk_tree(CPU(cpu)->as, g_raddr, pate.dw0 & PRTB=
E_R_RPDB,
+                                pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page=
_size,
+                                &fault_cause, &pte_addr);
+    /* No valid pte or access denied due to protection */
+    if (!(pte & R_PTE_VALID) ||
+            ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, =
true)) {
+        if (pde_addr) /* address being translated was that of a guest pd=
e */
+            fault_cause |=3D DSISR_PRTABLE_FAULT;
+        ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
+        return 1;
+    }
+
+    /* Update Reference and Change Bits */
+    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+
+    return 0;
+}
+
 static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *=
g_raddr,
@@ -247,9 +298,10 @@ static int ppc_radix64_process_scoped_xlate(PowerPCC=
PU *cpu, int rwx,
                                             bool cause_excp)
 {
     CPUState *cs =3D CPU(cpu);
-    uint64_t offset, size, prtbe_addr, prtbe0, pte;
-    int fault_cause =3D 0;
-    hwaddr pte_addr;
+    CPUPPCState *env =3D &cpu->env;
+    uint64_t offset, size, prtbe_addr, prtbe0, base_addr, nls, index, pt=
e;
+    int fault_cause =3D 0, h_page_size, h_prot, ret;
+    hwaddr h_raddr, pte_addr;
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
@@ -262,13 +314,69 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
         return 1;
     }
     prtbe_addr =3D (pate.dw1 & PATE1_R_PRTB) + offset;
-    prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
+
+    if (cpu->vhyp) {
+        prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
+    } else {
+        /*
+         * Process table addresses are subject to partition-scoped
+         * translation
+         *
+         * On a Radix host, the partition-scoped page table for LPID=3D0
+         * is only used to translate the effective addresses of the
+         * process table entries.
+         */
+        ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_=
addr,
+                                                 pate, &h_raddr, &h_prot=
,
+                                                 &h_page_size, 1, 1);
+        if (ret) {
+            return ret;
+        }
+        prtbe0 =3D ldq_phys(cs->as, h_raddr);
+    }
=20
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
-    pte =3D ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
-                                g_raddr, g_page_size, &fault_cause, &pte=
_addr);
+    base_addr =3D prtbe0 & PRTBE_R_RPDB;
+    nls =3D prtbe0 & PRTBE_R_RPDS;
+    if (msr_hv || cpu->vhyp) {
+        /*
+         * Can treat process table addresses as real addresses
+         */
+        pte =3D ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK, base=
_addr,
+                                    nls, g_raddr, g_page_size, &fault_ca=
use,
+                                    &pte_addr);
+    } else {
+        index =3D (eaddr & R_EADDR_MASK) >> (*g_page_size - nls); /* Shi=
ft */
+        index &=3D ((1UL << nls) - 1);                            /* Mas=
k */
+        pte_addr =3D base_addr + (index * sizeof(pte));
+
+        /*
+         * Each process table address is subject to a partition-scoped
+         * translation
+         */
+        do {
+            ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pt=
e_addr,
+                                                     pate, &h_raddr, &h_=
prot,
+                                                     &h_page_size, 1, 1)=
;
+            if (ret) {
+                return ret;
+            }
+
+            pte =3D ppc_radix64_next_level(cs->as, eaddr & R_EADDR_MASK,=
 &h_raddr,
+                                         &nls, g_page_size, &fault_cause=
);
+            pte_addr =3D h_raddr;
+        } while ((pte & R_PTE_VALID) && !(pte & R_PTE_LEAF));
+
+        /* Did we find a valid leaf? */
+        if ((pte & R_PTE_VALID) && (pte & R_PTE_LEAF)) {
+            uint64_t rpn =3D pte & R_PTE_RPN;
+            uint64_t mask =3D (1UL << *g_page_size) - 1;
+
+            /* Or high bits of rpn and low bits to ea to form whole real=
 addr */
+            *g_raddr =3D (rpn & ~mask) | (eaddr & mask);
+        }
+    }
=20
     if (!(pte & R_PTE_VALID) ||
         ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, fals=
e)) {
@@ -284,11 +392,29 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
     return 0;
 }
=20
+/*
+ * Radix tree translation is a 2 steps translation process:
+ *
+ * 1. Process-scoped translation:   Guest Eff Addr  -> Guest Real Addr
+ * 2. Partition-scoped translation: Guest Real Addr -> Host Real Addr
+ *
+ *                                  MSR[HV]
+ *              +-------------+----------------+---------------+
+ *              |             |     HV =3D 0     |     HV =3D 1    |
+ *              +-------------+----------------+---------------+
+ *              | Relocation  |    Partition   |      No       |
+ *              | =3D Off       |     Scoped     |  Translation  |
+ *  Relocation  +-------------+----------------+---------------+
+ *              | Relocation  |   Partition &  |    Process    |
+ *              | =3D On        | Process Scoped |    Scoped     |
+ *              +-------------+----------------+---------------+
+ */
 static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool relocation,
                              hwaddr *raddr, int *psizep, int *protp,
                              bool cause_excp)
 {
+    CPUPPCState *env =3D &cpu->env;
     uint64_t lpid =3D 0, pid =3D 0;
     ppc_v3_pate_t pate;
     int psize, prot;
@@ -320,11 +446,6 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr =
eaddr, int rwx,
             }
             return 1;
         }
-        /* We don't support guest mode yet */
-        if (lpid !=3D 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-        }
     }
=20
     *psizep =3D INT_MAX;
@@ -335,6 +456,8 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr e=
addr, int rwx,
      *
      * - Translates an effective address to a host real address in
      *   quadrants 0 and 3 when HV=3D1.
+     *
+     * - Translates an effective address to a guest real address.
      */
     if (relocation) {
         int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pi=
d,
@@ -349,7 +472,24 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr =
eaddr, int rwx,
         g_raddr =3D eaddr & R_EADDR_MASK;
     }
=20
-    *raddr =3D g_raddr;
+    /*
+     * Perform partition-scoped translation if !HV or HV access to
+     * quadrants 1 or 2. Translates a guest real address to a host
+     * real address.
+     */
+    if ((lpid !=3D 0) || (!cpu->vhyp && !msr_hv)) {
+        int ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
+                                                     pate, raddr, &prot,=
 &psize,
+                                                     0, cause_excp);
+        if (ret) {
+            return ret;
+        }
+        *psizep =3D MIN(*psizep, psize);
+        *protp &=3D prot;
+    } else {
+        *raddr =3D g_raddr;
+    }
+
     return 0;
 }
=20
--=20
2.21.1


