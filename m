Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E6C5ACC4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BE921D56
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PAyKlyz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BE921D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4cU8-0002Kf-44
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 22:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR7-0004bY-Ig
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR6-0008L9-Ab
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55797 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4cR5-0008IC-Ur; Wed, 19 Feb 2020 22:23:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NKg05Dj2z9sST; Thu, 20 Feb 2020 14:23:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582169004;
 bh=0lvTfXqoiUNxVPWrgRrJhN5mbXpUL6Tid8JMNpe1p8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PAyKlyz3rNomo5ok2C5C61dHmDZoAcp+O7+iOkfDzdYVYmoJkX/WIRriPTo1x9NLE
 w+pX9LBgD4dc3ZnNV59FA0i4VHo6tn7q6F+1GF84R5/2s3QEuUq5ZzciVgzNGmVAss
 XTc0xSiINEGzCcyT7g+fwMReX2wGmNmIelwV6JtU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	groug@kaod.org,
	clg@kaod.org
Subject: [PATCH v5 05/18] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Date: Thu, 20 Feb 2020 14:23:03 +1100
Message-Id: <20200220032317.96884-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220032317.96884-1-david@gibson.dropbear.id.au>
References: <20200220032317.96884-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the "pseries" machine, we use "virtual hypervisor" mode where we
only model the CPU in non-hypervisor privileged mode.  This means that
we need guest physical addresses within the modelled cpu to be treated
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
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 6 +-----
 target/ppc/mmu-hash64.c | 8 --------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d09125d9af..ea5e11f1d9 100644
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
index 0f9c0149e8..71e08801cc 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1126,14 +1126,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong =
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


