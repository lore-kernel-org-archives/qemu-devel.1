Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA276C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A348206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIuKFq3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A348206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtINu-00022h-J9
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtHvL-0006D6-1C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:15 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:45747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtHvH-0004i5-SE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:14 -0400
Received: by mail-vk1-xa41.google.com with SMTP id h1so10525275vkn.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CW3w8aXpYiNtlEq+t02GsBy4W29Z+h3Ij5vo0Nr7eGY=;
 b=RIuKFq3VYiB07h4YmCvRG4I2anaJCjb7HeHEiuCQ17ZexjR0w1NItMqi4FTh4TALcy
 5nVW7IxxZmQka8OrMmZ69z7d8eFGa+B6tC4GpwQBW544pXuB5LWRe/cYkASj01NusQHI
 kze1P8CJuaSFcT4m0I4mtDw3L48jHWVswsu/ZI0nHAiGhENr4QENEJMMOS096Bo3RgbF
 /vc7BDW0FQe+3/aFefHPQATDsETYGTm6IPtmL94HBiWkDejcKdS38inABwJCs1aaApHx
 kQHIS0BD2wIU8zs+nt679vLmDHek4xkOFcRYHTdVzTVujXz/W1AX2DT19C2J1T3CZGG3
 R21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CW3w8aXpYiNtlEq+t02GsBy4W29Z+h3Ij5vo0Nr7eGY=;
 b=K0B5MabdclSvNNSiN1GD0vuYN9rFwlppPjrHixrCPD4lzB/ZhE8/TA4j0c6ON1zxtU
 hsLFEeQxYSAQ06GAm2maF+WBgk9CE03MoAzWqMznga9k7PyMAOV1BBpw6joQbi4HUHx3
 M3aB6JRXbwgylp+wINzT9sU3HhZip/hWohbN/iLWZrb9Lq9EirvJThmbBklESbwFjAjA
 B5SBxCbBbvxJe9KX7cblzE+ds+NqBmTM9iQwbUc7RSKToxgEm7mPr36YXbwL9RZkRtZM
 V3b5GT7EwZhtUXYMahkO9YRRzHrMXFvukPw6jqGI6HCBuoVeeLlhfqwiuhmrUU3uPxdA
 HqYQ==
X-Gm-Message-State: AOAM533L4412+zJlRE8AiHzFeQ6DH/uWbjwhM1VBq61h8wdTsNiIBAuK
 T8V9w7rLtDFoC/HgFLGNl47408YMy46s4QtI9ulGHA==
X-Google-Smtp-Source: ABdhPJzSf9/srYfLG9Rh1B+5+0QBH9y/CKIw4oMCK3ve9e4nn9q/YlasiQ86uRlxKnJJrUViy4uWhHCbOImUntEXut8=
X-Received: by 2002:a1f:9144:: with SMTP id t65mr35070332vkd.50.1594244890268; 
 Wed, 08 Jul 2020 14:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
In-Reply-To: <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 14:47:58 -0700
Message-ID: <CAFQmdRbF_tM4RaphCG1cgnEJ1z6YMdYv3fVjuu6crXKeAaS9Zg@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 11:13 AM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
>
> On Wed, Jul 8, 2020 at 10:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> > > +    /* System Global Control Registers (GCR) */
> > > +    object_property_set_int(OBJECT(&s->gcr), nc->disabled_modules,
> > > +                            "disabled-modules", &error_abort);
> > > +    object_property_set_link(OBJECT(&s->gcr), OBJECT(s->dram), "dram=
",
> > > +                             &error_abort);
> >
> > I guess you can simplify using in npcm7xx_init():
> >
> >       object_property_add_const_link(obj, "dram-mr", OBJECT(&s->gcr));
> >
> > And in npcm7xx_gcr_realize()
> >
> >     obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
> >     if (obj =3D=3D NULL) {
> >         error_setg(errp, "%s: required dram-mr link not found: %s",
> >                    __func__, error_get_pretty(err));
> >         return;
> >     }
> >     s->dram =3D MEMORY_REGION(obj);
>
> OK, I'll try that, thanks!

Hmm, I ended up doing

-    object_property_set_link(OBJECT(&s->gcr), OBJECT(s->dram), "dram",
-                             &error_abort);
+    object_property_add_const_link(OBJECT(&s->gcr), "dram-mr",
OBJECT(s->dram));

in realize() because s->dram isn't initialized yet in npcm7xx_init().
Is this what you had in mind?

Here's the diff from all the dram-related changes:

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 39a1f28d8e..30e00a514d 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -28,6 +28,10 @@

 #define NPCM7XX_MAX_NUM_CPUS    (2)

+/* The first half of the address space is reserved for DDR4 DRAM. */
+#define NPCM7XX_DRAM_BA         (0x00000000)
+#define NPCM7XX_DRAM_SZ         (2 * GiB)
+
 /* Magic addresses for setting up direct kernel booting and SMP boot stubs=
. */
 #define NPCM7XX_LOADER_START            (0x00000000)  /* Start of SDRAM */
 #define NPCM7XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gcr.h
index 49d699410f..4884676be2 100644
--- a/include/hw/misc/npcm7xx_gcr.h
+++ b/include/hw/misc/npcm7xx_gcr.h
@@ -68,7 +68,6 @@ typedef struct NPCM7xxGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
-    MemoryRegion *dram;
 } NPCM7xxGCRState;

 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index e64cf6a84c..a05a900197 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -26,10 +26,6 @@
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"

-/* The first half of the address space is reserved for DDR4 DRAM. */
-#define NPCM7XX_DRAM_BA         (0x00000000)
-#define NPCM7XX_DRAM_SZ         (2 * GiB)
-
 /*
  * This covers the whole MMIO space. We'll use this to catch any MMIO acce=
sses
  * that aren't handled by any device.
@@ -257,8 +253,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **e=
rrp)
     /* System Global Control Registers (GCR) */
     object_property_set_int(OBJECT(&s->gcr), nc->disabled_modules,
                             "disabled-modules", &error_abort);
-    object_property_set_link(OBJECT(&s->gcr), OBJECT(s->dram), "dram",
-                             &error_abort);
+    object_property_add_const_link(OBJECT(&s->gcr), "dram-mr",
OBJECT(s->dram));
     sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM7XX_GCR_BA);

@@ -326,13 +321,10 @@ static void npcm7xx_realize(DeviceState *dev,
Error **errp)
     memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM7XX_ROM_SZ,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &s->i=
rom);
-
-    /* External DDR4 SDRAM */
-    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, s->d=
ram);
 }

 static Property npcm7xx_properties[] =3D {
-    DEFINE_PROP_LINK("dram", NPCM7xxState, dram, TYPE_MEMORY_REGION,
+    DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 2f66e699b1..cfb31ce6f5 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -83,21 +83,25 @@ static void npcm7xx_connect_flash(NPCM7xxFIUState
*fiu, int cs_no,
     sysbus_connect_irq(SYS_BUS_DEVICE(fiu), cs_no, flash_cs);
 }

+static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
+{
+    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram=
);
+
+    object_property_set_link(OBJECT(soc), OBJECT(dram), "dram-mr",
+                             &error_abort);
+}
+
 static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
                                         uint32_t hw_straps)
 {
     NPCM7xxMachineClass *nmc =3D NPCM7XX_MACHINE_GET_CLASS(machine);
-    NPCM7xxState *soc;
+    Object *obj;

-    soc =3D NPCM7XX(object_new_with_props(nmc->soc_type, OBJECT(machine), =
"soc",
-                                        &error_abort, NULL));
-    object_property_set_link(OBJECT(soc), OBJECT(machine->ram), "dram",
-                             &error_abort);
-    object_property_set_uint(OBJECT(soc), hw_straps, "power-on-straps",
-                             &error_abort);
-    qdev_realize(DEVICE(soc), NULL, &error_abort);
+    obj =3D object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
+                                &error_abort, NULL);
+    object_property_set_uint(obj, hw_straps, "power-on-straps", &error_abo=
rt);

-    return soc;
+    return NPCM7XX(obj);
 }

 static void npcm750_evb_init(MachineState *machine)
@@ -105,6 +109,9 @@ static void npcm750_evb_init(MachineState *machine)
     NPCM7xxState *soc;

     soc =3D npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
+    npcm7xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_abort);
+
     npcm7xx_load_bootrom(soc);
     npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
     npcm7xx_load_kernel(machine, soc);
@@ -115,6 +122,9 @@ static void quanta_gsj_init(MachineState *machine)
     NPCM7xxState *soc;

     soc =3D npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
+    npcm7xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_abort);
+
     npcm7xx_load_bootrom(soc);
     npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
                           drive_get(IF_MTD, 0, 0));
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index 78a885e265..9934cd238d 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -127,11 +127,16 @@ static void npcm7xx_gcr_realize(DeviceState
*dev, Error **errp)
 {
     NPCM7xxGCRState *s =3D NPCM7XX_GCR(dev);
     uint64_t dram_size;
+    Error *err =3D NULL;
+    Object *obj;

-    if (!s->dram) {
-        error_setg(errp, "npcm7xx_gcr: 'dram' link not set");
+    obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required dram-mr link not found: %s",
+                   __func__, error_get_pretty(err));
         return;
     }
+    dram_size =3D memory_region_size(MEMORY_REGION(obj));

     /* Power-on reset value */
     s->reset_intcr3 =3D 0x00001002;
@@ -149,7 +154,6 @@ static void npcm7xx_gcr_realize(DeviceState *dev,
Error **errp)
      *
      * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408db=
aad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
      */
-    dram_size =3D int128_get64(s->dram->size);
     if (dram_size >=3D 2 * GiB) {
         s->reset_intcr3 |=3D 4 << 8;
     } else if (dram_size >=3D 1 * GiB) {
@@ -191,8 +195,6 @@ static const VMStateDescription vmstate_npcm7xx_gcr =3D=
 {
 static Property npcm7xx_gcr_properties[] =3D {
     DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0)=
,
     DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0)=
,
-    DEFINE_PROP_LINK("dram", NPCM7xxGCRState, dram, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };

