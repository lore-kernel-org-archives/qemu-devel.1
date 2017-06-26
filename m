Received: from eggs.gnu.org ([2001:4830:134:3::10]:42855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPV2h-0003Eh-AA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPV2e-0000Ex-5r
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:31:07 -0400
Date: Mon, 26 Jun 2017 15:30:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626143055.GC29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
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


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 03:46:55PM +0300, Manos Pitsidianakis wrote:
> +static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupMember *tgm,
> +                                                    QDict *options, Error **errp)
> +{
> +    int ret = 0;
> +    ThrottleState *ts;
> +    ThrottleTimers *tt;
> +    ThrottleConfig cfg;
> +    QemuOpts *opts = NULL;
> +    const char *group_name = NULL;
> +    Error *local_err = NULL;
> +
> +    opts = qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
> +    if (!group_name) {
> +        group_name = bdrv_get_device_or_node_name(bs);
> +        if (!strlen(group_name)) {
> +            error_setg(&local_err,
> +                       "A group name must be specified for this device.");

To make the error message clearer:
s/A group name/A throttle group name/

> +static int throttle_open(BlockDriverState *bs, QDict *options,
> +                            int flags, Error **errp)
> +{
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    Error *local_err = NULL;
> +
> +    bs->open_flags = flags;

Why is this necessary?  The other block drivers don't do it.  It should
be taken care of in block.c.

> +    bs->file = bdrv_open_child(NULL, options, "file",
> +                                    bs, &child_file, false, &local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +
> +    qdict_flatten(options);
> +    return throttle_configure_tgm(bs, tgm, options, errp);

Who destroys bs->file on error?

> +}
> +
> +static void throttle_close(BlockDriverState *bs)
> +{
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    bdrv_drained_begin(bs);

Why is this necessary?  bdrv_close() already encloses drv->bdrv_close()
in a bdrv_drained_begin/end region.

> +    throttle_group_unregister_tgm(tgm);
> +    bdrv_drained_end(bs);
> +    return;

Please omit return at the end of a void function.  They are a
distraction.

> +static void throttle_reopen_commit(BDRVReopenState *state)
> +{
> +    ThrottleGroupMember *tgm = state->bs->opaque;
> +    BlockDriverState *bs = state->bs;
> +
> +    bdrv_drained_begin(bs);

Why is this necessary?  bdrv_reopen_multiple() calls
bdrv_reopen_commit() from within a bdrv_drain_all_begin()/end() region.

> +static BlockDriver bdrv_throttle = {
> +    .format_name                        =   "throttle",
> +    .protocol_name                      =   "throttle",
> +    .instance_size                      =   sizeof(ThrottleGroupMember),
> +
> +    .bdrv_file_open                     =   throttle_open,
> +    .bdrv_close                         =   throttle_close,
> +    .bdrv_co_flush                      =   throttle_co_flush,
> +
> +    .bdrv_child_perm                    =   bdrv_filter_default_perms,
> +
> +    .bdrv_getlength                     =   throttle_getlength,
> +
> +    .bdrv_co_preadv                     =   throttle_co_preadv,
> +    .bdrv_co_pwritev                    =   throttle_co_pwritev,
> +
> +    .bdrv_co_pwrite_zeroes              =   throttle_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard                   =   throttle_co_pdiscard,
> +
> +    .bdrv_recurse_is_first_non_filter   =   bdrv_recurse_is_first_non_filter,
> +
> +    .bdrv_attach_aio_context            =   throttle_attach_aio_context,
> +    .bdrv_detach_aio_context            =   throttle_detach_aio_context,
> +
> +    .bdrv_reopen_prepare                =   throttle_reopen_prepare,
> +    .bdrv_reopen_commit                 =   throttle_reopen_commit,
> +    .bdrv_reopen_abort                  =   throttle_reopen_abort,
> +
> +    .is_filter                          =   true,
> +};

Missing:
bdrv_co_get_block_status()
bdrv_truncate()
bdrv_get_info()
bdrv_probe_blocksizes()
bdrv_probe_geometry()
bdrv_media_changed()
bdrv_eject()
bdrv_lock_medium()
bdrv_co_ioctl()

See block/raw-format.c.

I think most of these could be modified in block.c or block/io.c to
automatically call bs->file's function if drv doesn't implement them.
This way all block drivers would transparently pass them through by
default and block/raw-format.c code could be eliminated.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZURqfAAoJEJykq7OBq3PIpWcH/3c6SMdgOwKXty0LldJ0bicm
1VIuA6cPj23ur95cU93os4Cj0w3MXQx4zhC8qH7xsFbQKQNdpfxEvnjoS+Z/jLns
MhC8Dw3WUgV+b5NdKWRg0HbumDOXXyknwxdS/aLLZ6gT3g5XB9i7kxhH5v3V7/sg
gGgWsvJo7Zb3aqaMeZ34IgIdotTKcF4T6afTcNdV5z54KqCGpG8B7opu4sz3erxQ
N/FBoDOSBQC/Ko2KUmTkEicTHR2wMnQPCj54tCCsbvZsCzanRSS90cBndRUt+axE
tHeZBSf2JsEYMBzlLtm/sDbUBsowwrofWEcBuDGd98Mz8V7k5i6TssmhB60+u6E=
=CxMt
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
