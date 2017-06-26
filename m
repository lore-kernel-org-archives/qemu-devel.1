Received: from eggs.gnu.org ([2001:4830:134:3::10]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPWC6-0002y4-26
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPWC1-00014Q-1b
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:44:54 -0400
Date: Mon, 26 Jun 2017 16:44:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626154444.GH29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-8-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-8-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 7/8] block: remove
 legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:59PM +0300, Manos Pitsidianakis wrote:
> @@ -1914,45 +1878,115 @@ int blk_commit_all(void)
>  /* throttling disk I/O limits */
>  void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
>  {
> -    throttle_group_config(&blk->public.throttle_group_member, cfg);
> +    ThrottleGroupMember *tgm;
> +
> +    assert(blk->public.throttle_node);
> +    tgm =3D blk->public.throttle_node->opaque;
> +    throttle_group_config(tgm, cfg);

block-backend.c should not access ->opaque.  Instead block/throttle.c
could provide an interface:

  void throttle_node_set_config(BlockDriverState *bs,
                                ThrottleConfig *cfg);

We know bs is always a throttle node but it's also possible for
block/trottle.c to check that:

  assert(bs->drv =3D=3D &throttle_driver_ops);

>  }
> =20
> -void blk_io_limits_disable(BlockBackend *blk)
> +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
>  {
> -    assert(blk->public.throttle_group_member.throttle_state);
> -    bdrv_drained_begin(blk_bs(blk));
> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
> -    bdrv_drained_end(blk_bs(blk));
> +    Error *local_err =3D NULL;
> +    BlockDriverState *bs, *throttle_node;
> +
> +    throttle_node =3D blk_get_public(blk)->throttle_node;
> +
> +    assert(throttle_node && throttle_node->refcnt =3D=3D 1);

I'm not sure if we can enforce refcnt =3D=3D 1.  What stops other graph
manipulation operations from inserting a node above or a BB that uses
throttle_node as the root?

> +
> +    bs =3D throttle_node->file->bs;
> +    blk_get_public(blk)->throttle_node =3D NULL;

Missing drained_begin/end region around code that modifies the graph.

> +
> +    /* ref throttle_node's child bs so that it isn't lost when throttle_=
node is
> +     * destroyed */
> +    bdrv_ref(bs);
> +
> +    /* this destroys throttle_node */
> +    blk_remove_bs(blk);

This assumes that throttle_node is the top node.  How is this constraint en=
forced?

> +
> +    blk_insert_bs(blk, bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        blk_insert_bs(blk, bs, NULL);

How does this handle the error? :)

If there's no way to handle the error then error_abort should be used.

> +    }
> +    bdrv_unref(bs);
>  }
> =20
>  /* should be called before blk_set_io_limits if a limit is set */
> -void blk_io_limits_enable(BlockBackend *blk, const char *group)
> +void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error *=
*errp)
>  {
> -    blk->public.throttle_group_member.aio_context =3D blk_get_aio_contex=
t(blk);
> -    assert(!blk->public.throttle_group_member.throttle_state);
> -    throttle_group_register_tgm(&blk->public.throttle_group_member, grou=
p);

It would be nice to do:

assert(!blk->public.throttle_node);

> +    BlockDriverState *bs =3D blk_bs(blk), *throttle_node;
> +    Error *local_err =3D NULL;
> +    /*
> +     * increase bs refcount so it doesn't get deleted when removed
> +     * from the BlockBackend's root
> +     * */
> +    bdrv_ref(bs);
> +    blk_remove_bs(blk);
> +
> +    QDict *options =3D qdict_new();
> +    qdict_set_default_str(options, "file", bs->node_name);
> +    qdict_set_default_str(options, "throttling-group", group);
> +    throttle_node =3D bdrv_new_open_driver(bdrv_find_format("throttle"),
> +            NULL, bdrv_get_flags(bs), options, &local_err);
> +
> +    QDECREF(options);

Perhaps it's more consistent to use bdrv_open_inherit() ownership
semantics instead.  Then callers don't need to worry about freeing
options.

> +    if (local_err) {
> +        blk_insert_bs(blk, bs, NULL);

&error_abort

> +        bdrv_unref(bs);
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    /* bs will be throttle_node's child now so unref it*/
> +    bdrv_unref(bs);
> +
> +    blk_insert_bs(blk, throttle_node, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);

The only blk_insert_bs() errors are permission errors.  Can the code
guarantee that permissions will always be usable?  Then you can drop the
error handling and just use &error_abort.

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUSvsAAoJEJykq7OBq3PIvUoIAL2TeJ0ingV038sDjqIc1dmV
ClqMBSqx2/jgrkA+Xp/DSSuw+6S3vVn/d9v7yEE70BbXJKnbow4FnW63M0B5x8AD
vA5X3S8V9nUZUm4hK7WVhpkCT9I87cUw9guPsWHvYfHIOMgnMaankYxs6Z9o9tYl
HO/sNGjWWbyYZH2/0g98qRnvq2Ix5wXYVdjUYBcPYIozBvp3arpSOM5AcG9uc0KX
WEY+g85vFvxGjArjBSkjE6qXLPQj0S1+Orw1fVPX49EkAYoHhWpPf46eNGZ/AP7c
EAKwd2ZoXuaSCk3GvBPRZpYw8Xzh6Nugb0MqJgA+ouXGEFlYt98MWi+wWLP4UYE=
=Bcch
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
