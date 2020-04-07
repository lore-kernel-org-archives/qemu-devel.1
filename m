Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF7C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ADC20748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LdhVJJB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ADC20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLg0u-0004V1-8b
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyK-0007xt-Tx
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyJ-0004B8-NY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyH-00045R-R2; Tue, 07 Apr 2020 00:36:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K2lkPz9sSY; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=X5Ej82Y7wUl4ZiHOQRagKSHMjnjSw840CrcPTymZoeM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LdhVJJB0WEZ1l3e+NvqMZ7O+2w4IpyEnrv98VUBw8Ew5fdfz4Lf2TD56ww+iYOPge
 awOXTgbfgqs9dDIJbmuytL7bLmDnsJBD9y8fB8B887M83ra364Jh62NMI3sA3IuLVL
 6cdavnQFc/LMGdwAY6EDwne80ofAXjbjrK06y/cY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/10] ppc/spapr: Improve FWNMI machine check delivery corner
 case comments
Date: Tue,  7 Apr 2020 14:36:00 +1000
Message-Id: <20200407043606.291546-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Some of the conditions are not as clearly documented as they could be.
Also the non-FWNMI case does not need a large comment.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200325142906.221248-3-npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index a4a540f43d..a908c5d0e9 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -860,17 +860,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool reco=
vered)
     Error *local_err =3D NULL;
=20
     if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
-        /*
-         * This implies that we have hit a machine check either when the
-         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
-         * called) or between system reset and "ibm,nmi-register".
-         * Fall back to the old machine check behavior in such cases.
-         */
+        /* Non-FWNMI case, deliver it like an architected CPU interrupt.=
 */
         cs->exception_index =3D POWERPC_EXCP_MCHECK;
         ppc_cpu_do_interrupt(cs);
         return;
     }
=20
+    /* Wait for FWNMI interlock. */
     while (spapr->fwnmi_machine_check_interlock !=3D -1) {
         /*
          * Check whether the same CPU got machine check error
@@ -882,8 +878,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
             return;
         }
         qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_co=
nd);
-        /* Meanwhile if the system is reset, then just return */
         if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
+            /*
+             * If the machine was reset while waiting for the interlock,
+             * abort the delivery. The machine check applies to a contex=
t
+             * that no longer exists, so it wouldn't make sense to deliv=
er
+             * it now.
+             */
             return;
         }
     }
@@ -894,7 +895,9 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
          * We don't want to abort so we let the migration to continue.
          * In a rare case, the machine check handler will run on the tar=
get.
          * Though this is not preferable, it is better than aborting
-         * the migration or killing the VM.
+         * the migration or killing the VM. It is okay to call
+         * migrate_del_blocker on a blocker that was not added (which th=
e
+         * nmi-interlock handler would do when it's called after this).
          */
         warn_report("Received a fwnmi while migration was in progress");
     }
--=20
2.25.2


