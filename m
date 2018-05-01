Received: from eggs.gnu.org ([2001:4830:134:3::10]:48479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDayg-0003xB-4a
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDayd-0005ck-4W
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:30:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDayc-0005b2-Rp
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:30:15 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-4-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <46d433c0-eddd-03c8-d695-c30cd1ffd1e7@redhat.com>
Date: Tue, 1 May 2018 15:30:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] qemu.py: Check console arch is
 supported before calling mktemp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>



On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 0eecc44d09..379767b62f 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -189,6 +189,16 @@ class QEMUMachine(object):
>                  if option in item:
>                      return []
> =20
> +        device =3D '{dev_type},chardev=3Dconsole'
> +        if '86' in self._arch:
> +            device =3D device.format(dev_type=3D'isa-serial')
> +        elif 'ppc' in self._arch:
> +            device =3D device.format(dev_type=3D'spapr-vty')
> +        elif 's390x' in self._arch:
> +            device =3D device.format(dev_type=3D'sclpconsole')
> +        else:
> +            return []
> +
>          chardev =3D 'socket,id=3Dconsole,{address},server,nowait'
>          if console_address is None:
>              console_address =3D tempfile.mktemp()
> @@ -203,16 +213,6 @@ class QEMUMachine(object):
> =20
>          self._console_address =3D console_address
> =20
> -        device =3D '{dev_type},chardev=3Dconsole'
> -        if '86' in self._arch:
> -            device =3D device.format(dev_type=3D'isa-serial')
> -        elif 'ppc' in self._arch:
> -            device =3D device.format(dev_type=3D'spapr-vty')
> -        elif 's390x' in self._arch:
> -            device =3D device.format(dev_type=3D'sclpconsole')
> -        else:
> -            return []
> -
>          return ['-chardev', chardev,
>                  '-device', device]
> =20
>=20

I understand your point here, but I found the commit message to be
misleading.  You're probably referring to this snippet (from
tests/avocado/test_linux-boot-console.py):

   +    def setUp(self):
   +        self.console_path =3D tempfile.mkstemp()[1]

So I see the following points regarding this patch:

1) Function called is mkstemp(), and not mktemp(), assuming you meant
the one from the pasted snippet above.

2) The commit message should just state that it returns earlier when
architecture is not supported wrt console creation.
