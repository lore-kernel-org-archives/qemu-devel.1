Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D34C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384BD20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KhdT80b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384BD20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih52u-00034q-UM
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ia-0000LX-Fu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iZ-0005vz-8B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:20 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36987 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iY-0005Zd-Tf; Mon, 16 Dec 2019 23:44:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWV3DSZz9sSl; Tue, 17 Dec 2019 15:43:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557814;
 bh=SF6fWedF+5KWjn9BhcYbOsSQqaIC10oX6/pQpr5822g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KhdT80b8J/NZIKjKnnWmeVf2v3Q4fjbt1LyhWBUUopSdAXiEMMXX5VxJOa//wkvtX
 81g7wFGb9rrfN0868oz3lMe9dCzoVzmvyeRTffWEQ7sX1biomPfKh58njQBg/9xwyM
 7JyhB0aRjcYzisV4lFbP+H6hIU3pEDAJ+zIDuP0Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 30/88] ppc/pnv: Loop on the threads of the chip to find a
 matching NVT
Date: Tue, 17 Dec 2019 15:42:24 +1100
Message-Id: <20191217044322.351838-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

CPU_FOREACH() loops on all the CPUs of the machine which is incorrect.
Each XIVE Presenter should scan only the HW threads of the chip it
belongs to.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c | 61 ++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 8055de89cf..9798bd9e72 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -377,34 +377,43 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
                               bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
-    CPUState *cs;
+    PnvXive *xive =3D PNV_XIVE(xptr);
+    PnvChip *chip =3D xive->chip;
     int count =3D 0;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-        int ring;
-
-        /*
-         * Check the thread context CAM lines and record matches.
-         */
-        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
-                                         cam_ignore, logic_serv);
-        /*
-         * Save the context and follow on to catch duplicates, that we
-         * don't support yet.
-         */
-        if (ring !=3D -1) {
-            if (match->tctx) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
-                              "thread context NVT %x/%x\n",
-                              nvt_blk, nvt_idx);
-                return -1;
+    int i, j;
+
+    for (i =3D 0; i < chip->nr_cores; i++) {
+        PnvCore *pc =3D chip->cores[i];
+        CPUCore *cc =3D CPU_CORE(pc);
+
+        for (j =3D 0; j < cc->nr_threads; j++) {
+            PowerPCCPU *cpu =3D pc->threads[j];
+            XiveTCTX *tctx;
+            int ring;
+
+            tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+            /*
+             * Check the thread context CAM lines and record matches.
+             */
+            ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_b=
lk,
+                                             nvt_idx, cam_ignore, logic_=
serv);
+            /*
+             * Save the context and follow on to catch duplicates, that =
we
+             * don't support yet.
+             */
+            if (ring !=3D -1) {
+                if (match->tctx) {
+                    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found =
a "
+                                  "thread context NVT %x/%x\n",
+                                  nvt_blk, nvt_idx);
+                    return -1;
+                }
+
+                match->ring =3D ring;
+                match->tctx =3D tctx;
+                count++;
             }
-
-            match->ring =3D ring;
-            match->tctx =3D tctx;
-            count++;
         }
     }
=20
--=20
2.23.0


