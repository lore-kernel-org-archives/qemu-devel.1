Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da5Ku-0004OU-KD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da5Kr-0006b9-Dr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1da5Kr-0006ay-47
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:17:37 -0400
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-5-apahim@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c043bf9b-84ad-161b-8498-a9d74c419c9a@redhat.com>
Date: Tue, 25 Jul 2017 15:17:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170725171014.25193-5-apahim@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="70UNJ5LwdXWx8l6mQoBWf18Gxo5PNidGm"
Subject: Re: [Qemu-devel] [PATCH v5 4/6] qemu.py: cleanup launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, ldoktor@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--70UNJ5LwdXWx8l6mQoBWf18Gxo5PNidGm
From: Cleber Rosa <crosa@redhat.com>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 ldoktor@redhat.com
Message-ID: <c043bf9b-84ad-161b-8498-a9d74c419c9a@redhat.com>
Subject: Re: [PATCH v5 4/6] qemu.py: cleanup launch()
References: <20170725171014.25193-1-apahim@redhat.com>
 <20170725171014.25193-5-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-5-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/25/2017 01:10 PM, Amador Pahim wrote:
> launch() is currently taking care of a number of flows, each one if its=

> own exception treatment, depending on the VM state and the files
> creation state.
>=20
> This patch makes launch() more resilient, off-loading the core calls to=

> the new _launch() and calling shutdown() if any exception is raised by
> _launch(), making sure VM will be terminated and cleaned up.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 56142ed59b..45a63e8e9d 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -99,8 +99,11 @@ class QEMUMachine(object):
>          return self._popen.pid
> =20
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as fh:
> -            self._iolog =3D fh.read()
> +        try:
> +            with open(self._qemu_log_path, "r") as fh:
> +                self._iolog =3D fh.read()
> +        except IOError:
> +            pass
> =20
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -126,23 +129,28 @@ class QEMUMachine(object):
>          self._remove_if_exists(self._qemu_log_path)
> =20
>      def launch(self):
> -        '''Launch the VM and establish a QMP connection'''
> -        devnull =3D open('/dev/null', 'rb')
> -        qemulog =3D open(self._qemu_log_path, 'wb')
> +        '''
> +        Try to launch the VM and make sure we cleanup on exception.
> +        '''
> +        if self.is_running():
> +            return
> +
>          try:
> -            self._pre_launch()
> -            args =3D self._wrapper + [self._binary] + self._base_args(=
) + self.args
> -            self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, st=
dout=3Dqemulog,
> -                                           stderr=3Dsubprocess.STDOUT,=
 shell=3DFalse)
> -            self._post_launch()
> +            self._launch()
>          except:
> -            if self.is_running():
> -                self._popen.kill()
> -                self._popen.wait()
> -            self._load_io_log()
> -            self._post_shutdown()
> +            self.shutdown()
>              raise
> =20
> +    def _launch(self):
> +        '''Launch the VM and establish a QMP connection.'''
> +        devnull =3D open('/dev/null', 'rb')

Nitpick: using "os.path.devnull" can improve portability.

- Cleber.

> +        qemulog =3D open(self._qemu_log_path, 'wb')
> +        self._pre_launch()
> +        args =3D self._wrapper + [self._binary] + self._base_args() + =
self._args
> +        self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, stdout=
=3Dqemulog,
> +                                       stderr=3Dsubprocess.STDOUT, she=
ll=3DFalse)
> +        self._post_launch()
> +
>      def shutdown(self):
>          '''Terminate the VM and clean up'''
>          if self.is_running():
> @@ -156,8 +164,8 @@ class QEMUMachine(object):
>              if exitcode < 0:
>                  sys.stderr.write('qemu received signal %i\n' % -exitco=
de)
> =20
> -            self._load_io_log()
> -            self._post_shutdown()
> +        self._load_io_log()
> +        self._post_shutdown()
> =20
>      underscore_to_dash =3D string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--70UNJ5LwdXWx8l6mQoBWf18Gxo5PNidGm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd5lEAAoJEGV+jTOl8gnzFBwQAIBNOG6F9VfDm7ea/XgYAhZb
eZmlmoJV6WpWCkG9d8oHhmxu6UXuHoNeIHTQkzzLiGnvCBuxEXS1p0rGsOjt4FPp
4tEYZ7TVA6sKm2ZlsLLUnx7zR0WS2YQ380gEipkD3QHoS3aSmoGmdAHzVRQutjSX
0kzpBPTTDNHf40qVLBYNJm4207nKEvqUx8cN+hOUdHckaYe+B6jqfbmWKiaAK6GO
jLFtDD/yulycGADavsV5JgIwPPcPqnatOF0iNak7mKcZ8e9TB9LRXNsAXfXcbFJ0
nOf+rUnevZFgxD0zsIvRz1HfNnJuVTqjsxd0O2KhPVTzWcF4f+FR2zhyoY/IOeW6
rzHSLTGu4lHPrIDpVjj2iksJDJrFCqmnY5+UsDzAc6j21tlTADrbfZw36M0ZgOCB
xknTysmj60XEfY8OnG/strlXdEjXXJ/t8XRxHUuVnRSsBli/nYTn7GffAwwttpci
MfGZimNJJRab25GQI1n86/9WhNrkAsXqh/nAHlRsrrHKK/QbbjxzFDWWmx2XFyxb
kG9Em7otZHB4u2MBTDMveYzOk0daLZipzbZnuw0ppbpviHaT64C5z82yXpF1Aamu
vS9TqJLjV3yBGI95o38ec0HoLFapuTfIuYOkevZthQHmaBb0n3YgwbxyAXBLzp1k
Xxpq/tyv47DYSlXmlum2
=LEah
-----END PGP SIGNATURE-----

--70UNJ5LwdXWx8l6mQoBWf18Gxo5PNidGm--
