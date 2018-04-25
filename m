Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBP8A-00039f-SC
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBP89-0006op-NL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:27:02 -0400
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-5-eblake@redhat.com>
	<3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5736e2c9-1baf-dc44-ae51-eaaec5c8827a@redhat.com>
Date: Wed, 25 Apr 2018 13:26:45 -0500
MIME-Version: 1.0
In-Reply-To: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R7AmZVl5EmYaTJYPMrdg7urBYQFZTYEYA"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] qcow2: Don't allow overflow during
 cluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R7AmZVl5EmYaTJYPMrdg7urBYQFZTYEYA
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com
Message-ID: <5736e2c9-1baf-dc44-ae51-eaaec5c8827a@redhat.com>
Subject: Re: [PATCH v5 4/5] qcow2: Don't allow overflow during cluster
 allocation
References: <20180423223337.82366-1-eblake@redhat.com>
 <20180423223337.82366-5-eblake@redhat.com>
 <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
In-Reply-To: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 09:44 AM, Max Reitz wrote:
> On 2018-04-24 00:33, Eric Blake wrote:
>> Our code was already checking that we did not attempt to
>> allocate more clusters than what would fit in an INT64 (the
>> physical maximimum if we can access a full off_t's worth of

s/maximimum/maximum/

>> data).  But this does not catch smaller limits enforced by
>> various spots in the qcow2 image description: L1 and normal
>> clusters of L2 are documented as having bits 63-56 reserved
>> for other purposes, capping our maximum offset at 64PB (bit
>> 55 is the maximum bit set).  And for compressed images with
>> 2M clusters, the cap drops the maximum offset to bit 48, or
>> a maximum offset of 512TB.  If we overflow that offset, we
>> would write compressed data into one place, but try to
>> decompress from another, which won't work.
>>
>> I don't have 512TB handy to prove whether things break if we
>> compress so much data that we overflow that limit, and don't
>> think that iotests can (quickly) test it either.  Test 138
>> comes close (it corrupts an image into thinking something lives
>> at 32PB, which is half the maximum for L1 sizing - although
>> it relies on 512-byte clusters).  But that test points out
>> that we will generally hit other limits first (such as running
>> out of memory for the refcount table, or exceeding file system
>> limits like 16TB on ext4, etc), so this is more a theoretical
>> safety valve than something likely to be hit.
>=20
> You don't need 512 TB, though, 36 MB is sufficient.

Cool.  I'll have to attempt that as a followup patch.

>=20
> Here's what you do:
> (1) Create a 513 TB image with cluster_size=3D2M,refcount_bits=3D1
> (2) Take a hex editor and enter 16 refblocks into the reftable
> (3) Fill all of those refblocks with 1s

That's a lot of leaked clusters ;)

>=20
> (Funny side note: qemu-img check thinks that image is clean because it
> doesn't check refcounts beyond the image end...)

Eww - yet another bug to fix...

>=20
> I've attached a compressed test image (unsurprisingly, it compresses
> really well).
>=20
> Before this series:
> $ ./qemu-io -c 'write -c 0 2M' test.qcow2
> qcow2: Marking image as corrupt: Preventing invalid write on metadata
> (overlaps with refcount block); further corruption events will be suppr=
essed
> write failed: Input/output error
>=20
> Aw.
>=20
> After this series:
> $ ./qemu-io -c 'write -c 0 2M' test.qcow2
> write failed: Input/output error
>=20
> (Normal writes just work fine.)
>=20
>=20
> Maybe you want to add a test still -- creating the image is rather quic=
k
> (well, you have to write 64 MB of 1s, but other than that).  The only
> thing that takes a bit of time is qemu figuring out where the first fre=
e
> cluster is...  That takes like 15 seconds here.

Then the test doesn't belong in '-g quick'.

>=20
> And another issue of course is...
>=20
> $ ls -lhs test.qcow2
> 42M -rw-r--r--. 1 maxx maxx 513T 25. Apr 16:42 test.qcow2
>=20
> Yeah, that.  Depends on the host file system, of course, whether that i=
s
> a real issue. O:-)

As long as iotests can gracefully skip if qemu-img fails to create the
image, then the test should still run on all remaining filesystems that
support sparse files that large.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--R7AmZVl5EmYaTJYPMrdg7urBYQFZTYEYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgyGUACgkQp6FrSiUn
Q2r9bQf/bm+jxwwLAjWa1bHnd7LpOoDBodAFtjTMhsHeO7uEgyLZ9Y1PFyXHUnSe
8p0VpmZyD+n2J+PnDLZHgSxuOVakUQiNwmRc1mA++z2E08atatZq5FpK7GZTt6Io
/YHV/6nMiOdm02E7bnMkXyvhEcVXtaTX7Jary13/TjppIXizSj7RSLHQv6VYZDpk
tMV2IfLLa8Z6XKqyZWpyI0r3NE8JDGuz+4aCvNdk7MdGe8fHo5UQXBibQF4JuSrl
y6S6FCwc0MNCNgP0fH8bULazs9MR9mttHTM/FMP07oK9kt44KixWkpuwyQF/eahG
zNq2eh1cgCkBBABAnBnJgDn/njFc1g==
=LThU
-----END PGP SIGNATURE-----

--R7AmZVl5EmYaTJYPMrdg7urBYQFZTYEYA--
