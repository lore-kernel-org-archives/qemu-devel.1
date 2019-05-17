Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42CC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 12:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E073020881
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 12:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E073020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcPm-0008FK-Sc
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 08:56:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hRcP2-0007hG-DJ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hRcP0-00081v-GY
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:55:59 -0400
Received: from 89-24-57-155.nat.epc.tmcz.cz ([89.24.57.155]:28926 helo=gorgo)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jermar@gorgo>) id 1hRcOy-0007h8-GZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:55:57 -0400
Received: from gorgo (localhost.localdomain [127.0.0.1])
	by gorgo (8.15.2/8.15.2) with ESMTPS id x4HCarGY868599
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 May 2019 14:36:53 +0200
Received: (from jermar@localhost)
	by gorgo (8.15.2/8.15.2/Submit) id x4HCapHV868540;
	Fri, 17 May 2019 14:36:51 +0200
From: =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub.jermar@kernkonzept.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 14:35:33 +0200
Message-Id: <20190517123533.868479-1-jakub.jermar@kernkonzept.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gorgo id x4HCarGY868599
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 89.24.57.155
Subject: [Qemu-devel] [PATCH v3] mips: Decide to map PAGE_EXEC in map_address
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
Cc: =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub.jermar@kernkonzept.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit addresses QEMU Bug #1825311:

  mips_cpu_handle_mmu_fault renders all accessed pages executable

It allows finer-grained control over whether the accessed page should be
executable by moving the decision to the underlying map_address
function, which has more information for this.

As a result, pages that have the XI bit set in the TLB and are accessed
for read/write, don't suddenly end up being executable.

Signed-off-by: Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
---

 Changes since v2:
=20
 This is the same patch as v2, but rebased to current master.

 target/mips/helper.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 9799f2ede1..68e44df4da 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *phys=
ical, int *prot,
                         target_ulong address, int rw, int access_type)
 {
     *physical =3D address;
-    *prot =3D PAGE_READ | PAGE_WRITE;
+    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
=20
@@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *p=
hysical, int *prot,
     else
         *physical =3D address;
=20
-    *prot =3D PAGE_READ | PAGE_WRITE;
+    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
=20
@@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physi=
cal, int *prot,
                 *prot =3D PAGE_READ;
                 if (n ? tlb->D1 : tlb->D0)
                     *prot |=3D PAGE_WRITE;
+                if (!(n ? tlb->XI1 : tlb->XI0)) {
+                    *prot |=3D PAGE_EXEC;
+                }
                 return TLBRET_MATCH;
             }
             return TLBRET_DIRTY;
@@ -182,7 +185,7 @@ static int get_seg_physical_address(CPUMIPSState *env=
, hwaddr *physical,
     } else {
         /* The segment is unmapped */
         *physical =3D physical_base | (real_address & segmask);
-        *prot =3D PAGE_READ | PAGE_WRITE;
+        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TLBRET_MATCH;
     }
 }
@@ -907,7 +910,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
     }
     if (ret =3D=3D TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
+                     physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
@@ -927,7 +930,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
                                        access_type, mips_access_type, mm=
u_idx);
             if (ret =3D=3D TLBRET_MATCH) {
                 tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                             physical & TARGET_PAGE_MASK, prot | PAGE_EX=
EC,
+                             physical & TARGET_PAGE_MASK, prot,
                              mmu_idx, TARGET_PAGE_SIZE);
                 return true;
             }
--=20
2.20.1


