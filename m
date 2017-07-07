Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTQdU-0002P2-Ar
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTQdP-0005xp-EZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dTQdP-0005x8-53
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:37:15 -0400
Date: Fri, 7 Jul 2017 11:37:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170707103703.GA18375@stefanha-x1.localdomain>
References: <1499368127-19855-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <1499368127-19855-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v2] Python3 Support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 12:38:47AM +0530, Ishani Chugh wrote:

Commit messages usually begin with a prefix indicating the affected
component.  This makes it easier for code reviewers and maintainers to
browse email subjects and the git log.  I recommend the following commit
message:

  scripts/qmp: Python3 Support for qmp.py

>      def __json_read(self, only_event=3DFalse):
>          while True:
> -            data =3D self.__sockfile.readline()
> +            data =3D self.__sock_readline()
>              if not data:
>                  return
>              resp =3D json.loads(data)
>              if 'event' in resp:
>                  if self._debug:
> -                    print >>sys.stderr, "QMP:<<< %s" % resp
> +                    print("QMP:<<< %s" % resp)

Previously debug output was printed to stderr.  Please do not change
this.

Here is how to keep stderr in Python 2.6+/3 compatible fashion:

=66rom __future__ import print_function
=2E..
print("QMP:<<< %s" % resp, file=3Dsys.stderr)

There are more instances of this below.

> @@ -98,9 +112,11 @@ class QEMUMonitorProtocol:
>          try:
>              self.__json_read()
>          except socket.error as err:
> -            if err[0] =3D=3D errno.EAGAIN:
> +            if err.errno =3D=3D errno.EAGAIN:
>                  # No data available
>                  pass
> +            else:
> +                raise
>          self.__sock.setblocking(1)
> =20
>          # Wait for new events, if needed.

The "else: raise" silently fixes a bug.  Please mention that socket
errors were silently ignored in the commit description.  That will make
the intention of this change clear for anyone who looks at this commit
in the future.

> @@ -175,7 +190,7 @@ class QEMUMonitorProtocol:
>          @param args: command arguments (dict)
>          @param id: command id (dict, list, string or int)
>          """
> -        qmp_cmd =3D { 'execute': name }
> +        qmp_cmd =3D {'execute': name}
>          if args:
>              qmp_cmd['arguments'] =3D args
>          if id:

Please make PEP8 fixes in a separate commit and only Python 2/3
compatibility changes in this commit.  Commits that do only one thing
are easier to understand, backport, and bisect.

> @@ -245,3 +260,4 @@ class QEMUMonitorProtocol:
> =20
>      def is_scm_available(self):
>          return self.__sock.family =3D=3D socket.AF_UNIX
> +

What is the purpose of this extra newline?

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZX2ROAAoJEJykq7OBq3PI9IQH/jFmWKQQoeDw+kNgphAei2w5
rqsVJrGVRRvv3RSJczZpnBDgak4lif7u+53Hrf1+G/Xv6jHOwAhs9rKD9hN5k3zw
RxnMgxoGrostpYyLgIHJe6b3KtNYBq22Cs53vWcbCbgR7FP71GxYnbeZCXZJ9eyE
1d33Kk1BvsvJt7LWZH3QLA76coOJ9c7V2rQE2MsVJ8lPoEUwIV0Jv2uogo/v9/ga
H/tGpNrbgyo4BrO4P/60RnPKoz0qxQ44QlieZsNOKekZq/kplVQJc9ry5wetvjJp
GYR0IWvY2NFO+bIngwJozUYtAWGVfWpbJtIPB0HaOm1wvgsdm4x10bA53Xqk7pE=
=iYCl
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
