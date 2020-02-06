Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F124C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BAF20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BAF20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfKq-00077L-RQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1izfJU-0005ow-FT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1izfJT-0008N3-2p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:16 -0500
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:56382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1izfJS-0008Gm-ST
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:15 -0500
Received: from player788.ha.ovh.net (unknown [10.108.35.215])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id ED3C31ADD10
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 12:27:12 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 6CA72F1A6DD3;
 Thu,  6 Feb 2020 11:27:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] aspeed/smc: Fix User mode select/unselect scheme
Date: Thu,  6 Feb 2020 12:26:45 +0100
Message-Id: <20200206112645.21275-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206112645.21275-1-clg@kaod.org>
References: <20200206112645.21275-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17874786922089712401
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheefgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.108.172
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Andrew Geissler <geissonator@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Aspeed SMC Controller can operate in different modes : Read, Fast
Read, Write and User modes. When the User mode is configured, it
selects automatically the SPI slave device until the CE_STOP_ACTIVE
bit is set to 1. When any other modes are configured the device is
unselected. The HW logic handles the chip select automatically when
the flash is accessed through its AHB window.

When configuring the CEx Control Register, the User mode logic to
select and unselect the slave is incorrect and data corruption can be
seen on machines using two chips, witherspoon and romulus.

Rework the handler setting the CEx Control Register to fix this issue.

Fixes: 7c1c69bca43c ("ast2400: add SMC controllers (FMC and SPI)")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 39 +++++++++++++++++++++++----------------
 hw/ssi/trace-events |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index e5621bf728ca..32be2a02b0e4 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -639,27 +639,23 @@ static inline int aspeed_smc_flash_is_4byte(const A=
speedSMCFlash *fl)
     }
 }
=20
-static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl=
)
+static void aspeed_smc_flash_do_select(AspeedSMCFlash *fl, bool unselect=
)
 {
-    const AspeedSMCState *s =3D fl->controller;
+    AspeedSMCState *s =3D fl->controller;
+
+    trace_aspeed_smc_flash_select(fl->id, unselect ? "un" : "");
=20
-    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
+    qemu_set_irq(s->cs_lines[fl->id], unselect);
 }
=20
 static void aspeed_smc_flash_select(AspeedSMCFlash *fl)
 {
-    AspeedSMCState *s =3D fl->controller;
-
-    s->regs[s->r_ctrl0 + fl->id] &=3D ~CTRL_CE_STOP_ACTIVE;
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    aspeed_smc_flash_do_select(fl, false);
 }
=20
 static void aspeed_smc_flash_unselect(AspeedSMCFlash *fl)
 {
-    AspeedSMCState *s =3D fl->controller;
-
-    s->regs[s->r_ctrl0 + fl->id] |=3D CTRL_CE_STOP_ACTIVE;
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    aspeed_smc_flash_do_select(fl, true);
 }
=20
 static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
@@ -911,13 +907,25 @@ static const MemoryRegionOps aspeed_smc_flash_ops =3D=
 {
     },
 };
=20
-static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
+static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t va=
lue)
 {
     AspeedSMCState *s =3D fl->controller;
+    bool unselect;
+
+    /* User mode selects the CS, other modes unselect */
+    unselect =3D (value & CTRL_CMD_MODE_MASK) !=3D CTRL_USERMODE;
+
+    /* A change of CTRL_CE_STOP_ACTIVE from 0 to 1, unselects the CS */
+    if (!(s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE) &&
+        value & CTRL_CE_STOP_ACTIVE) {
+        unselect =3D true;
+    }
+
+    s->regs[s->r_ctrl0 + fl->id] =3D value;
=20
-    s->snoop_index =3D aspeed_smc_is_ce_stop_active(fl) ? SNOOP_OFF : SN=
OOP_START;
+    s->snoop_index =3D unselect ? SNOOP_OFF : SNOOP_START;
=20
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    aspeed_smc_flash_do_select(fl, unselect);
 }
=20
 static void aspeed_smc_reset(DeviceState *d)
@@ -1249,8 +1257,7 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
         s->regs[addr] =3D value;
     } else if (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
         int cs =3D addr - s->r_ctrl0;
-        s->regs[addr] =3D value;
-        aspeed_smc_flash_update_cs(&s->flashes[cs]);
+        aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
     } else if (addr >=3D R_SEG_ADDR0 &&
                addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
         int cs =3D addr - R_SEG_ADDR0;
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index ffe531a500aa..0a70629801a9 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -7,3 +7,4 @@ aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t s=
ize, uint64_t data, int
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRI=
x64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
 aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
+aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
--=20
2.21.1


