Received: from eggs.gnu.org ([2001:4830:134:3::10]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQhj-0000jH-KQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQhh-0000k3-RW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:04:23 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-7-mreitz@redhat.com>
	<20181015203036.GE31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <edce93ab-cdde-fc70-4592-3bede42301a2@redhat.com>
Date: Fri, 19 Oct 2018 11:03:56 +0200
MIME-Version: 1.0
In-Reply-To: <20181015203036.GE31060@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uXUcvOb7wCzcAj1IPeURHEwegcXDwAroM"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uXUcvOb7wCzcAj1IPeURHEwegcXDwAroM
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <edce93ab-cdde-fc70-4592-3bede42301a2@redhat.com>
Subject: Re: [PATCH 6/9] iotests: Explicitly inherit FDs in Python
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-7-mreitz@redhat.com>
 <20181015203036.GE31060@habkost.net>
In-Reply-To: <20181015203036.GE31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 22:30, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 04:14:50PM +0200, Max Reitz wrote:
>> Python 3.2 introduced the inheritable attribute for FDs.  At the same
>> time, it changed the default so that all FDs are not inheritable by
>> default, that only inheritable FDs are inherited to subprocesses, and
>> only if close_fds is explicitly set to False.
>>
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
>> +            os.set_inheritable(fd, True)
>> +        except AttributeError:
>> +            pass
>> +
>=20
> This is add_fd(), so calling set_inheritable() automatically here
> makes sense.
>=20
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
>=20
> Why did you decide to place this code inside is_scm_available()?
>=20
> For reference, this is the only caller of is_scm_available():
>=20
>     def send_fd_scm(self, fd_file_path):
>         # In iotest.py, the qmp should always use unix socket.
>         assert self._qmp.is_scm_available()
>         ...
>=20
> In addition to making a method called is_*() have an unexpected
> side-effect,

True.  My idea was that a function that asks for SCM to be available
might as well make it available.

>              the method won't be called at all if running with
> debugging disabled.

Well, I sure hope we don't disable debugging in the iotests.  We use
assert quite a number of times there.

On the other hand, someone might want to use this outside of the iotests
but I don't even know whether that works, considering the SCM helper
program is part of the iotests.

> I suggest simply placing the os.set_inheritable() call inside
> send_fd_scm(), as close as possible to the subprocess.Popen()
> call.

Yes, I think you're right.  I didn't want to put it into send_fd_scm(),
because that method is only there to send some FD over QMP/SCM; it isn't
really supposed to send the QMP socket FD somewhere.  But sending
something over QMP/SCM is different from bequeathing something to a
child process (the socket_scm_helper).  And since send_fd_scm() needs to
bequeath the QMP socket FD to that helper, it should be responsible for
making it inheritable.

And maybe even more importantly, whether the socket allows for SCM
really has nothing to do with whether it's inheritable.  So it's
actually just wrong to put it here.

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
>=20
> Why not make send_fd_scm() responsible for calling
> os.set_inheritable(), making this hunk unnecessary?

My idea was: Because send_fd_scm() takes a string and not an integer.
The socket_scm_helper takes either an FD or a path, so send_fd_scm()
accepts either.

But now I realize that if we pass a path, we don't need to make the FD
inheritable.  So send_fd_scm() can check whether it's supposed to pass
an FD, and if so, make it inheritable, yes.

Max

>>          result =3D self.vm.send_fd_scm(str(sockfd.fileno()))
>>          self.assertEqual(result, 0, 'Failed to send socket FD')
>> =20
>> --=20
>> 2.17.1
>>
>=20



--uXUcvOb7wCzcAj1IPeURHEwegcXDwAroM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJnfwACgkQ9AfbAGHV
z0ALXQgAlGa62Q75pxNUAPUIzoRhbHcBesnFdeWGPww65xMl/bHSwjEnuJlgvCpU
X06Bqh0KKmo9nVvhSCzwN8p5qeHoLXxoC8PnkkNYkmcYIurSU1HFB1jrtJjiod6f
GQU3JYBIqxSI7lfsZYQB6hgQwEebQ2Z16XfUr75vs04BlAjVl3JL3mtqnIt4kaNh
AnyB8vvhAXWBAJ79pke9jUPD5RfV7+++zFVTDXtLgzspP2RsoQe0a4G1GhRzfZ/0
J5CsFgDoKZwWH2vV6Sl228Yez7Izxlq0WillH3TRKbONtxryU5IYu+fMLGyOIBUX
NU9cHWKNISz09YZ3l1QUeqH9LaGPpA==
=wcId
-----END PGP SIGNATURE-----

--uXUcvOb7wCzcAj1IPeURHEwegcXDwAroM--
