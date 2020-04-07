Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9179D20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axvfpdKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9179D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmEb-0002ML-PG
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmDq-0001CN-UI
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmDp-0001Vl-D0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:16:50 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d]:34150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jLmDp-0001VI-85; Tue, 07 Apr 2020 07:16:49 -0400
Received: by mail-il1-x12d.google.com with SMTP id t11so2802298ils.1;
 Tue, 07 Apr 2020 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wGIxJUtkUDHcup4SgLJ5MT1btx+T7qC+ZTD5Q9HuceE=;
 b=axvfpdKw7AMQBsn7/mfZHixfOZSlI9I+DlDBd/0WvXdAEBf1Ib54QNumv5V9b9EueE
 lPDYCIgNTNjWy77ZxjXQFbSr+sUMpEPwiyUdOh1R0kjcI1/6NpquMCg/EG+yYZKfQCxk
 2ze+uaTbss+UurYvl+q7mOB/TMOuEQSTFrPFxBlxKfo8Zj0E8Xt8BzXOv6zBZhkYgbQp
 Nug+gjm8DQKMo4uL09R1plOPCZzZkW2CabWBB839i2IbFLktX6s0VZUMKDHRiaztWvdo
 lIvoP1qv+0FbmPFkeurHz8mQyVVE4Lx2TDown/Nri/R6rKa6yKf8dFULyMGH/cfooT+R
 kSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wGIxJUtkUDHcup4SgLJ5MT1btx+T7qC+ZTD5Q9HuceE=;
 b=fW/Smx3/HDDkzSZNvq4nvfFs6uOf0OEbT5sfQ+kwrW9P567h02ibf8yhk1uFYTuO3/
 1QRKSsU6/s32h8rBt+jh2uDcUHTgiMHwTPEcGolsN6CZ1/IPzU60DMybAyZdIa800Vyq
 DboQo4QA3dVZNlq2+rDGq+FBTPHS4fTeYeFfq/foXJzZAmXn/cIDyTpqZycNT64cEdaZ
 RfqAnokiBzvoUii8n0MBm6J95hJ2rC9dpSR9xmXKuyeYR+Wm5E+V45gfoMHNeYZUBIVj
 JlqC0oRtR8cHTC2s/V7Nj0SfjsnH7t7AJWujkvl4jAk+yf7wYMy7GHYawTBCSTafQ0CZ
 1/9w==
X-Gm-Message-State: AGi0PuZ8LsNwSz4ZlUUM73VoG+OjdTnTX3H0inMx0UmzhRE1ya90/C+j
 ZwFMT4x5eb/hwgmYZTrSxl8vkPls764AZF7Sga0=
X-Google-Smtp-Source: APiQypKah6PSYrWvbirjC6jV2H5SgghCbr2mXbuN0ll8UMMnEZ2iR86qzjL1I2pVQJXsNiWC5hEa2ygdqNwrpQLIInM=
X-Received: by 2002:a92:aac8:: with SMTP id p69mr1802634ill.305.1586258208130; 
 Tue, 07 Apr 2020 04:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586063624-13375-1-git-send-email-sundeep.lkml@gmail.com>
 <8783e9e6-e013-955b-c953-d203f59225d1@redhat.com>
In-Reply-To: <8783e9e6-e013-955b-c953-d203f59225d1@redhat.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 7 Apr 2020 16:46:36 +0530
Message-ID: <CALHRZuq0vqqzTeBYiYapmbwyi_0Yy9GLOsJVcfrEH8ghqNvaDA@mail.gmail.com>
Subject: Re: [Qemu-devel PATCH v2 0/2] Add SmartFusion2 EMAC block
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12d
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Mon, Apr 6, 2020 at 3:54 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Sundeep,
>
> On 4/5/20 7:13 AM, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >
> > This patch set emulates Ethernet MAC block
> > present in Microsemi SmartFusion2 SoC.
> >
> > v2:
> >    No changes. Fixed Signed-off mail id in patch 2/2
> >
> >
> > Testing:
> >
> > 1. Download u-boot.bin, uImage and msf2-devkit.dtb from
> >     https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
> > 2. Copy uImage and msf2-devkit.dtb to suitable Qemu tftp directory
> > 3. Launch Qemu by
> >     ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -ker=
nel \
> >     u-boot.bin -display none -nic user,tftp=3D<qemu tftp directory>
> >
> > Example:
> > ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -kernel =
u-boot -display none -nic user,tftp=3D/home/hyd1358/qemu_tftp
> >
> > U-Boot 2010.03-00000-ga7695d6 (Apr 04 2020 - 15:07:27)
> >
> > CPU  : SmartFusion2 SoC (Cortex-M3 Hard IP)
> > Freqs: CORTEX-M3=3D142MHz,PCLK0=3D71MHz,PCLK1=3D71MHz
> > Board: M2S-FG484-SOM Rev 1A, www.emcraft.com
> > DRAM:  64 MB
> > *** Warning - bad CRC, using default environment
> >
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   M2S_MAC
> >
> > Hit any key to stop autoboot:  3  0
> >
> > M2S-FG484-SOM> run netboot
> > Using M2S_MAC device
> > TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> > Filename 'uImage'.
> > Load address: 0xa0007fc0
> > Loading: *#############################################################=
####
> >   #################################################################
> >   #################################################################
> >   ###############################################################
> > done
> > Bytes transferred =3D 3681568 (382d20 hex)
> > Using M2S_MAC device
> > TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> > Filename 'msf2-devkit.dtb'.
> > Load address: 0xa0000200
> > Loading: *#
> > done
> > Bytes transferred =3D 1712 (6b0 hex)
> > ## Booting kernel from Legacy Image at a0007fc0 ...
> >     Image Name:
> >     Image Type:   ARM Linux Kernel Image (uncompressed)
> >     Data Size:    3681504 Bytes =3D  3.5 MB
> >     Load Address: a0008000
> >     Entry Point:  a0008001
> >     Verifying Checksum ... OK
> >     Loading Kernel Image ... OK
> > OK
> >
> > Starting kernel ...
> >
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.5.0-gb0e5502-dirty (hyd1358@hyd1358) (gc=
c version 4.4.1 (Sourcery G++ Lite 2010q1-189) ) #85 PREEMPT Sat Apr 4 23:2=
6:40 IST 2020
> > [    0.000000] CPU: ARMv7-M [410fc231] revision 1 (ARMv7M), cr=3D000000=
00
> > [    0.000000] CPU: unknown data cache, unknown instruction cache
> > [    0.000000] Machine model: Microsemi SmartFusion 2 development board
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 16256
> > [    0.000000] Kernel command line: console=3DttyS0,115200n8 panic=3D10=
 mem=3D64M@0xa0000000 earlyprintk
> > [    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
> > [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 b=
ytes)
> > [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 by=
tes)
> > [    0.000000] Memory: 61212K/65536K available (1612K kernel code, 75K =
rwdata, 680K rodata, 1224K init, 120K bss, 4324K reserved, 0K cma-reserved)
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0x00000000 - 0x00001000   (   4 kB)
> > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > [    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
> > [    0.000000]     lowmem  : 0xa0000000 - 0xa4000000   (  64 MB)
> > [    0.000000]     modules : 0xa0000000 - 0xa0800000   (   8 MB)
> > [    0.000000]       .text : 0xa0008000 - 0xa02453e8   (2293 kB)
> > [    0.000000]       .init : 0xa0246000 - 0xa0378000   (1224 kB)
> > [    0.000000]       .data : 0xa0378000 - 0xa038ace0   (  76 kB)
> > [    0.000000]        .bss : 0xa038ace0 - 0xa03a8ea0   ( 121 kB)
> > [    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
> > [    0.000000] Preemptible hierarchical RCU implementation.
> > .
> > .
> > .
> > [    0.445184] Found M2S MAC at 0x40041000, irq 18
> > [    0.448810] libphy: msf2 MII bus: probed
> > [    0.527047] ipip: IPv4 over IPv4 tunneling driver
> > [    0.532367] NET: Registered protocol family 10
> > [    0.542307] sit: IPv6 over IPv4 tunneling driver
> > [    0.544655] NET: Registered protocol family 17
> > [    0.565395] Freeing unused kernel memory: 1224K (a0246000 - a0378000=
)
> > init started: BusyBox v1.31.1 (2020-01-25 20:01:06 IST)
> > starting pid 26, tty '': '/etc/rc'
> > starting pid 31, tty '/dev/ttyS0': '/bin/hush -i'
> >
> >
> > BusyBox v1.31.1 (2020-01-25 20:01:06 IST) hush - the humble shell
> > Enter 'help' for a list of built-in commands.
> >
> > / # ifconfig eth0 10.0.2.15
> > [   11.116091] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > / # [   11.653634] eth0: link up (100/full)
> > [   11.655246] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> >
> > / # ls
> > dev   proc  sys   etc   usr   bin   tmp   sbin  mnt   init
> > / # tftp -gr uImage 10.0.2.2
> > [   40.780983] random: nonblocking pool is initialized
> > / # ls
> > dev     sys     usr     tmp     mnt     uImage
> > proc    etc     bin     sbin    init
> > / #
>
> Thanks for the use case example!
>
> Do you mind adding it to our test suite? There are various examples in
> tests/acceptance/boot_linux_console.py.

Sure I will add and send next spin.

Thanks,
Sundeep
>
> Thanks!
>
> Phil.
> >
> > Subbaraya Sundeep (2):
> >    hw/net: Add Smartfusion2 emac block
> >    msf2: Add EMAC block to SmartFusion2 SoC
> >
> >   MAINTAINERS                |   2 +
> >   hw/arm/msf2-soc.c          |  21 +-
> >   hw/net/Makefile.objs       |   1 +
> >   hw/net/msf2-emac.c         | 556 ++++++++++++++++++++++++++++++++++++=
+++++++++
> >   include/hw/arm/msf2-soc.h  |   3 +
> >   include/hw/net/msf2-emac.h |  50 ++++
> >   6 files changed, 632 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/net/msf2-emac.c
> >   create mode 100644 include/hw/net/msf2-emac.h
> >
>

