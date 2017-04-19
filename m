Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0wtk-0006Eq-VJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0wtj-0004HY-Ja
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:12:24 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-17-eblake@redhat.com>
	<18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
Date: Wed, 19 Apr 2017 16:12:10 -0500
MIME-Version: 1.0
In-Reply-To: <18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2gFmOva9sG6MeUGmsOq85Ngv3D6XjnrPh"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: Make
 bdrv_is_allocated() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2gFmOva9sG6MeUGmsOq85Ngv3D6XjnrPh
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
Subject: Re: [Qemu-block] [PATCH 16/17] block: Make bdrv_is_allocated()
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-17-eblake@redhat.com>
 <18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
In-Reply-To: <18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 03:32 PM, John Snow wrote:

>> @@ -279,9 +280,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMi=
gDevState *bmds)
>>          /* Skip unallocated sectors; intentionally treats failure as
>>           * an allocated sector */
>>          while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
>> -            cur_sector +=3D nr_sectors;
>> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTO=
R_SIZE,
>> +                                  MAX_IS_ALLOCATED_SEARCH, &count)) {=

>> +            cur_sector +=3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>          }
>=20
> Let's try asking again with the right vocabulary:
>=20
> OK, so I guess the idea is that we definitely shouldn't ever have a
> partially allocated sector; so I suppose this ROUND_UP is just a precau=
tion?

For now, yes - but the part 3 series (bdrv_get_block_status) makes
returning a sub-sector value possible.  For most drivers, it will only
happen at end-of-file (as status doesn't change mid-sector unless your
file is not a multiple of a sector size) - in fact, I found that I had
to patch the block layer to round up and sub-sector return that
coincides with end-of-file back to a round sector amount in order to
avoid breaking other code that assumed everything is allocated in sectors=
=2E

>=20
> What would it mean if this actually DID round up? Would we miss
> transmitting a fraction of a sector because we assumed it was unallocat=
ed?

In general, the only mid-sector transition I encountered in testing was
at EOF, where the first half is allocated and the second half (beyond
EOF) was an implicit hole.  But here, you are worried about the opposite
case - can we ever have a hole that ends mid-sector, followed by actual
data in the second half.  Probably not, but I can add an assertion to
the generic block layer that mid-sector returns for an unallocated
answer can only happen at end-of-file.

>=20
> In other places, you scale down with X / BDRV_SECTOR_SIZE or an
> equivalent bitshift, why does this receive a round *up* treatment?

Really? I thought I was being careful in this patch about ALWAYS
preserving the same sector value - the only time I did a bitshift was if
I already asserted the answer was aligned to sector boundaries to begin
with, and when I wasn't sure, it should be a round up.

>=20
> Are we considering a future in which this function might actually give
> us some unaligned answers? Do we need to re-audit all of the callers at=

> that point to make sure they cope appropriately?

Yes, I've been trying to do that all along, but a second set of eyes
never hurts.  Or, as I said, we can play it safe by guaranteeing that
even when byte-based, the block layer enforces sector-aligned answers.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2gFmOva9sG6MeUGmsOq85Ngv3D6XjnrPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY99KqAAoJEKeha0olJ0NqaR8IAI9YzufsCvBglHLNZ39MB5SV
OYALe3XgKBwzRL6XeXKipaC8AWgXJdnqy7gZLdDCI7hYwftljj2anbih9tboIaGu
YauUxFtbr9TlZmTuKDQPM2EHpRWBurnvVIMAg2/4bAshKV/DXlzvIqQAF/Ak9Oop
Dql5Zf58pkOpPiyvPlCifypueqQImoRGvMAKAGQZpccDMeySuAbFi2yhk+SBhGuo
mRupOshp4aoG5UoBPssnC1eaKsiZPloiRdFD9rlsdCYxW8DvUcTRWFj3zLmfbpHw
5t4LUeMhXjLfKNwVsn+ZTboNwfM1fTn2439Wq+hSRGQmFi2rerxu4cR3HBalIqA=
=s87M
-----END PGP SIGNATURE-----

--2gFmOva9sG6MeUGmsOq85Ngv3D6XjnrPh--
