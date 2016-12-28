Received: from eggs.gnu.org ([2001:4830:134:3::10]:55534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cMHmc-0007hX-Td
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cMHmZ-00036g-LU
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:12:58 -0500
Received: from ignoranthack.me ([199.102.79.106]:60668
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cMHmZ-00036Y-E9
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:12:55 -0500
References: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
	<CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <db8a59e9-f4b3-1cb5-c1ed-82158b61b008@freebsd.org>
Date: Wed, 28 Dec 2016 10:12:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Oi3wO5knq1MFxRIuaj54CXi1Jdn8ri57o"
Subject: Re: [Qemu-devel] Looking for a linux-user mode test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oi3wO5knq1MFxRIuaj54CXi1Jdn8ri57o
From: Sean Bruno <sbruno@freebsd.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <db8a59e9-f4b3-1cb5-c1ed-82158b61b008@freebsd.org>
Subject: Re: [Qemu-devel] Looking for a linux-user mode test
References: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
 <CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/28/16 10:05, Peter Maydell wrote:
> On 28 December 2016 at 15:06, Sean Bruno <sbruno@freebsd.org> wrote:
>> After some recent-ish changes to how user mode executes things/stuff,
>> I'm running into issues with the out of tree bsd-user mode code that
>> FreeBSD has been maintaining.  It looks like the host_signal_handler()=

>> is never executed or registered correctly in our code.  I'm curious if=

>> the linux-user code can handle this bit of configure script from m4.
>>
>> https://people.freebsd.org/~sbruno/stack.c
>=20
> Hmm. That code does:
>  * set up a SIGSEGV signal handler to run on its own stack
>  * go into an infinite recursion, expecting to run out of
>    stack and trigger a SEGV
> which is a bit of an obscure corner case of signal handling.
>=20
> We recently fixed a lot of signal handler related bugs in linux-user
> by doing a significant overhaul of that code. If bsd-user is still
> using the old broken approach it's probably still got lots of bugs
> in it. Alternatively, it's possible we changed some of the core
> code in that process and broke bsd-user by mistake.
>=20
> Ideally all of that rework (including the support for properly
> interrupting syscalls without races) should be ported over to
> bsd-user at some point.

If you have a moment to point me at the merge commit that pulled in the
majority of this overhaul, I'll take a moment to review it for
application to bsd-user.

>=20
>> If someone has the time/inclination, can this code be compiled for ARM=
v6
>> and executed in a linux chroot with the -strace argument applied?  I s=
ee
>> the following, which after much debugging seems to indicate that the
>> host_signal_handler() code is never executed as this code is requestin=
g
>> that SIGSEGV be masked to its own handler.
>=20
> Built for ARMv7 since I don't have an ARMv6 cross compiler
> or system, but it works ok for linux (also, built with -static
> rather than run in a chroot, for convenience):
>=20
> e104462:xenial:qemu$ ./build/arm-linux/arm-linux-user/qemu-arm -strace
> ~/linaro/qemu-misc-tests/stack
> 29798 uname(0xf6fff1f0) =3D 0
> 29798 brk(NULL) =3D 0x0007f000
> 29798 brk(0x0007fd00) =3D 0x0007fd00
> 29798 readlink("/proc/self/exe",0xf6ffe328,4096) =3D 43
> 29798 brk(0x000a0d00) =3D 0x000a0d00
> 29798 brk(0x000a1000) =3D 0x000a1000
> 29798 access("/etc/ld.so.nohwcap",F_OK) =3D -1 errno=3D2 (No such file =
or directory)
> 29798 sigaltstack(0xf6fff2e0,(nil)) =3D 0
> 29798 rt_sigaction(SIGSEGV,0xf6fff1b0,NULL) =3D 0
> --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3D1, si_addr =3D 0xf67ffffc} -=
--
> 29798 exit_group(0)
>=20
> (the enhancement to linux-user's strace to print the line on signal
> delivery is also a pretty new change.)
>=20

Thanks.  This is what I expect to see.

>> https://people.freebsd.org/~sbruno/qemu-bsd-user-arm.txt
>>
>> Prior to 7e6c57e2957c7d868f74bd0d53b5e861b495e1c7 this DTRT for our
>> ARMv6 targets.
>=20
> This commit hash doesn't seem to be in QEMU master.
>=20

*sigh* ... that was the merge commit to the bsd-user branch I maintain.
Ignore it.

> thanks
> -- PMM
>=20


--Oi3wO5knq1MFxRIuaj54CXi1Jdn8ri57o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhj8pJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmQ9wAf+PhADiPvJOJJdeimhrgJoNvus8O7UXCfw+WqT7srXUfEd/kwZVX1qFQZv
GCcZSkRZYyn8ac8dV0sXLIgjJ6gq7FSeFV2Wvk+ZgmL3mc7Zuml2BAMHABrDNliS
DE2tAiPRgX/RDnD/XdlsWynU5jzoZHF7xiHbB9dhhlqrG9eECVfP0ijZvXJRk65K
aJxXSsOFLmXsxQGQPq2VX1TlH3jc7iRR1pNmHQwmDIO5rUQnGw+YGGOHpyC7vB4U
is9okccAfIx/3FKpLsHLq8BfbLEY1t6n0u+JtLiZOqCX/TJQlCoa8rASa0rpaOK+
vmQQdANSLHnqxs2oJWmp3vk7dh+osg==
=4wPa
-----END PGP SIGNATURE-----

--Oi3wO5knq1MFxRIuaj54CXi1Jdn8ri57o--
