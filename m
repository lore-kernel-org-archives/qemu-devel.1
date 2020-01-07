Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E9EC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B59207FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KxTiFHSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B59207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iohCl-0006jg-5X
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 00:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iognO-0005P5-Fb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 23:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iognM-0004hg-R0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 23:48:46 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iognM-0004cX-GD; Mon, 06 Jan 2020 23:48:44 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sKdX4cptz9sRh; Tue,  7 Jan 2020 15:48:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578372512;
 bh=pOhF9Y4Db6T7gymFJzNkWvkw/xq6Ps53OMhtnsGSzic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KxTiFHSImnyNIq+cIMIL38Cenv3EGiD9e4IEREgxj8BtN15GcG8pKefI6vQTnnsiX
 0FrPEU0YZ40Xc0gO502NvQULN9dFzskwv1VlOfV63Obe7PUT3ic878Q3K3/vY2/BU9
 Gqim69ipfz/BaykTclnhQGUSPG2sTl+MV7xzvYc4=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	groug@kaod.org,
	philmd@redhat.com,
	clg@kaod.org
Subject: [PATCH v2 05/10] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Date: Tue,  7 Jan 2020 15:48:22 +1100
Message-Id: <20200107044827.471355-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107044827.471355-1-david@gibson.dropbear.id.au>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the "pseries" machine, we use "virtual hypervisor" mode where we only
model the CPU in non-hypervisor privileged mode.  This means that we need
guest physical addresses within the modelled within the cpu to be treated
as absolute physical addresses.

We used to do that by clearing LPCR[VPM0] and setting LPCR[RMLS] to a hig=
h
limit so that the old offset based translation for guest mode applied,
which does what we need.  However, POWER9 has removed support for that
translation mode, which meant we had some ugly hacks to keep it working.

We now explicitly handle this sort of translation for virtual hypervisor
mode, so the hacks aren't necessary.  We don't need to set VPM0 and RMLS
from the machine type code - they're now ignored in vhyp mode.  On the cp=
u
side we don't need to allow LPCR[RMLS] to be set on POWER9 in vhyp mode -
that was only there to allow the hack on the machine side.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 6 +-----
 target/ppc/mmu-hash64.c | 8 --------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 8339c4c0f8..daebcd9f38 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -58,14 +58,10 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
      * we don't get spurious wakups before an RTAS start-cpu call.
      * For the same reason, set PSSCR_EC.
      */
-    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_=
pm);
+    lpcr &=3D ~(LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
     lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
     env->spr[SPR_PSSCR] |=3D PSSCR_EC;
=20
-    /* Set RMLS to the max (ie, 16G) */
-    lpcr &=3D ~LPCR_RMLS;
-    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
-
     ppc_store_lpcr(cpu, lpcr);
=20
     /* Set a full AMOR so guest can use the AMR as it sees fit */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d878180df5..d7f9933e6d 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1124,14 +1124,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong =
val)
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
-        /*
-         * If we have a virtual hypervisor, we need to bring back RMLS. =
It
-         * doesn't exist on an actual P9 but that's all we know how to
-         * configure with softmmu at the moment
-         */
-        if (cpu->vhyp) {
-            lpcr |=3D (val & LPCR_RMLS);
-        }
         break;
     default:
         g_assert_not_reached();
--=20
2.24.1


