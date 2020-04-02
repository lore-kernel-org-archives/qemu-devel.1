Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A206206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hysS8l2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A206206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzsJ-0003r6-4c
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jJzrS-00035o-Di
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jJzrQ-0003P9-7o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:26:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jJzrQ-0003Ox-4V
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585833979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=391BggxrLydLXOUG5ViV/Po2ozOM0pnDVm4+1mwpoUA=;
 b=hysS8l2MZHaT69mHMXyAxK/gstBDxjSYzHZUyswFF/QdFy6i4n04cKIqhiRHTve7HKEIDL
 EN6TTGCwlE0zrMD21Vu+y2rYfmTIdPXviMkNJwS+9VGftuTvv4SZGNIVcZwnCY0de51Xgd
 m1qTRSL3a7AeK/CvsJe+Ljv9zEXbHhU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-myos7O2hMcOoOdnB_AtbyA-1; Thu, 02 Apr 2020 09:25:53 -0400
X-MC-Unique: myos7O2hMcOoOdnB_AtbyA-1
Received: by mail-ua1-f71.google.com with SMTP id 77so1201745uaj.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 06:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=391BggxrLydLXOUG5ViV/Po2ozOM0pnDVm4+1mwpoUA=;
 b=d2MP5a9WLAYbVaQFMF12ZD/+3zCG7uG05j/tjSF4Rb+GnRL9FiOkZh/K5bz5DrhrD+
 b6Jig62hkaATTY6zDTWcpkOLrMrlJDJ/auZmqLH5WdWtf/mHAMabuLQtY5GPQPbcKJoM
 xUfHEyPKyL/+rMPCfHno6BtYRfL2m/uWz0yT/F8MIi/FA50Dj0ix0ZpI4Ult5Enwsgzb
 GjJCdxzpmuYpFjZjaxl6q5Ya+EAM/3focL9lOowHq/0ZF0DZC8z6WBTmkyHHH0lzpk3a
 LY1RJJze+cTTdKlSwQ1x/Bwii9C13NYE0fjXEP4yrMmeLAVKFUbj2Su7TM+YkY03V7cz
 gKDA==
X-Gm-Message-State: AGi0PuacS04l/NGA2BntXbPUJgPuRdmD01PymT6/gTdjBcDF5yjIIx8W
 SmAa6r47jhmx+6epfpQZQXvIw+aRSOHXruL8eiGvj1rodaG2Z/FIyO1CiApRbTX/PGvGFVV1kES
 9rKILYDCmkQ6UMq6w/0tb06Cr9k6G2Pg=
X-Received: by 2002:a1f:7f1d:: with SMTP id o29mr2160059vki.101.1585833952021; 
 Thu, 02 Apr 2020 06:25:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZ4A/nXn9HhuOOKKcrhYObPQKaWz+EsQ3jP7tsZ7WmGVmCz/GGBX5Qow58LcRYPMDJQsqm8kT8XaTVaZjo69w=
X-Received: by 2002:a1f:7f1d:: with SMTP id o29mr2160020vki.101.1585833951633; 
 Thu, 02 Apr 2020 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
 <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
 <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
 <d52e1d9d-f892-f760-6bca-e37689cff362@redhat.com>
 <581e054a-b3a0-fe3c-fc09-f9dcab7f08c7@redhat.com>
In-Reply-To: <581e054a-b3a0-fe3c-fc09-f9dcab7f08c7@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Thu, 2 Apr 2020 10:25:40 -0300
Message-ID: <CAKJDGDZz+rzvrTbHDVY1ibgfq-7kpQXFJfqub5-Y-2s96nBQ4g@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 8:08 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> This issue persists, OTOH the good news is caching is working:
>
> https://travis-ci.org/github/philmd/qemu/builds/670078763#L1626
>

Philippe, do you have a way to clean up the Travis cache and try it
again? Last week, when I was investigating the previous problem you
reported, I had the same issue as you are having now. The problem just
disappeared without any action. I could not reproduce the problem now
on an empty cache using the same command you used. I suspect the
previous bug left some inconsistencies in the cache.

[wrampazz@wrampazz qemu.philippe]$ avocado --config ../avocado.conf
assets fetch tests/acceptance/*.py
Fetching assets from tests/acceptance/boot_linux_console.py.
  File https://archives.fedoraproject.org/pub/archive/fedora/linux/releases=
/29/Everything/x86_64/os/images/pxeboot/vmlinuz
fetched or already on cache.
  File http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main=
/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
fetched or already on cache.
  File http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main=
/l/linux-2.6/linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb
fetched or already on cache.
  File http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/main=
/l/linux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/8584a59ed9e5eb5ee7ca9=
1f6d74bbb06619205b8/rootfs/mips/rootfs.cpio.gz
fetched or already on cache.
  File https://github.com/philmd/qemu-testing-blob/raw/9ad2df38/mips/malta/=
mips64el/vmlinux-3.19.3.mtoman.20150408
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/8584a59e/rootfs/mipse=
l64/rootfs.mipsel64r1.cpio.gz
fetched or already on cache.
  File https://archives.fedoraproject.org/pub/archive/fedora/linux/releases=
/29/Everything/aarch64/os/images/pxeboot/vmlinuz
fetched or already on cache.
  File https://archives.fedoraproject.org/pub/archive/fedora/linux/releases=
/29/Everything/armhfp/os/images/pxeboot/vmlinuz
fetched or already on cache.
  File https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binari=
es/fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot
fetched or already on cache.
  File https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binari=
es/fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin
fetched or already on cache.
  File http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmwa=
re/raspberrypi-kernel_1.20190215-1_armhf.deb
fetched or already on cache.
  File https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/mai=
n/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df3170c=
546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.cpio.gz
fetched or already on cache.
  File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-d=
ev-sunxi_5.75_armhf.deb
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df3170c=
546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.cpio.gz
fetched or already on cache.
  File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-d=
ev-sunxi_5.75_armhf.deb
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df3170c=
546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.ext2.gz
fetched or already on cache.
  File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-d=
ev-sunxi_5.75_armhf.deb
fetched or already on cache.
  File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-d=
ev-sunxi_5.75_armhf.deb
fetched or already on cache.
  File https://github.com/groeck/linux-build-test/raw/2eb0a73b5d5a28df3170c=
546ddaaa9757e1e0848/rootfs/arm/rootfs-armv7a.cpio.gz
fetched or already on cache.
  File https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-d=
ev-sunxi_5.75_armhf.deb
fetched or already on cache.
  File http://storage.kernelci.org/images/rootfs/buildroot/kci-2019.02/arme=
l/base/rootfs.ext2.xz
fetched or already on cache.
  File https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangepipc=
_bionic_current_5.3.9.7z
fetched or already on cache.
  File http://snapshot.debian.org/archive/debian/20200108T145233Z/pool/main=
/u/u-boot/u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb
fetched or already on cache.
  File https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/=
gzimg/armv7.img.gz
fetched or already on cache.
  File https://archives.fedoraproject.org/pub/archive/fedora-secondary/rele=
ases/29/Everything/s390x/os/images/kernel.img
fetched or already on cache.
  File http://archive.debian.org/debian/dists/lenny/main/installer-alpha/cu=
rrent/images/cdrom/vmlinuz
fetched or already on cache.
  File https://archives.fedoraproject.org/pub/archive/fedora-secondary/rele=
ases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz
fetched or already on cache.
  File https://snapshot.debian.org/archive/debian-ports/20191021T083923Z/po=
ol-m68k/main/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb
fetched or already on cache.
Fetching assets from tests/acceptance/boot_linux.py.
Fetching assets from tests/acceptance/cpu_queries.py.
Fetching assets from tests/acceptance/empty_cpu_model.py.
Fetching assets from tests/acceptance/linux_initrd.py.
  File https://archives.fedoraproject.org/pub/archive/fedora/linux/releases=
/18/Fedora/x86_64/os/images/pxeboot/vmlinuz
fetched or already on cache.
  File https://archives.fedoraproject.org/pub/archive/fedora/linux/releases=
/28/Everything/x86_64/os/images/pxeboot/vmlinuz
fetched or already on cache.
Fetching assets from tests/acceptance/linux_ssh_mips_malta.py.
Fetching assets from tests/acceptance/machine_arm_integratorcp.py.
  File https://github.com/zayac/qemu-arm/raw/master/arm-test/kernel/zImage.=
integrator
fetched or already on cache.
  File https://github.com/zayac/qemu-arm/raw/master/arm-test/kernel/arm_roo=
t.img
fetched or already on cache.
  File https://github.com/torvalds/linux/raw/v2.6.12/drivers/video/logo/log=
o_linux_vga16.ppm
fetched or already on cache.
Fetching assets from tests/acceptance/machine_arm_n8x0.py.
  File http://stskeeps.subnetmask.net/meego-n8x0/meego-arm-n8x0-1.0.80.2010=
0712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
fetched or already on cache.
Fetching assets from tests/acceptance/machine_m68k_nextcube.py.
  File http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/68040_Non-=
Turbo_Chipset/Rev_2.5_v66.BIN
fetched or already on cache.
Fetching assets from tests/acceptance/machine_mips_malta.py.
  File https://github.com/philmd/qemu-testing-blob/raw/a5966ca4b5/mips/malt=
a/mips64el/vmlinux-4.7.0-rc1.I6400.gz
fetched or already on cache.
  File https://github.com/torvalds/linux/raw/v2.6.12/drivers/video/logo/log=
o_linux_vga16.ppm
fetched or already on cache.
Fetching assets from tests/acceptance/machine_sparc_leon3.py.
  File http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin
fetched or already on cache.
Fetching assets from tests/acceptance/migration.py.
Fetching assets from tests/acceptance/pc_cpu_hotplug_props.py.
Fetching assets from tests/acceptance/ppc_prep_40p.py.
  File ftp://ftp.boulder.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG
fetched or already on cache.
  File https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/NetBSD-4.0/prep/ins=
tallation/floppy/generic_com0.fs
fetched or already on cache.
  File https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/NetBSD-7.1.2-prep.iso
fetched or already on cache.
Fetching assets from tests/acceptance/version.py.
Fetching assets from tests/acceptance/virtio_check_params.py.
Fetching assets from tests/acceptance/virtio_version.py.
Fetching assets from tests/acceptance/vnc.py.
Fetching assets from tests/acceptance/x86_cpu_model_versions.py.
[wrampazz@wrampazz qemu.philippe]$


