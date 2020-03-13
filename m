Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6407CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22070206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Gfs3wPNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22070206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbb4-0004gw-AT
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 00:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba7-0003Pg-7c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba6-000767-3i
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:55 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCba5-0006rh-4P; Fri, 13 Mar 2020 00:05:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dsYj2Hb5z9sSV; Fri, 13 Mar 2020 15:05:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584072345;
 bh=lA1CWq6sTkYH0ckLD0jbjNno+xackfvWz9OnWzmHeU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gfs3wPNxtW/ijFL365hm7QA99qkUsyyvuShTxzbSp9UOZpQwIC0u+dR1K6Zr5VGoa
 ERxcdun0ujwsuMTjnZtKBwOjhC0XV6Qr8ZeZDxFYFHud/H2p2xgakJ1FPLEJoWgmwi
 2ja21SIfHd1MOTbjebS3U8KIkaM1zRmRc8I2paR8=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com
Subject: [PATCH 2/4] spapr: Move creation of ibm,architecture-vec-5 property
Date: Fri, 13 Mar 2020 15:05:37 +1100
Message-Id: <20200313040539.819138-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313040539.819138-1-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is currently called from spapr_dt_cas_updates() which is a hang over
from when we created this only as a diff to the DT at CAS time.  Now that
we fully rebuild the DT at CAS time, just create it alon with the rest
of the properties in /chosen.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 66289ffef5..fc28d9df25 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -889,22 +889,6 @@ static int spapr_rng_populate_dt(void *fdt)
     return ret ? -1 : 0;
 }
=20
-static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
-                                SpaprOptionVector *ov5_updates)
-{
-    int offset;
-
-    offset =3D fdt_path_offset(fdt, "/chosen");
-    if (offset < 0) {
-        offset =3D fdt_add_subnode(fdt, 0, "chosen");
-        if (offset < 0) {
-            return offset;
-        }
-    }
-    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
-                                  "ibm,architecture-vec-5");
-}
-
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms =3D MACHINE(spapr);
@@ -1115,6 +1099,9 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
=20
     spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
+    _FDT(spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
+                                "ibm,architecture-vec-5"));
+
     g_free(stdout_path);
     g_free(bootlist);
 }
@@ -1263,13 +1250,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bo=
ol reset, size_t space)
         }
     }
=20
-    /* ibm,client-architecture-support updates */
-    ret =3D spapr_dt_cas_updates(spapr, fdt, spapr->ov5_cas);
-    if (ret < 0) {
-        error_report("couldn't setup CAS properties fdt");
-        exit(1);
-    }
-
     if (smc->dr_phb_enabled) {
         ret =3D spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
         if (ret < 0) {
--=20
2.24.1


