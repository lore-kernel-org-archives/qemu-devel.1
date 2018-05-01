Received: from eggs.gnu.org ([2001:4830:134:3::10]:51530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDbEZ-0001Ke-3U
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDbEU-0003RA-F2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:46:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDbEU-0003QX-5T
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:46:38 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-6-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <df794f3f-d448-8caf-55de-9dd90e2fda08@redhat.com>
Date: Tue, 1 May 2018 15:46:27 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/7] avocado: Add an optional flag
 'login' to get_console()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>

On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Not all consoles require users to log in :/
>=20

You're breaking a lot of assumptions here (in a good way) ;).

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/avocado/avocado_qemu/test.py | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado=
_qemu/test.py
> index 1ead917014..ac8ee6d250 100644
> --- a/tests/avocado/avocado_qemu/test.py
> +++ b/tests/avocado/avocado_qemu/test.py
> @@ -244,7 +244,7 @@ class _VM(qemu.QEMUMachine):
>          super(_VM, self).__init__(qemu_bin, name=3Dself.name, arch=3Da=
rch)
>          logging.getLogger('QMP').setLevel(logging.INFO)
> =20
> -    def get_console(self, console_address=3DNone, prompt=3Dr"[\#\$] ")=
:
> +    def get_console(self, console_address=3DNone, prompt=3Dr"[\#\$] ",=
 login=3DTrue):
>          """
>          :param address: Socket address, can be either a unix socket pa=
th
>                          (string) or a tuple in the form (address, port=
)
> @@ -252,9 +252,6 @@ class _VM(qemu.QEMUMachine):
>          :param prompt: The regex to identify we reached the prompt.
>          """
> =20
> -        if not all((self.username, self.password)):
> -            raise QEMULoginError('Username or password not set.')
> -
>          if not self.is_running():
>              raise QEMULoginError('VM is not running.')
> =20
> @@ -272,13 +269,17 @@ class _VM(qemu.QEMUMachine):
>              nc_cmd +=3D ' -U %s' % console_address
> =20
>          console =3D aexpect.ShellSession(nc_cmd)
> -        try:
> -            logging.info('Console: Waiting login prompt...')
> -            _handle_prompts(console, self.username, self.password, pro=
mpt)
> -            logging.info('Console: Ready!')
> -        except:
> -            console.close()
> -            raise
> +        if login:
> +            if not all((self.username, self.password)):
> +                raise QEMULoginError('Username or password not set.')
> +
> +            try:
> +                logging.info('Console: Waiting login prompt...')
> +                _handle_prompts(console, self.username, self.password,=
 prompt)
> +            except:
> +                console.close()
> +                raise
> +        logging.info('Console: Ready!')
> =20
>          return console
> =20
>=20

Since having docstrings for new parameters is a minor issue and not a
requirement:

Acked-by: Cleber Rosa <crosa@redhat.com>
