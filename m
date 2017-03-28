Received: from eggs.gnu.org ([2001:4830:134:3::10]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csngg-0004Gb-Q9
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csngd-0002lY-Mz
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1csngd-0002lJ-DW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:45:11 -0400
Date: Tue, 28 Mar 2017 10:43:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170328094307.GA26523@stefanha-x1.localdomain>
References: <1490450201-30433-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1490450201-30433-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] scripts/qmp: python3 support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, jsnow@redhat.com


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2017 at 04:56:41PM +0300, Joannah Nanjekye wrote:
> From: nanjekyejoannah <nanjekyejoannah@gmail.com>
>=20
> The patch provides python 3 support for one of the scripts  in scripts/qm=
p that is to say qmp.py. This is not a port to python 3 but rather the patc=
h ensures that the script runs fine for both python 2 and 3.
>=20
> Minimum Python Versions supported:
>=20
>   Python 2 : python 2.6 +
>   Python 3 : python 3.3 +
>=20
> The two new imports future and builtins introduced refer to the future
> pip-installable package on PyPI.
>=20
> Signed-off-by: nanjekyejoannah <nanjekyejoannah@gmail.com>
> ---
>  scripts/qmp/qmp.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 62d3651..57ac86b 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -7,7 +7,7 @@
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2.  See
>  # the COPYING file in the top-level directory.
> -
> +from __future__ import absolute_import, print_function, unicode_literals
>  import json
>  import errno
>  import socket
> @@ -56,13 +56,13 @@ class QEMUMonitorProtocol:
> =20
>      def __negotiate_capabilities(self):
>          greeting =3D self.__json_read()
> -        if greeting is None or not greeting.has_key('QMP'):
> -            raise QMPConnectError
> +        if greeting is None or not 'QMP' in list(greeting):

list() is not necessary.  The "key in dict" expression already operates
on just the dict's keys.

> +            raise QMPConnectError()
>          # Greeting seems ok, negotiate capabilities
>          resp =3D self.cmd('qmp_capabilities')
>          if "return" in resp:
>              return greeting
> -        raise QMPCapabilitiesError
> +        raise QMPCapabilitiesError()
> =20
>      def __json_read(self, only_event=3DFalse):
>          while True:
> @@ -72,7 +72,7 @@ class QEMUMonitorProtocol:
>              resp =3D json.loads(data)
>              if 'event' in resp:
>                  if self._debug:
> -                    print >>sys.stderr, "QMP:<<< %s" % resp
> +                    print(u"QMP:<<< %s" % resp, file=3Dsys.stderr)=20

unicode_literals already makes all string literals unicode.  There is no
need to explicitly add u"".

>                  self.__events.append(resp)
>                  if not only_event:
>                      continue
> @@ -113,7 +113,7 @@ class QEMUMonitorProtocol:
>              except socket.timeout:
>                  raise QMPTimeoutError("Timeout waiting for event")
>              except:
> -                raise QMPConnectError("Error while reading from socket")
> +                raise(QMPConnectError("Error while reading from socket"))

Is there a reason for this change?

>              if ret is None:
>                  raise QMPConnectError("Error while reading from socket")
>              self.__sock.settimeout(None)
> @@ -155,16 +155,16 @@ class QEMUMonitorProtocol:
>                  been closed
>          """
>          if self._debug:
> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
> +            print(u"QMP:>>> %s" % qmp_cmd, file=3Dsys.stderr)=20
>          try:
> -            self.__sock.sendall(json.dumps(qmp_cmd))
> +            self.__sock.sendall((json.dumps(qmp_cmd)).encode('latin-1'))

The socket's encoding should be 'utf-8'.

You didn't specify an encoding in __json_read() where
self.__sockfile.readline() is called.  It will use the default encoding
and could therefore hit decoding errors.  We need to specify 'utf-8' for
reading too.

I think that is a little tricky to do in a Python 2/3 compatible way
because Python 2.6 socket and makefile do not take an encoding argument.
The simplest solution might be to read 1 byte at a time in __json_read()
until '\n' is encountered instead of calling readline().  That way you
can call line.decode('utf-8') on the raw bytes.

>          except socket.error as err:
>              if err[0] =3D=3D errno.EPIPE:
>                  return
> -            raise socket.error(err)
> +            raise (socket.error(), err)

We're re-raising the exception.  There is shorter syntax for this:

  except socket.error as err:
      if err[0] =3D=3D errno.EPIPE:
          return
      raise

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2jArAAoJEJykq7OBq3PIR9YH/01ZlPIUm5XGMCaJxEgexJP3
LeyLIRbxKPfIze9afdCC7lANPgH0wAb+OzRumw5hmjm/nR7r5vg94BfI79V+kexQ
b2Jjvl0FfPb/dfXx0fMxCechrGTdCp3QcrBe+vICOyTWtJ3FjTM/1AsY0UGrZx5t
d+Li40++oxhrDSrb67ehsfKiIK5/78fAIUBFcYV7/ppBUKQsWD1Ayd8xqiJBg7WT
bfXtpKLxVxR+VvRSDxcVCcT9LXvL9x6mX7Lq+DFwwQOKGAqAuoq5mp53GAn/bA/B
T7n0vUX6hT+nhFAvvJQ5j3yG+OouU59rKCrf8RUdYhdbhBhuGh/nZ1kz7tGZGpc=
=dAiM
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
