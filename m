Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df5o3-0007cq-2J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df5o1-000179-Us
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:48:27 -0400
Date: Tue, 8 Aug 2017 16:48:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808144800.GL4850@dhcp-200-186.str.redhat.com>
References: <20170703180950.9895-1-eblake@redhat.com>
	<20170808135407.GK4850@dhcp-200-186.str.redhat.com>
	<b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.08.2017 um 16:29 hat Eric Blake geschrieben:
> On 08/08/2017 08:54 AM, Kevin Wolf wrote:
> > Am 03.07.2017 um 20:09 hat Eric Blake geschrieben:
> >> POSIX says that backslashes in the arguments to 'echo', as well as
> >> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
> >> people should favor 'printf' instead.  This is definitely true where
> >> we do not control which shell is running (such as in makefile snippets
> >> or in documentation examples).  But even for scripts where we
> >> require bash (and therefore, where echo does what we want by default),
> >> it is still possible to use 'shopt -s xpg_echo' to change bash's
> >> behavior of echo.  And setting a good example never hurts when we are
> >> not sure if a snippet will be copied from a bash-only script to a
> >> general shell script (although I don't change the use of non-portable
> >> \e for ESC when we know the running shell is bash).
> >>
>=20
> >> +++ b/tests/multiboot/run_test.sh
> >> @@ -26,7 +26,7 @@ run_qemu() {
> >>      local kernel=3D$1
> >>      shift
> >>
> >> -    echo -e "\n\n=3D=3D=3D Running test case: $kernel $@ =3D=3D=3D\n"=
 >> test.log
> >> +    printf %b "\n\n=3D=3D=3D Running test case: $kernel $@ =3D=3D=3D\=
n\n" >> test.log
> >>
> >>      $QEMU \
> >>          -kernel $kernel \
> >=20
> > Not completely sure why, but this broke the test with whitespace changes
> > like this:
> >=20
> > -=3D=3D=3D Running test case: mmap.elf -m 1.1M =3D=3D=3D
> > +=3D=3D=3D Running test case: mmap.elf -m1.1M =3D=3D=3D
>=20
> I guess that means I'm not regularly running tests/multiboot?  Is it not
> part of 'make check' or qemu-iotests?

The problem is that it needs an i386 compiler to build the test kernels
(and qemu-system-i386 or qemu-system-x86_64 binaries to execute them).

I guess we could check these conditions, though, and skip the test if we
can't produce i386 binaries.

> Ah, I see the problem, and it's insidious.  We're using "...$@...", but
> want to be using "...$*...".  $@ causes multiple arguments to be passed,
> but printf %b is not concatenating those arguments; while $* uses only a
> single argument.  We didn't notice it with echo -e, because echo inserts
> a space between multiple arguments, just as you'd get a space with $*.

The thing that completely confused me here is that printf doesn't just
ignore additional arguments as I would have expected, but just starts
over with the format string, so that it does kind of work with multiple
arguments and fails only subtly.

Kevin

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZic8gAAoJEH8JsnLIjy/Ww1QP/3j4jHFo8D0qN7f+ncLBeL/Q
eHAKEKgOP9CW6pB2CZhC5ylmqKsP6rAyaheMJZJfoC3q/U6apUx9xv5DDyxdG8RZ
engUW7MmrgD5vhqHTFOldm8z6vqES6IBdZxWaDlzg/CL9DjLT00lMwVczrHM6PbY
M42sJWNVQOXc2SJL35Z7hdD2GaDPih0inB6HgI0TOVGLdwshO21pFtG4ATwGDa9h
oVf+sb4nbpaAqBAfgPG5YKQtxhqyFmH4KFoIkc8fa9pcqmQcbrxtFk6J3dLpsGWh
fQZKX8zvaVJu80bkWINePmKCop11e1mNB75UObmE0vB0MYDjUCO6G9Bu3E8HS4Uw
Ed+d6NL1CjIXQpv7066KFSSpx4cLDVYo1BZYw8w3FNaXrb76PRnQVeTz9Rg/LmX0
tXGChMIzI9vh0bpbUdx0yOnKj+prjE/QTJjMnGBEQXpouSCTcFtxvbluBo7DZF68
D61j1nupgdB1Tmg8DDjT80/e1rOTvfnjRSfOQXWYZP4rouPyac4kyqQ+YXhh5CQd
KLejeqMKZsX7B/jA95HfVgf4sADWg5ChmW0uTiKQrxL0tI9TkPdpuQ4lann/NB5m
i6azzR7DyfAFJKo59knYySdIZPGbCEh3NbqzAIYhofJ+7g5oc+wjjy80LJu6mx8J
9wp/kG9C8Is9V2Ke6fgZ
=1NVb
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
