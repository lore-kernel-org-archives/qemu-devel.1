Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEF3206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="pAebr2KA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iokxDrkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEF3206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWNtl-0007oA-TS
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jWNsf-0007BG-Ca; Wed, 06 May 2020 13:30:49 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jWNsd-00038A-Ht; Wed, 06 May 2020 13:30:49 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 988CD9EA;
 Wed,  6 May 2020 13:30:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 06 May 2020 13:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 le0TrXnjxNexSHwUHhBLtj35Z6Tm86hJSExVVUMMBM4=; b=pAebr2KAUpmIyRM5
 Uiu5mBinrMi8XLd61/YnC05LlqsI9RvSAgO05Hiv11YCq91jTyBrbY2Rk9LI1aCO
 sWIRyoiWvHgGULzEo6UbzhsnYJXwoFjJ+BlM5r044Ss7i4Hag/1SgjH5O9dDOH9h
 3g+kVsE46OlF4MhbrwLNIHwYmG4rClJWiMY5bHGmvkBJ46gZ/Bb9TZCkD0bNAgN2
 OdvFlXuU/k8bGIIy1F6GG33TEVhDix0gnsKvd72fVB0SNFULWWfVtC6IX7R4PRqA
 xZEqqgGNH9AENYmInOztS9HuaacZJOQtyRIyXE23XLP+QuyWpwvlfOXC0rLVbfDp
 FfSgUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=le0TrXnjxNexSHwUHhBLtj35Z6Tm86hJSExVVUMMB
 M4=; b=iokxDrkH2LHssH3vQcCNjgzOhEIVYpflhcEKnZdSOPAnqgwgjVnv0SqN3
 tE61abpw7MdxIfK3GDBJ4AnqvwnDJY6NSp+nyysMH1wHBUugRLCfk+agXm7fESmt
 Ojvg1vKMrli8H60aKmxbAKPPS76Eeb3sIbPoztCeS6sDgPy9hr+duVP6EONTh5Au
 uGx6kpafIT38xqKYSIAtP8LMS6hQIntvoCebP1K9bT2UmvjI35s7dy7HIRxVpvSp
 abkqmj/H1gm+121T3u+6ojNsRiBvUgCeL5HtMaTLdnIR2XNt1S2fTTbNWdHdKCKR
 obObdaCXk95aR0fKnDaGUq/S+TETQ==
X-ME-Sender: <xms:QvSyXiV3pyeyS_ANiW4P-JdQ1IZ8tFcGmFAKwPU2S5oZ-iuD1ggnQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdduuddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegfrhhlucfvnfffucdlvdefmden
 ucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefrrghtrh
 hitghkucghihhllhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucgg
 tffrrghtthgvrhhnpefghfeluefgvdelhefhvddvtdejudekueeuheevudeludfhtdekge
 etkeejiedvtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieeirddu
 jeeirdduvdefrddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:QvSyXug51kK-AajFKRuQy_cofMv_h4lmEJtuMxAwAZCZ02pjxXZazg>
 <xmx:QvSyXh82Ho--CE5E_vE3cnpHJ5Gszl7oX-jJMkBhQa3aL4HutaQ-xw>
 <xmx:QvSyXuQ52Tf_F2VtQZsW5Z3FPj039Z9G670NpVorsGIpH0hRxBqB_w>
 <xmx:Q_SyXp0lWFRAjb-HF_RdsfFR3vPr1b9KwMndTDNB9D_4ozL5yVHmRA>
Received: from localhost (mobile-166-176-123-20.mycingular.net
 [166.176.123.20])
 by mail.messagingengine.com (Postfix) with ESMTPA id CAD0F328006A;
 Wed,  6 May 2020 13:30:41 -0400 (EDT)
From: Patrick Williams <patrick@stwcx.xyz>
To: 
Subject: [PATCH v2] aspeed: Add support for the sonorapass-bmc board
Date: Wed,  6 May 2020 12:30:35 -0500
Message-Id: <20200506173035.2154053-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501113704.2240698-1-patrick@stwcx.xyz>
References: <20200501113704.2240698-1-patrick@stwcx.xyz>
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a6a2102a93..01e74e34be 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -84,6 +84,21 @@ struct AspeedBoardState {
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
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -372,6 +387,49 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
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
@@ -499,6 +557,21 @@ static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 512 * MiB;
 };
 
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER SonoraPass BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
 static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -563,6 +636,10 @@ static const TypeInfo aspeed_machine_types[] = {
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


