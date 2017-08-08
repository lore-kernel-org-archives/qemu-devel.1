Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3mR-0008Fb-Vt
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3mM-0006UE-UY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:38:40 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df3mM-0006Tb-KS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:38:34 -0400
Received: by mail-wm0-x229.google.com with SMTP id t201so6098412wmt.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:38:34 -0700 (PDT)
Date: Tue, 8 Aug 2017 13:38:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808123829.GM16801@stefanha-x1.localdomain>
References: <20170726144226.6913-1-ldoktor@redhat.com>
	<20170726144226.6913-2-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wKTlTxfx0Fr6BT7S"
Content-Disposition: inline
In-Reply-To: <20170726144226.6913-2-ldoktor@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org


--wKTlTxfx0Fr6BT7S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 04:42:17PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> No actual code changes, just several pylint/style fixes and docstring
> clarifications.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 53 insertions(+), 23 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 880e3e8..191c916 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -23,8 +23,22 @@ import qmp.qmp
>  class QEMUMachine(object):
>      '''A QEMU VM'''
> =20
> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone, tes=
t_dir=3D"/var/tmp",
> -                 monitor_address=3DNone, socket_scm_helper=3DNone, debug=
=3DFalse):
> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
> +                 socket_scm_helper=3DNone, debug=3DFalse):
> +        '''
> +        Create a QEMUMachine object
> +
> +        @param binary: path to the qemu binary (str)
> +        @param args: initial list of extra arguments
> +        @param wrapper: list of arguments used as prefix to qemu binary
> +        @param name: name of this object (used for log/monitor/... file =
names)
> +        @param test_dir: base location to put log/monitor/... files in
> +        @param monitor_address: custom address for QMP monitor
> +        @param socket_scm_helper: path to scm_helper binary (to forward =
fds)
> +        @param debug: enable debug mode (forwarded to QMP helper and suc=
h)
> +        @note: Qemu process is not started until launch() is used.
> +        '''
>          if name is None:
>              name =3D "qemu-%d" % os.getpid()
>          if monitor_address is None:
> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>          self._qemu_log_path =3D os.path.join(test_dir, name + ".log")
>          self._popen =3D None
>          self._binary =3D binary
> -        self._args =3D list(args) # Force copy args in case we modify th=
em
> +        self._args =3D list(args)     # Force copy args in case we modif=
y them
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
> +        if os.path.exists(self._socket_scm_helper) is False:

PEP8 says:

  Don't compare boolean values to True or False using =3D=3D.

https://www.python.org/dev/peps/pep-0008/#id51

This should be:

  if not os.path.exists(self._socket_scm_helper):

>      def command(self, cmd, conv_keys=3DTrue, **args):
> +        '''
> +        Invoke a QMP command and on success report result dict or on fai=
lure

s/report/return/ ?

> +        raise exception with details.
> +        '''
>          reply =3D self.qmp(cmd, conv_keys, **args)
>          if reply is None:
>              raise Exception("Monitor is closed")
> @@ -193,15 +216,18 @@ class QEMUMachine(object):
>          return events
> =20
>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
> -        # Test if 'match' is a recursive subset of 'event'
> -        def event_match(event, match=3DNone):
> +        ''' Wait for event in QMP, optionally filter results by match. '=
''

Why are spaces around this docstring?

--wKTlTxfx0Fr6BT7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZibDFAAoJEJykq7OBq3PIJK4IALm2Frmipyu4lUNK2b35jnG6
KKaF/M7bQ0K3D/CuxipPYXQyfBAyaPI0x7tzIr99CanKm0XSFB128Uie8qkp4WTL
e9ly7o3mgVsKETS5g9AVK/NUMxol+RVmSNpOHXqce0BW9s+0Kzq08Keccf6WaqUB
Qi18WElsMzG3jFzL1xE0QxnOBMyJZvw/Wc+VCOs58D4a0eiby/veIY3jeXy/AiSJ
dp5kqf04OR2TpuSF1V2bFnwEON07ucADemVNLiJY38p+sZdyHPjX8mpAyZAd5RN9
ZSqm9/CrJEypBT+JxKOIxO34+gcgIguJzlyXaCQTtbpLvaLYK1DruWBahxGFmlY=
=dVMG
-----END PGP SIGNATURE-----

--wKTlTxfx0Fr6BT7S--
