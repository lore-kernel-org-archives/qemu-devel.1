Received: from eggs.gnu.org ([209.51.188.92]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbU1-0002tn-Rd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbU0-0002TB-1h
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:38:57 -0500
References: <20190110071330.28136-1-eblake@redhat.com>
	<20190110071330.28136-2-eblake@redhat.com>
	<3a2bac12-d3c2-8ce9-fc25-4a01c4ec1e3f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0e453b6-369e-11e3-e4b1-c6867b99d74a@redhat.com>
Date: Thu, 10 Jan 2019 08:38:33 -0600
MIME-Version: 1.0
In-Reply-To: <3a2bac12-d3c2-8ce9-fc25-4a01c4ec1e3f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DGaqVjkUwqsAwiZDJl5Mi6dgLFDVOSawv"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd: Only require disabled bitmap
 for read-only exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DGaqVjkUwqsAwiZDJl5Mi6dgLFDVOSawv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <b0e453b6-369e-11e3-e4b1-c6867b99d74a@redhat.com>
Subject: Re: [PATCH v2 1/6] nbd: Only require disabled bitmap for read-only
 exports
References: <20190110071330.28136-1-eblake@redhat.com>
 <20190110071330.28136-2-eblake@redhat.com>
 <3a2bac12-d3c2-8ce9-fc25-4a01c4ec1e3f@virtuozzo.com>
In-Reply-To: <3a2bac12-d3c2-8ce9-fc25-4a01c4ec1e3f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 4:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.01.2019 10:13, Eric Blake wrote:
>> Our initial implementation of x-nbd-server-add-bitmap put
>> in a restriction because of incremental backups: in that
>> usage, we are exporting one qcow2 file (the temporary overlay
>> target of a blockdev-backup sync:none job) and a dirty bitmap
>> owned by a second qcow2 file (the source of the
>> blockdev-backup, which is the backing file of the temporary).
>> While both qcow2 files are still writable (the target capture
>> copy-on-write of old contents, the source to track live guest
>> writes in the meantime), the NBD client expects to see
>> constant data, including the dirty bitmap.  An enabled bitmap
>> in the source would be modified by guest writes, which is at
>> odds with the NBD export being a read-only constant view,
>> hence the initial code choice of enforcing a disabled bitmap
>> (the intent is that the exposed bitmap was disabled in the
>> same transaction that started the blockdev-backup job,
>> although we don't want to actually track enough state to
>> actually enforce that).
>>
>> However, in the case of image migration, where we WANT a
>> writable export, it makes total sense that the NBD client
>> could expect writes to change the status visible through
>> the exposed dirty bitmap,
>=20
> Don't follow.. Which kind of migration do you mean?

When libvirt does block migration, it opens up an NBD server on the
destination, does a block-mirror from the source to copy the contents to
the destination, then when the two are in sync does the actual VM state
migration. There may be a use case where the destination already has
some of the state (say that we started a migration, then got
interrupted, and now want to restart but not lose the progress of what
has already been sync'd previously) - in which case, the destination
would expose a dirty bitmap of what has been already transferred, and
the source can use that information to avoid re-sending data that has
not changed since the previous partial transfer.  There may be other
uses for exposing a live dirty bitmap for a writeable NBD export; and
it's more a question of not forbidding this case even if I don't have a
strong use case for why it will be useful.

>=20
>   and thus permitting an enabled
>> bitmap for an export that is not read-only makes sense;
>> although the current restriction prevents that usage.
>>
>> Alternatively, consider the case when the active layer does
>> not contain the bitmap but the backing layer does.  If the
>> backing layer is read-only (which is different from the
>> backing layer of a blockdev-backup job being writable),
>> we know the backing layer cannot be modified,=20
>=20
> hmm, sounds a bit strange "in case of read-only backing, we know
> that it cannot be modified". It's true for any read-only node,
> so you can say just something like "read-only node (for example
> regular backing file)"

Nicer wording indeed. And, since my first paragraph was harder to
justify, I'll swap the two in order to emphasize the case I actually hit
over the one that is just hand-wavy "we might find a use for it".

>=20
> and thus the
>> bitmap will not change contents even if it is still marked
>> enabled (for that matter, since the backing file is
>> read-only, we couldn't change the bitmap to be disabled
>> in the first place).  Again, the current restriction
>> prevents this usage.
>>
>> Solve both issues by gating the restriction against a
>> disabled bitmap to only happen when the caller has
>> requested a read-only export, and where the BDS that owns
>> the bitmap (which might be a backing file of the BDS
>> handed to nbd_export_new) is still writable.
>>
>> Update iotest 223 to add some tests of the error paths.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>   _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
>>     "arguments":{"device":"n"}}' "return"
>> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
>> +  "arguments":{"device":"n"}}' "error"
>=20
> twice add?
>=20

>=20
> aha, I've just realized that it's "some tests of the error paths" not r=
elated to bitmaps..
>=20
> So, I'd prefer to keep them in separate patch

Could do.  I can split it if I have to respin.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--DGaqVjkUwqsAwiZDJl5Mi6dgLFDVOSawv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw3WOkACgkQ3g5py3or
ov2daQf+M4WIIfY5jRCZdN/S5Z+PoGDEjg5xfsOBJdYzN/wVg6sg6LSX4jHQGeDh
VsBqZYUPO6Edo/C+CLbclTexqzWecnf9ufRnhK9YQLHPNhWlIGResXiicsACJUZ9
mtj/lWpSIjLWf9K8qFtmuw0MwWJCdtZSdbaZx9Ny0MdYqK5YvWunFu09wL/OvA5t
XIFoktB4bWzl0SXsVDf4UF0JrF//rEt/ZuHXuB/Sz6J6MJ8SyEe6fp46nEGi6Jbg
/ZiRVOcuqTxQO/1QB4b1n8/+0uhwz+Gu20qG54Ie5Q56CSPI1EiBcAsdizZ/AMI+
/3XUUoAfbT4HuQbLB1CkWgGqaGNXhg==
=7Qfg
-----END PGP SIGNATURE-----

--DGaqVjkUwqsAwiZDJl5Mi6dgLFDVOSawv--
