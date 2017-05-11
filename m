Received: from eggs.gnu.org ([2001:4830:134:3::10]:48719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pW7-0006Ht-9d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pW5-0003du-V3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:56:35 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Date: Thu, 11 May 2017 09:56:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bhSbvjqMqip2b5RdKuqcnHM1BHVclfiHP"
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bhSbvjqMqip2b5RdKuqcnHM1BHVclfiHP
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Message-ID: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[revisiting this older patch version, even though the final version in
today's pull request changed somewhat from this approach]

On 04/12/2017 04:49 AM, Kevin Wolf wrote:
> Am 11.04.2017 um 03:17 hat Eric Blake geschrieben:
>> 'qemu-img map' already coalesces information about unallocated
>> clusters (those with status 0) and pure zero clusters (those
>> with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
>> qcow2 images with no backing file already report all unallocated
>> clusters (in the preallocation sense of clusters with no offset)
>> as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
>> set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
>> BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
>> to external users), thanks to generic block layer code in
>> bdrv_co_get_block_status().
>>
>> So, for an image with no backing file, having bdrv_pwrite_zeroes
>> mark clusters as unallocated (defer to backing file) rather than
>> reads-as-zero (regardless of backing file) makes no difference
>> to normal behavior, but may potentially allow for fewer writes to
>> the L2 table of a freshly-created image where the L2 table is
>> initially written to all-zeroes (although I don't actually know
>> if we skip an L2 update and flush when re-writing the same
>> contents as already present).
>=20
> I don't get this. Allocating a cluster always involves an L2 update, no=

> matter whether it was previously unallocated or a zero cluster.

On IRC, John, Kevin, and I were discussing the current situation with
libvirt NBD storage migration.  When libvirt creates a file on the
destination (rather than the user pre-creating it), it currently
defaults to 0.10 [v2] images, even if the source was a 1.1 image [v3]
(arguably something that could be improved in libvirt, but
https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749 was closed as not a=

bug).

Therefore, the use case of doing a mirror job to a v2 image, and having
that image become thick even though the source was thin, is happening
more than we'd like
(https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749).  While Kevin had=

a point that in the common case we ALWAYS want to turn an unallocated
cluster into a zero cluster (so that we don't have to audit whether all
callers are properly accounting for the case where a backing image is
added later), our conversation on IRC today conceded that we may want to
introduce a new BDRV_REQ_READ_ZERO_NOP (or some such name) that
particular callers can use to request that if a cluster already reads as
zeroes, the write zero request does NOT have to change it.  Normal guest
operations would not use the flag, but mirroring IS a case that would
use the flag, so that we can end up with thinner mirrors even to 0.10
images.

The other consideration is that on 0.10 images, even if we have to
allocate, right now our allocation is done by way of failing with
-ENOTSUP and falling back to the normal pwrite() of explicit zeroes.  It
may be worth teaching the qcow2 layer to explicitly handle write zeroes,
even on 0.10 images, by allocating a cluster (as needed) but then
telling bs->file to write zeroes (punching a hole as appropriate) so
that the file is still thin.  In fact, it matches the fact that we
already have code that probes whether a qcow2 cluster that reports
BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID then probes bs->file to see if
there is a hole there, at which point it can add BDRV_BLOCK_ZERO to the
bdrv_get_block_status.

I don't know which one of us will tackle patches along these lines, but
wanted to at least capture the gist of the IRC conversation in the
archives for a bit more permanence.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bhSbvjqMqip2b5RdKuqcnHM1BHVclfiHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFHuYAAoJEKeha0olJ0NqnFIIAKLyDbUta0OtKoL3ouycWXwd
U20WayAZRv0tRXb548he3j/GbSRnotbLqiiK6C9kN9qFvkLCzRT9edHqd+d1Wurs
Kk9yh1PqIFGxD5dgTCUqWu3/yYKDVrN4F4SaHdTbWSilAHdaNYHI4HofuzMElq1d
ysjTX9EjGeDqEf0MoTIQVD3lBkuTj/BF/uY6kRd/sT5TXj2hw7CejKqc1iOeiOGx
IfVjEOem5qTB1SS+1fKsv8gFFcFfm1ZFdzY85R/eyvqXScGbDiDX+kWG4AWJ0OJJ
YDq3WCspB3ILZM7Ua2wrKIjN8RjhU4McuxdsR4wtqmvD/ckYwzCH4aw90JgOwxY=
=juNh
-----END PGP SIGNATURE-----

--bhSbvjqMqip2b5RdKuqcnHM1BHVclfiHP--
