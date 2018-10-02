Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7U3t-0001FE-1M
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7U3o-000673-Ub
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g7U3o-00066L-ME
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5613130832C2
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 23:26:35 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
References: <20180928003058.12786-1-philmd@redhat.com>
	<20180928003058.12786-2-philmd@redhat.com>
Message-ID: <3642a22b-6132-690b-b6af-58cf0dd12bdc@redhat.com>
Date: Tue, 2 Oct 2018 19:26:25 -0400
MIME-Version: 1.0
In-Reply-To: <20180928003058.12786-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/3] acceptance tests: Add SeaBIOS boot and
 debug console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 9/27/18 8:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test boots SeaBIOS and check the debug console (I/O port on the IS=
A bus)
> reports enough information on the initialized devices.
>=20
> Example:
>=20
>     $ avocado --show=3Ddebugcon run tests/acceptance/boot_firmware.py
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> - can we avoid the time.time() 2nd timeout check?
>=20

The problem here is that the "draining" of the console is done
synchronously and at the same time the "if 'No bootable device.' in msg"
check is performed.

If we split those, it could become a simple function that can be given
to wait_for():

https://avocado-framework.readthedocs.io/en/65.0/api/utils/avocado.utils.=
html#avocado.utils.wait.wait_for

Something like:

   if not wait_for(check_bootable(), 5):
       self.fail("Reason")

Greatly simplifying the code.

> - can we avoid tempfile.mkdtemp() + shutil.rmtree() with Python2?
>   (using context manager)

Yep, workdir is your friend.  More on that later.

> ---
>  tests/acceptance/boot_firmware.py | 72 +++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 tests/acceptance/boot_firmware.py
>=20
> diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_=
firmware.py
> new file mode 100644
> index 0000000000..a41e04936d
> --- /dev/null
> +++ b/tests/acceptance/boot_firmware.py
> @@ -0,0 +1,72 @@
> +# coding=3Dutf-8
> +#
> +# Functional test that boots SeaBIOS and checks the console
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import time
> +import shutil
> +import logging
> +import tempfile
> +
> +from avocado_qemu import Test
> +
> +
> +class BootFirmwareX86(Test):
> +    """
> +    Boots a firmware on a default PC machine and checks the debug cons=
ole is
> +    operational
> +
> +    :avocado: enable
> +    :avocado: tags=3Dx86_64,quick

Eventually, we'll need to have a predictable definition to, at least,
some of the tags.  I mean, I agree this *should* be a quick by test
(considering it's a functional test), but eventually we may want to set
some ranges for what we consider "quick", "slow" or "I'm gonna take my
time, don't wait on me". :)

> +    """
> +
> +    timeout =3D 15
> +
> +    def test_seabios(self):
> +        tmpdirname =3D tempfile.mkdtemp()

Every Avocado test has a "workdir" that can be used for temporary
content.  That property points to a directory will be discarded after
the test has finished.  Documentation is here:

https://avocado-framework.readthedocs.io/en/65.0/api/test/avocado.html#av=
ocado.Test.workdir

> +        debugcon_path =3D os.path.join(tmpdirname, 'debugconsole.log')
> +        serial_logger =3D logging.getLogger('serial')
> +        debugcon_logger =3D logging.getLogger('debugcon')
> +
> +        self.vm.set_machine('pc')
> +        self.vm.set_console()
> +        self.vm.add_args('-nographic',
> +                         '-net', 'none',
> +                         '-global', 'isa-debugcon.iobase=3D0x402',
> +                         '-debugcon', 'file:%s' % debugcon_path)
> +        self.vm.launch()
> +        console =3D self.vm.console_socket.makefile()
> +
> +        # serial console checks
> +        timeout =3D time.time() + 5
> +        while True:
> +            msg =3D console.readline()
> +            if not '\x1b' in msg: # ignore ANSI sequences
> +                serial_logger.debug(msg.strip())
> +            if 'No bootable device.' in msg:
> +                break
> +            if time.time() > timeout:
> +                self.fail('SeaBIOS failed to boot?')

It looks like tests such as this could benefit from having an async
method of draining a given file (descriptor or object) and putting that
into a log.  Then, the boilerplate code of reading from a file and
writing to a log could be avoided.

In theory, Avocado has such a tool:

https://avocado-framework.readthedocs.io/en/65.0/api/utils/avocado.utils.=
html#avocado.utils.process.FDDrainer

But it needs some TLC when it comes to being used on a test to really
remove boilerplate code. For instance, instead of having to do:

    debugcon_path =3D os.path.join(self.workdir, 'debug_console.log')
    debugcon_logger =3D logging.getLogger('debugcon')
    ...
    lines =3D open(debugcon_path).readlines()
    for msg in lines:
        debugcon_logger.debug(msg.strip())

One should be able to do:

   # debug_console.log is created with the content of debugcon_path
   self.log_file(debugcon_path, "debug_console")

> +
> +        # debug console checks
> +        expected =3D [
> +            'Running on QEMU (i440fx)',
> +            'Turning on vga text mode console',
> +            'Found 1 lpt ports',
> +            'Found 1 serial ports',
> +            'PS2 keyboard initialized',
> +        ]
> +        lines =3D open(debugcon_path).readlines()
> +        for msg in lines:
> +            debugcon_logger.debug(msg.strip())
> +        for line in expected:
> +            if line + '\n' not in lines:
> +                self.fail('missing: %s' % line)

A slightly more Pythonic version would be:

   with open(debugcon_path) as debugcon:
      content =3D debugcon.readlines()
      for exp in expected:
          self.assertIn(expected, content)

> +        shutil.rmtree(tmpdirname, ignore_errors=3DTrue)
>=20

And by using workdir you don't need this manual cleanup.
