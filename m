Received: from eggs.gnu.org ([2001:4830:134:3::10]:56924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LbS-00018z-H1
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LbR-0006Ql-BG
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:49:02 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
Date: Mon, 8 Oct 2018 04:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SdBGfLJIM1CJl0PlYo4x8I7naUINr7Vs7"
Subject: Re: [Qemu-devel] [PATCH 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
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
--SdBGfLJIM1CJl0PlYo4x8I7naUINr7Vs7
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
Subject: Re: [PATCH 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
References: <cover.1537367701.git.berto@igalia.com>
 <ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
In-Reply-To: <ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> Now that all callers are passing the new options using the QDict we no
> longer need the 'flags' parameter.
>=20
> This patch makes the following changes:
>=20
>    1) The update_options_from_flags() call is no longer necessary
>       so it can be removed.
>=20
>    2) The update_flags_from_options() call is now used in all cases,
>       and is moved down a few lines so it happens after the options
>       QDict contains the final set of values.
>=20
>    3) The flags parameter is removed. Now the flags are initialized
>       using the current value (for the top-level node) or the parent
>       flags (after inherit_options()). In both cases the initial
>       values are updated to reflect the new options in the QDict. This
>       happens in bdrv_reopen_queue_child() (as explained above) and in
>       bdrv_reopen_prepare().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 50 +++++++++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index fd27b204d9..26c6a4e58a 100644
> --- a/block.c
> +++ b/block.c
> @@ -2884,7 +2884,6 @@ BlockDriverState *bdrv_open(const char *filename,=
 const char *reference,
>  static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_=
queue,
>                                                   BlockDriverState *bs,=

>                                                   QDict *options,
> -                                                 int flags,
>                                                   const BdrvChildRole *=
role,
>                                                   QDict *parent_options=
,
>                                                   int parent_flags)
> @@ -2894,6 +2893,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(=
BlockReopenQueue *bs_queue,
>      BlockReopenQueueEntry *bs_entry;
>      BdrvChild *child;
>      QDict *old_options, *explicit_options;
> +    int flags;
> =20
>      /* Make sure that the caller remembered to use a drained section. =
This is
>       * important to avoid graph changes between the recursive queuing =
here and
> @@ -2919,22 +2919,11 @@ static BlockReopenQueue *bdrv_reopen_queue_chil=
d(BlockReopenQueue *bs_queue,
>      /*
>       * Precedence of options:
>       * 1. Explicitly passed in options (highest)
> -     * 2. Set in flags (only for top level)
> -     * 3. Retained from explicitly set options of bs
> -     * 4. Inherited from parent node
> -     * 5. Retained from effective options of bs
> +     * 2. Retained from explicitly set options of bs
> +     * 3. Inherited from parent node
> +     * 4. Retained from effective options of bs
>       */
> =20
> -    if (!parent_options) {
> -        /*
> -         * Any setting represented by flags is always updated. If the
> -         * corresponding QDict option is set, it takes precedence. Oth=
erwise
> -         * the flag is translated into a QDict option. The old setting=
 of bs is
> -         * not considered.
> -         */
> -        update_options_from_flags(options, flags);
> -    }
> -
>      /* Old explicitly set values (don't overwrite by inherited value) =
*/
>      if (bs_entry) {
>          old_options =3D qdict_clone_shallow(bs_entry->state.explicit_o=
ptions);
> @@ -2948,12 +2937,22 @@ static BlockReopenQueue *bdrv_reopen_queue_chil=
d(BlockReopenQueue *bs_queue,
> =20
>      /* Inherit from parent node */
>      if (parent_options) {
> -        QemuOpts *opts;
> -        QDict *options_copy;
> -        Error *local_err =3D NULL;
> -        assert(!flags);
> +        flags =3D 0;
>          role->inherit_options(&flags, options, parent_flags, parent_op=
tions);
> -        options_copy =3D qdict_clone_shallow(options);
> +    } else {
> +        flags =3D bdrv_get_flags(bs);
> +    }
> +
> +    /* Old values are used for options that aren't set yet */
> +    old_options =3D qdict_clone_shallow(bs->options);
> +    bdrv_join_options(bs, options, old_options);
> +    qobject_unref(old_options);
> +
> +    /* We have the final set of options so let's update the flags */
> +    {
> +        Error *local_err =3D NULL;
> +        QemuOpts *opts;
> +        QDict *options_copy =3D qdict_clone_shallow(options);

I-I'm not sure this conforms to our coding style.

While I applaud your effort to keep the patch size small, I know for
sure I don't want to read code like this.  (Unless it's necessary
because of some variables' lifetimes.)

I agree with the changes, however.

Max

>          opts =3D qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_=
abort);
>          qemu_opts_absorb_qdict(opts, options_copy, &local_err);
>          /* Don't call update_flags_from_options() if the options are w=
rong.
> @@ -2967,11 +2966,6 @@ static BlockReopenQueue *bdrv_reopen_queue_child=
(BlockReopenQueue *bs_queue,
>          qobject_unref(options_copy);
>      }
> =20
> -    /* Old values are used for options that aren't set yet */
> -    old_options =3D qdict_clone_shallow(bs->options);
> -    bdrv_join_options(bs, options, old_options);
> -    qobject_unref(old_options);
> -
>      /* bdrv_open_inherit() sets and clears some additional flags inter=
nally */
>      flags &=3D ~BDRV_O_PROTOCOL;
>      if (flags & BDRV_O_RDWR) {
> @@ -3011,7 +3005,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(=
BlockReopenQueue *bs_queue,
>          qdict_extract_subqdict(options, &new_child_options, child_key_=
dot);
>          g_free(child_key_dot);
> =20
> -        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options=
, 0,
> +        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options=
,
>                                  child->role, options, flags);
>      }
> =20
> @@ -3022,9 +3016,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQu=
eue *bs_queue,
>                                      BlockDriverState *bs,
>                                      QDict *options)
>  {
> -    int flags =3D bdrv_get_flags(bs);
> -    return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
> -                                   NULL, NULL, 0);
> +    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, =
0);
>  }
> =20
>  /*
>=20



--SdBGfLJIM1CJl0PlYo4x8I7naUINr7Vs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6xZIACgkQ9AfbAGHV
z0BccwgAkR11hLjKnZEG1H86kAg0Ki+C5A13jGxggVP277LiR25VdHmvH0AbOYkc
WGthSffvfvF3XL1rEId14cA+wnNVS50eTKFE0gxQaWVU/j8ZiPNS4oeymyfzta96
4p8r/K/qlr4OBKG0CAeBP4zGdawsghtTETq/IVwynyvdaCFBgvnEeWU6JqjdN/cL
+sbFqCWOjC+PSEF4edxkBUj0/qgUQmLTYKBqJCq6RWv3ZdLtWZzU8XDy4RoihtJL
bXCCBQUDZ81FyY7IH5mX45XdVZfB0ywoUSIgKpfGA/d8tDR6wYic+lGVXYOU5Z4U
rp2IjMgkFi8HCezVdf9JnmN2GDHM7Q==
=yRwu
-----END PGP SIGNATURE-----

--SdBGfLJIM1CJl0PlYo4x8I7naUINr7Vs7--
