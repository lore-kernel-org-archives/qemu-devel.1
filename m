Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33458C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B510921D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Z/yixsQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B510921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLksq-0000I7-QZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknL-0001BX-V7; Fri, 25 Sep 2020 06:17:39 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknJ-0007SP-8I; Fri, 25 Sep 2020 06:17:39 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id C5B91C60F23;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsNBR+iq9fdf+lKa2N77Xg9ZgMSlmTYx7Lrf4dgXr5M=;
 b=Z/yixsQk9LhChvn6Av25PKVNnCU2u7tFz3KPh7EOcnLhdElmL1kfIOWnpJL2YC+Le18X6R
 KBqwmEO+EJXlt11nAmINSnb/YxDTMwA+NLHrTpPJvmKi4NQ1QNJvE60lFqQRt8ymcy6BRC
 Hh0qEM/zT3EtAgDM9Lbo+CgWhdBukFNpvdAIqTt2xN6CKfQQgShNy0S1rrOkdNFEdmXNBB
 wSE/9HKiV7GWHm9hzXfpMISLrTLVb2MnPWBnQ1FluxEuDBz/rzaUR4jNMAkcBAg+4efW3m
 5wMVjLglF0i1BvAPUB54FpCfF56z4cbTnhfOpRK8Lwg4pUspgE7KtoxAlDa1+g==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/14] hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
Date: Fri, 25 Sep 2020 12:17:28 +0200
Message-Id: <20200925101731.2159827-12-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsNBR+iq9fdf+lKa2N77Xg9ZgMSlmTYx7Lrf4dgXr5M=;
 b=YV1ALaM0Zcy3/FLJKBAK9mQZDveD4zzRvBsNo3PrzIOw03rR6XLWLLSUA6Q3IVXuyzXv0/
 NmXVrJDCFFXIMK7kHCKRvFryHAc0FFCs2Bi8d3rrgmq5LV8JdA4uxVam1TtOMHbcsH4V+O
 Q6ckXBEp/6eYUEnUjxME1Jr34yJUIHt/2dC+JhCE5kJsEbSdn03Wh0aOWdenrSd1UsF8Ke
 EnQWza/M4EJYWPhSpW8JnJPcMl2VA6Lga5ZlwNWmDW7+V5ARvxJjmWrIlYTPYWYZTkoDri
 vJvy5DbYn72GkV4PKehHQ0OTZ/tw120ZyMR5CwUgw1fsALffqhWDgmD+VWZTMw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=IeGihrNl9K3ZP6IAGdpfdOYwR4CiL/lsj4Eqk4LV6LwzRbX+ne/R32W0x0fb6XWZSeVLBO2woHl3zALMLRm6yNaM3xJjdQGCoxXZ0c8b+vGUShlhlo6FpjBJWzCwdPLbaupAK5agxnnbW7ChVySO93T/vB4puJmeBsdvshNpP+IGN4HAi1Kcv1lLZWLdVh+M6DJ4KjjoDrf5SENX9PBpfXR7TRVdxX5SoncP7jO7ufnWqtDvIsW4FMEan+7qI5HbWXAp4o4d/0LdvJk35pYoq6QoUQeFEUjJ25gU9t0erdZRah5L2k2iC55NKH6VaBqzhCZ/ZyQf5GG8KmNMTOE2bQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simple mux sits between the PLL channels and the DSI0E and DSI0P
clock muxes. This mux selects between PLLA-DSI0 and PLLD-DSI0 channel
and outputs the selected signal to source number 4 of DSI0E/P clock
muxes. It is controlled by the cm_dsi0hsck register.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman.h           | 15 +++++
 include/hw/misc/bcm2835_cprman_internals.h |  6 ++
 hw/misc/bcm2835_cprman.c                   | 78 +++++++++++++++++++++-
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index c2a89e8e90..5555a299fc 100644
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
 
     CprmanPLLState plls[CPRMAN_NUM_PLL];
     CprmanPLLChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
     CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
+    CprmanDsi0HsckMuxState dsi0hsck_mux;
 
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
 
     Clock *xosc;
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index a2b5a1aa50..ad07cf5276 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -13,17 +13,20 @@
 #include "hw/misc/bcm2835_cprman.h"
 
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
 #define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
 #define TYPE_CPRMAN_CLOCK_MUX "bcm2835-cprman-clock-mux"
+#define TYPE_CPRMAN_DSI0HSCK_MUX "bcm2835-cprman-dsi0hsck-mux"
 
 DECLARE_INSTANCE_CHECKER(CprmanPLLState, CPRMAN_PLL,
                          TYPE_CPRMAN_PLL)
 DECLARE_INSTANCE_CHECKER(CprmanPLLChannelState, CPRMAN_PLL_CHANNEL,
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
index 75bc11939b..e576ab2642 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -327,10 +327,62 @@ static const TypeInfo cprman_clock_mux_info = {
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
     static const int CM_LOCK_MAPPING[] = {
@@ -488,10 +540,14 @@ static void cprman_write(void *opaque, hwaddr offset,
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
 
@@ -519,10 +575,12 @@ static void cprman_reset(DeviceState *dev)
 
     for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
         device_cold_reset(DEVICE(&s->channels[i]));
     }
 
+    device_cold_reset(DEVICE(&s->dsi0hsck_mux));
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         device_cold_reset(DEVICE(&s->clock_muxes[i]));
     }
 
     clock_update_hz(s->xosc, s->xosc_freq);
@@ -560,10 +618,14 @@ static void cprman_init(Object *obj)
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
@@ -608,11 +670,11 @@ static void connect_mux_sources(BCM2835CprmanState *s,
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
@@ -646,10 +708,23 @@ static void cprman_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize(DEVICE(channel), NULL, errp)) {
             return;
         }
     }
 
+    {
+        CprmanDsi0HsckMuxState *dsi0hsck_mux = &s->dsi0hsck_mux;
+
+        clock_set_source(dsi0hsck_mux->plla_in,
+                         s->channels[CPRMAN_PLLA_CHANNEL_DSI0].out);
+        clock_set_source(dsi0hsck_mux->plld_in,
+                         s->channels[CPRMAN_PLLD_CHANNEL_DSI0].out);
+
+        if (!qdev_realize(DEVICE(dsi0hsck_mux), NULL, errp)) {
+            return;
+        }
+    }
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         CprmanClockMuxState *clock_mux = &s->clock_muxes[i];
 
         connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_mapping);
 
@@ -696,8 +771,9 @@ static void cprman_register_types(void)
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


