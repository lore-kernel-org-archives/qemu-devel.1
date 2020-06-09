Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1414C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01EA2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRi2ciC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01EA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZqr-0005xp-Vu
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZpW-00055A-KB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:41:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZpT-0002Qd-G4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591692113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=URclTCt7k5hT37jv9XxlDrRkcWetnOxlqK72Ul8T360=;
 b=HRi2ciC2sWKkHaG8+mvPkB1sbzLnIwqWuR/LCcY3gdUCnFlwVz+HWFdDMnqct58Z/ZiF6Y
 W2bpuei1NgzNAsokKlA/qnwqMXwJWKRroYGjKY6m3rwArLpI/6T+xj3Cgz/D2JZVlmzFZM
 wGPj2Ypn4SvLeHZKBn+mk95fPv5Oci4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-mNPkwU3qP2qg0_cPEqk6uA-1; Tue, 09 Jun 2020 04:41:52 -0400
X-MC-Unique: mNPkwU3qP2qg0_cPEqk6uA-1
Received: by mail-wm1-f69.google.com with SMTP id v24so482668wmh.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=URclTCt7k5hT37jv9XxlDrRkcWetnOxlqK72Ul8T360=;
 b=a6LTxoHJIdmUYElJ+iL7fHhglb8iFIN1XdnkKl7AjTcmg4+IYISbCRnrOsi1IszMQm
 Y9fk/6Je1UslkNnwVFvk5+kHv9CW1G93sqIPV8uyXZvbimuj+6ZtgYXQkOJGL3MYVQZy
 /mvoe5p59AiZXd0mAgmkoJf8VoAXhNVUv7euEOqb71NiKQqdZfOK8sXDYe8iBdmpvzwO
 19TRLtVHaEv81enXynxPeh6vz/+J/hDd230ohwEzXUhGwT7NNppSIDYeZHyxmQ6Rg2sB
 djm7LKqBMlIxLPAnA6xUikhpo9A0wGlydjgH/EaKrtygiQAtL3r1KYNvMl6Lb5KiDBjq
 vrKQ==
X-Gm-Message-State: AOAM531du9D+c3qSZHLYm/uKjcHL33+UDIrFuG7q0d67QGBVsxW7uA24
 9QtShuPCOf6m1ZfXWMyWqVYZk01P6Ghk4GZYqikf68e2e+ljoeiU+4Z0kSqVzRvOtbJGn7ZJtCP
 hwTad8O+nLMYq258=
X-Received: by 2002:a1c:230f:: with SMTP id j15mr3005978wmj.100.1591692110989; 
 Tue, 09 Jun 2020 01:41:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUvHG/s2qs9XpjCasy6/tFINu81HjIP2lZY5Aoxq/ekRJ7Yguus6yNJD9Kfd6d28TAMvM0LQ==
X-Received: by 2002:a1c:230f:: with SMTP id j15mr3005949wmj.100.1591692110672; 
 Tue, 09 Jun 2020 01:41:50 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k26sm2214169wmi.27.2020.06.09.01.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:41:50 -0700 (PDT)
Subject: Re: [PATCH v2 45/58] sysbus: Convert to sysbus_realize() etc. with
 Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-46-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <838581c2-8dc1-8391-76f3-538e83c35162@redhat.com>
Date: Tue, 9 Jun 2020 10:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-46-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:45 PM, Markus Armbruster wrote:
> Convert from qdev_realize(), qdev_realize_and_unref() with null @bus
> argument to sysbus_realize(), sysbus_realize_and_unref().
> 
> Coccinelle script:
> 
>     @@
>     expression dev, errp;
>     @@
>     -    qdev_realize(DEVICE(dev), NULL, errp);
>     +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);

YES YES YES!!!$!@#$

> 
>     @@
>     expression sysbus_dev, dev, errp;
>     @@
>     +    sysbus_dev = SYS_BUS_DEVICE(dev);
>     -    qdev_realize_and_unref(dev, NULL, errp);
>     +    sysbus_realize_and_unref(sysbus_dev, errp);
>     -    sysbus_dev = SYS_BUS_DEVICE(dev);
> 
>     @@
>     expression sysbus_dev, dev, errp;
>     expression expr;
>     @@
>          sysbus_dev = SYS_BUS_DEVICE(dev);
>          ... when != dev = expr;
>     -    qdev_realize_and_unref(dev, NULL, errp);
>     +    sysbus_realize_and_unref(sysbus_dev, errp);
> 
>     @@
>     expression dev, errp;
>     @@
>     -    qdev_realize_and_unref(DEVICE(dev), NULL, errp);
>     +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> 
>     @@
>     expression dev, errp;
>     @@
>     -    qdev_realize_and_unref(dev, NULL, errp);
>     +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> 
> Whitespace changes minimized manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/lm32/lm32.h                           |  6 ++---
>  hw/lm32/milkymist-hw.h                   | 18 ++++++-------
>  include/hw/char/cadence_uart.h           |  2 +-
>  include/hw/char/cmsdk-apb-uart.h         |  2 +-
>  include/hw/char/pl011.h                  |  4 +--
>  include/hw/char/xilinx_uartlite.h        |  2 +-
>  include/hw/cris/etraxfs.h                |  2 +-
>  include/hw/misc/unimp.h                  |  2 +-
>  include/hw/timer/cmsdk-apb-timer.h       |  2 +-
>  hw/alpha/typhoon.c                       |  2 +-
>  hw/arm/exynos4210.c                      | 18 ++++++-------
>  hw/arm/exynos4_boards.c                  |  2 +-
>  hw/arm/highbank.c                        | 12 ++++-----
>  hw/arm/integratorcp.c                    |  2 +-
>  hw/arm/mps2-tz.c                         |  2 +-
>  hw/arm/msf2-som.c                        |  2 +-
>  hw/arm/musicpal.c                        |  4 +--
>  hw/arm/netduino2.c                       |  2 +-
>  hw/arm/netduinoplus2.c                   |  2 +-
>  hw/arm/nseries.c                         |  4 +--
>  hw/arm/omap1.c                           |  8 +++---
>  hw/arm/omap2.c                           |  8 +++---
>  hw/arm/pxa2xx.c                          |  4 +--
>  hw/arm/pxa2xx_gpio.c                     |  2 +-
>  hw/arm/pxa2xx_pic.c                      |  2 +-
>  hw/arm/realview.c                        | 10 ++++----
>  hw/arm/sbsa-ref.c                        | 12 ++++-----
>  hw/arm/spitz.c                           |  2 +-
>  hw/arm/stellaris.c                       |  6 ++---
>  hw/arm/strongarm.c                       |  4 +--
>  hw/arm/versatilepb.c                     |  8 +++---
>  hw/arm/vexpress.c                        |  8 +++---
>  hw/arm/virt.c                            | 18 ++++++-------
>  hw/arm/xilinx_zynq.c                     | 16 ++++++------
>  hw/arm/xlnx-versal-virt.c                |  2 +-
>  hw/arm/xlnx-versal.c                     |  2 +-
>  hw/block/fdc.c                           |  4 +--
>  hw/block/pflash_cfi01.c                  |  2 +-
>  hw/block/pflash_cfi02.c                  |  2 +-
>  hw/char/exynos4210_uart.c                |  2 +-
>  hw/char/mcf_uart.c                       |  2 +-
>  hw/char/serial.c                         |  2 +-
>  hw/core/empty_slot.c                     |  2 +-
>  hw/core/sysbus.c                         |  2 +-
>  hw/cris/axis_dev88.c                     |  2 +-
>  hw/display/milkymist-tmu2.c              |  2 +-
>  hw/display/sm501.c                       |  2 +-
>  hw/dma/pxa2xx_dma.c                      |  4 +--
>  hw/dma/rc4030.c                          |  2 +-
>  hw/dma/sparc32_dma.c                     |  8 +++---
>  hw/hppa/dino.c                           |  2 +-
>  hw/hppa/lasi.c                           |  2 +-
>  hw/hppa/machine.c                        |  2 +-
>  hw/i386/pc.c                             |  2 +-
>  hw/i386/pc_q35.c                         |  2 +-
>  hw/i386/pc_sysfw.c                       |  2 +-
>  hw/i386/x86.c                            |  2 +-
>  hw/intc/exynos4210_gic.c                 |  2 +-
>  hw/intc/s390_flic.c                      |  2 +-
>  hw/isa/isa-bus.c                         |  2 +-
>  hw/m68k/mcf5208.c                        |  2 +-
>  hw/m68k/mcf_intc.c                       |  2 +-
>  hw/m68k/next-cube.c                      |  6 ++---
>  hw/m68k/q800.c                           | 12 ++++-----
>  hw/microblaze/petalogix_ml605_mmu.c      | 10 ++++----
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  6 ++---
>  hw/mips/boston.c                         |  4 +--
>  hw/mips/gt64xxx_pci.c                    |  2 +-
>  hw/mips/jazz.c                           |  8 +++---
>  hw/mips/malta.c                          |  2 +-
>  hw/mips/mipssim.c                        |  4 +--
>  hw/net/etraxfs_eth.c                     |  2 +-
>  hw/net/fsl_etsec/etsec.c                 |  2 +-
>  hw/net/lan9118.c                         |  2 +-
>  hw/net/lasi_i82596.c                     |  2 +-
>  hw/net/smc91c111.c                       |  2 +-
>  hw/nios2/10m50_devboard.c                |  6 ++---
>  hw/nvram/fw_cfg.c                        |  4 +--
>  hw/openrisc/openrisc_sim.c               |  4 +--
>  hw/pci-bridge/pci_expander_bridge.c      |  2 +-
>  hw/pci-host/bonito.c                     |  2 +-
>  hw/pci-host/i440fx.c                     |  2 +-
>  hw/pcmcia/pxa2xx.c                       |  2 +-
>  hw/ppc/e500.c                            | 16 ++++++------
>  hw/ppc/mac_newworld.c                    | 16 ++++++------
>  hw/ppc/mac_oldworld.c                    |  6 ++---
>  hw/ppc/pnv.c                             |  8 +++---
>  hw/ppc/ppc440_uc.c                       |  4 +--
>  hw/ppc/prep.c                            |  4 +--
>  hw/ppc/sam460ex.c                        |  2 +-
>  hw/ppc/spapr.c                           |  2 +-
>  hw/ppc/spapr_irq.c                       |  2 +-
>  hw/ppc/spapr_vio.c                       |  2 +-
>  hw/ppc/virtex_ml507.c                    |  4 +--
>  hw/riscv/sifive_clint.c                  |  2 +-
>  hw/riscv/sifive_e_prci.c                 |  2 +-
>  hw/riscv/sifive_plic.c                   |  2 +-
>  hw/riscv/sifive_test.c                   |  2 +-
>  hw/riscv/virt.c                          |  4 +--
>  hw/rtc/m48t59.c                          |  2 +-
>  hw/rtc/sun4v-rtc.c                       |  2 +-
>  hw/s390x/ap-bridge.c                     |  2 +-
>  hw/s390x/css-bridge.c                    |  2 +-
>  hw/s390x/s390-virtio-ccw.c               |  2 +-
>  hw/s390x/sclp.c                          |  2 +-
>  hw/sd/pxa2xx_mmci.c                      |  2 +-
>  hw/sh4/r2d.c                             |  6 ++---
>  hw/sparc/leon3.c                         | 10 ++++----
>  hw/sparc/sun4m.c                         | 32 ++++++++++++------------
>  hw/sparc64/sun4u.c                       | 12 ++++-----
>  hw/xen/xen-bus.c                         |  2 +-
>  hw/xen/xen-legacy-backend.c              |  2 +-
>  hw/xtensa/virt.c                         |  2 +-
>  hw/xtensa/xtfpga.c                       |  4 +--
>  114 files changed, 257 insertions(+), 257 deletions(-)
[...]
> diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
> index 725e5fd998..d0bdd01b9d 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/core/empty_slot.c
> @@ -66,7 +66,7 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
>          e = EMPTY_SLOT(dev);
>          e->size = slot_size;
>  
> -        qdev_realize_and_unref(dev, NULL, &error_fatal);
> +        sysbus_realize_and_unref(s, &error_fatal);
>  
>          sysbus_mmio_map(s, 0, addr);

Oops you need to rebase this one.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
             __
        _   /  |
       | \  \/_/
       \_\| / __
          \/_/__\           .--='/~\
   ____,__/__,_____,______)/   /{~}}}
   -,-----,--\--,-----,---,\'-' {{~}}
           __/\_            '--=.\}/
          /_/ |\\
               \/


