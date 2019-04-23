Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD537C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00CA206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00CA206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIv8t-00020i-VX
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 09:07:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hIsJm-0004bx-Jo
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hIsFj-0000S2-LI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:02:16 -0400
Received: from [93.153.64.87] (port=40118 helo=gorgo)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jermar@gorgo>) id 1hIsFj-0000JY-2V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:02:15 -0400
Received: from gorgo (localhost.localdomain [127.0.0.1])
	by gorgo (8.15.2/8.15.2) with ESMTPS id x3N9Re501254771
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2019 11:27:40 +0200
Received: (from jermar@localhost)
	by gorgo (8.15.2/8.15.2/Submit) id x3N9ReLw1254733;
	Tue, 23 Apr 2019 11:27:40 +0200
From: =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub.jermar@kernkonzept.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 11:26:02 +0200
Message-Id: <20190423092602.1254515-1-jakub.jermar@kernkonzept.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gorgo id x3N9Re501254771
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 93.153.64.87
X-Mailman-Approved-At: Tue, 23 Apr 2019 09:04:25 -0400
Subject: [Qemu-devel] [PATCH] mips: Decide to map PAGE_EXEC in map_address
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
Message-ID: <20190423092602.8EYz_jaOjEZNbjXp_cDJ_AqNhaQ-sFk2-Ccls7ZmzXc@z>

This commit addresses QEMU Bug #1825311:

  mips_cpu_handle_mmu_fault renders all accessed pages executable

It allows finer-grained control over whether the accessed page should be
executable by moving the decision to the underlying map_address
function, which has more information for this.

As a result, pages that have the XI bit set in the TLB and are accessed
for read/write, don't suddenly end up being executable.

Signed-off-by: Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
---
 target/mips/helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index c44cdca3b5..f182935fcf 100644
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
@@ -101,6 +101,8 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physi=
cal, int *prot,
                 *prot =3D PAGE_READ;
                 if (n ? tlb->D1 : tlb->D0)
                     *prot |=3D PAGE_WRITE;
+                if (!(n ? tlb->XI1 : tlb->XI0))
+                    *prot |=3D PAGE_EXEC;
                 return TLBRET_MATCH;
             }
             return TLBRET_DIRTY;
@@ -182,7 +184,7 @@ static int get_seg_physical_address(CPUMIPSState *env=
, hwaddr *physical,
     } else {
         /* The segment is unmapped */
         *physical =3D physical_base | (real_address & segmask);
-        *prot =3D PAGE_READ | PAGE_WRITE;
+        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TLBRET_MATCH;
     }
 }
@@ -913,8 +915,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr add=
ress, int size, int rw,
     }
     if (ret =3D=3D TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
+                     TARGET_PAGE_SIZE);
         ret =3D 0;
     } else if (ret < 0)
 #endif
@@ -936,8 +938,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr add=
ress, int size, int rw,
                                            address, rw, access_type, mmu=
_idx);
                 if (ret =3D=3D TLBRET_MATCH) {
                     tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                            physical & TARGET_PAGE_MASK, prot | PAGE_EXE=
C,
-                            mmu_idx, TARGET_PAGE_SIZE);
+                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
+                            TARGET_PAGE_SIZE);
                     ret =3D 0;
                     return ret;
                 }
--=20
2.20.1


