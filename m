Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD3C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678FC206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678FC206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8L9W-0007r9-Ma
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2z-0001Wc-LT; Wed, 19 Aug 2020 06:10:21 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:38671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2u-0006ZB-2T; Wed, 19 Aug 2020 06:10:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.221])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id B44985892854;
 Wed, 19 Aug 2020 12:10:09 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 12:10:08 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004deb20b99-5ee6-4250-b1d1-233a85c47f8c,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/21] ftgmac100: Improve software reset
Date: Wed, 19 Aug 2020 12:09:50 +0200
Message-ID: <20200819100956.2216690-16-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819100956.2216690-1-clg@kaod.org>
References: <20200819100956.2216690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 63076d19-80f8-4b39-88fb-0542958e2445
X-Ovh-Tracer-Id: 18050708783064976233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:10:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The software reset of the MAC needs a finer granularity. Some settings
in MACCR are kept.

Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
Fixes: bd44300d1afc ("net: add FTGMAC100 support")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 7c9fa720df03..782ff192cedc 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -649,10 +649,8 @@ static uint32_t ftgmac100_rxpoll(FTGMAC100State *s)
     return cnt / div[speed];
 }
 
-static void ftgmac100_reset(DeviceState *d)
+static void ftgmac100_do_reset(FTGMAC100State *s, bool sw_reset)
 {
-    FTGMAC100State *s = FTGMAC100(d);
-
     /* Reset the FTGMAC100 */
     s->isr = 0;
     s->ier = 0;
@@ -671,7 +669,12 @@ static void ftgmac100_reset(DeviceState *d)
     s->fear1 = 0;
     s->tpafcr = 0xf1;
 
-    s->maccr = 0;
+    if (sw_reset) {
+        s->maccr &= FTGMAC100_MACCR_GIGA_MODE | FTGMAC100_MACCR_FAST_MODE;
+    } else {
+        s->maccr = 0;
+    }
+
     s->phycr = 0;
     s->phydata = 0;
     s->fcr = 0x400;
@@ -680,6 +683,11 @@ static void ftgmac100_reset(DeviceState *d)
     phy_reset(s);
 }
 
+static void ftgmac100_reset(DeviceState *d)
+{
+    ftgmac100_do_reset(FTGMAC100(d), false);
+}
+
 static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
 {
     FTGMAC100State *s = FTGMAC100(opaque);
@@ -824,7 +832,7 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
     case FTGMAC100_MACCR: /* MAC Device control */
         s->maccr = value;
         if (value & FTGMAC100_MACCR_SW_RST) {
-            ftgmac100_reset(DEVICE(s));
+            ftgmac100_do_reset(s, true);
         }
 
         if (ftgmac100_can_receive(qemu_get_queue(s->nic))) {
-- 
2.25.4


