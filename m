Received: from eggs.gnu.org ([2001:4830:134:3::10]:34536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDYiW-0007Hy-UB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDYiR-00065D-5C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDYiP-00063O-1B
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:37:37 -0400
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-3-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <6dd4b200-03d1-728d-45b2-a89c5461d5cc@redhat.com>
Date: Fri, 19 Oct 2018 13:37:32 -0400
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 2/6] tests/acceptance: Add a kludge
 to not use the default console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 10/13/18 11:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The board already instantiate the proper devices, we don't want to
> add extra devices but connect the chardev to one of the serial already
> available.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index fca9b76990..7e779954e6 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -221,8 +221,10 @@ class QEMUMachine(object):
>                                                   self._name + "-consol=
e.sock")
>              chardev =3D ('socket,id=3Dconsole,path=3D%s,server,nowait'=
 %
>                         self._console_address)
> -            device =3D '%s,chardev=3Dconsole' % self._console_device_t=
ype
> -            args.extend(['-chardev', chardev, '-device', device])
> +            args.extend(['-chardev', chardev])
> +            if len(self._console_device_type):

Considering `self._console_device_type` will come from `set_console()`,
either explicitly as the "device_type" parameter, or from the list on
CONSOLE_DEV_TYPES, wouldn't it make more sense to just drop the
definitions for the machine types that don't need an explicit device?

That way, self.set_console() could be called with no arguments (instead
of the empty string).  And this check would become:

  if self._console_device_type is not None:

> +                device =3D '%s,chardev=3Dconsole' % self._console_devi=
ce_type
> +                args.extend(['-device', device])
>          return args
> =20
>      def _pre_launch(self):
>=20
