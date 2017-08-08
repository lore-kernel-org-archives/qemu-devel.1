Received: from eggs.gnu.org ([2001:4830:134:3::10]:34961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBOd-0005fJ-2h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBOb-0005bK-SG
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:46:35 -0400
References: <20170703180950.9895-1-eblake@redhat.com>
	<20170808135407.GK4850@dhcp-200-186.str.redhat.com>
	<b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
	<20170808144800.GL4850@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7aa6c259-ccfe-a393-d89e-5727b8c12e90@redhat.com>
Date: Tue, 8 Aug 2017 15:46:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170808144800.GL4850@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b2DUwPMX0U3eMMdj8JTVKDHXT0sXq9THE"
Subject: Re: [Qemu-devel] [PATCH v4] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2DUwPMX0U3eMMdj8JTVKDHXT0sXq9THE
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <7aa6c259-ccfe-a393-d89e-5727b8c12e90@redhat.com>
Subject: Re: [PATCH v4] tests: Avoid non-portable 'echo -ARG'
References: <20170703180950.9895-1-eblake@redhat.com>
 <20170808135407.GK4850@dhcp-200-186.str.redhat.com>
 <b3458a2d-3643-d69e-611f-3832ad8f24b4@redhat.com>
 <20170808144800.GL4850@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170808144800.GL4850@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 09:48 AM, Kevin Wolf wrote:

>>> Not completely sure why, but this broke the test with whitespace chan=
ges
>>> like this:
>>>
>>> -=3D=3D=3D Running test case: mmap.elf -m 1.1M =3D=3D=3D
>>> +=3D=3D=3D Running test case: mmap.elf -m1.1M =3D=3D=3D
>>
>> I guess that means I'm not regularly running tests/multiboot?  Is it n=
ot
>> part of 'make check' or qemu-iotests?
>=20
> The problem is that it needs an i386 compiler to build the test kernels=

> (and qemu-system-i386 or qemu-system-x86_64 binaries to execute them).
>=20
> I guess we could check these conditions, though, and skip the test if w=
e
> can't produce i386 binaries.

And when you CAN run the test, it litters 'git status' of an in-tree
build with:

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	tests/multiboot/mmap.elf
	tests/multiboot/modules.elf
	tests/multiboot/test.out

which ought to be fixed.

>=20
>> Ah, I see the problem, and it's insidious.  We're using "...$@...", bu=
t
>> want to be using "...$*...".  $@ causes multiple arguments to be passe=
d,
>> but printf %b is not concatenating those arguments; while $* uses only=
 a
>> single argument.  We didn't notice it with echo -e, because echo inser=
ts
>> a space between multiple arguments, just as you'd get a space with $*.=

>=20
> The thing that completely confused me here is that printf doesn't just
> ignore additional arguments as I would have expected, but just starts
> over with the format string, so that it does kind of work with multiple=

> arguments and fails only subtly.

Both echo and printf accept more than one argument, but only echo
injects an automatic space between those arguments in the output.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--b2DUwPMX0U3eMMdj8JTVKDHXT0sXq9THE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKIxwACgkQp6FrSiUn
Q2pLKQgAkPY8K4M03/RS1JCBwgeXtkYHMSjSVeEYr9X7fFf2O1ewZ85Yf1zKvu7s
s1+DUV/wPTc/feJDM8F+qTWsiRk4Nx8BGwQHckMQIvCbkpHMXnZTdRcMbIZK7nSZ
7FMBcbterPhvxjICENjDNG7snMpgQ89L81cbsUxB4r74QxsCkCsTL1uj8sqnvzd4
pUKwyRWOAEnYaROqfJooGyNzrFJHlcGAfXo31cDGdgVaouBYy9AxizXVDINfCkw3
il0HlXbFI8zuaEcOwU1NoTsSDE2GPWtzWc/tvPjjb1knLBvNvsdGCme/Oj5BG2Kp
Cb4XksDe3QtUntwkyHWPmVyzFKtNfQ==
=OvTz
-----END PGP SIGNATURE-----

--b2DUwPMX0U3eMMdj8JTVKDHXT0sXq9THE--
