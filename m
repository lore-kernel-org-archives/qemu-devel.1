Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210EB20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210EB20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40809 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8Rj-0000LQ-Oy
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8Ko-00022f-PV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8Km-0001Ib-Mw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:58:58 -0500
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:56521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8Km-0001I0-E7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:58:56 -0500
Received: from player697.ha.ovh.net (unknown [10.108.57.18])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7B5BB13DBFE
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:58:55 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id DC7C0C809465;
 Mon, 25 Nov 2019 06:58:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 04/20] ppc/pnv: Loop on the threads of the chip to find a
 matching NVT
Date: Mon, 25 Nov 2019 07:58:04 +0100
Message-Id: <20191125065820.927-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8912342187657759718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.49.208
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU_FOREACH() loops on all the CPUs of the machine which is incorrect.
Each XIVE Presenter should scan only the HW threads of the chip it
belongs to.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 61 ++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 8055de89cf63..9798bd9e729f 100644
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
2.21.0


