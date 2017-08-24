Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0m4-0002j2-IZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0m1-0002Q7-EB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl0m1-0002Po-3y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:38:49 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<20170818142613.32394-2-ldoktor@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <90effab1-bce0-d9c6-1e7a-5c02448a086d@redhat.com>
Date: Thu, 24 Aug 2017 18:38:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170818142613.32394-2-ldoktor@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tU2hstWU9hSgH3nwH9DSoD1oe5MIQUxtD"
Subject: Re: [Qemu-devel] [PATCH v6 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tU2hstWU9hSgH3nwH9DSoD1oe5MIQUxtD
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <90effab1-bce0-d9c6-1e7a-5c02448a086d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/10] qemu.py: Pylint/style fixes
References: <20170818142613.32394-1-ldoktor@redhat.com>
 <20170818142613.32394-2-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-2-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> No actual code changes, just several pylint/style fixes and docstring
> clarifications.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/qemu.py | 73 +++++++++++++++++++++++++++++++++++++++++++------=
--------
>  1 file changed, 55 insertions(+), 18 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 880e3e8..dd679f1 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -23,8 +23,22 @@ import qmp.qmp
>  class QEMUMachine(object):
>      '''A QEMU VM'''
> =20
> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone, t=
est_dir=3D"/var/tmp",
> -                 monitor_address=3DNone, socket_scm_helper=3DNone, deb=
ug=3DFalse):
> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
> +                 socket_scm_helper=3DNone, debug=3DFalse):
> +        '''
> +        Initialize a QEMUMachine
> +
> +        @param binary: path to the qemu binary
> +        @param args: list of extra arguments
> +        @param wrapper: list of arguments used as prefix to qemu binar=
y
> +        @param name: prefix for socket and log file names (default: qe=
mu-PID)
> +        @param test_dir: where to create socket and log file
> +        @param monitor_address: address for QMP monitor
> +        @param socket_scm_helper: helper program, required for send_fd=
_scm()"
> +        @param debug: enable debug mode
> +        @note: Qemu process is not started until launch() is used.
> +        '''
>          if name is None:
>              name =3D "qemu-%d" % os.getpid()
>          if monitor_address is None:
> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>          self._qemu_log_path =3D os.path.join(test_dir, name + ".log")
>          self._popen =3D None
>          self._binary =3D binary
> -        self._args =3D list(args) # Force copy args in case we modify =
them
> +        self._args =3D list(args)     # Force copy args in case we mod=
ify them
>          self._wrapper =3D wrapper
>          self._events =3D []
>          self._iolog =3D None
>          self._socket_scm_helper =3D socket_scm_helper
>          self._debug =3D debug
> +        self._qmp =3D None
> =20
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>          if self._socket_scm_helper is None:
>              print >>sys.stderr, "No path to socket_scm_helper set"
>              return -1
> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
> +        if not os.path.exists(self._socket_scm_helper):
>              print >>sys.stderr, "%s does not exist" % self._socket_scm=
_helper
>              return -1
>          fd_param =3D ["%s" % self._socket_scm_helper,
>                      "%d" % self._qmp.get_sock_fd(),
>                      "%s" % fd_file_path]
>          devnull =3D open('/dev/null', 'rb')
> -        p =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsys=
=2Estdout,
> -                             stderr=3Dsys.stderr)
> -        return p.wait()
> +        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3D=
sys.stdout,
> +                                stderr=3Dsys.stderr)
> +        return proc.wait()
> =20
>      @staticmethod
>      def _remove_if_exists(path):
> @@ -99,8 +114,8 @@ class QEMUMachine(object):
>          return self._popen.pid
> =20
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as fh:
> -            self._iolog =3D fh.read()
> +        with open(self._qemu_log_path, "r") as iolog:
> +            self._iolog =3D iolog.read()
> =20
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -114,7 +129,8 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
> =20
>      def _pre_launch(self):
> -        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addres=
s, server=3DTrue,
> +        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addres=
s,
> +                                                server=3DTrue,
>                                                  debug=3Dself._debug)
> =20
>      def _post_launch(self):
> @@ -131,9 +147,11 @@ class QEMUMachine(object):
>          qemulog =3D open(self._qemu_log_path, 'wb')
>          try:
>              self._pre_launch()
> -            args =3D self._wrapper + [self._binary] + self._base_args(=
) + self._args
> +            args =3D (self._wrapper + [self._binary] + self._base_args=
() +
> +                    self._args)
>              self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, st=
dout=3Dqemulog,
> -                                           stderr=3Dsubprocess.STDOUT,=
 shell=3DFalse)
> +                                           stderr=3Dsubprocess.STDOUT,=

> +                                           shell=3DFalse)
>              self._post_launch()
>          except:
>              if self.is_running():
> @@ -154,23 +172,30 @@ class QEMUMachine(object):
> =20
>              exitcode =3D self._popen.wait()
>              if exitcode < 0:
> -                sys.stderr.write('qemu received signal %i: %s\n' % (-e=
xitcode, ' '.join(self._args)))
> +                sys.stderr.write('qemu received signal %i: %s\n'
> +                                 % (-exitcode, ' '.join(self._args)))
>              self._load_io_log()
>              self._post_shutdown()
> =20
>      underscore_to_dash =3D string.maketrans('_', '-')
> +
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
> -        '''Invoke a QMP command and return the result dict'''
> +        '''Invoke a QMP command and return the response dict'''
>          qmp_args =3D dict()
> -        for k in args.keys():
> +        for key in args.keys():
>              if conv_keys:
> -                qmp_args[k.translate(self.underscore_to_dash)] =3D arg=
s[k]
> +                qmp_args[key.translate(self.underscore_to_dash)] =3D a=
rgs[key]
>              else:
> -                qmp_args[k] =3D args[k]
> +                qmp_args[key] =3D args[key]
> =20
>          return self._qmp.cmd(cmd, args=3Dqmp_args)
> =20
>      def command(self, cmd, conv_keys=3DTrue, **args):
> +        '''
> +        Invoke a QMP command.
> +        On success return the response dict.
> +        On failure raise an exception.
> +        '''
>          reply =3D self.qmp(cmd, conv_keys, **args)
>          if reply is None:
>              raise Exception("Monitor is closed")
> @@ -193,7 +218,15 @@ class QEMUMachine(object):
>          return events
> =20
>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
> -        # Test if 'match' is a recursive subset of 'event'
> +        '''
> +        Wait for specified timeout on named event in QMP; optionally f=
ilter
> +        results by match.
> +
> +        The 'match' is checked to be a recursive subset of the 'event'=
; skips
> +        branch processing on match's value None
> +           {"foo": {"bar": 1}} matches {"foo": None}
> +           {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}=

> +        '''
>          def event_match(event, match=3DNone):
>              if match is None:
>                  return True
> @@ -226,4 +259,8 @@ class QEMUMachine(object):
>          return None
> =20
>      def get_log(self):
> +        '''
> +        After self.shutdown or failed qemu execution, this returns the=
 output
> +        of the qemu process.
> +        '''
>          return self._iolog
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>



--tU2hstWU9hSgH3nwH9DSoD1oe5MIQUxtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfVWwACgkQZX6NM6Xy
CfPCSA//cSuk15b0P34zyzSLM3+SfjLhJI4xcUNU1nsbSqaB9X2Q2Jk/jWeKCChH
3IyBuCcakuPsiORSpZFjUj6K3rvSnOVnqin+Ad/p3QhJZi6uTO+2gT5C+I889xkd
2mhWfVNF8FOe7C449Sk6vU/PjqpaLirk2hAxjdBBduE2plh4oRXsELoeGd+UUjk2
tbCYPPSnSInpl6r+07U1qTHD8dNkaT2kVgSgDQoBmoBp+iSsihC89ulERWPgEgZv
pQEXwoIk5WRuV5vGcjaQki4+Tkr5yoYTHO1+WSbZjs5Rqbq8zBLk6WOO5S47T+23
bX7xm9WDj2oHYOFdQLjbDNYeDlIP45maznjMH0e+KZeU/VuMiHgJtehAwrRRbeFq
NrBx4DUOT/K9O9DP3sY9BPJrotub9jekYjgadxJaRJIn+oKkfOGMTtNBgICdvYQd
8qkTaO0PZVUFW3EWN6vsx/Xc5lGXHj3UGh7E0Jhwd4lS/lN76QEqBI0iAaFTg03m
+GbC5Pw8OEpHmoDsXHHl9+z4pn7Dph0wSrQkzqx7AQDcOoAvByOPWWYTNGfJOLic
QdR6xTpHDQMcL9z4ebzeQAcdmL6exzmWI9DS9DXv37lz4lp+IyeXL+teud6YVYhs
6+C3DgSG9rmAKr4TcI/Qv58njwHnJ1/uKpqnfWEueA9kqfgdk3k=
=69BZ
-----END PGP SIGNATURE-----

--tU2hstWU9hSgH3nwH9DSoD1oe5MIQUxtD--
