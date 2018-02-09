Received: from eggs.gnu.org ([2001:4830:134:3::10]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek92u-0008Le-9g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek92t-0002TC-4o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:48:56 -0500
References: <20180209113744.11842-1-berto@igalia.com>
	<66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
	<w51d11ee165.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60ca39a1-0722-72f3-d167-27ba789760e6@redhat.com>
Date: Fri, 9 Feb 2018 14:48:29 +0100
MIME-Version: 1.0
In-Reply-To: <w51d11ee165.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aZHXBAE3KkBtTEorRuq4X29O89AlGton0"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from
 all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aZHXBAE3KkBtTEorRuq4X29O89AlGton0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <60ca39a1-0722-72f3-d167-27ba789760e6@redhat.com>
Subject: Re: [PATCH] qcow2: Check the L1 table parameters from all internal
 snapshots
References: <20180209113744.11842-1-berto@igalia.com>
 <66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
 <w51d11ee165.fsf@maestria.local.igalia.com>
In-Reply-To: <w51d11ee165.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-09 14:35, Alberto Garcia wrote:
> On Fri 09 Feb 2018 02:04:06 PM CET, Max Reitz wrote:
>> I don't like completely refusing to open a qcow2 image if one of the
>> snapshots is invalid, without giving the user any way of fixing it.
>>
>> With this patch, the final two images created in 080 cannot be opened
>> at all (not even with qemu-img info).  Without it, you can, you just
>> can't load the snapshots.  (Well, in one case.  In the other, you can
>> even do that, but that's a bug, as you correctly claim.)
>>
>> More importantly, though, without this patch, you can delete the
>> snapshots.  qemu-img will complain a bit, and you'll have leaks
>> afterwards, but that's nothing qemu-img check can't fix.  With this
>> patch, you can't, because the image cannot be opened at all so it's
>> basically gone for good (unless you get a hex editor).
>=20
> What you're saying is correct. The alternative however is to add checks=

> everywhere the snapshot table is used.

Yes.

> There's for example qcow2_check_metadata_overlap() that will happily
> allocate a buffer of (l1_size * 8) bytes, that can be up to 32 GB.

It will only do that with QCOW2_OL_INACTIVE_L2, though, which is not
enabled by default and will cost a ton of performance anyway, when used.

(And by the way, I'd be OK with dropping that branch.  Or with
revisiting my good old series that strived to make the overlap checks
faster in general.)

> qcow2_expand_zero_clusters() has the same problem but there g_realloc()=

> is used, aborting the process on failure (we should actually use
> g_try_realloc() instead, I'll leave that for a different patch).

And this is only used for qemu-img amend from v3 to v2, offline.  While
aborts are bad, in this case they're not even that bad (because this is
not a common operation at all, and because it's fully offline).

And I'm still not sure how this patch would make anything better.
Without it, qemu-img amend aborts.  Yes, too bad.  So you can still do
qemu-img convert, losing all snapshots, but at least you got something.
(Or we just fix qemu-img amend, that tells you there's something bad
going on, and then you delete the snapshot in question.)

With this patch, your whole data is gone because qemu now refuses to
look at anything in the image.

> If we want to allow opening images with corrupted snapshots perhaps we
> could still do the checks in qcow2_read_snapshots() but instead of
> returning an error add a 'corrupted' flag to QCowSnapshot.

If you think that's simpler than having the proper checks everywhere we
access a snapshot, be my guest.  It does sound reasonable and it might
be nicer for users than having to figure out which snapshot to delete
themselves.

> That solution is not without problems because we'd still need to check
> for that flag everytime the snapshot is used, and that's calling for
> errors in the future.

Well, errors if your file is corrupted.  Not a good thing but I still
prefer it over rejecting files altogether because some non-vital data
structure is corrupted, with no chance of allowing the user to fix the
issue.

An intermediate thing would be to mark the whole image corrupt if some
snapshot is broken and then adding functionality to qemu-img check to
fix that (by deleting the snapshot, if the user has agreed to that).
But whatever we do, there needs to be a way for the user to get all
non-corrupted data off the image.

Max


--aZHXBAE3KkBtTEorRuq4X29O89AlGton0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9pq0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALLwH/RBQTCab4NLsIDpXDq8yi/Z1t4UymP2j
Byzv2q4Lunz1da1tc4Ch8bqC4ldtXoTxN7c+fsfCFCy2utnaPcTcV/DR8cJYMHyF
HHeAjA/GOdoMjqjC1g3dUYAZMs9u2ShYrSOtmRg44F0j47KgGCMUjzZPXzFNIrbe
SCvPIFGTiNy60iipuRia7LiJR+CtkTxBlqW9pfKS8RrBxoFAj3FCu0QQahOOjK3k
wctgmEhs484fbnPP8Y2sORFGR1TF45GxKitb2DRRo7StslYaCCa8fnj4BuSbHqBB
pFL9HWXdQdCqPp+XGnJN/N6nRCTixmF0vy261RDTytXxpKdS+D8sLOE=
=/5JW
-----END PGP SIGNATURE-----

--aZHXBAE3KkBtTEorRuq4X29O89AlGton0--
