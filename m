Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA85C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E5E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Aus/naQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9ey-0004gw-SX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96r-0002xR-UQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96q-0002Eh-I8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:06:05 -0400
Received: from ozlabs.org ([203.11.71.1]:37583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96o-0008EI-8Y; Tue, 17 Mar 2020 06:06:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL36CyJz9sTf; Tue, 17 Mar 2020 21:04:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439483;
 bh=gKwYQwb5HTXse/b5oCF+Tl+1Y9dBwynzr4Ti010BJdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Aus/naQ/cFH7OfOJV1sxcMZXH86fQtHSvjRYazNFJCE/Iq8P1vr7xcl2j4O00UP5i
 k3cYxL3/x9H/1Aykan+l3v00laL0xDRpwB6674RhrmpxUQZ2oYu8TzKdn1Wkyb6lwS
 eC5jxtiOxe4A5DS0MLN2AuEDLFTN53Ssa6oOsFH0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 44/45] ppc/spapr: Ignore common "ibm,nmi-interlock" Linux bug
Date: Tue, 17 Mar 2020 21:04:22 +1100
Message-Id: <20200317100423.622643-45-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Linux kernels call "ibm,nmi-interlock" in their system reset handlers
contrary to PAPR. Returning an error because the CPU does not hold the
interlock here causes Linux to print warning messages. PowerVM returns
success in this case, so do the same for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-9-npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 521e6b0b72..9fb8c8632a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -461,8 +461,18 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
     }
=20
     if (spapr->fwnmi_machine_check_interlock !=3D cpu->vcpu_id) {
-        /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" *=
/
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        /*
+	 * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
+         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interloc=
k"
+	 * for system reset interrupts, despite them not being interlocked.
+	 * PowerVM silently ignores this and returns success here. Returning
+	 * failure causes Linux to print the error "FWNMI: nmi-interlock
+	 * failed: -3", although no other apparent ill effects, this is a
+	 * regression for the user when enabling FWNMI. So for now, match
+	 * PowerVM. When most Linux clients are fixed, this could be
+	 * changed.
+	 */
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
         return;
     }
=20
--=20
2.24.1


