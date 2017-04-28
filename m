Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4DNd-0007WP-0d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4DNb-00006E-4K
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:24:45 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-10-eblake@redhat.com>
	<7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
Date: Fri, 28 Apr 2017 16:24:34 -0500
MIME-Version: 1.0
In-Reply-To: <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wDBmGCGBsBFOWt80heDcOulC8VoT98VaP"
Subject: Re: [Qemu-devel] [PATCH v10 09/17] qcow2: Optimize write zero of
 unaligned tail cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDBmGCGBsBFOWt80heDcOulC8VoT98VaP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
Subject: Re: [PATCH v10 09/17] qcow2: Optimize write zero of unaligned tail
 cluster
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-10-eblake@redhat.com>
 <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
In-Reply-To: <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 03:48 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> We've already improved discards to operate efficiently on the tail
>> of an unaligned qcow2 image; it's time to make a similar improvement
>> to write zeroes.  The special case is only valid at the tail
>> cluster of a file, where we must recognize that any sectors beyond
>> the image end would implicitly read as zero, and therefore should
>> not penalize our logic for widening a partial cluster into writing
>> the whole cluster as zero.
>>
>> Update test 154 to cover the new scenarios, using two images of
>> intentionally differing length.
>>
>> While at it, fix the test to gracefully skip when run as
>> ./check -qcow2 -o compat=3D0.10 154
>> since the older format lacks zero clusters already required earlier
>> in the test.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>
>> +echo
>> +echo =3D=3D unaligned image tail cluster, no allocation needed =3D=3D=

>> +
>> +CLUSTER_SIZE=3D1024 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((siz=
e + 1024))
>=20
> Any reason for the CLUSTER_SIZE? It passes with 64 kB as well, and I
> actually think that would be a better test because as it is, the image'=
s
> "unaligned" tail is exactly one cluster (so it isn't really unaligned).=


Uhhh - copy-and-paste?  You're right, that 1024 is too small for what
I'm actually doing with it.  :(

>=20
>> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
>> +
>> +# With no backing file, write to all or part of unallocated partial c=
luster
>> +
>> +# Backing file: 128m: ... | 00 --
>=20
> Not sure what the "00 --" is supposed to mean. The cluster size is 1 kB=
,
> so this is just a single cluster; which will be converted from
> unallocated to a zero cluster because the tail reads as zero.
>=20
>> +$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io

I'm doing a write of 512 bytes, so I was trying to show that in the
cluster starting at 128m, we have a write request for one sector to be
written to 00, while the rest of the sector is left uninitialized. The
obvious intent is that we note that the uninitialized portion reads as
zero, so we can optimize the entire cluster (even though it is a partial
cluster) to be a cluster write-zero instead of a sector-based allocating
write.  But since you've pointed out that my setup is flawed, I'll have
to double-check that I'm actually testing what I thought I was (I know I
hit the right breakpoints in gdb, but its the iotest expected output
that needs to show the difference between pre- and post-patched qemu
with regards to the partial-tail-cluster optimizations).

>> +
>> +# Backing file: 128m: ... | -- 00
>=20
> Same here, but now it's the head that reads as zero (and it's already a=

> zero cluster so nothing changes here).
>=20
>> +$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
>=20
> But I suppose you mean $((size + 512))?

Umm. Yeah.  (Hey - you're not the only one that writes patches late at
night).

>=20
>> +
>> +# Backing file: 128m: ... | 00 00
>=20
> And finally this doesn't change anything either -- but then again this
> is a fully aligned request, so I don't quite see the point in testing
> this here.

At one point during my development, I had a bug where a partial write
request at the head of the cluster behaved differently from a partial
write request at the end (one allocated while the other did not).

Maybe it's best if I do a single write, then inspect the map, then reset
the image, rather than doing all three writes in a row and proving that
the net result of the three writes had no allocation.  In v9, when I was
trying to use unallocated clusters as a shortcut on files with no
backing image, this actually worked (after all three writes, the cluster
would still be unallocated); but since Kevin convinced me that v10 has
to set the zero flag on all three writes, I'm back to the point of
needing to clear the zero flag between writes.

Okay, I'll definitely have to fix it.

>> +# With backing file that reads as zero, write to all or part of entir=
e cluster
>> +
>> +# Backing file: 128m: ... | 00 00
>> +# Active layer: 128m: ... | 00 00 00 00
>> +$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>> +
>> +# Backing file: 128m: ... | 00 00
>> +# Active layer: 128m: ... | 00 00 -- --
>=20
> How so? Shouldn't this just stay a zero cluster because the rest of the=

> cluster already reads as zero?

Same problem as above.  In v9, I was trying to exploit code that left a
cluster unallocated; but that's not viable, so I'll have to reset the
image between steps.

>=20
> Also, I'm not quite sure what you are testing by just issuing three
> consecutive write requests without checking the result each time. You
> assume it to be something which you wrote in the comments above each,
> but you can't be sure (yes, if something goes wrong in between, the
> following final map should catch it, but it's not for certain).

Well, it helped me during development, but you're absolutely right that
we can't be certain in the long-run.  3 separate checks, with resets
between, is indeed the way to go.


>> +echo
>> +echo =3D=3D unaligned image tail cluster, allocation required =3D=3D
>> +
>> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size=
 + 1024))

Here, my backing cluster size is intentionally small, so that
bdrv_get_block_status() can easily return sane results for the backing
file portions, so only the active layer has a partial cluster. But
making it obvious in the comments can't hurt, given that my earlier
tests were invalidated when my size choice didn't actually match with
the operations I was attempting.

>> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
>> +
>> +# Write beyond backing file must COW
>> +# Backing file: 128m: ... | XX --
>=20
> Here, the "--" is an unallocated cluster...
>=20
>> +# Active layer: 128m: ... | -- -- 00 --
>=20
> ...while here it is normally allocated data. Or is "--" supposed to mea=
n
> you just don't write to that area...?

If we had subclusters, then it would be unallocated data.  But we don't.
 Since I just reset the image, I'm doing a write onto an unallocated
cluster in the current layer; the write request is to a subset of the
cluster, and the code checking whether the rest of the cluster reads as
zeros will see that a COW (and corresponding allocation) is required.

>=20
>> +
>> +$QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qem=
u_io
>> +$QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qem=
u_io
>> +$QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 0 $((size + 512)) 1536" "$TEST_IMG" | _filter_qe=
mu_io
>> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>> +
>> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size=
 + 1024))
>> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
>> +
>> +# Writes at boundaries of (partial) cluster must not lose mid-cluster=
 data
>> +# Backing file: 128m: ... | -- XX
>> +# Active layer: 128m: ... | 00 -- -- 00
>> +
>> +$QEMU_IO -c "write -P 1 $((size + 512)) 512" "$TEST_IMG.base" | _filt=
er_qemu_io
>> +$QEMU_IO -c "write -z $((size)) 512" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qem=
u_io
>> +$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_q=
emu_> +$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_=
qemu_io
>=20
> [1]
>=20
>> +$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qem=
u_io
>> +$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_q=
emu_io
>> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>> +
>> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size=
 + 1024))
>> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
>> +
>> +# Partial write must not lose data
>> +# Backing file: 128m: ... | -- --
>> +# Active layer: 128m: ... | -- -- XX 00
>=20
> Well, you have basically tested this in [1] already. After the first
> write -z to the active layer, the final four sectors are fully allocate=
d
> (as they are in a single cluster) and look like this:
>=20
> 00 01 00 00 =3D XX XX XX XX
>=20
> (Because the 00s are just written as data.)
>=20
> Now the write -z in [1] just overwrites the last of those four sectors
> with zero data (albeit it being zero already).
>=20
> But if you want to test it again, I'm not stopping you. :-)
>=20

Well, you've already proven that I need to revisit this test with a
fine-tooth comb, especially if I split the series to do the blkdebug
stuff separately from the qcow2 stuff.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wDBmGCGBsBFOWt80heDcOulC8VoT98VaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA7MSAAoJEKeha0olJ0NqBJkH/3j7opHAInSpokDE7Rug4Mc8
s3/8OTPES0QVQsrjAmjEfwGvD4gjpI4KfR3Wq8YyCcSVOCLUvjCIWzr57Jqr8ThX
IpuKwLBxiSxUr5BfpNTy9GYhmHJ9A/4tn1gifkjhmWzOueWrjnV7fQcBcbEwKJhn
WQDA/QIiEgxoEMMGOsJ1JGAJg/gHpLSDgRMLrH1yS3JpUrh6++IgzZF8P4Gs1U94
mVSxLvuG9nKViZfL7xIpZHALFbi3q24dYF3dYQco/Es9i9/4IiKf2tldVqoPo8cR
n7FOseMNRJgdRXzCXlrUhI/52PwAH95vDLIpywJ/ycFGd4uKgNt41lsQdr1xIsk=
=ciEm
-----END PGP SIGNATURE-----

--wDBmGCGBsBFOWt80heDcOulC8VoT98VaP--
