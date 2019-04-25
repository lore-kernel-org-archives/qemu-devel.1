Received: from eggs.gnu.org ([209.51.188.92]:55345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhTW-00011s-9f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhTU-0004oR-UY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:43:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJhTT-0004mM-KB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:43:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so139021wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:43:51 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-23-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b042daff-8b05-08e7-5386-1b89f05ad984@redhat.com>
Date: Thu, 25 Apr 2019 18:43:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-23-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 22/29] hw/arm: Express
 dependencies of sabrelite with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the Sabrelite / iMX6 machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 4 +---
>  hw/arm/Kconfig                  | 7 +++++++
>  hw/arm/Makefile.objs            | 3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 76508e3910..ef7dd7156a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -33,6 +33,7 @@ CONFIG_NETDUINO2=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_DIGIC=y
> +CONFIG_SABRELITE=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> @@ -40,13 +41,10 @@ CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
>  
> -CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
>  
> -CONFIG_IMX_I2C=y
> -
>  CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 059fb8282c..065c7acf1b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -177,6 +177,10 @@ config REALVIEW
>      select DS1338 # I2C RTC+NVRAM
>      select USB_OHCI
>  
> +config SABRELITE
> +    bool
> +    select FSL_IMX6

This one crashes:

$ qemu-system-aarch64 -display none -M sabrelite
ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type:
assertion failed: (type != NULL)
Aborted (core dumped)

(gdb) bt
#3  0x00007f71139fb4de in g_assertion_message_expr () at
/lib64/libglib-2.0.so.0
[...]
#8  0x000055a148c5eec9 in sysbus_init_child_obj
    (parent=parent@entry=0x55a14a2fbe10,
childname=childname@entry=0x55a148ed3713 "eth",
child=child@entry=0x55a14a33e0a0, childsize=childsize@entry=27296,
childtype=childtype@entry=0x55a148ed370a "imx.enet")
    at /source/qemu/hw/core/sysbus.c:373
#9  0x000055a148b37b82 in fsl_imx6_init (obj=0x55a14a2fbe10) at
/source/qemu/hw/arm/fsl-imx6.c:91
#10 0x000055a148d0fb17 in object_initialize_with_type
(data=data@entry=0x55a14a2fbe10, size=size@entry=299248,
type=0x55a14a27dbd0) at /source/qemu/qom/object.c:466
#11 0x000055a148d0fe5d in object_initialize
(data=data@entry=0x55a14a2fbe10, size=size@entry=299248,
typename=typename@entry=0x55a148ed3328 "fsl,imx6") at
/source/qemu/qom/object.c:474
#12 0x000055a148b35ced in sabrelite_init (machine=0x55a14a2c1300) at
/source/qemu/hw/arm/sabrelite.c:58
#13 0x000055a148c608bb in machine_run_board_init
(machine=0x55a14a2c1300) at /source/qemu/hw/core/machine.c:1030
[...]

Then:

$ qemu-system-aarch64 -display none -nodefaults -M sabrelite
qemu-system-aarch64: Unknown device 'sst25vf016b' for bus 'SSI'
Aborted (core dumped)

I got it working using the following snippet:

-- >8 --
@@ -186,6 +186,7 @@ config REALVIEW
 config SABRELITE
     bool
     select FSL_IMX6
+    select SSI_M25P80

 config STELLARIS
     bool
@@ -321,6 +322,7 @@ config FSL_IMX6
     select A9MPCORE
     select IMX
     select IMX_I2C
+    select IMX_FEC
     select SDHCI

 config ASPEED_SOC
---

With this snippet amended:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  config STELLARIS
>      bool
>      select ARM_V7M
> @@ -289,6 +293,9 @@ config FSL_IMX31
>  
>  config FSL_IMX6
>      bool
> +    select A9MPCORE
> +    select IMX
> +    select IMX_I2C
>  
>  config ASPEED_SOC
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 4f591ca487..fadd69882c 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -22,6 +22,7 @@ obj-$(CONFIG_COLLIE) += collie.o
>  obj-$(CONFIG_VERSATILE) += versatilepb.o
>  obj-$(CONFIG_VEXPRESS) += vexpress.o
>  obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
> +obj-$(CONFIG_SABRELITE) += sabrelite.o
>  
>  obj-$(CONFIG_ARM_V7M) += armv7m.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210.o
> @@ -36,7 +37,7 @@ obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
>  obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
>  obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
> -obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
> +obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>  obj-$(CONFIG_MPS2) += mps2.o
>  obj-$(CONFIG_MPS2) += mps2-tz.o
> 
