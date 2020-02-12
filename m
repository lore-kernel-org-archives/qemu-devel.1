Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDDC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAA720848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8Q2rLpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAA720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j206q-0007Ka-U9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2069-0006Yj-2k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2067-0006bD-CG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:03:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2067-0006ai-8p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581544986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL84po45IIdO6u5riFXtp0yYxJzH+jQWXd0Iz74mh4Y=;
 b=a8Q2rLpl66yWCPqV2rSgd2pok4KxPat2igiWwYyI63ic1QJK+aKwcK+Q/8VmuI87t8woIu
 9IcHnO+5EFtt+Ca/Lq3tcbCk+JZ2SqdNLNdWGrv20NDIuHOcNP5nrEe0vIJeMncC6c90ZC
 g1dOvLfWQqpLLbmspVaGX4+ZY9W3cpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Lze4IsvlN8mg-kQbt8YR4g-1; Wed, 12 Feb 2020 17:02:48 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so1398432wrp.8
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bHrOCkcq5rE/Eyjh4EHUzVSgTZl81BMuDnCzDms2+Nw=;
 b=HtiDLbtWxbmPmAAzAitO5vW1C4aZ0mCEB5LTUqI4NpRq1Y1BNAeDh8Zh7wRrtzeew3
 sqBwpRA+T4J00wxOAIVoIDKN0BZ+bNCoqFsjidKa+nsLmTOb10M/JSlXoCIdSOab/hhk
 5oSvb7MR4aJpr4Uuu+H8KpUdXJXItmNDc7En8AedxQCg24u2alXrr4du+mzVXf0WcvCu
 1YJ1a5rmvq27Dbe8/cNKwzq1dJM/NgcXqHclO8TpEEQXAj7tkIu7Eza/oebnCbT2dUrs
 CgfT6q3b8W3EitmIvOdk/2G3MLCKUwpkvl9xa2ol5fwmJkC1x9k2d5SB/Dfg71zuwyEo
 Zdrg==
X-Gm-Message-State: APjAAAXy9TPWGufbKZ8JNKd05KDSU+G0RdQ4Md1rH/rQ7AkKH74kzDrh
 ybFrRnO7TJm4GOsjeRV+bX5hyLWRJ0X27mD72JCYUVXgj+CXUtr43AKGna4KdLNuLo3jIh6GMDY
 K8r0s2iwZGwQLPk0=
X-Received: by 2002:adf:f58c:: with SMTP id f12mr16573536wro.22.1581544967251; 
 Wed, 12 Feb 2020 14:02:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqycYiElMgzrQNgG+kQtrJOiKOc4M7UNC0xFaEYE7jmmNlbxBpIoKfBI6wRfE+Omgyn0GQacqw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr16573492wro.22.1581544966862; 
 Wed, 12 Feb 2020 14:02:46 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z133sm241788wmb.7.2020.02.12.14.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:02:46 -0800 (PST)
Subject: Re: [PATCH v4 16/20] tests/boot_linux_console: Add a SLOW test
 booting Ubuntu on OrangePi PC
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-17-nieklinnenbank@gmail.com>
 <6dd1ab52-3a75-c439-f26b-fa04d797059c@amsat.org>
 <CAPan3Wq8eftDpzxzGoeY5Qhpvcw8oA0vFebXwmSbT+78UaDRcg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <479657c1-9adf-a6ee-d619-8e463acda86b@redhat.com>
Date: Wed, 12 Feb 2020 23:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3Wq8eftDpzxzGoeY5Qhpvcw8oA0vFebXwmSbT+78UaDRcg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Lze4IsvlN8mg-kQbt8YR4g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 10:21 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> On Sun, Jan 19, 2020 at 11:30 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org=20
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     On 1/19/20 1:50 AM, Niek Linnenbank wrote:
>      > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>      >
>      > This test boots Ubuntu Bionic on a OrangePi PC board.
>      >
>      > As it requires 1GB of storage, and is slow, this test is disabled
>      > on automatic CI testing.
>      >
>      > It is useful for workstation testing. Currently Avocado timeouts t=
oo
>      > quickly, so we can't run userland commands.
>      >
>      > The kernel image and DeviceTree blob are built by the Armbian
>      > project (based on Debian):
>      > https://www.armbian.com/orange-pi-pc/
>      >
>      > The Ubuntu image is downloaded from:
>      > https://dl.armbian.com/orangepipc/Bionic_current
>=20
>     I forgot the image is compressed is compressed with 7z, which is not
>     provided by avocado.utils.archive. This patch requires more checks, s=
ee
>     inlined...
>=20
>      >
>      > This test can be run using:
>      >
>      >=C2=A0 =C2=A0$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \
>      >=C2=A0 =C2=A0 =C2=A0avocado --show=3Dapp,console run -t machine:ora=
ngepi-pc \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/acceptance/boot_linux_console.py
>      >=C2=A0 =C2=A0console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:=
08:35 +0100)
>      >=C2=A0 =C2=A0console: DRAM: 1024 MiB
>      >=C2=A0 =C2=A0console: Failed to set core voltage! Can't set CPU fre=
quency
>      >=C2=A0 =C2=A0console: Trying to boot from MMC1
>      >=C2=A0 =C2=A0console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:3=
5 +0100)
>     Allwinner Technology
>      >=C2=A0 =C2=A0console: CPU:=C2=A0 =C2=A0Allwinner H3 (SUN8I 0000)
>      >=C2=A0 =C2=A0console: Model: Xunlong Orange Pi PC
>      >=C2=A0 =C2=A0console: DRAM:=C2=A0 1 GiB
>      >=C2=A0 =C2=A0console: MMC:=C2=A0 =C2=A0mmc@1c0f000: 0
>      >=C2=A0 =C2=A0[...]
>      >=C2=A0 =C2=A0console: Uncompressing Linux... done, booting the kern=
el.
>      >=C2=A0 =C2=A0console: Booting Linux on physical CPU 0x0
>      >=C2=A0 =C2=A0console: Linux version 5.3.9-sunxi (root@builder) (gcc=
 version
>     8.3.0 (GNU Toolchain for the A-profile Architecture 8.3-2019.03
>     (arm-rel-8.36))) #19.11.3 SMP Mon Nov 18 18:49:43 CET 2019
>      >=C2=A0 =C2=A0console: CPU: ARMv7 Processor [410fc075] revision 5 (A=
RMv7),
>     cr=3D50c5387d
>      >=C2=A0 =C2=A0console: CPU: div instructions available: patching div=
ision code
>      >=C2=A0 =C2=A0console: CPU: PIPT / VIPT nonaliasing data cache, VIPT=
 aliasing
>     instruction cache
>      >=C2=A0 =C2=A0console: OF: fdt: Machine model: Xunlong Orange Pi PC
>      >=C2=A0 =C2=A0[...]
>      >=C2=A0 =C2=A0console: EXT4-fs (mmcblk0p1): mounted filesystem with =
writeback
>     data mode. Opts: (null)
>      >=C2=A0 =C2=A0console: done.
>      >=C2=A0 =C2=A0console: Begin: Running /scripts/local-bottom ... done=
.
>      >=C2=A0 =C2=A0console: Begin: Running /scripts/init-bottom ... done.
>      >=C2=A0 =C2=A0console: systemd[1]: systemd 237 running in system mod=
e. (...)
>      >=C2=A0 =C2=A0console: systemd[1]: Detected architecture arm.
>      >=C2=A0 =C2=A0console: Welcome to Ubuntu 18.04.3 LTS!
>      >=C2=A0 =C2=A0console: systemd[1]: Set hostname to <orangepipc>.
>      >
>      > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>      > [NL: rename in commit message Raspbian to Armbian, remove
>     vm.set_machine()]
>      > [NL: changed test to boot from SD card via BootROM]
>      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > ---
>      >=C2=A0 tests/acceptance/boot_linux_console.py | 41
>     ++++++++++++++++++++++++++
>      >=C2=A0 1 file changed, 41 insertions(+)
>      >
>      > diff --git a/tests/acceptance/boot_linux_console.py
>     b/tests/acceptance/boot_linux_console.py
>      > index 50294e1675..399d5062db 100644
>      > --- a/tests/acceptance/boot_linux_console.py
>      > +++ b/tests/acceptance/boot_linux_console.py
>=20
>     This patch needs:
>=20
>      =C2=A0 from avocado.utils.path import find_command
>=20
>      =C2=A0 P7ZIP_AVAILABLE =3D True
>      =C2=A0 try:
>      =C2=A0 =C2=A0 =C2=A0 find_command('7z')
>      =C2=A0 except CmdNotFoundError:
>      =C2=A0 =C2=A0 =C2=A0 P7ZIP_AVAILABLE =3D False
>=20
>      > @@ -591,6 +591,47 @@ class BootLinuxConsole(Test):
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_patter=
n(self, 'reboot',
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'reboot:
>     Restarting system')
>      >
>      > +=C2=A0 =C2=A0 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'=
),
>     'storage limited')
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0@skipUnless(P7ZIP_AVAILABLE, '7z not inst=
alled')
>=20
>=20
> Ah indeed, that makes sense. I'll add this check for v5.
> Now that we come accross this, I'm thinking that functionality like=20
> decompression
> might not be specific to the linux tests and perhaps should eventually=20
> come in a utility/helper .py file.

Yes, but it is quicker if you start this way where you use it, then when=20
another uses it he'll refactor the helper. Ideally this should go in the=20
avocado.archive package.

>=20
> Regards,
> Niek
>=20
>=20
>      > +=C2=A0 =C2=A0 def test_arm_orangepi_bionic(self):
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 196MB compress=
ed image and expand
>     it to 932MB...
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D ('https://dl.armbian.co=
m/orangepipc/archive/'
>      > +                  =20
>      =C2=A0'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D '196a8ffb72b0123d92cea=
4a070894813d305c71e'
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_7z =3D self.fetch_asset(im=
age_url,
>     asset_hash=3Dimage_hash)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_name =3D
>     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D os.path.join(self.work=
dir, image_name)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 process.run("7z e -o%s %s" % (self.wo=
rkdir, image_path_7z))
>=20
>     Because here 7z is called ^
>=20
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args('-drive', 'file=3D' =
+ image_path +
>     ',if=3Dsd,format=3Draw',
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0'-nic', 'user',
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0'-no-reboot')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_=
COMMON_COMMAND_LINE +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'console=3DttyS0,115200 '
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'loglevel=3D7 '
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'nosmp '
>      > +                            =20
>      =C2=A0'systemd.default_timeout_start_sec=3D9000 '
>      > +                            =20
>      =C2=A0'systemd.mask=3Darmbian-zram-config.service '
>      > +                            =20
>      =C2=A0'systemd.mask=3Darmbian-ramlog.service')
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern('U-Boot=
 SPL')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern('Autobo=
ot in ')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(sel=
f, ' ', '=3D>')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(sel=
f, "setenv
>     extraargs '" +
>      > +                                              =20
>     kernel_command_line + "'", '=3D>')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(sel=
f, 'boot',
>     'Starting kernel ...');
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern('system=
d[1]: Set hostname ' +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'to <=
orangepipc>')
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern('Starti=
ng Load Kernel
>     Modules...')
>      > +
>      >=C2=A0 =C2=A0 =C2=A0 def test_s390x_s390_ccw_virtio(self):
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:s390x
>      >
>=20
>=20
>=20
> --=20
> Niek Linnenbank
>=20


