Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0EFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198812053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198812053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdThp-0002pa-Ac
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdThF-0002FH-Se
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:08:21 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:36309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdThD-0002Cl-4q
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:08:21 -0400
Received: from player157.ha.ovh.net (unknown [10.108.35.197])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id ECB0627FE94
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:08:16 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 5A37112B6207C;
 Tue, 26 May 2020 07:08:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006ec754a42-c167-4d29-935e-495ca2ff4d5d,BA58C4C231B6E713CF1CEA232D1729E48FB61414)
 smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] arm/aspeed: Rework NIC attachment
Date: Tue, 26 May 2020 09:08:02 +0200
Message-Id: <20200526070802.160897-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13862079653944396561
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvuddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieekkeelffetgeelveevjeehteduvdeivdeljeevvdeuvedtgfeiudeiveeiudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.40.108; envelope-from=clg@kaod.org;
 helo=3.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 03:08:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of MACs supported by an Aspeed SoC is defined by "macs_num"
under the SoC model, that is two for the AST2400 and AST2500 and four
the AST2600. The model initializes the maximum number of supported
MACs but the number of realized devices is caped by the number of
network device back-ends defined on the command line. This can leave
unrealized devices hanging around in the QOM composition tree.

Modify the machine initialization to define which MACs are attached to
a network device back-end using a bit-field property "macs-mask" and
let the SoC realize all network devices.

The default setting of "macs-mask" is "use MAC0" only, which works for
all our AST2400 and AST2500 machines. The AST2600 machines have
different configurations. The AST2600 EVB machine activates MAC1, MAC2
and MAC3 and the Tacoma BMC machine activates MAC2.

Inactive MACs will have no peer and QEMU will warn the user with :

    qemu-system-arm: warning: nic ftgmac100.0 has no peer
    qemu-system-arm: warning: nic ftgmac100.1 has no peer
    qemu-system-arm: warning: nic ftgmac100.3 has no peer

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h |  6 ++++++
 hw/arm/aspeed.c         | 13 +++++++++++++
 hw/arm/aspeed_ast2600.c |  3 +--
 hw/arm/aspeed_soc.c     |  3 +--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 18521484b90e..95b4daece86d 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -23,6 +23,11 @@ typedef struct AspeedMachine {
     bool mmio_exec;
 } AspeedMachine;
 
+#define ASPEED_MAC0_ON   (1 << 0)
+#define ASPEED_MAC1_ON   (1 << 1)
+#define ASPEED_MAC2_ON   (1 << 2)
+#define ASPEED_MAC3_ON   (1 << 3)
+
 #define ASPEED_MACHINE_CLASS(klass) \
      OBJECT_CLASS_CHECK(AspeedMachineClass, (klass), TYPE_ASPEED_MACHINE)
 #define ASPEED_MACHINE_GET_CLASS(obj) \
@@ -39,6 +44,7 @@ typedef struct AspeedMachineClass {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    uint32_t macs_mask;
     void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedMachineClass;
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index fd5cc542a584..f8f3ef89d320 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -258,6 +258,7 @@ static void aspeed_machine_init(MachineState *machine)
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
     ram_addr_t max_ram_size;
     int i;
+    NICInfo *nd = &nd_table[0];
 
     bmc = g_new0(AspeedBoardState, 1);
 
@@ -277,6 +278,14 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
                              &error_fatal);
 
+    for (i = 0; i < sc->macs_num; i++) {
+        if ((amc->macs_mask & (1 << i)) && nd->used) {
+            qemu_check_nic_model(nd, TYPE_FTGMAC100);
+            qdev_set_nic_properties(DEVICE(&bmc->soc.ftgmac100[i]), nd);
+            nd++;
+        }
+    }
+
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2",
@@ -556,12 +565,14 @@ static int aspeed_soc_num_cpus(const char *soc_name)
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->init = aspeed_machine_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
+    amc->macs_mask = ASPEED_MAC0_ON;
 
     aspeed_machine_class_props_init(oc);
 }
@@ -680,6 +691,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     amc->fmc_model = "w25q512jv";
     amc->spi_model = "mx66u51235f";
     amc->num_cs    = 1;
+    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = ast2600_evb_i2c_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
@@ -698,6 +710,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
     amc->fmc_model = "mx66l1g45g";
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC2_ON;
     amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
     mc->default_ram_size = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index c6821b332257..b912d19f809f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -461,8 +461,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e6f4b59134ba..3ec1257c140b 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -404,8 +404,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-- 
2.25.4


