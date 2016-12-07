Received: from eggs.gnu.org ([2001:4830:134:3::10]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEfBB-0005ya-2A
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEfB9-0006nT-QA
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:34:49 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-6-eblake@redhat.com>
	<20161207161659.GG4773@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
Date: Wed, 7 Dec 2016 10:34:33 -0600
MIME-Version: 1.0
In-Reply-To: <20161207161659.GG4773@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NbdlnSgE03kduxe5qsSaAo9L7nJ1mpm59"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add coverage for recent
 block geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NbdlnSgE03kduxe5qsSaAo9L7nJ1mpm59
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org
Message-ID: <6e1d4ce3-da78-2766-6670-9cfda8d61d33@redhat.com>
Subject: Re: [PATCH v3 5/5] tests: Add coverage for recent block geometry
 fixes
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-6-eblake@redhat.com>
 <20161207161659.GG4773@noname.str.redhat.com>
In-Reply-To: <20161207161659.GG4773@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 10:16 AM, Kevin Wolf wrote:
> Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
>> Use blkdebug's new geometry constraints to emulate setups that
>> have caused recent regression fixes: write zeroes asserting
>> when running through a loopback block device with max-transfer
>> smaller than cluster size, and discard rounding away portions
>> of requests not aligned to preferred boundaries.  Also, add
>> coverage that the block layer is honoring max transfer limits.
>>
>> For now, a single iotest performs all actions, with the idea
>> that we can add future blkdebug constraint test cases in the
>> same file; but it can be split into multiple iotests if we find
>> reason to run one portion of the test in more setups than what
>> are possible in the other.
>>

>> +
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +
>> +CLUSTER_SIZE=3D1M
>> +size=3D128M
>> +options=3Ddriver=3Dblkdebug,image.driver=3Dqcow2
>> +
>> +echo
>> +echo "=3D=3D setting up files =3D=3D"
>> +
>> +_make_test_img $size
>> +$QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG" | _filter_qemu_io
>> +mv "$TEST_IMG" "$TEST_IMG.base"
>=20
> I know that you declared "_supported_proto file", but if you don't use
> mv after creating the image, it might actually work with other
> protocols.
>=20
> Most other tests use something like this:
>=20
>     TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
>=20
> And for the qemu-io invocation you can just use the right filename.

Thanks.  I obviously copied-and-pasted from an earlier test, rather than
a later one, so I'll make the tweaks in v4.


>> +# non-power-of-2 write-zero/discard alignments
>> +echo
>> +echo "=3D=3D non-power-of-2 write zeroes =3D=3D"
>=20
> "non-power-of-2 write zeroes _limits_". The request offset/size is a
> power of two.

Indeed.

>=20
>> +limits=3Dalign=3D512,opt-write-zero=3D15M,max-write-zero=3D15M,opt-di=
scard=3D15M,max-discard=3D15M
>> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
>> +         -c "write -z 32M 32M" | _filter_qemu_io
>> +
>> +echo
>> +echo "=3D=3D non-power-of-2 discard =3D=3D"
>=20
> Here limits, too.
>=20
>> +limits=3Dalign=3D512,opt-write-zero=3D15M,max-write-zero=3D15M,opt-di=
scard=3D15M,max-discard=3D15M
>> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
>> +         -c "discard 80000001 30M" | _filter_qemu_io
>> +
>> +echo
>> +echo "=3D=3D verify image content =3D=3D"
>> +
>> +function verify_io()
>> +{
>> +    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
>> +	    grep "compat: 0.10" > /dev/null); then
>> +        # For v2 images, discarded clusters are read from the backing=
 file
>> +        discarded=3D11
>> +    else
>> +        # Discarded clusters are zeroed for v3 or later
>> +        discarded=3D0
>> +    fi
>> +
>> +    echo read -P 22 0 1000
>> +    echo read -P 33 1000 128k
>> +    echo read -P 22 132072 7871512
>> +    echo read -P 0 8003584 2093056
>> +    echo read -P 22 10096640 23457792
>> +    echo read -P 0 32M 32M
>> +    echo read -P 22 64M 13M
>> +    echo read -P $discarded 77M 29M
>=20
> Hm, why is this exactly 77M?
>=20
> The original request starts at 80000001, 77M is 80740352. We have a
> discard limit of 15M, but that is only used for splitting the request
> (and wouldn't match 77M anyway). We still pass the partial requests at
> the head and the tail to the driver, and what it enforces is align, i.e=
=2E
> 512. The next 512 byte boundary from 80000001 would be 80000512.
>=20
> I'm almost sure that the patch is correct and I'm just missing a piece,=

> but what is it?

We are using a qcow2 image with 1M clusters.  Discarding visible through
qcow2 is therefore at 1M boundaries, regardless of whether we can
discard at finer granularity elsewhere.

Stepping through the request, we have:

qemu-io: discard 30M at 80000001, passed to blkdebug
  blkdebug: discard 511 bytes at 80000001, -ENOTSUP (smaller than
blkdebug's 512 align)
  blkdebug: discard 14371328 bytes at 80000512, passed to qcow2
    qcow2: discard 739840 bytes at 80000512, -ENOTSUP (smaller than
qcow2's 1M align)
    qcow2: discard 13M bytes at 77M, succeeds
  blkdebug: discard 15M bytes at 90M, passed to qcow2
    qcow2: discard 15M bytes at 90M, succeeds
  blkdebug: discard 1356800 bytes at 105M, passed to qcow2
    qcow2: discard 1M at 105M, succeeds
    qcow2: discard 308224 bytes at 106M, -ENOTSUP (smaller than qcow2's
1M align)
  blkdebug: discard 1 byte at 111457280, -ENOTSUP (smaller than
blkdebug's 512 align)


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NbdlnSgE03kduxe5qsSaAo9L7nJ1mpm59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSDoZAAoJEKeha0olJ0Nq3IQH/irA9f5+Y624yhLykB9eKjpo
nxQyULf9lWJ9/iijBNEFQbIISgEBFHLu9fpcunGvIZcDZ/0BUmBTYIHZ5WgtEr18
AH1AKqcAM4yQQevP+yVLiEe67yuSeg0gDGdmoWdvta0e1uaH0+jdgIwri15hMSas
vezy8vzwkIABAh5CryGz24JXxEjxui/W1FVx68Cgx7GrJ4OExOWMAzLL4K4iJdvm
4fIskYANYH0dvMzTJ1B21REG9v40Q7KaAnq2PpUcnDD1Y0TKfApi/x/tXcMh3I69
Oxv1g0+JlXmZYKNCGo2z7KIIST4/aD96GdOJ98vcAOn5FIOsSIQk1y3npm4VoD4=
=wwUv
-----END PGP SIGNATURE-----

--NbdlnSgE03kduxe5qsSaAo9L7nJ1mpm59--
