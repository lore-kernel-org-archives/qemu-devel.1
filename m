Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6FC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D70320718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HALt0A51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D70320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3j4J-00048U-B9
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3j3S-0003Fg-2c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3j3P-0001ny-IE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:15:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3j3P-0001mb-CG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581956126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJkDkcBZmkRSpMkBiJ2CZKSXcZCAGQXl53EDq8kSyCQ=;
 b=HALt0A51/JY+PUk9PXQDMOJ6XC/GLyrhJSpkGGLCtWama3jFk4EgUxFxvKl9QH0oN9+B4d
 h9+kSmcKW74zxgvauTGRBMUkMXyzf7/V9vmSGfs2fZdeQX9XjK1q0gYUS9dSKyGF5gKT2e
 OdOMZxKLHV0reog9OWJcTaiJkQ/f7WM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-y2pz31HAMi6R8M6meGaoeA-1; Mon, 17 Feb 2020 11:15:23 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so9224712wrc.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3/FHm/XJhye1ByINF74sk0z+9FloZcd98UvVOCjWRoE=;
 b=qLP3yyWeWa210Z3TZjA55bJefeXJYkEn56XyHWgcaE3tcHO2CU4iCo5/KMH+Zahibm
 KQ3vU2TESLKW6ojtebYeZGrooRqJTWH5S5iJiuPug1InDeO19sYeNWcn27qMMeYFSWSO
 J3WoA8RpWSe8J3d0iei13joLHPjF24aLozV8i+Rk1V4DpgZlNtzakuA+01zi4hkhbLWf
 xxzPJk3Ody/SO2EH6RSBDGJIS7AWQZmC61MH1Ovuadbmsrm5CFtn3Bd4zwq7Lq9um/uT
 q01bIBGC7IYaMdn3TX1d3HB2xb1uec74b5+KrBwY2eIRacsvOptnKYHBmwixbIrzigcI
 fuzg==
X-Gm-Message-State: APjAAAXz2U4YFkHt8xmLP7oTE+dyFnFEZInPStDP+I60RSmuSiDO4nll
 DWsFnZ9YKR++P+s0+Mj216BZ12PK7e4XDlQYTXJOkwpsZUZZD7nhGSL5WtUNuv8vSFSBhUJkyU2
 vYBL2wiDnFmU0KVc=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr22380499wme.37.1581956122426; 
 Mon, 17 Feb 2020 08:15:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtX6QuKSgtoQSSj2QfcYGsHgXGO3BLKQKzvr64eGhof+x5U3sQXZCLmRQ6q3YJMkuiblxgow==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr22380476wme.37.1581956122088; 
 Mon, 17 Feb 2020 08:15:22 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s1sm1540926wro.66.2020.02.17.08.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 08:15:20 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
Date: Mon, 17 Feb 2020 17:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: y2pz31HAMi6R8M6meGaoeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 3:06 PM, Peter Maydell wrote:
> On Mon, 17 Feb 2020 at 13:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 2/17/20 2:25 PM, Peter Maydell wrote:
>=20
>>> So we now call timer_new in realize, and timer_del in unrealize,
>>> but timer_free in finalize. This seems unbalanced -- why not
>>> call timer_free in unrealize too, if we're moving things?
>>>
>>> Also, this is a case of code that's actually doing things right:
>>> we free the memory that we allocated in init in finalize. So
>>> we're not fixing any leak here, we're just moving code around
>>> (which is reasonable if we're trying to standardize on "call
>>> timer_new in realize, not init", but should be noted in the
>>> commit message).
>>
>> While I understand your point, I am confused because the documentation
>> on unrealize() and finalize() is rather scarce (and not obvious for
>> non-native english speaker). I think I'm not understanding QOM instance
>> lifetime well (in particular hotplug devices) so I will let this series =
go.
>=20
> Yes, the documentation is really not good at all. The
> basic structure as I understand it is that we have two-part
> creation and two-part destruction:
>   * instance_init is creation part 1
>   * realize is creation part 2
>   * unrealize is destruction part 1 and is the opposite of realize
>   * instance_finalize is destruction part 2 and is the
>     opposite of instance_init
>=20
> (Base QOM objects only have instance_init/instance_finalize;
> realize/unrealize exists only for DeviceState objects
> and their children.)
>=20
> ASCII-art state diagram:
>=20
>    [start] --instance_init-> [inited] --realize-> [realized]
>       ^                       |   ^                     |
>       \---instance_finalize---/   \-----unrealize-------/
>=20
> In practice the only sequences we really care about are:
>   instance_init; realize; unrealize; instance_finalize
>     (a full object creation-use-destruction cycle;
>      even if realize fails, unrealize will be called)
>   instance_init; realize
>     (a subset of the above: for non-hot-pluggable devices
>      we will never try to unrealize them, so this is
>      as far as it goes for most devices unless they
>      returned an error from their realize function)

Per this comment in qdev.c, unrealize() is the expected default:

     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
      * device_set_realized() functions make every device
      * hotpluggable. Devices that shouldn't be hotpluggable,
      * should override it in their class_init()
      */
     dc->hotpluggable =3D true;

>   instance_init; instance_finalize
>     (the monitor does this for introspection of an object
>      without actually wanting to create and use it; it's
>      also the basic lifecycle for non-DeviceState objects)
>=20
> The difference between hot-pluggable and not is just
> whether it's valid to try to unrealize the device.
>=20
> We should definitely be clearer about what belongs in
> instance_init vs what belongs in realize. But where we
> have both a "do thing" and a "clean up that thing" task,
> we should put the cleanup code in the operation that is
> the pair of the operation we put the "do thing" code in
> (i.e. do thing in instance_init, clean it up in finalize;
> or do thing in realize, clean it up in unrealize).

With the following code snippet:

-- >8 --
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3937d1eb1a..00d1e5c0e5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -859,6 +859,16 @@ static void device_set_realized(Object *obj, bool=20
value, Error **errp)
      bool unattached_parent =3D false;
      static int unattached_count;

+    if (!dc->hotpluggable && dc->unrealize) {
+        fprintf(stderr,
+                "type '%s' is not hotpluggable and implements=20
unrealize()\n",
+                object_get_typename(obj));
+    }
+    if (dc->hotpluggable && !dc->unrealize) {
+        fprintf(stderr, "type '%s' is hotpluggable and misses=20
unrealize()\n",
+                object_get_typename(obj));
+    }
+
      if (dev->hotplugged && !dc->hotpluggable) {
          error_setg(errp, QERR_DEVICE_NO_HOTPLUG,=20
object_get_typename(obj));
          return;
diff --git a/qom/object.c b/qom/object.c
index 555c8b9d07..2d8d166cba 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -347,6 +347,16 @@ static void type_initialize(TypeImpl *ti)

              type_initialize_interface(ti, t, t);
          }
+
+        if (!type_is_ancestor(ti, type_get_by_name(TYPE_DEVICE))
+                && !type_is_ancestor(ti, type_get_by_name(TYPE_INTERFACE))
+                && !ti->instance_finalize
+                && !parent->instance_finalize
+                && !parent->abstract) {
+            fprintf(stderr,
+                    "type '%s' misses instance_finalize() [parent '%s']\n"=
,
+                    ti->name, parent->name);
+        }
      } else {
          ti->class->properties =3D g_hash_table_new_full(
              g_str_hash, g_str_equal, NULL, object_property_free);

---

I get for qemu-system-aarch64:


- qdev objects missing instance_finalize():

     bcm2835-sdhost-bus
     PCIE
     pxa2xx-mmci-bus
     qtest-accel
     sdhci-bus
     tcg-accel

- non-hotpluggable devices implementing unrealize():

     VGA

- hotpluggable devices missing unrealize()

     a15mpcore_priv
     a9mpcore_priv
     a9-scu
     acpi-ged
     ads7846
     aer915
     allwinner-a10
     allwinner-a10-pic
     allwinner-A10-timer
     allwinner-ahci
     allwinner-emac
     arm11mpcore_priv
     arm11-scu
     ARM,bitband-memory
     arm.cortex-a9-global-timer
     arm_gic
     arm-gicv2m
     arm-gicv3
     arm_mptimer
     arm-smmuv3
     armsse-cpuid
     armsse-mhu
     armv7m
     armv7m_nvic
     armv7m_systick
     aspeed.fmc-ast2400
     aspeed.fmc-ast2500
     aspeed.fmc-ast2600
     aspeed.gpio-ast2400
     aspeed.gpio-ast2500
     aspeed.gpio-ast2600-1_8v
     aspeed.gpio-ast2600
     aspeed.i2c-ast2400
     aspeed.i2c-ast2500
     aspeed.i2c-ast2600
     aspeed-mmi
     aspeed.rtc
     aspeed.scu-ast2400
     aspeed.scu-ast2500
     aspeed.scu-ast2600
     aspeed.sdhci
     aspeed.sdmc-ast2400
     aspeed.sdmc-ast2500
     aspeed.sdmc-ast2600
     aspeed.spi1-ast2400
     aspeed.spi1-ast2500
     aspeed.spi1-ast2600
     aspeed.spi2-ast2500
     aspeed.spi2-ast2600
     aspeed.timer-ast2400
     aspeed.timer-ast2500
     aspeed.timer-ast2600
     aspeed.vic
     aspeed.wdt-ast2400
     aspeed.wdt-ast2500
     aspeed.wdt-ast2600
     aspeed.xdma
     ast2400-a1
     ast2500-a1
     ast2600-a0
     bcm2835-aux
     bcm2835-dma
     bcm2835-fb
     bcm2835_gpio
     bcm2835-ic
     bcm2835-mbox
     bcm2835-peripherals
     bcm2835-property
     bcm2835-rng
     bcm2835-sdhost
     bcm2835-sys-timer
     bcm2835-thermal
     bcm2836-control
     bcm2836
     bcm2837
     cadence_gem
     cadence_ttc
     cadence_uart
     cfi.pflash01
     cmsdk-apb-dualtimer
     cmsdk-apb-timer
     cmsdk-apb-uart
     cmsdk-apb-watchdog
     corgi-ssp
     cpu-cluster
     designware-pcie-host
     digic
     digic-timer
     digic-uart
     dpcd
     ds1338
     exynos4210.clk
     exynos4210.combiner
     exynos4210-ehci-usb
     exynos4210.fimd
     exynos4210.gic
     exynos4210.i2c
     exynos4210.irq_gate
     exynos4210
     exynos4210.mct
     exynos4210.pmu
     exynos4210.pwm
     exynos4210.rng
     exynos4210.rtc
     exynos4210.uart
     fsl,imx25
     fsl,imx31
     fsl,imx6
     fsl,imx6ul
     fsl,imx7
     ftgmac100
     fw_cfg_mem
     gpex-pcihost
     gpio_i2c
     gpio-key
     highbank-regs
     i2c-ddc
     icp-ctrl-regs
     imx25.ccm
     imx25.gpt
     imx2.wdt
     imx31.ccm
     imx31.gpt
     imx6.ccm
     imx6.gpt
     imx6.src
     imx6ul.ccm
     imx7.analog
     imx7.ccm
     imx7.gpr
     imx7.gpt
     imx7.snvs
     imx.avic
     imx.enet
     imx.epit
     imx.fec
     imx-gpcv2
     imx.gpio
     imx.i2c
     imx.rngc
     imx.serial
     imx.spi
     integrator_core
     integrator_debug
     integrator_pic
     integrator_pit
     iotkit
     iotkit-secctl
     iotkit-sysctl
     iotkit-sysinfo
     l2x0
     lan9118
     lm8323
     luminary-watchdog
     mainstone-fpga
     max1111
     max7310
     microbit.i2c
     mps2-fpgaio
     mps2-scc
     msf2-soc
     msf2-sysreg
     mss-spi
     mss-timer
     musicpal_gpio
     musicpal_key
     musicpal_lcd
     musicpal-misc
     mv88w8618_audio
     mv88w8618_eth
     mv88w8618_flashcfg
     mv88w8618_pic
     mv88w8618_pit
     mv88w8618_wlan
     mx25l25635e
     mx66l1g45g
     mx66u51235f
     n25q128
     n25q256a
     n25q512a11
     nand
     nrf51_soc.gpio
     nrf51-soc
     nrf51_soc.nvm
     nrf51_soc.rng
     nrf51_soc.timer
     nrf51_soc.uart
     omap2-gpio
     omap2-intc
     omap-gpio
     omap_i2c
     omap-intc
     onenand
     or-irq
     pca9552
     pl011
     pl011_luminary
     pl022
     pl031
     pl041
     pl050_keyboard
     pl050_mouse
     pl061
     pl061_luminary
     pl080
     pl081
     pl110
     pl110_versatile
     pl111
     pl181
     pl190
     pl330
     platform-bus-device
     platform-ehci-usb
     pxa25x-timer
     pxa27x-timer
     pxa2xx-dma
     pxa2xx-gpio
     pxa2xx_i2c
     pxa2xx-i2c-slave
     pxa2xx-pcmcia
     pxa2xx_pic
     pxa2xx_rtc
     pxa2xx-ssp
     realview_gic
     realview_mpcore
     realview_pci
     realview_sysctl
     s25sl12801
     scoop
     sd-card
     serial-mm
     sii9022
     sl-nand
     smbus-eeprom
     smc91c111
     sp804
     spitz-keyboard
     spitz-lcdtg
     split-irq
     ssd0303
     ssd0323
     sse-200
     ssi-sd
     sst25vf016b
     sst25wf080
     stellaris-adc
     stellaris_enet
     stellaris-gptm
     stellaris-i2c
     stm32f205-soc
     stm32f2xx-adc
     stm32f2xx-spi
     stm32f2xx-syscfg
     stm32f2xx-timer
     stm32f2xx-usart
     stm32f405-soc
     stm32f4xx-exti
     stm32f4xx-syscfg
     strongarm-gpio
     strongarm_pic
     strongarm-ppc
     strongarm-rtc
     strongarm-ssp
     strongarm-uart
     sysbus-ahci
     sysbus-ohci
     tmp105
     tmp423
     tosa_dac
     tosa-ssp
     twl92230
     tz-mpc
     tz-msc
     tz-ppc
     unimplemented-device
     usb-chipidea
     versatile_i2c
     versatilepb_sic
     versatile_pci
     virtio-mmio
     w25q256
     w25q512jv
     wm8750
     xgmac
     xilinx,zynq_slcr
     xlnx.dpdma
     xlnx.ps7-dev-cfg
     xlnx.ps7-qspi
     xlnx.ps7-spi
     xlnx,ps7-usb
     xlnx.usmp-gqspi
     xlnx.v-dp
     xlnx-versal
     xlnx.zdma
     xlnx-zynmp.rtc
     xlnx.zynqmp_ipi
     xlnx,zynqmp
     xlnx,zynq-xadc
     zipit-lcd

Most of these are sysbus devices. The list is big, I probably have=20
something wrong.


