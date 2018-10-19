Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDYmu-0002th-1H
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDYmq-0001q8-2A
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDYmp-0001oY-NR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:42:11 -0400
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-4-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0553e4ed-fab7-f286-52a0-8bd5240172a0@redhat.com>
Date: Fri, 19 Oct 2018 13:42:04 -0400
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests/acceptance: Add
 test_mips_4kc_malta in BootLinuxConsole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/13/18 11:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Similar to the test_x86_64_pc test, this boots a Linux kernel on a
> Malta board (MIPS 4Kc big-endian) and verify the serial is working.
>=20
> This test requires the dpkg-deb tool (apt/dnf install dpkg) to
> extract the kernel from the Debian package.
>=20

Debian packages are really "ar" archives, with a control.tar.gz and
data.tar.gz in them.  More on that later.

>   $ avocado --show=3Dconsole run -p arch=3Dmips tests/acceptance/boot_l=
inux_console.py
>   console: [    0.000000] Initializing cgroup subsys cpuset
>   console: [    0.000000] Initializing cgroup subsys cpu
>   console: [    0.000000] Linux version 2.6.32-5-4kc-malta (Debian 2.6.=
32-48) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 Sat=
 Feb 16 12:43:42 UTC 2013
>   console: [    0.000000]
>   console: [    0.000000] LINUX started...
>   console: [    0.000000] bootconsole [early0] enabled
>   console: [    0.000000] CPU revision is: 00019300 (MIPS 24Kc)
>   console: [    0.000000] FPU revision is: 00739300
>   console: [    0.000000] Determined physical RAM map:
>   console: [    0.000000]  memory: 00001000 @ 00000000 (reserved)
>   console: [    0.000000]  memory: 000ef000 @ 00001000 (ROM data)
>   console: [    0.000000]  memory: 005b7000 @ 000f0000 (reserved)
>   console: [    0.000000]  memory: 03958000 @ 006a7000 (usable)
>   console: [    0.000000] Wasting 54496 bytes for tracking 1703 unused =
pages
>   console: [    0.000000] Initrd not found or empty - disabling initrd
>   console: [    0.000000] Zone PFN ranges:
>   console: [    0.000000]   DMA      0x00000000 -> 0x00001000
>   console: [    0.000000]   Normal   0x00001000 -> 0x00003fff
>   console: [    0.000000] Movable zone start PFN for each node
>   console: [    0.000000] early_node_map[1] active PFN ranges
>   console: [    0.000000]     0: 0x00000000 -> 0x00003fff
>   console: [    0.000000] Built 1 zonelists in Zone order, mobility gro=
uping on.  Total pages: 16255
>   console: [    0.000000] Kernel command line: console=3DttyS0 printk.t=
ime=3D0
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 3aa4dbe5f9..81c96fc338 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,6 +9,7 @@
>  # later.  See the COPYING file in the top-level directory.
> =20
>  import logging
> +import subprocess

It's definitely your call, but I like to think that
avocado.utils.process provides simpler and more capable functions:

https://avocado-framework.readthedocs.io/en/65.0/api/utils/avocado.utils.=
html#avocado.utils.process.run

> =20
>  from avocado_qemu import Test
> =20
> @@ -47,3 +48,48 @@ class BootLinuxConsole(Test):
>                  break
>              if 'Kernel panic - not syncing' in msg:
>                  self.fail("Kernel panic reached")
> +
> +    def test_mips_4kc_malta(self):
> +        """
> +        This test requires the dpkg-deb tool (apt/dnf install dpkg) to=
 extract
> +        the kernel from the Debian package.
> +
> +        The kernel can be rebuilt using this Debian kernel source [1] =
and
> +        following the instructions on [2].
> +
> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-co=
mmon-tasks.html#s-common-official
> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#li=
nux-source-2.6.32_2.6.32-48
> +
> +        :avocado: tags=3Darch:mips
> +        """
> +        if self.arch !=3D 'mips': # FIXME use 'arch' tag in parent cla=
ss?
> +            self.cancel('Currently specific to the %s target arch' % s=
elf.arch)
> +

I missed how the arch tag in the parent class (common to all tests here)
would be useful for this specific test.

> +        deb_url =3D ('http://snapshot.debian.org/archive/debian/201302=
17T032700Z/'
> +                   'pool/main/l/linux-2.6/'
> +                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'=
)
> +        deb_hash =3D 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self=
.workdir]) # FIXME move to avocado ...

This could become:

 # from avocado.utils.process import run
 run("ar p %s data.tar.gz | tar zxf - -C %s
./boot/vmlinux-2.6.32-5-4kc-malta" % (deb_path, self.workdir), shell=3DTr=
ue)

> +        kernel_path =3D self.workdir + '/boot/vmlinux-2.6.32-5-4kc-mal=
ta'          # FIXME ... and use from assets?
> +

Putting produced/processed files back into the cache would be nice
addition to the asset fetcher (or related tools).  Not there yet, though.

> +        self.vm.set_arch(self.arch)
> +        self.vm.set_machine('malta')
> +        self.vm.set_console("") # XXX this disable isa-serial to use -=
serial ...

See the comments on the previous patch.  Basically, if a machine doesn't
need an explicit console device to be added, set_console() should do
just that (not add one).  The ideal API would be to call set_console()
without any explicit parameter IMO.

That assumes, what I believe to be true, that we don't want to setup
multiple *console* devices per QEMUMachine, right?

Regards,
- Cleber.

> +        kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
> +        self.vm.add_args('-m', "64",
> +                         '-serial', "chardev:console", # XXX ... here.
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +
> +        # FIXME below to parent class?
> +        self.vm.launch()
> +        console =3D self.vm.console_socket.makefile()
> +        console_logger =3D logging.getLogger('console')
> +        while True:
> +            msg =3D console.readline()
> +            console_logger.debug(msg.strip())
> +            if 'Kernel command line: %s' % kernel_command_line in msg:
> +                break
> +            if 'Kernel panic - not syncing' in msg:
> +                self.fail("Kernel panic reached")
>=20
