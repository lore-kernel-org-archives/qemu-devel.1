Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B93C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 11:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F24B24690
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 11:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V34kEk/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F24B24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ismC8-0002nJ-6a
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 06:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ismBV-0002GQ-C8
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ismBS-0000N9-E5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:22:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ismBR-0000MT-TY
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579346548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33jlVoydYg/HEI+WdV72NSyntZE0fgO13cZjCkZu4n0=;
 b=V34kEk/qaS0kOt2kfrt3OKTKH4pNeBgAxddljTl4L6IJSi+JZixIvnsW4or7su4uAJfZQJ
 tS1JJUmCwMhza0TphDm0LbIlzUqZvAE2ElEd62fcy+FexF8Wpr/Cwkw5l1ukSlOlHUGk7v
 YbZouB3K7g2fwcClpn6OgHpFsicwPiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-pR413WDsOoWKkMPHUiAfuQ-1; Sat, 18 Jan 2020 06:22:23 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so11660156wrt.15
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 03:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nE0+vwvyzy3SC6fckVMOmInDDbmnTIQ9SvhnqGGIULo=;
 b=BAyCj7/bffmEqj+d3riUUTSqkypB5/BHvqyFaNIaFzJw8OowByb7+THKRR85ZXdVTi
 eK7SeDOa47yDsn9WhcsU5d5sTanAytuQqgzJ6Rw7fLyCOw932mR8V7c7x+wMXmJIHsHT
 I6GVc1lPG587RRuq8lLuECBgpZGE5S9Q50F/MucY+VMEXsgCVquy/OOFq0fcW6VQ0DMb
 HiKzttSgCCaj8muPnTJXRKUhbDn6KB5hNnUCuDw1PDyQUCvMuqR9dL/2WcOEewehX9fV
 uTC5ecqDUr+W46xgx6hC5M9ewlJvAtCV1QG2xMCPr026PIwyHAVoFxcQY2jEAI5ruX4A
 GYkQ==
X-Gm-Message-State: APjAAAVkzsuv4/pmvR7WWdP2nMiUDLN7wsri3IvD7uxMVF6J6IiKWyfH
 KEoTimMpzgEtkeZmUuBNtm2qZsO7BvS4beLAnew0S76+AyNy/oFprTN5ytKse/hVOJIJWQmojx2
 FvRLwUWH9OjpSYUE=
X-Received: by 2002:a1c:6605:: with SMTP id a5mr8908250wmc.112.1579346542092; 
 Sat, 18 Jan 2020 03:22:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyi2T2a8AHEA7HSI0WoI5a9ZWo0H9ktuK2WXwj03G3LE/mYiGp56sSvS4GJhUBtlti2dn49hQ==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr8908233wmc.112.1579346541828; 
 Sat, 18 Jan 2020 03:22:21 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id j12sm41160847wrw.54.2020.01.18.03.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 03:22:20 -0800 (PST)
Subject: Re: [PATCH v3 13/17] tests/boot_linux_console: Add a quick test for
 the OrangePi PC board
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-14-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b20d022-f3f8-4913-b157-73f42808a4c0@redhat.com>
Date: Sat, 18 Jan 2020 12:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-14-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: pR413WDsOoWKkMPHUiAfuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>=20
> The kernel image and DeviceTree blob are built by the Armbian
> project (based on Debian):
> https://www.armbian.com/orange-pi-pc/
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>    $ make check-venv
>    $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orangep=
i-pc tests/acceptance/boot_linux_console.py
>    JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
>    JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi:
>    console: Uncompressing Linux... done, booting the kernel.
>    console: Booting Linux on physical CPU 0x0
>    console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.=
2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 201=
9
>    console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c5=
387d
>    console: CPU: div instructions available: patching division code
>    console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instru=
ction cache
>    console: OF: fdt: Machine model: Xunlong Orange Pi PC
>    console: Memory policy: Data cache writealloc
>    console: OF: reserved mem: failed to allocate memory for node 'cma@4a0=
00000'
>    console: cma: Failed to reserve 128 MiB
>    console: psci: probing for conduit method from DT.
>    console: psci: PSCIv0.2 detected in firmware.
>    console: psci: Using standard PSCI v0.2 function IDs
>    console: psci: Trusted OS migration not required
>    console: random: get_random_bytes called from start_kernel+0x8d/0x3c2 =
with crng_init=3D0
>    console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 u=
73728
>    console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
>    console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
>    PASS (8.59 s)
>    JOB TIME   : 8.81 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [NL: rename in commit message Raspbian to Armbian]
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 9c6aa2040a..b58308d724 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -400,6 +400,32 @@ class BootLinuxConsole(Test):
>           self.wait_for_console_pattern('Boot successful.')
>           # TODO user command, for now the uart is stuck
>  =20
> +    def test_arm_orangepi(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.=
deb')
> +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.20.7-sunxi'=
)
> +        dtb_path =3D '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-p=
c.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        self.vm.set_machine('orangepi-pc')

Please remove the vm.set_machine() calls.

> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200n8 '
> +                               'earlycon=3Duart,mmio32,0x1c28000')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
> +
>       def test_s390x_s390_ccw_virtio(self):
>           """
>           :avocado: tags=3Darch:s390x
>=20


