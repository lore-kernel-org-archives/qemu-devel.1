Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54297C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC2920718
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC2920718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeai-0004WW-LJ
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePr-0000Ba-DW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVePq-0000qs-3r
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:47 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:50037)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVePp-0000qi-Tz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:46 -0500
Received: from player787.ha.ovh.net (unknown [10.108.35.159])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 53B171ECA1F
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:44 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id DB0C8C444A69;
 Fri, 15 Nov 2019 16:25:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 10/23] ppc/pnv: Loop on the threads of the chip to
 find a matching NVT
Date: Fri, 15 Nov 2019 17:24:23 +0100
Message-Id: <20191115162436.30548-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15098317754299157478
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.26
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
---
 include/hw/ppc/pnv.h |  2 ++
 hw/intc/pnv_xive.c   | 63 ++++++++++++++++++++++++++------------------
 hw/ppc/pnv.c         |  2 +-
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 07c56c05ad30..58f4dcc0b71d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -150,6 +150,8 @@ typedef struct PnvChipClass {
  */
 #define PNV_CHIP_HWID(i) ((((i) & 0x3e) << 3) | ((i) & 0x1))
=20
+const char *pnv_chip_core_typename(const PnvChip *chip);
+
 /*
  * Converts back a HW chip id to an index. This is useful to calculate
  * the MMIO addresses of some controllers which depend on the chip id.
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 087cbfbaad48..71ca4961b6b1 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -377,34 +377,45 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
                               bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
-    CPUState *cs;
+    PnvXive *xive =3D PNV_XIVE(xptr);
+    PnvChip *chip =3D xive->chip;
+    const char *typename =3D pnv_chip_core_typename(chip);
+    size_t typesize =3D object_type_get_instance_size(typename);
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
+        PnvCore *pc =3D PNV_CORE(chip->cores + i * typesize);
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 57f924ba0466..94c9f536413f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -64,7 +64,7 @@
 #define INITRD_LOAD_ADDR        0x60000000
 #define INITRD_MAX_SIZE         (256 * MiB)
=20
-static const char *pnv_chip_core_typename(const PnvChip *o)
+const char *pnv_chip_core_typename(const PnvChip *o)
 {
     const char *chip_type =3D object_class_get_name(object_get_class(OBJ=
ECT(o)));
     int len =3D strlen(chip_type) - strlen(PNV_CHIP_TYPE_SUFFIX);
--=20
2.21.0


