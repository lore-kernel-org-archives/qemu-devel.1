Received: from eggs.gnu.org ([209.51.188.92]:54887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdaN-0002uE-3B
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdO0-0001fq-CD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:06:30 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85831164-fd1e-aa7b-4fc1-e840e38967f3@redhat.com>
Date: Tue, 12 Feb 2019 12:58:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tz8iGWiDA4QOpnll8PT8jnTpFYoIChU5a"
Subject: Re: [Qemu-devel] [PATCH 3/5] block/dirty-bitmap: change semantics
 of enabled predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tz8iGWiDA4QOpnll8PT8jnTpFYoIChU5a
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <85831164-fd1e-aa7b-4fc1-e840e38967f3@redhat.com>
Subject: Re: [PATCH 3/5] block/dirty-bitmap: change semantics of enabled
 predicate
References: <20190212010248.11056-1-jsnow@redhat.com>
 <20190212010248.11056-4-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> Currently, enabled means something like "the status of the bitmap
> is ACTIVE." After this patch, it should mean exclusively: "This
> bitmap is recording guest writes, and is allowed to do so."
>=20
> In many places, this is how this predicate was already used.
> We'll allow users to call user_locked if they're really curious about
> finding out if the bitmap is in use by an operation.
>=20
> To accommodate this, modify the create_successor routine to now
> explicitly disable the parent bitmap at creation time.
>=20
>=20
> Justifications:
>=20
> 1. bdrv_dirty_bitmap_status suffers no change from the lack of
>    1:1 parity with the new predicates because of the order in which
>    the predicates are checked. This is now only for compatibility.
>=20
> 2. bdrv_set_dirty_bitmap is only used by mirror, which does not use
>    disabled bitmaps -- all of these writes are internal usages.
>    Therefore, we should allow writes even in the disabled state.
>    The condition is removed.
>=20
> 3. bdrv_reset_dirty_bitmap Similarly, this is only used internally by
>    mirror and migration. In these contexts it is always enabled anyway,=

>    but our API does not need to enforce this.
>=20
> 4. bdrv_set_dirty will skip recording writes from the guest here if
>    we are disabled OR if we had a successor, which now changes.
>    Accommodate the change by explicitly disabling bitmaps with successo=
rs.

I didn't quite follow this wording.  My try:

The code in bdrv_set_dirty() is unchanged: pre-patch, it was skipping
bitmaps that were disabled or had a successor, while post-patch it is
only skipping bitmaps that are disabled. But we have the same behavior
because the change to create_successor now ensures that any bitmap with
a successor is disabled.

>=20
> 5. qcow2/dirty-bitmap: This only ever wanted to check if the bitmap

Did you mean qcow2_store_persistent_dirty_bitmaps()?

>    was enabled or not. Theoretically if we save during an operation,
>    this now gets set as enabled instead of disabled.

I'm not sure I see the theoretical change in behavior (let alone whether
you could write an iotest to expose it).  Pre-patch, persistent bitmaps
that were disabled or which had a successor did not have the AUTO bit
set (although since we currently only write persistent bitmaps out to
file at exit, when there should be no ongoing jobs and thus no
successors); post-patch, only disabled bitmaps do not have the AUTO bit
(but a bitmap with a successor is disabled because of the change to
create_successor).  But I agree that this code did not need a change due
to the new semantics of bdrv_dirty_bitmap_enabled.

>=20
> 6. block_dirty_bitmap_enable_prepare only ever cared if about the

s/if //

>    literal bit, and already checked for user_locked beforehand.

That is, the check for user_locked already ruled out the has_successor
clause.

>=20
> 7. block_dirty_bitmap_disable_prepare ditto as above.
>=20
> 8. init_dirty_bitmap_migration also already checks user_locked,
>    so this call can be a simple enabled/disabled check.

Looks like correct conversions to me.

> ---
>  block/dirty-bitmap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--tz8iGWiDA4QOpnll8PT8jnTpFYoIChU5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjF3IACgkQp6FrSiUn
Q2o+rwf/e5a3P7yI8JNWSTzofMJlsfBmrTtcx64BRwTgXhy7qTKVMKi8AZppUKWp
ieSEm4WAMmiaVattOe6kaZ9Om6ULeHbe+o0M2MGW9sCHnmTKz5pE4zyRoEqOvc+u
3rMyfxTPGxVoSF7MKEdF1Zse7CplGlvmN0QW14h8LCH9ViXdY3+3s7ixcvnvORIy
plwUmEZ1feTanOuzNpm51EwsDF6vtg7oPb2mt0vGQviXoIeNmEKQQwo2hQxNg0lL
Bex5wK0q2EfC9n+aiwmbWJf5W9ulMC/Za1DMbQOAz12Z6u37If/jB3+uSETnV1zJ
bjY4qfLo84HRoIQZcZqizkNNYVe+lw==
=o5Ag
-----END PGP SIGNATURE-----

--tz8iGWiDA4QOpnll8PT8jnTpFYoIChU5a--
