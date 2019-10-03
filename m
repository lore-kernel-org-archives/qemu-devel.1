Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763AAC4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 21:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4207620679
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 21:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+vqMexC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4207620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG8sR-0003kC-9w
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 17:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iG8qh-0002ba-QJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 17:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iG8qg-000369-75
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 17:41:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21455)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iG8qC-0002Un-Vy
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 17:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570138844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oiie/5BoLYvBLnYujIkzYtsCTPZmL/d7Jgw3LTxPJ9M=;
 b=h+vqMexCuAQcrfwwjGcZyltKwVKMNL7qS/At93usRZvWuANpKctly7MYFAtbjd3yNbiDch
 ZR8tZbORkEp2ZNNtD0tpW87pC6q9Mz8d7z4dce5r0403IWxnttCslxM0auZ61K5mMYh3Ys
 Vv7WZFTitEkl52kEtTFFzRANHWYLZn0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-A5xj5iVXOAq89fjLNJG3Lg-1; Thu, 03 Oct 2019 17:40:42 -0400
Received: by mail-wr1-f71.google.com with SMTP id w8so1722913wrm.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 14:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tOf5KBlaCBTyfqyZJRcF2KlfUtLrLdbL5dPGhD9CX2A=;
 b=pWlgTuZfby7xpsrFl2+CSp9L9m1JRn6ggNYt830ubC4ksO/WwiZV37gvP8y35gIwCf
 MQ1Rgey9ukx/5BM5x9YFXGc7oLdUGuYFBWOYsaeWn46Pvpd9qN4pBDCBXaKPr8QHjFl/
 qLo2a6VJCsBOzEpoCx04LKXJLbAbDYlkDLX0+PHY5WkuR5T01Cumn8aWsFjRbhHj/lyD
 PLm25c9wnWU7Y9WbIAuZNfwLtuj1GiEzdko8lAvvIoBXE0JMOwJVMrLBUSb4pGiqvaZv
 9IVv/YUOY3TNQtPA9qXF+Yf6ycdAaH/41RejiInwI4tVJUpEd91mt5xbigbcnt155o32
 hyBQ==
X-Gm-Message-State: APjAAAW/ONCdst7Kq4NUGX9x4JSN/atxYkQTcG/hXtkxSqKpW/lue8am
 ck4pZuVuqcmUOAUT4x1hUbiBsWgb8NmN6SOjb7vjkOEyO5oHhEzlTy2qsydFsFaY6nq8ogKOiem
 duJ0BLB9Z2AVRbKo=
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr8614192wmj.81.1570138841488; 
 Thu, 03 Oct 2019 14:40:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6Q2PjWcu+9/BeMELrbtABnlZb1Itk0R8hVg5T3v21z8OdnwzJrJg33oGErmLAHfBEwD7xDw==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr8614173wmj.81.1570138841043; 
 Thu, 03 Oct 2019 14:40:41 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id p7sm4778733wma.34.2019.10.03.14.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 14:40:40 -0700 (PDT)
Subject: Re: [U-Boot] U-Boot build for i.MX board won't boot in corresponding
 QEMU machine
To: Bin Meng <bmeng.cn@gmail.com>, Waseem ALKurdi <waseem19992009@outlook.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <AM0PR01MB5795656B2DB2EA6E760BA8A8D79C0@AM0PR01MB5795.eurprd01.prod.exchangelabs.com>
 <CAEUhbmUYt=kNzJMyhZWouuktSKkqRtwkzxSQeFygMTid-M=QUw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77dd4faa-77b9-2156-3f6a-ece8c7b6f1df@redhat.com>
Date: Thu, 3 Oct 2019 23:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmUYt=kNzJMyhZWouuktSKkqRtwkzxSQeFygMTid-M=QUw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: A5xj5iVXOAq89fjLNJG3Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the SABRELITE maintainers:

$ ./scripts/get_maintainer.pl -f hw/misc/imx6_ccm.c
Peter Maydell <peter.maydell@linaro.org> (odd fixer:SABRELITE / i.MX6)
Jean-Christophe Dubois <jcd@tribudubois.net> (reviewer:SABRELITE / i.MX6)
qemu-arm@nongnu.org (open list:SABRELITE / i.MX6)

On 10/3/19 1:54 PM, Bin Meng wrote:
> +QEMU developers ML
> On Thu, Oct 3, 2019 at 7:37 PM Waseem ALKurdi
> <waseem19992009@outlook.com> wrote:
>>
>> I'm trying to get mainline U-Boot to boot on mainline QEMU 4.1.0 for the=
 'sabrelite' board, using the configuration 'mx6qsabrelite_defconfig'.
>>
>> It's not booting at all. Actually, not a single U-Boot build for an i.MX=
 board would boot, with the exception of 'imx25-pdk'.
>>
>> I'm compiling U-Boot by un-tarring the source tarball and running the fo=
llowing commands:
>>
>> $ time CROSS_COMPILE=3D/path/to/toolchain/arm-2014.05/bin/arm-none-linux=
-gnueabi- make ARCH=3Darm clean
>> $ time CROSS_COMPILE=3D/path/to/toolchain/arm-2014.05/bin/arm-none-linux=
-gnueabi- make ARCH=3Darm mrproper
>> $ time CROSS_COMPILE=3D/path/to/toolchain/arm-2014.05/bin/arm-none-linux=
-gnueabi- make ARCH=3Darm mx6qsabrelite_defconfig
>>
>> then after the build finishes:
>>
>> $ qemu-system-arm -M sabrelite -m 512M -kernel ~/Downloads/u-boot-2019.1=
0-rc3/u-boot.imx -monitor stdio
>>
>> And other variations on this command as well.
>> No amount of kernel commandline options or anything would make it boot. =
What should I do?

Running QEMU with '-d in_asm,cpu' shows the guest is looping polling a=20
mmio mapped register:

IN: arch_cpu_init
0x17803264:  e5943150  ldr      r3, [r4, #0x150]
0x17803268:  f57ff05f  dmb      sy
0x1780326c:  e3130080  tst      r3, #0x80
0x17803270:  0afffffb  beq      #0x17803264

R00=3D00000000 R01=3D00000000 R02=3D00000001 R03=3D04000000
R04=3D020c8000 R05=3D17864a7c R06=3D17864a78 R07=3D00000000
R08=3D00000000 R09=3D0093dde0 R10=3D00000000 R11=3D00000000
R12=3D0093dee8 R13=3D0093ddc8 R14=3D178033e4 R15=3D17803264
PSR=3D400001d3 -Z-- A S svc32
R00=3D00000000 R01=3D00000000 R02=3D00000001 R03=3D04000000
R04=3D020c8000 R05=3D17864a7c R06=3D17864a78 R07=3D00000000
R08=3D00000000 R09=3D0093dde0 R10=3D00000000 R11=3D00000000
R12=3D0093dee8 R13=3D0093ddc8 R14=3D178033e4 R15=3D17803264
PSR=3D400001d3 -Z-- A S svc32

R04 + 0x150 =3D 0x020c8000 + 0x150 =3D 0x020c8150, which is the=20
CCM_ANALOG_MISC0 register.

Looking at u-boot arch/arm/mach-imx/mx6/soc.c we have:

int arch_cpu_init(void)
{
=09struct mxc_ccm_reg *ccm =3D (struct mxc_ccm_reg *)CCM_BASE_ADDR;

=09init_aips();

=09/* Need to clear MMDC_CHx_MASK to make warm reset work. */
=09clear_mmdc_ch_mask();

=09/*
=09 * Disable self-bias circuit in the analog bandap.
=09 * The self-bias circuit is used by the bandgap during startup.
=09 * This bit should be set after the bandgap has initialized.
=09 */
=09init_bandgap();

         ...

With:

static void init_bandgap(void)
{
=09struct anatop_regs *anatop =3D (struct anatop_regs *)ANATOP_BASE_ADDR;
=09struct ocotp_regs *ocotp =3D (struct ocotp_regs *)OCOTP_BASE_ADDR;
=09struct fuse_bank *bank =3D &ocotp->bank[1];
=09struct fuse_bank1_regs *fuse =3D
=09=09(struct fuse_bank1_regs *)bank->fuse_regs;
=09uint32_t val;

=09/*
=09 * Ensure the bandgap has stabilized.
=09 */
=09while (!(readl(&anatop->ana_misc0) & 0x80))
=09=09;

QEMU returns R03=3D04000000 which comes from hw/misc/imx6_ccm.c:

static void imx6_ccm_reset(DeviceState *dev)
{
     ...
     s->analog[PMU_MISC0] =3D 0x04000000;
     s->analog[PMU_MISC1] =3D 0x00000000;
     s->analog[PMU_MISC2] =3D 0x00272727;

Changing the PMU_MISC0 register to return the bit u-boot is polling with=20
this snippet (I have no clue what this does) with:

-- >8 --
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 7fec8f0a47..3a52ea640a 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -450,7 +450,7 @@ static void imx6_ccm_reset(DeviceState *dev)
      s->analog[PMU_REG_3P0] =3D 0x00000F74;
      s->analog[PMU_REG_2P5] =3D 0x00005071;
      s->analog[PMU_REG_CORE] =3D 0x00402010;
-    s->analog[PMU_MISC0] =3D 0x04000000;
+    s->analog[PMU_MISC0] =3D 0x04000080;
      s->analog[PMU_MISC1] =3D 0x00000000;
      s->analog[PMU_MISC2] =3D 0x00272727;
---

I see u-boot going further.

> I suspect mainline QEMU sabrelite machine only supports booting the
> Linux kernel directly, but not booting U-Boot.

Note this u-boot code is ~4 years old:

commit 1f516faa45611aedc8c2e3f303b3866f615d481e
Author: Peng Fan <Peng.Fan@freescale.com>
Date:   Thu Jan 15 14:22:32 2015 +0800

     ARM: imx6: disable bandgap self-bias after boot

     The self-bias circuit is used by the bandgap during startup.
     Once the bandgap has stabilized, the self-bias circuit should
     be disabled for best noise performance of analog blocks.
     Also this bit should be disabled before the chip enters STOP mode or
     when ever the regular bandgap is disabled.

The QEMU device code was added later:

commit a66d815cd558193182b09fb23211f7ebf88d0661
Author: Jean-Christophe Dubois <jcd@tribudubois.net>
Date:   Wed Mar 16 17:06:00 2016 +0000

     i.MX: Add i.MX6 CCM and ANALOG device.

So I believe QEMU never booted u-boot on the i.MX6.

Waseem, you can enable some QEMU i.MX debug changing DEBUG_IMX*=20
definitions, such:

-- >8 --
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 7fec8f0a47..3a52ea640a 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -17,7 +17,7 @@
  #include "qemu/module.h"

  #ifndef DEBUG_IMX6_CCM
-#define DEBUG_IMX6_CCM 0
+#define DEBUG_IMX6_CCM 1
  #endif

  #define DPRINTF(fmt, args...) \
---

There are more:

$ git grep ifndef.*DEBUG_IMX
hw/char/imx_serial.c:29:#ifndef DEBUG_IMX_UART
hw/gpio/imx_gpio.c:28:#ifndef DEBUG_IMX_GPIO
hw/i2c/imx_i2c.c:29:#ifndef DEBUG_IMX_I2C
hw/intc/imx_avic.c:25:#ifndef DEBUG_IMX_AVIC
hw/misc/imx25_ccm.c:20:#ifndef DEBUG_IMX25_CCM
hw/misc/imx31_ccm.c:22:#ifndef DEBUG_IMX31_CCM
hw/misc/imx6_ccm.c:19:#ifndef DEBUG_IMX6_CCM
hw/misc/imx6_src.c:21:#ifndef DEBUG_IMX6_SRC
hw/misc/imx_ccm.c:19:#ifndef DEBUG_IMX_CCM
hw/net/imx_fec.c:38:#ifndef DEBUG_IMX_FEC
hw/net/imx_fec.c:50:#ifndef DEBUG_IMX_PHY
hw/ssi/imx_spi.c:18:#ifndef DEBUG_IMX_SPI
hw/timer/imx_epit.c:24:#ifndef DEBUG_IMX_EPIT
hw/timer/imx_gpt.c:23:#ifndef DEBUG_IMX_GPT

Regards,

Phil.


