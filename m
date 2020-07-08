Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA2DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A3420772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5EvTFtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A3420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIcB-0006yz-62
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIFg-0001C8-Lc
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:09:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIFe-0007de-HY
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmBHZAsCxRBaVtiuMQKnNmwmfE8e6W/5RdK+mrOP/9g=;
 b=W5EvTFtIQQ9wQI1mweoAwZLGwnqHKYagGw4XGmMhscNovRfYbMIwhkuof+xh2w1NFTob5u
 iogFpg3nJqtePOJkuJK/1g0LybufqaKmjZMcJNhYsFmLCskd/pclllH/ZJ9kC+YPwpnUQ2
 ztjHhAOAmmK6J5chcEd9+9xMyv43HoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-XEMtncXgP5ar8_VGyIL52g-1; Wed, 08 Jul 2020 08:07:30 -0400
X-MC-Unique: XEMtncXgP5ar8_VGyIL52g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284D38014D7;
 Wed,  8 Jul 2020 12:07:29 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27AD91001B07;
 Wed,  8 Jul 2020 12:07:27 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:07:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/5] block: introduce preallocate filter
Message-ID: <20200708120726.GC459887@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200620143649.225852-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 05:36:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> It may be used for file-systems with slow allocation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |   3 +-
>  block/preallocate.c  | 255 +++++++++++++++++++++++++++++++++++++++++++
>  block/Makefile.objs  |   1 +
>  3 files changed, 258 insertions(+), 1 deletion(-)
>  create mode 100644 block/preallocate.c

Please add documentation to docs/system/qemu-block-drivers.rst.inc
describing the purpose of this block driver and how to use it.

Since this filter grows the file I guess it's intended to be below an
image format?

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0e1c6a59f2..a0bda399d6 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2805,7 +2805,7 @@
>              'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', '=
ftps',
>              'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'is=
csi',
>              'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parall=
els',
> -            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
> +            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd=
',
>              { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
>              'sheepdog',
>              'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'v=
xhs' ] }
> @@ -3995,6 +3995,7 @@
>        'null-co':    'BlockdevOptionsNull',
>        'nvme':       'BlockdevOptionsNVMe',
>        'parallels':  'BlockdevOptionsGenericFormat',
> +      'preallocate':'BlockdevOptionsGenericFormat',
>        'qcow2':      'BlockdevOptionsQcow2',
>        'qcow':       'BlockdevOptionsQcow',
>        'qed':        'BlockdevOptionsGenericCOWFormat',
> diff --git a/block/preallocate.c b/block/preallocate.c
> new file mode 100644
> index 0000000000..c272a6e41d
> --- /dev/null
> +++ b/block/preallocate.c
> @@ -0,0 +1,255 @@
> +/*
> + * preallocate filter driver
> + *
> + * The driver performs preallocate operation: it is injected above
> + * some node, and before each write over EOF it does additional prealloc=
ating
> + * write-zeroes request.
> + *
> + * Copyright (c) 2020 Virtuozzo International GmbH.
> + *
> + * Author:
> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "block/block_int.h"
> +
> +
> +typedef struct BDRVPreallocateState {
> +    int64_t prealloc_size;
> +    int64_t prealloc_align;
> +
> +    /*
> +     * Track real data end, to crop preallocation on close  data_end may=
 be
> +     * negative, which means that actual status is unknown (nothing crop=
ped in
> +     * this case)
> +     */
> +    int64_t data_end;
> +} BDRVPreallocateState;
> +
> +
> +static int preallocate_open(BlockDriverState *bs, QDict *options, int fl=
ags,
> +                            Error **errp)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +
> +    /*
> +     * Parameters are hardcoded now. May need to add corresponding optio=
ns in
> +     * future.
> +     */

The code for .bdrv_open() options is quick to write. If you add the
options right away then it will be much easier for users who need to
tweak them in the future.

> +    s->prealloc_align =3D 1 * MiB;
> +    s->prealloc_size =3D 128 * MiB;
> +
> +    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bd=
s,
> +                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> +                               false, errp);
> +    if (!bs->file) {
> +        return -EINVAL;
> +    }
> +
> +    s->data_end =3D bdrv_getlength(bs->file->bs);
> +    if (s->data_end < 0) {
> +        return s->data_end;
> +    }
> +
> +    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
> +        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
> +
> +    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
> +        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
> +            bs->file->bs->supported_zero_flags);
> +
> +    return 0;
> +}
> +
> +static void preallocate_close(BlockDriverState *bs)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +
> +    if (s->data_end >=3D 0 && bdrv_getlength(bs->file->bs) > s->data_end=
) {
> +        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0,=
 NULL);
> +    }
> +}
> +
> +static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                   BdrvChildRole role,
> +                                   BlockReopenQueue *reopen_queue,
> +                                   uint64_t perm, uint64_t shared,
> +                                   uint64_t *nperm, uint64_t *nshared)
> +{
> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, n=
shared);
> +
> +    /* Force RESIZE permission, to be able to crop file on close() */
> +    *nperm |=3D BLK_PERM_RESIZE;
> +}
> +
> +static coroutine_fn int preallocate_co_preadv_part(
> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
> +{
> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offse=
t,
> +                               flags);
> +}
> +
> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
> +                                               int64_t offset, int bytes=
)
> +{
> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
> +}
> +
> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t of=
fset,
> +                                       int64_t bytes, bool write_zero)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +    int64_t len, start, end;
> +    BdrvTrackedRequest *lock;
> +    int ret;
> +
> +    if (s->data_end >=3D 0) {
> +        s->data_end =3D MAX(s->data_end,
> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE=
));
> +    }
> +
> +    len =3D bdrv_getlength(bs->file->bs);
> +    if (len < 0) {
> +        return false;
> +    }
> +
> +    if (s->data_end < 0) {
> +        s->data_end =3D MAX(len,
> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE=
));
> +    }
> +
> +    if (offset + bytes <=3D len) {
> +        return false;
> +    }
> +
> +    lock =3D bdrv_co_range_try_lock(bs->file->bs, len, INT64_MAX - len);
> +    if (!lock) {
> +        /* There are already preallocating requests in-fligth */

s/fligth/flight/

> +        return false;
> +    }
> +
> +    /* Length should not have changed */
> +    assert(len =3D=3D bdrv_getlength(bs->file->bs));
> +
> +    start =3D write_zero ? MIN(offset, len) : len;
> +    end =3D QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc=
_align);
> +
> +    ret =3D bdrv_co_pwrite_zeroes_locked(bs->file, start, end - start,
> +                                       BDRV_REQ_NO_FALLBACK, lock);
> +
> +    bdrv_co_range_unlock(lock);

Hmm...if this piece of code is the only user of bdrv_co_range_try_lock()
then a BDRV_REQ_NO_WAIT flag might be a simpler API.

I thought the lock request would be used to perform multiple operations,
but if it's just for a single operation then I think it's less code and
easier to understand without the lock request.

> +
> +    return !ret;
> +}
> +
> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *b=
s,
> +        int64_t offset, int bytes, BdrvRequestFlags flags)
> +{
> +    if (do_preallocate(bs, offset, bytes, true)) {
> +        return 0;
> +    }
> +
> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
> +}
> +
> +static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *bs=
,
> +                                                    uint64_t offset,
> +                                                    uint64_t bytes,
> +                                                    QEMUIOVector *qiov,
> +                                                    size_t qiov_offset,
> +                                                    int flags)
> +{
> +    do_preallocate(bs, offset, bytes, false);
> +
> +    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offs=
et,
> +                                flags);
> +}
> +
> +static int coroutine_fn
> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
> +                        bool exact, PreallocMode prealloc,
> +                        BdrvRequestFlags flags, Error **errp)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +    int ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, flag=
s, errp);
> +
> +    /* s->data_end may become negative here, which means unknown data en=
d */
> +    s->data_end =3D bdrv_getlength(bs->file->bs);
> +
> +    return ret;
> +}
> +
> +static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
> +{
> +    if (!bs->file) {
> +        return 0;
> +    }

When does this happen? It's surprising to see the !bs->file check here
but not in other functions.

> +
> +    return bdrv_co_flush(bs->file->bs);
> +}
> +
> +static int64_t preallocate_getlength(BlockDriverState *bs)
> +{
> +    /*
> +     * We probably can return s->data_end here, but seems safer to retur=
n real
> +     * file length, not trying to hide the preallocation.
> +     *
> +     * Still, don't miss the chance to restore s->data_end if it is brok=
en.
> +     */
> +    BDRVPreallocateState *s =3D bs->opaque;
> +    int64_t ret =3D bdrv_getlength(bs->file->bs);
> +
> +    if (s->data_end < 0) {
> +        s->data_end =3D ret;
> +    }
> +
> +    return ret;
> +}
> +
> +BlockDriver bdrv_preallocate_filter =3D {
> +    .format_name =3D "preallocate",
> +    .instance_size =3D sizeof(BDRVPreallocateState),
> +
> +    .bdrv_getlength =3D preallocate_getlength,
> +    .bdrv_open =3D preallocate_open,
> +    .bdrv_close =3D preallocate_close,
> +
> +    .bdrv_co_preadv_part =3D preallocate_co_preadv_part,
> +    .bdrv_co_pwritev_part =3D preallocate_co_pwritev_part,
> +    .bdrv_co_pwrite_zeroes =3D preallocate_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard =3D preallocate_co_pdiscard,
> +    .bdrv_co_flush =3D preallocate_co_flush,
> +    .bdrv_co_truncate =3D preallocate_co_truncate,
> +
> +    .bdrv_co_block_status =3D bdrv_co_block_status_from_file,
> +
> +    .bdrv_child_perm =3D preallocate_child_perm,
> +
> +    .has_variable_length =3D true,
> +    .is_filter =3D true,
> +};
> +
> +static void bdrv_preallocate_init(void)
> +{
> +    bdrv_register(&bdrv_preallocate_filter);
> +}
> +
> +block_init(bdrv_preallocate_init);
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 3635b6b4c1..f46a353a35 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -45,6 +45,7 @@ block-obj-y +=3D crypto.o
>  block-obj-y +=3D aio_task.o
>  block-obj-y +=3D backup-top.o
>  block-obj-y +=3D filter-compress.o
> +block-obj-y +=3D preallocate.o
>  common-obj-y +=3D monitor/
> =20
>  block-obj-y +=3D stream.o
> --=20
> 2.18.0
>=20

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Ftv4ACgkQnKSrs4Gr
c8gahQgAv6yAZUKvp1C7m8wBSjnk7+NTqNTqGAFycYP+NgnSJlwxO1N/9QawUz1G
8fl5Oe3FDb4cYq3x/Q7/ykZbYGYwsgP0VWc9v0irpw3XXL22eAt1Twc+OMiT6vkX
hydfKkYzbj9nwlsh/PfPe73hALYDMDuDcL6Jy30c1N2ffksvgl1ba0CH7DI2v41N
9F0mN2erM5YzxMWKmQ0oCqUEfxLeyqncuuL2JrArGukV6vCDN1jeE0n2HzcjKktY
ikaVq0HG/NTzYzydXTJxA+2TlPht3Bc7r7PtcZsjr0ZT1a1qJNdvUlINIUka7kKL
yAgawts/Xt14RfQ3uFIDblB7Q0wzfA==
=8rUk
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--


