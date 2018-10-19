Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRJu-0008Vp-A4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRJr-00079m-40
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:43:50 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-7-mreitz@redhat.com>
	<4c35f899-8586-4b57-7c9d-699aac223752@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc57cd72-eafc-e6a9-207c-6ebb7eea5deb@redhat.com>
Date: Fri, 19 Oct 2018 11:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <4c35f899-8586-4b57-7c9d-699aac223752@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M8sKQjef8FCsbhKFEFPE4DKdqBAcqGWC2"
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests: Explicitly inherit FDs in
 Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M8sKQjef8FCsbhKFEFPE4DKdqBAcqGWC2
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <cc57cd72-eafc-e6a9-207c-6ebb7eea5deb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests: Explicitly inherit FDs in
 Python
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-7-mreitz@redhat.com>
 <4c35f899-8586-4b57-7c9d-699aac223752@redhat.com>
In-Reply-To: <4c35f899-8586-4b57-7c9d-699aac223752@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 01:18, Cleber Rosa wrote:
>=20
>=20
> On 10/15/18 10:14 AM, Max Reitz wrote:
>> Python 3.2 introduced the inheritable attribute for FDs.  At the same
>> time, it changed the default so that all FDs are not inheritable by
>> default, that only inheritable FDs are inherited to subprocesses, and
>> only if close_fds is explicitly set to False.
>>
>=20
> It's actually a change that was introduced in 3.4:
>=20
> https://docs.python.org/3/library/os.html#inheritance-of-file-descripto=
rs

Oops, don't know how I got that wrong.

>> Adhere to this by setting close_fds to False when working with
>> subprocesses that may want to inherit FDs, and by trying to
>> set_inheritable() on FDs that we do want to bequeath to them.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  scripts/qemu.py        | 13 +++++++++++--
>>  scripts/qmp/qmp.py     |  7 +++++++
>>  tests/qemu-iotests/147 |  7 +++++++
>>  3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index f099ce7278..28366c4a67 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -142,10 +142,18 @@ class QEMUMachine(object):
>>          if opts:
>>              options.append(opts)
>> =20
>> +        # This did not exist before 3.2, but since then it is
>> +        # mandatory for our purpose
>> +        try:
>=20
> Version should be 3.4 here as well.

Yes, will fix everywhere.

>> +            os.set_inheritable(fd, True)
>> +        except AttributeError:
>> +            pass
>> +
>=20
> Doing hasattr(os, "set_inheritable") is cheaper.
>=20
> - Cleber.

Nice, I'll use that then.

Max

>>          self._args.append('-add-fd')
>>          self._args.append(','.join(options))
>>          return self
>> =20
>> +    # The caller needs to make sure the FD is inheritable
>>      def send_fd_scm(self, fd_file_path):
>>          # In iotest.py, the qmp should always use unix socket.
>>          assert self._qmp.is_scm_available()
>> @@ -159,7 +167,7 @@ class QEMUMachine(object):
>>                      "%s" % fd_file_path]
>>          devnull =3D open(os.path.devnull, 'rb')
>>          proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3D=
subprocess.PIPE,
>> -                                stderr=3Dsubprocess.STDOUT)
>> +                                stderr=3Dsubprocess.STDOUT, close_fds=
=3DFalse)
>>          output =3D proc.communicate()[0]
>>          if output:
>>              LOG.debug(output)
>> @@ -280,7 +288,8 @@ class QEMUMachine(object):
>>                                         stdin=3Ddevnull,
>>                                         stdout=3Dself._qemu_log_file,
>>                                         stderr=3Dsubprocess.STDOUT,
>> -                                       shell=3DFalse)
>> +                                       shell=3DFalse,
>> +                                       close_fds=3DFalse)
>>          self._post_launch()
>> =20
>>      def wait(self):
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index 5c8cf6a056..009be8345b 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -10,6 +10,7 @@
>> =20
>>  import json
>>  import errno
>> +import os
>>  import socket
>>  import logging
>> =20
>> @@ -253,4 +254,10 @@ class QEMUMonitorProtocol(object):
>>          return self.__sock.fileno()
>> =20
>>      def is_scm_available(self):
>> +        # This did not exist before 3.2, but since then it is
>> +        # mandatory for our purpose
>> +        try:
>> +            os.set_inheritable(self.get_sock_fd(), True)
>> +        except AttributeError:
>> +            pass
>>          return self.__sock.family =3D=3D socket.AF_UNIX
>> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
>> index d2081df84b..b58455645b 100755
>> --- a/tests/qemu-iotests/147
>> +++ b/tests/qemu-iotests/147
>> @@ -229,6 +229,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
>>          sockfd =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
>>          sockfd.connect(unix_socket)
>> =20
>> +        # This did not exist before 3.2, but since then it is
>> +        # mandatory for our purpose
>> +        try:
>> +            os.set_inheritable(sockfd.fileno(), True)
>> +        except AttributeError:
>> +            pass
>> +
>>          result =3D self.vm.send_fd_scm(str(sockfd.fileno()))
>>          self.assertEqual(result, 0, 'Failed to send socket FD')
>> =20
>>
>=20



--M8sKQjef8FCsbhKFEFPE4DKdqBAcqGWC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJp0QACgkQ9AfbAGHV
z0AwbAf/aqruepb1d1IDUjMKCTed5WL6kGrVvy8UljwlTWvyT+MTasRxV1u81hjC
yIXa/j5A82uVtIKgKR5ef0LHoXvwuY7kaHt2ba++W0fc66apM8C7Y4dxZDC6ZhGv
75Q39LgaKRXPmiamKV2ob6clO8RRIDpDD2HgjGyyScGC63T1RXoQf2DNys+2zZFs
7WPYjIMuDF/oCceOAB37QKOIXUrQP09aGDz2TIupYv1XpNKG2LoPuK3O2RKpCXEq
nH0jyEZaZi4BzSo5xGFgy3kxIURzmlJvDtVWu+Nmu+ztlg8PEpV/YW0h78WfitA7
gTELbXWjKFHEekHd2OB2U9tO/QnjGA==
=myLl
-----END PGP SIGNATURE-----

--M8sKQjef8FCsbhKFEFPE4DKdqBAcqGWC2--
