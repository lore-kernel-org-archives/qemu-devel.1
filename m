Received: from eggs.gnu.org ([2001:4830:134:3::10]:52028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7Uiq-0001QC-Um
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7Uin-0004gQ-Pm
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g7Uin-0004eu-HG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A82043082128
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 00:08:56 +0000 (UTC)
References: <20180928003058.12786-1-philmd@redhat.com>
	<20180928003058.12786-3-philmd@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <227be6c2-3bd7-ac0e-91d7-fa64991424f7@redhat.com>
Date: Tue, 2 Oct 2018 20:08:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180928003058.12786-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] acceptance tests: Add EDK2 OVMF
 boot and debug console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 9/27/18 8:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test boots OVMF and check the debug console (I/O port on the ISA b=
us)
> report enough information on the initialized devices.
>=20
> Example:
>=20
>     $ avocado --show=3DQMP,serial run tests/acceptance/boot_firmware.py
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> - how to refactor common code from test_seabios() (previous patch)?
> ---
>  tests/acceptance/boot_firmware.py | 52 +++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_=
firmware.py
> index a41e04936d..05f6728212 100644
> --- a/tests/acceptance/boot_firmware.py
> +++ b/tests/acceptance/boot_firmware.py
> @@ -70,3 +70,55 @@ class BootFirmwareX86(Test):
>              if line + '\n' not in lines:
>                  self.fail('missing: %s' % line)
>          shutil.rmtree(tmpdirname, ignore_errors=3DTrue)

Almost every comment on the previous patch applies here of course.
Because of that, it may make sense to generalize some of these patterns
into utility methods and/or, move some common setup code into a setUp()
method.

> +
> +    def test_ovmf(self):
> +        tmpdirname =3D tempfile.mkdtemp()
> +        debugcon_path =3D os.path.join(tmpdirname, 'debugconsole.log')
> +        serial_logger =3D logging.getLogger('serial')
> +        debugcon_logger =3D logging.getLogger('debugcon')
> +
> +        self.vm.set_machine('pc')
> +        self.vm.set_console()
> +        self.vm.add_args('-nographic',
> +                         '-net', 'none',
> +                         '-global', 'isa-debugcon.iobase=3D0x402',
> +                         '-debugcon', 'file:%s' % debugcon_path,

For instance, the setting up of the machine type, console and these
common arguments seem to be good candidates to be moved to a common
setUp() method.

> +                         '--bios', '/usr/share/OVMF/OVMF_CODE.fd')

This would be the difference between the arguments of this and the
seabios test, so it could be given by itself here (with the rest on
setUp()).

> +        self.vm.launch()
> +        console =3D self.vm.console_socket.makefile()
> +
> +        # serial console checks
> +        timeout =3D time.time() + 15
> +        while True:
> +            msg =3D console.readline()
> +            if not '\x1b' in msg: # ignore ANSI sequences
> +                serial_logger.debug(msg.strip())
> +            if 'EDK II' in msg:
> +                break
> +            if time.time() > timeout:
> +                self.fail('OVMF failed to boot?')
> +

This seems to be a code block that could become something like:

   def check_boot(self, pattern, timeout):
       ...
       self.fail("Failed to boot")

IMO, a generic fail reason is enough, given that it's associated with
the "test_ovmf".

> +        # debug console checks
> +        expected =3D [
> +            'SEC: Normal boot',
> +            'S3 support was detected on QEMU',
> +            'Platform PEI Firmware Volume Initialization',
> +            'DXE IPL Entry',
> +            'Installing FVB for EMU Variable support',
> +            'DetectSmbiosVersion: SMBIOS version from QEMU: 0x0208',
> +            'SmbiosCreateTable: Initialize 32-bit entry point structur=
e',
> +            'PlatformBootManagerBeforeConsole',
> +            'OnRootBridgesConnected: root bridges have been connected,=
 '
> +                'installing ACPI tables',
> +            'Found LPC Bridge device',
> +            'PlatformBootManagerAfterConsole',
> +            'EfiBootManagerConnectAll',
> +            '[Bds]Booting EFI Internal Shell',
> +        ]
> +        lines =3D open(debugcon_path).readlines()
> +        for msg in lines:
> +            debugcon_logger.debug(msg.strip())
> +        for line in expected:
> +            if line + '\r\n' not in lines:
> +                self.fail('missing: %s' % line)
> +        shutil.rmtree(tmpdirname, ignore_errors=3DTrue)
>=20

And this could also become something like:

   def check_console(self, patterns):
      with open(self.test_logs["debugcon"]) as debugcon:
      content =3D debugcon.readlines()
      for expected in patterns:
          self.assertIn(expected, content)

Assuming "self.test_logs" is a byproduct of the "self.log_file()"
suggestion for the new feature given previously.
