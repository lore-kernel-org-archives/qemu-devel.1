Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EADC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5070420748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W+mhxOeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5070420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLg2N-0006NT-H6
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyN-0007zs-Gv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyM-0004EU-4y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyL-0004Bi-Ps; Tue, 07 Apr 2020 00:36:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K3SH6z9sSb; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=DUnTri7UMEV9sPL1R6ffZJAUsoqegh6MBdGQbtcDAxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W+mhxOeMtJvqlhPBm0agJzRIEoupKGsXeppToXgisYD2ACkiW+emDykx0FTMYNl4T
 prp6bJJUkg2cALl3URuOM31HW5bqjCpkoy0up/MQOvZ5DTXDzfTcrxjnJPkpSFtV46
 g9zgkmNYk8ynjaryW2OaCLT9RCYFq3lgKMaWDIKs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/10] ppc/spapr: Don't kill the guest if a recovered FWNMI
 machine check delivery fails
Date: Tue,  7 Apr 2020 14:36:02 +1000
Message-Id: <20200407043606.291546-7-david@gibson.dropbear.id.au>
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

Try to be tolerant of FWNMI delivery errors if the machine check had been
recovered by the host.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200325142906.221248-5-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Updated comment at Greg's suggestion]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index c8964eb25d..1069d0197b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -833,13 +833,28 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu=
, bool recovered)
     /* get rtas addr from fdt */
     rtas_addr =3D spapr_get_rtas_addr();
     if (!rtas_addr) {
-        error_report(
+        if (!recovered) {
+            error_report(
 "FWNMI: Unable to deliver machine check to guest: rtas_addr not found.")=
;
-        qemu_system_guest_panicked(NULL);
+            qemu_system_guest_panicked(NULL);
+        } else {
+            warn_report(
+"FWNMI: Unable to deliver machine check to guest: rtas_addr not found. "
+"Machine check recovered.");
+        }
         g_free(ext_elog);
         return;
     }
=20
+    /*
+     * By taking the interlock, we assume that the MCE will be
+     * delivered to the guest. CAUTION: don't add anything that could
+     * prevent the MCE to be delivered after this line, otherwise the
+     * guest won't be able to release the interlock and ultimately
+     * hang/crash?
+     */
+    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
+
     stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET=
,
                 env->gpr[3]);
     cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
@@ -876,9 +891,15 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
          * that CPU called "ibm,nmi-interlock")
          */
         if (spapr->fwnmi_machine_check_interlock =3D=3D cpu->vcpu_id) {
-            error_report(
+            if (!recovered) {
+                error_report(
 "FWNMI: Unable to deliver machine check to guest: nested machine check."=
);
-            qemu_system_guest_panicked(NULL);
+                qemu_system_guest_panicked(NULL);
+            } else {
+                warn_report(
+"FWNMI: Unable to deliver machine check to guest: nested machine check. =
"
+"Machine check recovered.");
+            }
             return;
         }
         qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_co=
nd);
@@ -906,7 +927,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
         warn_report("Received a fwnmi while migration was in progress");
     }
=20
-    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
     spapr_mce_dispatch_elog(cpu, recovered);
 }
=20
--=20
2.25.2


