Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD42C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0095C20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="HpGBfrqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0095C20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX0k-0007mC-OR
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaI-0004zD-Ci; Mon, 05 Oct 2020 15:55:46 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaG-0007ZY-2T; Mon, 05 Oct 2020 15:55:46 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 22D9BC60F23;
 Mon,  5 Oct 2020 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgQnfA4gJ5UqQkulxy+qp1Ezps7+MOOFEN3I8HU3nPw=;
 b=HpGBfrqT5zf3Xo4h2VyGmPCGiTbPeQcP1WmH4SEbitffqje7G3L8wOENHyIwjkwwsYzPpv
 lxn5C6mxWmG7e5kyh8Dy6roEVE2jf3TyHtE2N4As33GkpvkerURsRjlYvS4EQupc4Szoud
 FhWFAkZ88zpN2sdT/d64d0Ziw41qJfx5+MwuRx8bVk0iMNOq8nuOlbvLu+uI6xs+0o+sra
 GPo1OHXXEJPr5z8pbr6eltvttQbq3eD50kNDA7H2f6DWGcgtfGcSButxtL3X4Z68B+rUE1
 HZjQ8t+0KFzFVnhAytgD4QfJC2MF8L+BZdw8GN9FIUGRfGtn/swZoU/05/iHJA==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
Date: Mon,  5 Oct 2020 21:56:09 +0200
Message-Id: <20201005195612.1999165-13-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgQnfA4gJ5UqQkulxy+qp1Ezps7+MOOFEN3I8HU3nPw=;
 b=OFzSJOv1dIV5034BL//GACaNYfDMm8wFd8CRxcvkn6WIRRbOBYRLljqw4obPRxJ6C0Edtq
 5p1F5DgCVWtltQSNLy1oQFnRxWAvOvZnxyEidkfLRkX0p3AnDQf0NpW+LpBR+Y5beAFhxp
 8InyHNmue9EUeg+OtePjZOMy8eduBWa8GVzqj/J/PKy4cSMNC85lOIeynphwclf1jy0X/3
 H76saGaFLkTvh/kHNhG6L4Zt6bajpKRnP4jugB1lDCDNVBMFyu/561PVJ5axSP3aprZQSB
 W/rJlM8rjD4dYq9BhNB5YtSenAX9eHML9rXRgFQa4t5VXHmxcpmLnqpb/AVbGg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927720; a=rsa-sha256; cv=none;
 b=EfK5vG+7Sz6VlLyHx/tTXDTcbSI/JHcciA/mR8fsCuAsq/4bb2oYhUmVpHFdZoP1984PCOa0XSTq6EGRQUR1FBhoScLbkgTELEs9H5lRcJEnjWt0HnWos+ERb7TJkUXE5xiAYsDHYj3x5x35kNcCER17kkcAMqFsk69CjntGBAD5B1WK2bSBIhNub2sQ/3mfhQQzR6MQNHfHqMsy/yPr0F9xnw8dLFle5QjWxsuez34T6ay76AD7rIs3ItIEO0mFQHYe1jvSSFbV96wkTTikkCVJ6IFRjeK4jj0xy6g40WNh50pMjbk/uWm6+0zgwhOW1n1E+tVU/mEC8WB5CAPVLQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simple mux sits between the PLL channels and the DSI0E and DSI0P
clock muxes. This mux selects between PLLA-DSI0 and PLLD-DSI0 channel
and outputs the selected signal to source number 4 of DSI0E/P clock
muxes. It is controlled by the cm_dsi0hsck register.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman.h           | 15 +++++
 include/hw/misc/bcm2835_cprman_internals.h |  6 ++
 hw/misc/bcm2835_cprman.c                   | 74 +++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 817915ee95..4a1060c3d1 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -171,20 +171,35 @@ typedef struct CprmanClockMuxState {
      * source number.
      */
     struct CprmanClockMuxState *backref[CPRMAN_NUM_CLOCK_MUX_SRC];
 } CprmanClockMuxState;
 
+typedef struct CprmanDsi0HsckMuxState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    CprmanClockMux id;
+
+    uint32_t *reg_cm;
+
+    Clock *plla_in;
+    Clock *plld_in;
+    Clock *out;
+} CprmanDsi0HsckMuxState;
+
 struct BCM2835CprmanState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion iomem;
 
     CprmanPllState plls[CPRMAN_NUM_PLL];
     CprmanPllChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
     CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
+    CprmanDsi0HsckMuxState dsi0hsck_mux;
 
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
 
     Clock *xosc;
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 2d16f9ace5..d9abda91cb 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -13,17 +13,20 @@
 #include "hw/misc/bcm2835_cprman.h"
 
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
 #define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
 #define TYPE_CPRMAN_CLOCK_MUX "bcm2835-cprman-clock-mux"
+#define TYPE_CPRMAN_DSI0HSCK_MUX "bcm2835-cprman-dsi0hsck-mux"
 
 DECLARE_INSTANCE_CHECKER(CprmanPllState, CPRMAN_PLL,
                          TYPE_CPRMAN_PLL)
 DECLARE_INSTANCE_CHECKER(CprmanPllChannelState, CPRMAN_PLL_CHANNEL,
                          TYPE_CPRMAN_PLL_CHANNEL)
 DECLARE_INSTANCE_CHECKER(CprmanClockMuxState, CPRMAN_CLOCK_MUX,
                          TYPE_CPRMAN_CLOCK_MUX)
+DECLARE_INSTANCE_CHECKER(CprmanDsi0HsckMuxState, CPRMAN_DSI0HSCK_MUX,
+                         TYPE_CPRMAN_DSI0HSCK_MUX)
 
 /* Register map */
 
 /* PLLs */
 REG32(CM_PLLA, 0x104)
@@ -221,10 +224,13 @@ REG32(CM_LOCK, 0x114)
     FIELD(CM_LOCK, FLOCKD, 11, 1)
     FIELD(CM_LOCK, FLOCKC, 10, 1)
     FIELD(CM_LOCK, FLOCKB, 9, 1)
     FIELD(CM_LOCK, FLOCKA, 8, 1)
 
+REG32(CM_DSI0HSCK, 0x120)
+    FIELD(CM_DSI0HSCK, SELPLLD, 0, 1)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
  */
 FIELD(CPRMAN, PASSWORD, 24, 8)
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 7d59423367..4f5bb7a182 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -328,10 +328,62 @@ static const TypeInfo cprman_clock_mux_info = {
     .class_init = clock_mux_class_init,
     .instance_init = clock_mux_init,
 };
 
 
+/* DSI0HSCK mux */
+
+static void dsi0hsck_mux_update(CprmanDsi0HsckMuxState *s)
+{
+    bool src_is_plld = FIELD_EX32(*s->reg_cm, CM_DSI0HSCK, SELPLLD);
+    Clock *src = src_is_plld ? s->plld_in : s->plla_in;
+
+    clock_update(s->out, clock_get(src));
+}
+
+static void dsi0hsck_mux_in_update(void *opaque)
+{
+    dsi0hsck_mux_update(CPRMAN_DSI0HSCK_MUX(opaque));
+}
+
+static void dsi0hsck_mux_init(Object *obj)
+{
+    CprmanDsi0HsckMuxState *s = CPRMAN_DSI0HSCK_MUX(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->plla_in = qdev_init_clock_in(dev, "plla-in", dsi0hsck_mux_in_update, s);
+    s->plld_in = qdev_init_clock_in(dev, "plld-in", dsi0hsck_mux_in_update, s);
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static const VMStateDescription dsi0hsck_mux_vmstate = {
+    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(plla_in, CprmanDsi0HsckMuxState),
+        VMSTATE_CLOCK(plld_in, CprmanDsi0HsckMuxState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dsi0hsck_mux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &dsi0hsck_mux_vmstate;
+}
+
+static const TypeInfo cprman_dsi0hsck_mux_info = {
+    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CprmanDsi0HsckMuxState),
+    .class_init = dsi0hsck_mux_class_init,
+    .instance_init = dsi0hsck_mux_init,
+};
+
+
 /* CPRMAN "top level" model */
 
 static uint32_t get_cm_lock(const BCM2835CprmanState *s)
 {
     static const int CM_LOCK_MAPPING[CPRMAN_NUM_PLL] = {
@@ -489,10 +541,14 @@ static void cprman_write(void *opaque, hwaddr offset,
     case R_CM_SDCCTL ... R_CM_ARMCTL:
     case R_CM_AVEOCTL ... R_CM_EMMCDIV:
     case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
         update_mux_from_cm(s, idx);
         break;
+
+    case R_CM_DSI0HSCK:
+        dsi0hsck_mux_update(&s->dsi0hsck_mux);
+        break;
     }
 }
 
 #undef CASE_PLL_A2W_REGS
 
@@ -528,10 +584,12 @@ static void cprman_reset(DeviceState *dev)
 
     for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
         device_cold_reset(DEVICE(&s->channels[i]));
     }
 
+    device_cold_reset(DEVICE(&s->dsi0hsck_mux));
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         device_cold_reset(DEVICE(&s->clock_muxes[i]));
     }
 
     clock_update_hz(s->xosc, s->xosc_freq);
@@ -553,10 +611,14 @@ static void cprman_init(Object *obj)
                                 &s->channels[i],
                                 TYPE_CPRMAN_PLL_CHANNEL);
         set_pll_channel_init_info(s, &s->channels[i], i);
     }
 
+    object_initialize_child(obj, "dsi0hsck-mux",
+                            &s->dsi0hsck_mux, TYPE_CPRMAN_DSI0HSCK_MUX);
+    s->dsi0hsck_mux.reg_cm = &s->regs[R_CM_DSI0HSCK];
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         char *alias;
 
         object_initialize_child(obj, CLOCK_MUX_INIT_INFO[i].name,
                                 &s->clock_muxes[i],
@@ -600,11 +662,11 @@ static void connect_mux_sources(BCM2835CprmanState *s,
         Clock *src;
 
         if (mapping == CPRMAN_CLOCK_SRC_FORCE_GROUND) {
             src = s->gnd;
         } else if (mapping == CPRMAN_CLOCK_SRC_DSI0HSCK) {
-            src = s->gnd; /* TODO */
+            src = s->dsi0hsck_mux.out;
         } else if (i < CPRMAN_CLOCK_SRC_PLLA) {
             src = CLK_SRC_MAPPING[i];
         } else {
             src = s->channels[mapping].out;
         }
@@ -638,10 +700,19 @@ static void cprman_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize(DEVICE(channel), NULL, errp)) {
             return;
         }
     }
 
+    clock_set_source(s->dsi0hsck_mux.plla_in,
+                     s->channels[CPRMAN_PLLA_CHANNEL_DSI0].out);
+    clock_set_source(s->dsi0hsck_mux.plld_in,
+                     s->channels[CPRMAN_PLLD_CHANNEL_DSI0].out);
+
+    if (!qdev_realize(DEVICE(&s->dsi0hsck_mux), NULL, errp)) {
+        return;
+    }
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         CprmanClockMuxState *clock_mux = &s->clock_muxes[i];
 
         connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_mapping);
 
@@ -688,8 +759,9 @@ static void cprman_register_types(void)
 {
     type_register_static(&cprman_info);
     type_register_static(&cprman_pll_info);
     type_register_static(&cprman_pll_channel_info);
     type_register_static(&cprman_clock_mux_info);
+    type_register_static(&cprman_dsi0hsck_mux_info);
 }
 
 type_init(cprman_register_types);
-- 
2.28.0


