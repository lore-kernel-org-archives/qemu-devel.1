Received: from eggs.gnu.org ([209.51.188.92]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4d9-0003sN-ME
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4d7-0002xB-Op
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:58:27 -0500
References: <20190111194720.15671-1-eblake@redhat.com>
	<20190111194720.15671-4-eblake@redhat.com>
	<6e3c47c7-e6d1-3c2a-23d3-513ab036bc19@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <669eb663-d4ca-c75c-7d8d-d46b8a71ae2f@redhat.com>
Date: Mon, 14 Jan 2019 09:58:17 -0600
MIME-Version: 1.0
In-Reply-To: <6e3c47c7-e6d1-3c2a-23d3-513ab036bc19@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qr7ut122XeoxHEhgT64SRxhDqMHWbwLin"
Subject: Re: [Qemu-devel] [PATCH v3 3/8] nbd: Only require disabled bitmap
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
--Qr7ut122XeoxHEhgT64SRxhDqMHWbwLin
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <669eb663-d4ca-c75c-7d8d-d46b8a71ae2f@redhat.com>
Subject: Re: [PATCH v3 3/8] nbd: Only require disabled bitmap for read-only
 exports
References: <20190111194720.15671-1-eblake@redhat.com>
 <20190111194720.15671-4-eblake@redhat.com>
 <6e3c47c7-e6d1-3c2a-23d3-513ab036bc19@virtuozzo.com>
In-Reply-To: <6e3c47c7-e6d1-3c2a-23d3-513ab036bc19@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 3:49 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.01.2019 22:47, Eric Blake wrote:
>> Our initial implementation of x-nbd-server-add-bitmap put
>> in a restriction because of incremental backups: in that
>> usage, we are exporting one qcow2 file (the temporary overlay
>> target of a blockdev-backup sync:none job) and a dirty bitmap
>> owned by a second qcow2 file (the source of the
>> blockdev-backup, which is the backing file of the temporary).
>> While both qcow2 files are still writable (the target in
>> order to capture copy-on-write of old contents, and the
>> source in order to track live guest writes in the meantime),
>> the NBD client expects to see constant data, including the
>> dirty bitmap.  An enabled bitmap in the source would be
>> modified by guest writes, which is at odds with the NBD
>> export being a read-only constant view, hence the initial
>> code choice of enforcing a disabled bitmap (the intent is
>> that the exposed bitmap was disabled in the same transaction
>> that started the blockdev-backup job, although we don't want
>> to track enough state to actually enforce that).
>>
>> However, consider the case of a bitmap contained in a read-only
>> node (including when the bitmap is found in a backing layer of
>> the active image).  Because the node can't be modified, the
>> bitmap won't change due to writes, regardless of whether it is
>> still enabled.  Forbidding the export unless the bitmap is
>> disabled is awkward, paritcularly since we can't change the
>> bitmap to be disabled (because the node is read-only).
>>
>> Alternatively, consider the case of live storage migration,
>> where management directs the destination to create a writable
>> NBD server, then performs a drive-mirror from the source to
>> the mirror, prior to doing the rest of the live migration.
>=20
> s/mirror/target ?

Yes.

>=20
>> Since storage migration can be time-consuming, it may be wise
>> to let the destination include a dirty bitmap to track which
>> portions it has already received, where even if the migration
>> is interrupted and restarted, the source can query the
>> destination block status in order to minimize re-sending
>> data that has not changed in the meantime on a second attempt.
>=20
> hmm, dirty bitmap dirtiness don't guarantee that data was written,
> due to:
>=20
> 1. philosofy: we generally don't care, when something is reported
>     as dirty, when actually it is clean, we assume that it is always
>     safe to consider things to be dirty.
>=20
> 2. granularity: really, at least granularity of target bitmap should
>     correspond to mirror cluster size and target block size, if one of
>     these three things is out of sync, we definitely get [1]
>=20
> 3. errors: bitmaps are set dirty for failed writes too, so [1]

Good points.

>=20
> I'm not totally against, I just note that the feature you mean is
> at least not as simple to implement. And for me it looks like it is mor=
e
> correct to track progress of mirror on source, assuming all success
> nbd write requests as successful story. At least, as all vm metadata
> is on source, when storage migration not finished yet.

I'm fine adding a caveat that while allowing reads from a modifying
dirty bitmap may help, they may not be trivial to use correctly.

>=20
>> Such code has not been written, but it makes sense that
>> letting an active dirty bitmap be exposed and changing
>> alongside writes may prove useful in the future.

to go along with my caveat that such code does not yet exist anyways :)

>>
>> Solve both issues by gating the restriction against a
>> disabled bitmap to only happen when the caller has requested
>> a read-only export, and where the BDS that owns the bitmap
>> (whether or not it is the BDS handed to nbd_export_new() or
>> from its backing chain) is still writable.
>>
>> Update iotest 223 to show the looser behavior by leaving
>> a bitmap enabled the whole run; note that we have to tear
>> down and re-export a node when handling an error.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> anyway, I'm OK with new if-condition, and for me something like
>=20
>    No real reasons to forbid export of enabled bitmap, user should unde=
rstand,
>    that block-status result may not correspond to reality if bitmap may=
 be
>    changed by guest-write or something in parallel (including client's =
self requests).
>    So, it should be OK to drop the restriction at all, but let's keep a=
 smaller
>    one to prevent dangerous wrong management error..
>=20
> would be enough description so,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Okay. Thanks for the review!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Qr7ut122XeoxHEhgT64SRxhDqMHWbwLin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8sZkACgkQp6FrSiUn
Q2pcmAf/dNuSkmHaHyvRUUwdqdoanqdygE2vXxNTYAoqyTvpU58rtOCSBIBFGUDt
6sUl1b593V6zNHAEgeNrm0kc4w3NTXBDwvtFzpnd8XX0fyeJXqtxjHopVQUFJk8C
FefHNfwMJId8fjzfPy1TZ33yZTuyzwKvc/4+r3kN2XTY9M3xFCj33R7Ltv/cOClV
EfFwkKP7wDN0L4sNpMHbRcn23dB4rXY9mFtoxq+0gmF52lhKKMwyf5uzwJR/49VO
8W1VBUwgv/ZveFh73dmHFKRLW2aaNWUoYf3mGrjXdtYVcuCXh4Jfu9Lg0eJzLfhg
4KF2bgXZw7HHplNZLfnReVF/+1sEZQ==
=OOab
-----END PGP SIGNATURE-----

--Qr7ut122XeoxHEhgT64SRxhDqMHWbwLin--
