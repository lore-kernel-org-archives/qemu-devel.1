Received: from eggs.gnu.org ([2001:4830:134:3::10]:53078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7khq-0000kP-LH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7khp-0007j0-HF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:36:14 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-2-eblake@redhat.com>
	<35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
Date: Mon, 8 May 2017 10:36:06 -0500
MIME-Version: 1.0
In-Reply-To: <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FqfdiIPaL8O6Vs1JR7fvoo9UWuuqv7Ejx"
Subject: Re: [Qemu-devel] [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FqfdiIPaL8O6Vs1JR7fvoo9UWuuqv7Ejx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
Subject: Re: [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-2-eblake@redhat.com>
 <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
In-Reply-To: <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 10:27 AM, Max Reitz wrote:
> On 07.05.2017 02:05, Eric Blake wrote:
>> In order to keep checkpatch happy when the next patch changes
>> indentation, we first have to shorten some long lines.  The easiest
>> approach is to use a new variable in place of
>> 'offset & L2E_OFFSET_MASK', except that 'offset' is the best name
>> for that variable.  Change '[old_]offset' to '[old_]entry' to
>> make room.
>>
>> While touching things, also fix checkpatch warnings about unusual
>> 'for' statements.
>>
>> Suggested by Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -1117,20 +1118,22 @@ int qcow2_update_snapshot_refcount(BlockDriver=
State *bs,
>>                  goto fail;
>>              }
>>
>> -            for(j =3D 0; j < s->l2_size; j++) {
>> +            for (j =3D 0; j < s->l2_size; j++) {
>>                  uint64_t cluster_index;
>> +                uint64_t offset;
>=20
> Actually, introducing entry and old_entry in this scope would have
> sufficed, too, because they aren't used anywhere else. But nobody
> actually cares (O:-)), so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>
>> -                offset =3D be64_to_cpu(l2_table[j]);
>> -                old_offset =3D offset;
>> -                offset &=3D ~QCOW_OFLAG_COPIED;
>> +                entry =3D be64_to_cpu(l2_table[j]);
>> +                old_entry =3D entry;

Other things I thought about, but didn't care enough to actually do:
it's possible to reduce a line of code by either:

old_entry =3D entry =3D be64_to_cpu(l2_table[j]);
entry &=3D ~QCOW_OFLAG_COPIED;

or by:

old_entry =3D be64_to_cpu(l2_table[j]);
entry =3D old_entry & ~QCOW_OFLAG_COPIED;

for one less line of source.  You're welcome to make either such tweak
if you care, but I'm not going to respin for just that ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FqfdiIPaL8O6Vs1JR7fvoo9UWuuqv7Ejx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEJBmAAoJEKeha0olJ0NqI6kIAKPH5uWr0mNI2X/GhRjYfeHX
EHFJOto4D4KgZfUwR6VGShUSW008gjP3yl9OM7oEX0P71hmRCBtbV2s/dPmGApeu
2k9KpcrgXGBqJTj53S+CzKtwwdo8ThNzgfx1pc9ubiTQHvaspO2Up2DCgZqNDkwt
zOnkjHLvBsOiVhOcsTEOmXj500O0+FlpARM1XjkiIzUPTZXiPbQWF/O7IuJlOgII
401zZhLRUhEHDZ5wNSsY5GYmdKWeCV7sFXldLR+6KWCIDAmmeELxcBrGuU2FZlsa
TP65+WK1yLn16tKKTJr/mhflwqRp5PB77OEwZ1McmYUVK2SsX/lZmHA7wZSnHt0=
=09h3
-----END PGP SIGNATURE-----

--FqfdiIPaL8O6Vs1JR7fvoo9UWuuqv7Ejx--
