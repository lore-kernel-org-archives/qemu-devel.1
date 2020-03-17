Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BDFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9771120663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jqj9t+wQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9771120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9ci-0000hi-Mg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96Y-0002TJ-Jt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96X-0000GX-0R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:46 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51335 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96W-00068N-Gw; Tue, 17 Mar 2020 06:05:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL23GBZz9sTY; Tue, 17 Mar 2020 21:04:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439482;
 bh=mIsHUpFrAFGza27JGR43LmGf3jqwhFuZkDmxkORmg/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jqj9t+wQWiRoAgbmZl0u41GOl63uTFTX7s8cbsztwMNQvV1m4lZyN/VpJBZQCpLmC
 xxR8tpo+TsLKq1RsnoErDYSxRyUSZ11Bqe2gsL0pbwfHIN5hQZZcj3/ULdZMTX9GsA
 XYSfePumh+O9wBSy91fUkGHZhQbCDoYrityuGbSM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 39/45] ppc/spapr: Add FWNMI System Reset state
Date: Tue, 17 Mar 2020 21:04:17 +1100
Message-Id: <20200317100423.622643-40-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

The FWNMI option must deliver system reset interrupts to their
registered address, and there are a few constraints on the handler
addresses specified in PAPR. Add the system reset address state and
checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-4-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviwed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_rtas.c    | 14 +++++++++++++-
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 822dea8118..d22bf54baf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1688,6 +1688,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
=20
     spapr->cas_reboot =3D false;
=20
+    spapr->fwnmi_system_reset_addr =3D -1;
     spapr->fwnmi_machine_check_addr =3D -1;
     spapr->fwnmi_machine_check_interlock =3D -1;
=20
@@ -2007,6 +2008,7 @@ static const VMStateDescription vmstate_spapr_fwnmi=
 =3D {
     .needed =3D spapr_fwnmi_needed,
     .pre_save =3D spapr_fwnmi_pre_save,
     .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
         VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
         VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0b8c481593..521e6b0b72 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -414,6 +414,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
                                   uint32_t nret, target_ulong rets)
 {
     hwaddr rtas_addr;
+    target_ulong sreset_addr, mce_addr;
=20
     if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_OFF) {
         rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
@@ -426,7 +427,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
=20
-    spapr->fwnmi_machine_check_addr =3D rtas_ld(args, 1);
+    sreset_addr =3D rtas_ld(args, 0);
+    mce_addr =3D rtas_ld(args, 1);
+
+    /* PAPR requires these are in the first 32M of memory and within RMA=
 */
+    if (sreset_addr >=3D 32 * MiB || sreset_addr >=3D spapr->rma_size ||
+           mce_addr >=3D 32 * MiB ||    mce_addr >=3D spapr->rma_size) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    spapr->fwnmi_system_reset_addr =3D sreset_addr;
+    spapr->fwnmi_machine_check_addr =3D mce_addr;
=20
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 64b83402cb..42d64a0368 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -194,9 +194,10 @@ struct SpaprMachineState {
=20
     /* State related to FWNMI option */
=20
-    /* Machine Check Notification Routine address
+    /* System Reset and Machine Check Notification Routine addresses
      * registered by "ibm,nmi-register" RTAS call.
      */
+    target_ulong fwnmi_system_reset_addr;
     target_ulong fwnmi_machine_check_addr;
=20
     /* Machine Check FWNMI synchronization, fwnmi_machine_check_interloc=
k is
--=20
2.24.1


