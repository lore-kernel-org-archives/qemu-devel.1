Received: from eggs.gnu.org ([209.51.188.92]:60135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1griN9-0005ZE-Hg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1griMw-0005qV-Fw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:01:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1griMs-0005mX-Ha
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:01:26 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
	<1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
Date: Thu, 7 Feb 2019 13:01:06 +0100
MIME-Version: 1.0
In-Reply-To: <1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="iuMFxEZsnJzWk1R5UjlFVZDHMFxngSYNb"
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Giovanni Mascellani <gio@debian.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iuMFxEZsnJzWk1R5UjlFVZDHMFxngSYNb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-02-07 12:46, Giovanni Mascellani wrote:
> Hi,
>=20
> Il 07/02/19 12:26, Thomas Huth ha scritto:
>> The problem is rather that the STCK instruction is fenced with
>> "#ifndef CONFIG_USER_ONLY" ... quick-n-dirty hack to allow it:
>=20
> Thanks for the patch. Unfortunately on my system it failes with:
>=20
>   LINK    s390x-linux-user/qemu-s390x
> /usr/bin/ld: ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple
> definition of `use_icount'; exec.o:(.bss+0x58): first defined here
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:207: qemu-s390x] Error 1
> make: *** [Makefile:432: subdir-s390x-linux-user] Error 2
>=20
> The error does not appear when compiling from current master.

I just saw it, too. Seems like the stubs/cpu-get-icount.c file now gets
pulled in for some reason. Try this on top:

diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index 35f0c1e..8da6646 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -4,7 +4,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"

-int use_icount;
+int use_icount __attribute__((weak));

 int64_t cpu_get_icount(void)
 {

=2E.. anyway, I'll ponder about that a little bit and will try to come up=

with a proper, mergable patch instead.

 Thomas


--iuMFxEZsnJzWk1R5UjlFVZDHMFxngSYNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcXB4HAAoJEC7Z13T+cC21ymgP/iFoZgBl+o/8CcwsmwI1AUQ7
w3mN9akFAT6E7Fz1jTWaRFWDRHEJnXe17OVx6owjDI3BHnMXV//abzwIEnI71tkv
8freywvsPVl8FVdkf5fvdb+nhB4nwzjcvEyNmNPK0x4BlDqT7WnrWwQENHPm6whq
orkQJtFchQ9AGelKNp/p+vm5JJ1iaiE6VfvvTxCAaKcsFad3RkvC2xB0tePPC4PR
P44CqFUF1LzpAyWDdLr4lJxjHlj25jhBd4+y93+gqyTg8MOOIfr5yhan68hSDsJy
amo7U+A7F2AwRFyHGwVMZEpQt986VYTqhyq1sU1PWPJBtT9UKCxcXEc1Ww4NIgM5
8lDsvBpOIMiuMKdbOsqIZKT9IunoN2p7B2t5PIBWuvUhsKk4DsOBFzGOUqva/Ogb
KsHxsruH5H9i8RIZYYsPGeEBIr/waWfE0SrZkofVdljZhAygrq+dad/MiIZ5STun
d74qYypNDK3x2jueAloPdg8NezOLaWxgCD0PuOg0U8MKwvbKPCxzX4k2vWNPw6Xv
02v+H36gRs/CgLNi0sokUYaTJ4h7fHRs72YEyBjDIudRz5FMquj/pymzG1xZPu+6
T6ldBRLsplB54o2NBTZTk5kfDlYJIYZv44U5JFxzhI9CoxMTOVjOsYg4RyBIuJIk
XqjNoK40ckazaJUb1ZjA
=H9/X
-----END PGP SIGNATURE-----

--iuMFxEZsnJzWk1R5UjlFVZDHMFxngSYNb--
