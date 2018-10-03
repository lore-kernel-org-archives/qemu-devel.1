Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7Uu2-0004Vx-Di
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g7Uty-0001SB-8c
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g7Uty-0001RG-09
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:20:30 -0400
References: <20180928003058.12786-1-philmd@redhat.com>
	<20180928003058.12786-4-philmd@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c71fe8c8-9cfb-251b-cd7f-f8a339c443f8@redhat.com>
Date: Tue, 2 Oct 2018 20:20:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180928003058.12786-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] acceptance tests: Add EDK2 AAVMF
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>



On 9/27/18 8:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test boots EDK2 AAVMF and check the debug console (PL011) reports =
enough
> information on the initialized devices.
>=20
> Example:
>=20
>     $ avocado --show=3Dconsole run tests/acceptance/boot_firmware.py --=
cit-parameter-file aarch64.cit
>=20
> having aarch64.cit:
>=20
> [parameters]
> qemu_bin: aarch64-softmmu/qemu-system-aarch64
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> - requires (even for single parameter):
>   $ pip install avocado-framework-plugin-varianter-cit
>=20

Avocado 65.0 now features a core parameter passing option (one that
doesn't depend on the varianter).  Command line option is documented as:

  -p NAME_VALUE, --test-parameter NAME_VALUE
                Parameter name and value to pass to all tests. This is
                only applicable when not using a varianter plugin.
                This option format must be given in the NAME=3DVALUE
                format, and may be given any number of times, or per
                parameter.

> - use gzip kludge (avocado only support tarballs)
>=20

I'll finish the work to get that into the avocado.utils.archive module.

> - can not set $arch param since pick_default_qemu_bin() forces to host =
os.uname()[4]

This is definitely a common requirement, and something to be addressed
ASAP.  I have a patch on my tree (pretty simple change) that I'll be
sending shortly.

> ---
>  tests/acceptance/boot_firmware.py | 43 +++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_=
firmware.py
> index 05f6728212..4f5554c0ad 100644
> --- a/tests/acceptance/boot_firmware.py
> +++ b/tests/acceptance/boot_firmware.py
> @@ -10,6 +10,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> =20
>  import os
> +import gzip
>  import time
>  import shutil
>  import logging
> @@ -122,3 +123,45 @@ class BootFirmwareX86(Test):
>              if line + '\r\n' not in lines:
>                  self.fail('missing: %s' % line)
>          shutil.rmtree(tmpdirname, ignore_errors=3DTrue)
> +
> +
> +class BootFirmwareAarch64(Test):
> +    """
> +    Boots the EDK2 firmware on a default virt machine and checks the c=
onsole is
> +    operational
> +
> +    :avocado: enable
> +    :avocado: tags=3Darch:aarch64

Yay, I like where you're going here.  This matches what I said before
about having some standardization on the tags.

On a related topic, sometimes tests can be written in an abstract way
that parameters only will allow the same test to be reused in different
arches, but, sometimes we may need to explicit include/exclude some
tests on some executions - then tags could be a foundation for that.

> +    :avocado: tags=3Daarch64,quick
> +    """
> +
> +    timeout =3D 15
> +
> +    def test_aavmf(self):
> +        tmpdirname =3D tempfile.mkdtemp()
> +        image_url =3D ('http://snapshots.linaro.org/components/kernel/=
'
> +                    'leg-virt-tianocore-edk2-upstream/latest/'
> +                    'QEMU-AARCH64/DEBUG_GCC5/QEMU_EFI.img.gz')
> +        image_path_gz =3D self.fetch_asset(image_url)
> +        image_path =3D os.path.join(tmpdirname, 'flash.img')
> +        with gzip.open(image_path_gz) as gz, open(image_path, 'wb') as=
 img:
> +            shutil.copyfileobj(gz, img)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        self.vm.add_args('-nographic',
> +                         '-cpu', 'cortex-a57',
> +                         '-m', '1G',

Is there a reason for defining this exact amount of memory?  My question
has to do with the idea of setting some "sane" hardware defaults at the
base test level (to avoid boiler plate code).

> +                         '-pflash', image_path)
> +        self.vm.launch()
> +        console =3D self.vm.console_socket.makefile()
> +        serial_logger =3D logging.getLogger('serial')
> +
> +        # serial console checks
> +        while True:
> +            msg =3D console.readline()
> +            if not '\x1b' in msg: # ignore ANSI sequences
> +                serial_logger.debug(msg.strip())
> +            if 'Start PXE over IPv4InstallProtocolInterface:' in msg:
> +                break
> +        shutil.rmtree(tmpdirname, ignore_errors=3DTrue)
>=20

Again, seems like a candidate for the ideas presented on the previous
patches.

Thanks for sending those, lots of interesting opportunities.

- Cleber.
