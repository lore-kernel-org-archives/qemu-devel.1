Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B4BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569B820708
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="WsLc+cUY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nij8Wfbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569B820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOxr-00007c-Dx
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jWOqK-0007WS-J4; Wed, 06 May 2020 14:32:28 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jWOqI-0006MP-QN; Wed, 06 May 2020 14:32:28 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 37D025E2;
 Wed,  6 May 2020 14:32:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 06 May 2020 14:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 l1hDY85fQqEkJ5nyfvKU1QkI/YgipGbBsH+gneoMgfo=; b=WsLc+cUYdZ0+y3/l
 NT3oRe6MF98IH3DiW/wnv4ZGad9iUjjdWeogJT0foAyu0gtyBQ/LjqwgwlgiS8M/
 ToHB2YE/CihTCwKgIDrujIYfLuy1wnjlSelxEeM0m9YLjll8F/9EaNyLlub23TlZ
 Zwt97BKpcr1qoGWUyjgUzhhhDJw60DqJ3gIKxWJZEHcrnnoCsmiJVWIkhRKRmcJc
 Pf8HOIopgykkGWzndbqGNxFo5MGB71cc+P8OnnPvYUU0ctUGraXQ1r3nX3UgdNtj
 cPspmxeuLHxOCEbXVqUhXcFYw2h2od4z497R/96tMxGgRImhaUM22O41Yzkomym0
 9dU9og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=l1hDY85fQqEkJ5nyfvKU1QkI/YgipGbBsH+gneoMg
 fo=; b=Nij8Wfbq/HKICkqp3KFLbOPZLQi5Xm1qiMOZTzR/FXkQBpEDNZ6kumfuu
 hr37+0YJORQIwDpAHd3XNBvHPcmg4xg5+gsnZjy/iuP3pA8WrvpJ0czE1faVMQGn
 PGe8zRmfYSLLgveOjTRUEitO+vvsa1SU2vcQLfZhZgfdtK2SCgao29e88o/CJner
 kMxaNoCWGGE5KAg53mxGa7ZSCT2zlZbPX3AYGNqCTnyEstgfz7BgWS+GT61+LLx8
 RXnK67y8nmMVcnPhl5ROFq1LBl89iiWobD1fWdWA+hu0Orup0NTPmf5stlmWckRq
 F+vB+FVxe4+K0FN/kAQljlSygF43Q==
X-ME-Sender: <xms:twKzXmGhpd7kqd8zRM3xvk6AOo_Alz3-b6oAvVq2JnALqFB76HPYxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegfrhhlucfvnfffucdlvdefmden
 ucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefrrghtrh
 hitghkucghihhllhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucgg
 tffrrghtthgvrhhnpefghfeluefgvdelhefhvddvtdejudekueeuheevudeludfhtdekge
 etkeejiedvtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieeirddu
 jeeirdduvdefrddvvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:twKzXiT7Hg7kN9fZP2pjQobb6ady2BmHVrgO00Ay4a_Tfoh2xbDEOw>
 <xmx:twKzXvK8C6T8XZSAs5gG3Dr5sWseAzNawLFJnE00Me6hdx9lzKF7Yg>
 <xmx:twKzXlbjpm7hRUit7KGYQ4AY7hETT8phBmiVIYX4uP2U8vmlQHvJcw>
 <xmx:twKzXjK6vrL5apPbKJA30rqOcTGkE_Jl0kEJ2nw_VnDD5efWJL8xBw>
Received: from localhost (mobile-166-176-123-220.mycingular.net
 [166.176.123.220])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3C54A328005A;
 Wed,  6 May 2020 14:32:23 -0400 (EDT)
From: Patrick Williams <patrick@stwcx.xyz>
To: 
Subject: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
Date: Wed,  6 May 2020 13:32:19 -0500
Message-Id: <20200506183219.2166987-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506173035.2154053-1-patrick@stwcx.xyz>
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.19; envelope-from=patrick@stwcx.xyz;
 helo=wout3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 13:30:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Patrick Williams <patrick@stwcx.xyz>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sonora Pass is a 2 socket x86 motherboard designed by Facebook
and supported by OpenBMC.  Strapping configuration was obtained
from hardware and i2c configuration is based on dts found at:

https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts

Booted a test image of http://github.com/facebook/openbmc to login
prompt.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Amithash Prasad <amithash@fb.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6f4d7075c4..74c46681e8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -74,6 +74,21 @@ struct AspeedBoardState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+/* Sonorapass hardware value: 0xF100D216 */
+#define SONORAPASS_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
 /* Swift hardware value: 0xF11AD206 */
 #define SWIFT_BMC_HW_STRAP1 (                                           \
         AST2500_HW_STRAP1_DEFAULTS |                                    \
@@ -434,6 +449,49 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
 }
 
+static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    /* bus 2 : */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
+    /* bus 2 : pca9546 @ 0x73 */
+
+    /* bus 3 : pca9548 @ 0x70 */
+
+    /* bus 4 : */
+    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
+                          eeprom4_54);
+    /* PCA9539 @ 0x76, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
+    /* PCA9539 @ 0x77, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
+
+    /* bus 6 : */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
+    /* bus 6 : pca9546 @ 0x73 */
+
+    /* bus 8 : */
+    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
+                          eeprom8_56);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
+    /* bus 8 : adc128d818 @ 0x1d */
+    /* bus 8 : adc128d818 @ 0x1f */
+
+    /* bus 13 : pca9548 @ 0x71
+     *      - channel 3:
+     *          - tmm421 @ 0x4c
+     *          - tmp421 @ 0x4e
+     *          - tmp421 @ 0x4f
+     */
+
+}
+
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
@@ -552,6 +610,21 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 512 * MiB;
 };
 
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
 static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -631,6 +704,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("swift-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_swift_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sonorapass_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.26.2


