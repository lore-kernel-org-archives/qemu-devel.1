Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7DF2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRX59wAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7DF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAadh-0002Lf-2E
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAach-0001Xr-OP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAace-0004e0-Ub
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598368347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Wni0i/sFeDletPt18IH1jquY15u1gtBT8skERbcGNQ=;
 b=gRX59wAfQjmKCmy2LfFYPBkaW3mFW/9UPjZ3qM/h3DnMiwpNpFyGlTcPsfLrv+nmYXeLgU
 F4EpMCaTByJqBObIxHuGo0fBix1YAHGntspqmN3Rs2jFTpBQD7vO0+bvX8go357BQVa9RI
 5jR/YkBWYwqOEam1NXo7sLpCyZfCLtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-KpKP1XnSMWK9b1DCIBPusQ-1; Tue, 25 Aug 2020 11:12:22 -0400
X-MC-Unique: KpKP1XnSMWK9b1DCIBPusQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A66F1098B04;
 Tue, 25 Aug 2020 15:11:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-72.ams2.redhat.com
 [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79EE11055829;
 Tue, 25 Aug 2020 15:11:37 +0000 (UTC)
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
Date: Tue, 25 Aug 2020 17:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821141123.28538-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jKg8omJ8ALPdy0iarbPGvgqbN6EsYn0R8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jKg8omJ8ALPdy0iarbPGvgqbN6EsYn0R8
Content-Type: multipart/mixed; boundary="oyZW4O97L6kv0YpqPoJgevCxEVPAG7V0P"

--oyZW4O97L6kv0YpqPoJgevCxEVPAG7V0P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
> It's intended to be inserted between format and protocol nodes to
> preallocate additional space (expanding protocol file) on writes
> crossing EOF. It improves performance for file-systems with slow
> allocation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc |  26 +++
>  qapi/block-core.json                   |  20 +-
>  block/preallocate.c                    | 291 +++++++++++++++++++++++++
>  block/Makefile.objs                    |   1 +
>  4 files changed, 337 insertions(+), 1 deletion(-)
>  create mode 100644 block/preallocate.c

Looks good to me in essence.  Besides minor details, I wonder most about
whether truncating the file on close can be safe, but more about that below=
.

> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bl=
ock-drivers.rst.inc
> index b052a6d14e..5e8a35c571 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU =
process on the image file.
>  More than one byte could be locked by the QEMU instance, each byte of wh=
ich
>  reflects a particular permission that is acquired or protected by the ru=
nning
>  block driver.
> +
> +Filter drivers
> +~~~~~~~~~~~~~~
> +
> +QEMU supports several filter drivers, which don't store any data, but do=
 some

s/do/perform/

> +additional tasks, hooking io requests.
> +
> +.. program:: filter-drivers
> +.. option:: preallocate
> +
> +  Preallocate filter driver is intended to be inserted between format

*The preallocate filter driver

> +  and protocol nodes and does preallocation of some additional space

I=E2=80=99d simplify this as s/does preallocation of/preallocates/

> +  (expanding the protocol file) on write. It may be used for

I=E2=80=99d complicate this as s/on write/when writing past the file=E2=80=
=99s end/, or
=E2=80=9Cwhen data is written to the file after its end=E2=80=9D, or at lea=
st =E2=80=9Con
post-EOF writes=E2=80=9D.

Maybe also s/It may be used for/This can be useful for/?

> +  file-systems with slow allocation.
> +
> +  Supported options:
> +
> +  .. program:: preallocate
> +  .. option:: prealloc-align
> +
> +    On preallocation, align file length to this number, default 1M.

*the file length

As for =E2=80=9Cnumber=E2=80=9D...  Well, it is a number.  But =E2=80=9Cval=
ue=E2=80=9D might fit better.
 Or =E2=80=9Clength (in bytes)=E2=80=9D?

> +
> +  .. program:: preallocate
> +  .. option:: prealloc-size
> +
> +    How much to preallocate, default 128M.
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 197bdc1c36..b40448063b 100644
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
>              'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
> @@ -3074,6 +3074,23 @@
>    'data': { 'aes': 'QCryptoBlockOptionsQCow',
>              'luks': 'QCryptoBlockOptionsLUKS'} }
> =20
> +##
> +# @BlockdevOptionsPreallocate:
> +#
> +# Filter driver intended to be inserted between format and protocol node
> +# and do preallocation in protocol node on write.
> +#
> +# @prealloc-align: on preallocation, align file length to this number,
> +#                 default 1048576 (1M)

Speaking of alignment, this second line isn=E2=80=99t properly aligned.

> +#
> +# @prealloc-size: how much to preallocate, default 134217728 (128M)
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'BlockdevOptionsPreallocate',
> +  'base': 'BlockdevOptionsGenericFormat',
> +  'data': { '*prealloc-align': 'int', '*prealloc-size': 'int' } }
> +
>  ##
>  # @BlockdevOptionsQcow2:
>  #
> @@ -3979,6 +3996,7 @@
>        'null-co':    'BlockdevOptionsNull',
>        'nvme':       'BlockdevOptionsNVMe',
>        'parallels':  'BlockdevOptionsGenericFormat',
> +      'preallocate':'BlockdevOptionsPreallocate',
>        'qcow2':      'BlockdevOptionsQcow2',
>        'qcow':       'BlockdevOptionsQcow',
>        'qed':        'BlockdevOptionsGenericCOWFormat',
> diff --git a/block/preallocate.c b/block/preallocate.c
> new file mode 100644
> index 0000000000..bdf54dbd2f
> --- /dev/null
> +++ b/block/preallocate.c
> @@ -0,0 +1,291 @@
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
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu/units.h"
> +#include "block/block_int.h"
> +
> +
> +typedef struct BDRVPreallocateState {
> +    int64_t prealloc_size;
> +    int64_t prealloc_align;
> +
> +    /*
> +     * Filter is started as not-active, so it doesn't do any preallocati=
ons nor
> +     * requires BLK_PERM_RESIZE on its child. This is needed to create f=
ilter
> +     * above another node-child and then do bdrv_replace_node to insert =
the
> +     * filter.

A bit weird, but seems fair.  It=E2=80=99s basically just a cache for wheth=
er
this node has a writer on it or not.

Apart from the weirdness, I don=E2=80=99t understand the =E2=80=9Canother n=
ode-child=E2=80=9D.
Say you have =E2=80=9Cformat=E2=80=9D -> =E2=80=9Cproto=E2=80=9D, and then =
you want to insert
=E2=80=9Cprealloc=E2=80=9D.  Wouldn=E2=80=99t you blockdev-add prealloc,fil=
e=3Dproto and then
blockdev-replace format.file=3Dprealloc?  So what is that =E2=80=9Cother no=
de-child=E2=80=9D?

> +     *
> +     * Filter becomes active the first time it detects that its parents =
have
> +     * BLK_PERM_RESIZE on it.
> +     * Filter becomes active forever: it doesn't lose active status if p=
arents
> +     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink the f=
ile on
> +     * filter close.

Oh, the file is shrunk?  That wasn=E2=80=99t clear from the documentation.

Hm.  Seems like useful behavior.  I just wonder if keeping the
permission around indefinitely makes sense.  Why not just truncate it
when the permission is revoked?

> +     */
> +    bool active;
> +
> +    /*
> +     * Track real data end, to crop preallocation on close  data_end may=
 be

s/on close /when closed./

> +     * negative, which means that actual status is unknown (nothing crop=
ped in
> +     * this case)
> +     */
> +    int64_t data_end;
> +} BDRVPreallocateState;
> +
> +#define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
> +#define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
> +static QemuOptsList runtime_opts =3D {
> +    .name =3D "preallocate",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> +    .desc =3D {
> +        {
> +            .name =3D PREALLOCATE_OPT_PREALLOC_ALIGN,
> +            .type =3D QEMU_OPT_SIZE,
> +            .help =3D "on preallocation, align file length to this numbe=
r, "
> +                "default 1M",
> +        },
> +        {
> +            .name =3D PREALLOCATE_OPT_PREALLOC_SIZE,
> +            .type =3D QEMU_OPT_SIZE,
> +            .help =3D "how much to preallocate, default 128M",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static int preallocate_open(BlockDriverState *bs, QDict *options, int fl=
ags,
> +                            Error **errp)
> +{
> +    QemuOpts *opts;
> +    BDRVPreallocateState *s =3D bs->opaque;
> +
> +    /*
> +     * Parameters are hardcoded now. May need to add corresponding optio=
ns in
> +     * future.
> +     */
> +    opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
> +    s->prealloc_align =3D
> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_ALIGN, 1 * MiB)=
;
> +    s->prealloc_size =3D
> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB=
);
> +    qemu_opts_del(opts);

Should we have some validation on these parameters?  Like,
prealloc_align being at least 512, or maybe even file.request_alignment?

(I suppose anything for prealloc_size is fine, though 0 doesn=E2=80=99t mak=
e
much sense...)

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
> +    if (s->active && s->data_end >=3D 0 &&
> +        bdrv_getlength(bs->file->bs) > s->data_end)
> +    {
> +        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0,=
 NULL);

Now that I think more about it...  What if there are other writers on
bs->file?  This may throw data away.  Maybe BDS.wr_highest_offset can
help to make a better call?

> +    }
> +}
> +
> +static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                   BdrvChildRole role,
> +                                   BlockReopenQueue *reopen_queue,
> +                                   uint64_t perm, uint64_t shared,
> +                                   uint64_t *nperm, uint64_t *nshared)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +
> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, n=
shared);
> +
> +    s->active =3D s->active || (perm & BLK_PERM_RESIZE);
> +
> +    if (s->active) {
> +        /* Force RESIZE permission, to be able to crop file on close() *=
/
> +        *nperm |=3D BLK_PERM_RESIZE;
> +    }
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
> +
> +    if (!s->active) {
> +        return false;
> +    }
> +
> +    if (s->data_end >=3D 0) {
> +        s->data_end =3D MAX(s->data_end,
> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE=
));
> +    }
> +
> +    len =3D bdrv_getlength(bs->file->bs);

I=E2=80=99d rename @len so it=E2=80=99s clear that it has nothing to do wit=
h the request
length.  Like, file_len.

(Because...

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
> +    start =3D write_zero ? MIN(offset, len) : len;

...I got confused here for a bit)

> +    end =3D QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc=
_align);

Ah, I expected offset + s->prealloc_size.  But OK.

> +    return !bdrv_co_pwrite_zeroes(bs->file, start, end - start,
> +            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WA=
IT);
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

What would be the problem with just setting data_end =3D offset?  We only
use data_end to truncate down on close, so basically repeat the
bdrv_co_truncate() call here, which seems correct.

> +
> +    return ret;
> +}
> +
> +static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
> +{
> +    return bdrv_co_flush(bs->file->bs);
> +}
> +
> +static int64_t preallocate_getlength(BlockDriverState *bs)
> +{
> +    /*
> +     * We probably can return s->data_end here, but seems safer to retur=
n real
> +     * file length, not trying to hide the preallocation.

I don=E2=80=99t know.  The auto-truncation on close makes that a bit weird,=
 in
my opinion.  But since this filter is probably never directly below a
BlockBackend (i.e., the length is never exposed to anything outside of
the block layer), but always below a format driver, it should be fine.
(In fact, those drivers do probably rather care about the true file
length rather than whatever they may have truncated it to, so you=E2=80=99r=
e
right, it should be safer.)

Max

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
> index 19c6f371c9..f8e6f16522 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -44,6 +44,7 @@ block-obj-y +=3D crypto.o
>  block-obj-y +=3D aio_task.o
>  block-obj-y +=3D backup-top.o
>  block-obj-y +=3D filter-compress.o
> +block-obj-y +=3D preallocate.o
>  common-obj-y +=3D monitor/
>  block-obj-y +=3D monitor/
> =20
>=20



--oyZW4O97L6kv0YpqPoJgevCxEVPAG7V0P--

--jKg8omJ8ALPdy0iarbPGvgqbN6EsYn0R8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9FKiYACgkQ9AfbAGHV
z0BzaAf+KvaVhnteF3bXNQGT0J/2wvj44ih+STkPW/5kQg5oev6wuJSVKw85A84+
Z/Nl1gQTibEDc74zrtwB0x7mmOXGkD3tUyIdWoFkpBlvRfR0TBVpBrKkRLdrXsUD
eZAnnfqLW57pyzaxevB/mAU/oEhYdBXOuHpv7cK2auOA6GwEDeWZ8JKp/D9bH/Jw
goNXPfuyAFs5K+aWfQeT/Q1D84dqw/859oYcUysr/SDk7kSogGjHtouExbvxL2iv
nQmMt3xjDPQgSR0jdBYJsPslpSMQH9LXi+xqm4wiMgNW4t2ffjhPWyDK50FO9ryE
aKpx3DhUKGocwcn8ErvMrBnf3mBzRw==
=jvFJ
-----END PGP SIGNATURE-----

--jKg8omJ8ALPdy0iarbPGvgqbN6EsYn0R8--


