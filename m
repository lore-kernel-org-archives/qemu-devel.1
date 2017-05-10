Received: from eggs.gnu.org ([2001:4830:134:3::10]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8aBM-0005yB-Az
	for qemu-devel@nongnu.org; Wed, 10 May 2017 18:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8aBL-0006fT-5H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 18:34:08 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-17-eblake@redhat.com>
	<18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
	<ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
	<2f38bef2-022b-881c-437c-7fb895214e4c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b286c9de-f843-4e61-e2fe-6be015a8d9c9@redhat.com>
Date: Wed, 10 May 2017 17:33:49 -0500
MIME-Version: 1.0
In-Reply-To: <2f38bef2-022b-881c-437c-7fb895214e4c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KPWmgSkc9j3pgB2H7ixs3aRsd2vuBRLRg"
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
--KPWmgSkc9j3pgB2H7ixs3aRsd2vuBRLRg
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b286c9de-f843-4e61-e2fe-6be015a8d9c9@redhat.com>
Subject: Re: [Qemu-block] [PATCH 16/17] block: Make bdrv_is_allocated()
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-17-eblake@redhat.com>
 <18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
 <ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
 <2f38bef2-022b-881c-437c-7fb895214e4c@redhat.com>
In-Reply-To: <2f38bef2-022b-881c-437c-7fb895214e4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 04:40 PM, John Snow wrote:
>=20
>=20
> On 04/19/2017 05:12 PM, Eric Blake wrote:
>> On 04/19/2017 03:32 PM, John Snow wrote:
>>
>>>> @@ -279,9 +280,9 @@ static int mig_save_device_bulk(QEMUFile *f, Blk=
MigDevState *bmds)
>>>>          /* Skip unallocated sectors; intentionally treats failure a=
s
>>>>           * an allocated sector */
>>>>          while (cur_sector < total_sectors &&
>>>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>>>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sect=
ors)) {
>>>> -            cur_sector +=3D nr_sectors;
>>>> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SEC=
TOR_SIZE,
>>>> +                                  MAX_IS_ALLOCATED_SEARCH, &count))=
 {
>>>> +            cur_sector +=3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>>>          }
>>>
>>> Let's try asking again with the right vocabulary:
>>>
>>> OK, so I guess the idea is that we definitely shouldn't ever have a
>>> partially allocated sector; so I suppose this ROUND_UP is just a prec=
aution?
>>
>> For now, yes - but the part 3 series (bdrv_get_block_status) makes
>> returning a sub-sector value possible.  For most drivers, it will only=

>> happen at end-of-file (as status doesn't change mid-sector unless your=

>> file is not a multiple of a sector size) - in fact, I found that I had=

>> to patch the block layer to round up and sub-sector return that
>> coincides with end-of-file back to a round sector amount in order to
>> avoid breaking other code that assumed everything is allocated in sect=
ors.
>=20
> I'm sorry, I'm having difficulty parsing your last sentence.

We should NEVER have an allocation smaller than
bds->bl.request_alignment (for example, if you can't write in chunks
smaller than 512, then how can your allocation be smaller than that?).
But when we eventually have byte-granularity support, and for a device
where request_alignment is 1, it is feasible that we could track
mid-sector alignment changes.  In practice, we DO have an
easy-to-observe mid-sector alignment change: on a regular file not
aligned to sector boundaries, where request_alignment IS 1, we get a
mid-sector transition from data to hole at EOF.  So it turned out to be
easier in my later series on bdrv_get_block_status() to intentionally
round a partial sector at end-of-file up as if the entire sector was
allocated, rather than reporting the mid-sector alignment (matching the
fact that bdrv_getlength() rounds up to sector boundaries).

If, someday, we fix bdrv_getlength() to report a non-sector-aligned
value, we'll have to revisit the rounding (again, it feels like
bds->bl.request_alignment is the obvious place to ensure that we never
report a mid-alignment result, but where the alignment size is now
driver-dependent instead of hard-coded to 512).  In fact, even with
non-sector-aligned bdrv_getlength(), we may STILL be able to enforce
rules such as mid-sector transitions from hole->data are not possible
(regardless of request_alignment), and mid-sector transitions from
data->hole are possible only at the end of the file.

> I agree with you that there is absolutely definitely no real problem
> here right now, but I do secretly wonder if we'll invent a way to screw=

> ourselves over.
>=20
> Presumably it will get converted at SOME point like everything else, an=
d
> it won't be a concern anymore.
>=20
> Presumably Presumably that will even happen before we invent a way to
> screw ourselves over.

Here's hoping we are careful enough, and have enough asserts in the
right place so that if we guessed wrong we get a nice assert (rather
than risking inf-looping because we rounded a sub-sector down to 0, or
causing data corruption that doesn't show up until much later where we
rounded up and missed copying something); at the same time, that the
asserts are accurate enough that we can't trip them from legitimate users=
=2E

One thing I plan to add to my v2 posting (for the part 3
bdrv_get_block_status series) is to remove the 'qemu-io alloc' sector
alignment restrictions, to have a tool that makes it easier to prove
that I am properly handling rounding at the block layer out to
request_alignment limits without triggering any asserts.  And my recent
blkdebug enhancements are probably going to be helpful in validating
things, even if I have to add more iotests.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KPWmgSkc9j3pgB2H7ixs3aRsd2vuBRLRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE5VNAAoJEKeha0olJ0NqlsYIAIRI0LfhBj1b5Y8SYSqnmBLn
hajM+StEYVqK0zHSRGccm1vQiYjmvJAZepVOcw93vBQ0/A1e4qOHasA/iKr3uGig
u9h3SKa3yZMF4QwkYAjEavXez06IvYGI63edT6cRe8hjjQz++JxeEat4HvaHhGv3
KzIkihYgiWnLZ4pzR7SVJtsQFhIDigrEINqR9XCf1cMvu+UwnPr73mqf0T4GwqAE
cfzYd1vXwBjsfaDGWQ6xmG9ZtIpIoVRBirysVezi1tb4c9k8hg60pxbaP8paYId5
vgNwlIuPAZsSUrKslI3ajA8cQqOVNIDBoEhnBWNMHFNGFSPpj308U0qfKYVSOvo=
=Mb5r
-----END PGP SIGNATURE-----

--KPWmgSkc9j3pgB2H7ixs3aRsd2vuBRLRg--
