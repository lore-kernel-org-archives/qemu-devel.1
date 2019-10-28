Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C4F20830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MayGkjrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C4F20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPBxc-00077j-L2
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 16:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPBwX-0005bZ-0d
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPBwU-0003nZ-P8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:48:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPBwS-0003ly-Ni
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572295723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVvsJw7P082vyOaC543TQCPovVzSTgCaxzjMNTZPxmg=;
 b=MayGkjrZpd1XzOBrsm9dG6JDBiNowXFu6eMwtVX4oZggOFQsf5JwdDaSRVH1oJ00xittuF
 EJ/2K/p4cXXCRMGLQVhl6WIhPLCfmlqo0UmDkLhywRuoeklV0vR8ZxRq0Yc4TNGWW4l1Jl
 sfKOb+B4zCifW1m5hoAni5bDWFAFAMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-4FHSRmVIMKWh3dZa1mRu3A-1; Mon, 28 Oct 2019 16:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0C0A85B6EE;
 Mon, 28 Oct 2019 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D11D55D9C8;
 Mon, 28 Oct 2019 20:48:31 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:48:29 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 22/26] tests/boot_linux_console: Boot Linux and run few
 commands on raspi3
Message-ID: <20191028204829.GD18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-23-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-23-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4FHSRmVIMKWh3dZa1mRu3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:37AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Add a test which boots Linux and run basic commands using the serial
> port console.
>=20
> The kernel image is built by the Debian project:
> https://wiki.debian.org/RaspberryPi
>=20
> The DeviceTree blob comes from the official Raspberry Pi project:
> https://www.raspberrypi.org/
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> This test can be run using:
>=20
>   $ avocado run --show=3Dconsole,app run -t machine:raspi3 tests/acceptan=
ce
>   console: [    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lis=
ts.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-=
2 (2018-01-06)
>   console: [    0.000000] Boot CPU: AArch64 Processor [410fd034]
>   console: [    0.000000] Machine model: Raspberry Pi 3 Model B
>   console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (opti=
ons '')
>   console: [    0.000000] bootconsole [pl11] enabled
>   [...]
>   console: Starting network: OK
>   console: Found console ttyAMA0
>   console: Boot successful.
>   console: / # cat /proc/cpuinfo
>   console: processor      : 0
>   console: BogoMIPS       : 125.00
>   console: r      : 0x41
>   console: CPU architecture: 8
>   console: CPU variant
>   console: : 0x0
>   console: CPU part       : 0xd03
>   console: CPU revision   : 4
>   console: / # uname -a
>   console: Linux buildroot 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-0=
1-06) aarch64 GNU/Linux
>   console: reboot
>   console: / # reboot
>   console: / # Found console ttyAMA0
>   console: Stopping network: OK
>   console: Saving random seed... done.
>   console: Stopping logging: OK
>   console: umount: devtmpfs busy - remounted read-only
>   console: umount: can't unmount /: Invalid argument
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: kvm: exiting hardware virtualization
>   console: reboot: Restarting system
>   PASS (11.08 s)
>=20
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: Use archive.gzip_uncompress (Cleber)
>=20
> some chars are scrambled on the console?
> Cleber ran this 100 times and doesn't have issue.
> ---
>  tests/acceptance/boot_linux_console.py | 48 ++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 1c9ff2bda3..dc27d79199 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -338,6 +338,54 @@ class BootLinuxConsole(MachineTest):
>          """
>          self.do_test_arm_raspi2(1)
> =20
> +    def test_arm_raspi3_initrd_uart0(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:raspi3
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20180106T174014Z/pool/main/l/linux/'
> +                   'linux-image-4.14.0-3-arm64_4.14.12-2_arm64.deb')
> +        deb_hash =3D 'e71c995de57921921895c1162baea5df527d1c6b'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.14.0-3-arm6=
4')
> +
> +        dtb_url =3D ('https://github.com/raspberrypi/firmware/raw/'
> +                   '1.20180313/boot/bcm2710-rpi-3-b.dtb')
> +        dtb_hash =3D 'eb14d67133401ef2f93523be7341456d38bfc077'
> +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> +
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
> +                      'arm64/rootfs.cpio.gz')
> +        initrd_hash =3D '6fd05324f17bb950196b5ad9d3a0fa996339f4cd'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dini=
trd_hash)
> +        initrd_path =3D self.workdir + "rootfs.cpio"
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_machine('raspi3')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dpl011,0x3f201000 console=3Dtt=
yAMA0 ' +
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Boot successful.',
> +                                      failure_message=3D'-----[ cut here=
 ]-----')
> +

With the previous refactors to wait_for_console_pattern(), this should beco=
me:

        wait_for_console_pattern(self,
                                 'Boot successful.',
                                 failure_message=3D'-----[ cut here ]-----'=
)

- Cleber.


