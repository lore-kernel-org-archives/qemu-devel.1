Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSj0C-00018x-FL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSj0B-00016S-Ef
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:01:52 -0400
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-15-eblake@redhat.com>
	<20170704094411.GO10298@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d6ff1e7-4d8a-a329-3c2a-0305f1bc706d@redhat.com>
Date: Wed, 5 Jul 2017 07:01:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170704094411.GO10298@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2U9oLocxDXBMxCxNuqI0uaDgbogID0Pm3"
Subject: Re: [Qemu-devel] [PATCH v2 14/15] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2U9oLocxDXBMxCxNuqI0uaDgbogID0Pm3
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9d6ff1e7-4d8a-a329-3c2a-0305f1bc706d@redhat.com>
Subject: Re: [PATCH v2 14/15] block: Align block status requests
References: <20170703221456.30817-1-eblake@redhat.com>
 <20170703221456.30817-15-eblake@redhat.com>
 <20170704094411.GO10298@lemon.lan>
In-Reply-To: <20170704094411.GO10298@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 04:44 AM, Fam Zheng wrote:
> On Mon, 07/03 17:14, Eric Blake wrote:
>> Any device that has request_alignment greater than 512 should be
>> unable to report status at a finer granularity; it may also be
>> simpler for such devices to be guaranteed that the block layer
>> has rounded things out to the granularity boundary (the way the
>> block layer already rounds all other I/O out).  Besides, getting
>> the code correct for super-sector alignment also benefits us
>> for the fact that our public interface now has byte granularity,
>> even though none of our drivers have byte-level callbacks.
>>
>> Add an assertion in blkdebug that proves that the block layer
>> never requests status of unaligned sections, similar to what it
>> does on other requests (while still keeping the generic helper
>> in place for when future patches add a throttle driver).  Note
>> note that iotest 177 already covers this (it would fail if you
>=20
> Drop one "note"?

Indeed. There are studies on how people read that show that redundant
words that cross a line boundaries are the most easy to mentally overlook=
=2E


>> +    /* Round out to request_alignment boundaries */
>> +    align =3D MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
>> +    aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
>> +    aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offse=
t;
>> +
>> +    {
>=20
> Not sure why using a {} block here?
>=20
>> +        int count; /* sectors */

Because it makes it easier (less indentation churn) to delete the code
when series 4 later deletes the .bdrv_co_get_block_status sector-based
callback in favor of the newer .bdrv_co_block_status byte-based (patch
16/15 which start series 4 turns it into an if statement, then a later
patch deletes the entire conditional); it is also justifiable because it
creates a tighter scope for 'int count' which is needed only on the
boundary of sector-based operations when the rest of the function is
byte-based (rather than declaring the helper variable up front).  I'll
have to call it out more specifically in the commit message as intentiona=
l.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2U9oLocxDXBMxCxNuqI0uaDgbogID0Pm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXNUcAAoJEKeha0olJ0Nq3IUH/1BzKc8P3fjeMURrwfoaFDVt
omBnw1Q1Vms1wMHJz1kP+To5SvMcm+2OlyQ256jKqC/Ho+AsI7i8t4qLLbySF8gf
CzJXLxxhs2sN3YS26q/72a6cjX9a75mjYSS4SFx+f1ByvI0aUc6RpN2rGWENqiYu
LfmUVH2CNdEfiz3cZ8TzH9amVRuFPR4okgzqQP27vHYRT+fD4/2oQAnIgizi50YL
TvEVMIFvFOdNepA579KkFpFExfy1AEnXQaQbZ9byg0l1Mb1GwgQQnCxCckJYYXOg
6dFibk8QNNLEWLq2IBqaeNbG0+tjP6Krx3wPEpJ+Glc4NSPf2dyk3VFQC8FmBoE=
=rmpt
-----END PGP SIGNATURE-----

--2U9oLocxDXBMxCxNuqI0uaDgbogID0Pm3--
