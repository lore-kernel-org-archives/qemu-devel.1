Received: from eggs.gnu.org ([2001:4830:134:3::10]:47838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZhd-0005VU-V4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZhZ-0002wu-UD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:23:25 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYZhZ-0002vl-Ly
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:23:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id n17-v6so9186301wmh.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:23:21 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180622004435.10291-5-f4bug@amsat.org>
Date: Thu, 28 Jun 2018 17:23:18 +0100
Message-ID: <87in62vq15.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Similar to the BootLinuxConsoleX86_64 test:
> boot a Linux kernel on a Malta board and verify the serial is working.
>
> This test can be run using:
>
>     $ avocado run -t endian:big tests/acceptance
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 17dc8d58c1..72cf5e943c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -46,3 +46,41 @@ class BootLinuxConsoleX86_64(Test):
>                  break
>              if 'Kernel panic - not syncing' in msg:
>                  self.fail("Kernel panic reached")
> +
> +
> +class BootLinuxConsoleMips(Test):
> +    """
> +    Boots a mips Linux kernel and checks that the console is operational
> +    and the kernel command line is properly passed from QEMU to the kern=
el
> +
> +    :avocado: enable
> +    :avocado: tags=3Dendian:big
> +    :avocado: tags=3Darch:mips
> +    :avocado: tags=3Dboard:malta
> +    """
> +
> +    arch =3D "mips"
> +    timeout =3D 60
> +
> +    def test(self):
> +        kernel_url =3D ('http://people.debian.org/~aurel32/qemu/mips/'
> +                      'vmlinux-3.2.0-4-4kc-malta')
> +        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> +        kernel_path =3D self.fetch_asset(kernel_url,
> asset_hash=3Dkernel_hash)

I'm uncomfortable using "random" binaries of websites as the source of
our test kernels. I can see the justification for distro kernels as they
at least have the infrastructure to rebuild from source if you really
want to, but even then the distros don't cover a lot of the
architectures.

I had experimented with using docker based builds for building test
fixtures (see tests/docker/dockerbuilds):

   https://github.com/stsquad/qemu/tree/docker/linux-user-and-ltp-builds-v2

As these tests are fairly simple boot tests that just need kernels maybe
we could look at tooling up the generation of these images in a
repeatable way - similar to the way vmtest builds VMs.

> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
> +        self.vm.add_args('-m', "64",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
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

Of course for bonus points a simple rootfs with hackbench or some such
in it would be nice. But I appreciate this makes the building job a lot
more complex than just a kernel.

--
Alex Benn=C3=A9e
