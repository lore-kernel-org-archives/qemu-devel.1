Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BE1C3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799BD2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Y06O8cdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799BD2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV0p-0008CO-IQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxP-0002TG-AP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxN-0002bN-Uw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:39 -0500
Received: from ozlabs.org ([203.11.71.1]:53915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxN-0002Ud-JR; Mon, 03 Feb 2020 01:11:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBn02v9z9sSQ; Mon,  3 Feb 2020 17:11:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710289;
 bh=xwNu4FGfWX/egNgtR4ivugsA4AmzcHorSgS/59pdGpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y06O8cdFbWiDqTL/TX0vvPygHiBkBb6aswuHIU6t0rM1rf6kX7CzL8+RRNS68LTtE
 VY3Xl02jfQFNmptbexEqk2x2oDqNZ0ghw511lHY2yRD546P5kEAXxOMNK6FHHhySqX
 qVzW57PSW3SjQOhy9RclbnsWb6A4HimNZAroBJ+0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/35] ppc/pnv: Add support for HRMOR on Radix host
Date: Mon,  3 Feb 2020 17:10:58 +1100
Message-Id: <20200203061123.59150-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When in HV mode, if EA[0] is 0, the Hypervisor Offset Real Mode
Register controls the access.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200127144154.10170-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 066e324464..224e646c50 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -235,6 +235,12 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
         /* In real mode top 4 effective addr bits (mostly) ignored */
         raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
=20
+        /* In HV mode, add HRMOR if top EA bit is clear */
+        if (msr_hv || !env->has_hv_mode) {
+            if (!(eaddr >> 63)) {
+                raddr |=3D env->spr[SPR_HRMOR];
+           }
+        }
         tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_M=
ASK,
                      PAGE_READ | PAGE_WRITE | PAGE_EXEC, mmu_idx,
                      TARGET_PAGE_SIZE);
--=20
2.24.1


