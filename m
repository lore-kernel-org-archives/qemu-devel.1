Received: from eggs.gnu.org ([2001:4830:134:3::10]:49756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZrO-0002GU-S2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZrL-00067s-Mz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:33:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYZrL-00066s-FV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:33:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id z13-v6so9749849wma.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:33:27 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-6-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180622004435.10291-6-f4bug@amsat.org>
Date: Thu, 28 Jun 2018 17:33:24 +0100
Message-ID: <87fu16vpkb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] tests/acceptance: Add a kludge
 to not use the default console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> The board already instantiate the proper devices, we don't want to
> add extra devices but connect the chardev to one of the serial already
> available.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py                        | 6 ++++--
>  tests/acceptance/boot_linux_console.py | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f099ce7278..7a975f4538 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -211,8 +211,10 @@ class QEMUMachine(object):
>                                                   self._name + "-console.=
sock")
>              chardev =3D ('socket,id=3Dconsole,path=3D%s,server,nowait' %
>                         self._console_address)
> -            device =3D '%s,chardev=3Dconsole' % self._console_device_type
> -            args.extend(['-chardev', chardev, '-device', device])
> +            args.extend(['-chardev', chardev])
> +            if len(self._console_device_type):
> +                device =3D '%s,chardev=3Dconsole' % self._console_device=
_type
> +                args.extend(['-device', device])
>          return args
>
>      def _pre_launch(self):
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 72cf5e943c..510742c4c7 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -69,9 +69,10 @@ class BootLinuxConsoleMips(Test):
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
>
>          self.vm.set_machine('malta')
> -        self.vm.set_console()
> +        self.vm.set_console("") # FIXME this disable isa-serial to
>          use -serial

This is reminiscent of assumptions libvirt made about serial consoles.
Does -serial not work on x86 for old style setups? I'm sure I have
x86-64 boots with -serial mon:stdio lines.

>          kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
>          self.vm.add_args('-m', "64",
> +                         '-serial', "chardev:console", # FIXME ... here.
>                           '-kernel', kernel_path,
>                           '-append', kernel_command_line)
>          self.vm.launch()


--
Alex Benn=C3=A9e
