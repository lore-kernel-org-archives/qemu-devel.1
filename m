Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB872C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D51022202
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="CdYFPvUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D51022202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFXl-00005T-Fb
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNO-0001yZ-9e; Sat, 10 Oct 2020 09:57:34 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNK-0004KE-P2; Sat, 10 Oct 2020 09:57:33 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id DC15EC6041E;
 Sat, 10 Oct 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1khL5jQgl79Wz4Nvt9T2Nmb7REQ+9nMviU5HHyZMUgY=;
 b=CdYFPvUqnOQ3LC/lrJ62V9OmfeFrvBfhF34UCcfADeAwmsXybYYNlw3S78YbUm6OujIH88
 /IFtncMowOM5Q91AY4Sp6nH0Quy5KMs3UMWW1+25jI3BwKz/8wZUmlCIrpiubMpgLkEO/K
 DeYeEbYQirtvaNC2AWR4GIlqj47kptx676jmcNmawTpI3Z8UtKZuKfje+CglI071n3ENQ5
 N0bLaRg1W1gz1vYwmqkhK9sEaECzsV4xkIh8/FiB79D+CJ2ypUoycvV7sdjteWBPQtnBaI
 U3tX0/9EqCNM2BCaQqE2InCxmp+YCPJMy3MEi+dtYdNCPQwaWW7Z37ZS556suQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/15] hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
Date: Sat, 10 Oct 2020 15:57:56 +0200
Message-Id: <20201010135759.437903-13-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1khL5jQgl79Wz4Nvt9T2Nmb7REQ+9nMviU5HHyZMUgY=;
 b=YYo8T48iB8aYG2YSgPatcr4NsM8wFKS+yv9TDZ5ogwPenJLivEa5pwvNctPhfEs00czoJf
 0va3egF8WSTZD6xQ21oJjeyJCVmdNsTGArhcLjgkmndEPZ+WfXvYymMjegxnKa8QCcqLsC
 9S2HIIJQkZOFJVKfn6bOhEp4OGqWDp8BZ8Nfj0vJrtTPhDC/76ihUq2uwGQzNWN9p57Kva
 Ml31WMXaOOxdF53PJfXF9ZUqJViGKySss76gT4RKhDcVRIb1PazpH2ebHpMZOOj7d8vJ93
 FqgufyAw7lLokYt/YM2P6i2bk0osp7tFYLBn/aP3C/Nj6GL8uQU58tHiXR1+HQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338224; a=rsa-sha256; cv=none;
 b=HlcPrta2QfgWpcPSIuOcGv3cJwYEOx9pCYO3bN6WYqlvIduLAkA3FPtk4uO+NhQ6KU+slsdJXCEEC+wNz9gInd51MH4WLp/TI0noMJzsbUNipfKyZf0ulwHzCj1QBqumxMWj6bVbzC/NyPAFc3GEftG0Q3vtuMx03MOcZqi/KgkzxA8Cs8Kmlweh1YKRnI/5JdQ45n8qD+PO3rBvafLCA/quw6LTlYvHWw2QNkX6pkg1VKD9E5HqKnDk3obk39lQsifcmf3cJ9ZiyaRNk1/Ss9Ma2ICwvy4LLwHK/r1AZ1E9PWcFF0rfnWDN8ndSVqz5OYlWJCp2RxOmLY14dTqZiw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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
index 0fc8f68845..3df4ceedd2 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -172,20 +172,35 @@ typedef struct CprmanClockMuxState {
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
index 0305448bbc..a6e799075f 100644
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
index 919a55aa23..7a7401963d 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -337,10 +337,62 @@ static const TypeInfo cprman_clock_mux_info = {
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
@@ -499,10 +551,14 @@ static void cprman_write(void *opaque, hwaddr offset,
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
 
@@ -538,10 +594,12 @@ static void cprman_reset(DeviceState *dev)
 
     for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
         device_cold_reset(DEVICE(&s->channels[i]));
     }
 
+    device_cold_reset(DEVICE(&s->dsi0hsck_mux));
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         device_cold_reset(DEVICE(&s->clock_muxes[i]));
     }
 
     clock_update_hz(s->xosc, s->xosc_freq);
@@ -563,10 +621,14 @@ static void cprman_init(Object *obj)
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
@@ -610,11 +672,11 @@ static void connect_mux_sources(BCM2835CprmanState *s,
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
@@ -648,10 +710,19 @@ static void cprman_realize(DeviceState *dev, Error **errp)
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
 
@@ -698,8 +769,9 @@ static void cprman_register_types(void)
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


