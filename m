Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06495208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="nAd5uCFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06495208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvr6-0002xJ-Bc
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAvqF-000253-QG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:51:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAvqC-0000BT-WF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:51:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so1881920wrs.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version:content-transfer-encoding;
 bh=DGYROD/wnsPA52oJqpkpPnHFqdELkB1fOTUE8EOGPxw=;
 b=nAd5uCFLxjyyY3dAnRGfSQNNZRXWnJJCfb9oCgUFXQ6ZXVBLgyhMNcthi37uqj9PcG
 XUsNS2c8LVbUjARM/RQy2Q6HOB3HvOJRszhiQ0uRSDaK5nRddJFRWGI0Z+jneG5Ua6zr
 M4rrhvsGcfjQs0xLMsn3oEk0ablKsG8crvmwNED1uuiUVNtowT0N3JvFQsRa6NcKJZgD
 T5WlRqKGaXW2K8yiJUmF2Qz4nnhpCZUIjuH1hXvIUSWT+j6DShfS/sCIirQwz4mi917v
 weHGebWhcD2cKFCgy/VgfV2loMAVFRJF1SFwP8/uzOfJfcTgcKzjkN2nWE8W7xlj3gZf
 vojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DGYROD/wnsPA52oJqpkpPnHFqdELkB1fOTUE8EOGPxw=;
 b=TZPt2ubqv/MUzTRaUz6MARUXWWYo/5dmRaDypF1XSVJEP7+3h8fMjg5U+Jsp04So9k
 hqisHsOJ+3Tee12E3dhVC6dzXfh+6pPyDhFg5bLvOdPxFRa/WXSsonc/UBdV+yJcL0R6
 K89DRSIU9nNtQ8JqNM8aY/zxWJV1Pb0ll6NF8xZMzeo3+J77tenFxooy6TRXjaykJmqo
 vuofrAQLWQK/pE82NFg2Ej5C7WBZa/zAywxISsagm8tKjwogwdrwKL4iufUrGnHdB7bK
 pamAWvav82Jfu7aH5Y3/kd238hP5SlP/JUbf4M3Z6LPjJZXn5/Qrl36fHeQ3j6Ec/B2F
 rEnQ==
X-Gm-Message-State: AOAM530RVxR27Lb7vBXrmovqZojlaYr9a3Nf1Mw03fRaRYImcHbxfJ4Y
 hDubOtzCkvkn8wciOLof+XpXswfo+j/tyz0SEj4=
X-Google-Smtp-Source: ABdhPJyJeeSlUQn7pOZzY4QD1/IcIwui7tT4tRWMQAlSJr7+IUHA9orTETQRTPIrUG3J7ZDy//jH2w==
X-Received: by 2002:a05:6000:d0:: with SMTP id
 q16mr2704076wrx.24.1598449910875; 
 Wed, 26 Aug 2020 06:51:50 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id q3sm5441292wmq.12.2020.08.26.06.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 06:51:49 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id b3bab257;
 Wed, 26 Aug 2020 13:51:49 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
In-Reply-To: <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 14:51:49 +0100
Message-ID: <m2o8mxjz0q.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::442;
 envelope-from=dme@dme.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

On Tuesday, 2020-08-25 at 17:11:34 +02, Max Reitz wrote:

> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>> It's intended to be inserted between format and protocol nodes to
>> preallocate additional space (expanding protocol file) on writes
>> crossing EOF. It improves performance for file-systems with slow
>> allocation.
>>=20
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  docs/system/qemu-block-drivers.rst.inc |  26 +++
>>  qapi/block-core.json                   |  20 +-
>>  block/preallocate.c                    | 291 +++++++++++++++++++++++++
>>  block/Makefile.objs                    |   1 +
>>  4 files changed, 337 insertions(+), 1 deletion(-)
>>  create mode 100644 block/preallocate.c
>
> Looks good to me in essence.  Besides minor details, I wonder most about
> whether truncating the file on close can be safe, but more about that bel=
ow.
>
>> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-b=
lock-drivers.rst.inc
>> index b052a6d14e..5e8a35c571 100644
>> --- a/docs/system/qemu-block-drivers.rst.inc
>> +++ b/docs/system/qemu-block-drivers.rst.inc
>> @@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU=
 process on the image file.
>>  More than one byte could be locked by the QEMU instance, each byte of w=
hich
>>  reflects a particular permission that is acquired or protected by the r=
unning
>>  block driver.
>> +
>> +Filter drivers
>> +~~~~~~~~~~~~~~
>> +
>> +QEMU supports several filter drivers, which don't store any data, but d=
o some
>
> s/do/perform/
>
>> +additional tasks, hooking io requests.
>> +
>> +.. program:: filter-drivers
>> +.. option:: preallocate
>> +
>> +  Preallocate filter driver is intended to be inserted between format
>
> *The preallocate filter driver
>
>> +  and protocol nodes and does preallocation of some additional space
>
> I=E2=80=99d simplify this as s/does preallocation of/preallocates/
>
>> +  (expanding the protocol file) on write. It may be used for
>
> I=E2=80=99d complicate this as s/on write/when writing past the file=E2=
=80=99s end/, or
> =E2=80=9Cwhen data is written to the file after its end=E2=80=9D, or at l=
east =E2=80=9Con
> post-EOF writes=E2=80=9D.
>
> Maybe also s/It may be used for/This can be useful for/?
>
>> +  file-systems with slow allocation.
>> +
>> +  Supported options:
>> +
>> +  .. program:: preallocate
>> +  .. option:: prealloc-align
>> +
>> +    On preallocation, align file length to this number, default 1M.
>
> *the file length
>
> As for =E2=80=9Cnumber=E2=80=9D...  Well, it is a number.  But =E2=80=9Cv=
alue=E2=80=9D might fit better.
>  Or =E2=80=9Clength (in bytes)=E2=80=9D?

Isn't it really:

"On preallocation, ensure that the file length is aligned to a multiple
of this value, default 1M."

?

>> +
>> +  .. program:: preallocate
>> +  .. option:: prealloc-size
>> +
>> +    How much to preallocate, default 128M.
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 197bdc1c36..b40448063b 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2805,7 +2805,7 @@
>>              'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', =
'ftps',
>>              'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'i=
scsi',
>>              'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'paral=
lels',
>> -            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>> +            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rb=
d',
>>              { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)=
' },
>>              'sheepdog',
>>              'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
>> @@ -3074,6 +3074,23 @@
>>    'data': { 'aes': 'QCryptoBlockOptionsQCow',
>>              'luks': 'QCryptoBlockOptionsLUKS'} }
>>=20=20
>> +##
>> +# @BlockdevOptionsPreallocate:
>> +#
>> +# Filter driver intended to be inserted between format and protocol node
>> +# and do preallocation in protocol node on write.
>> +#
>> +# @prealloc-align: on preallocation, align file length to this number,
>> +#                 default 1048576 (1M)
>
> Speaking of alignment, this second line isn=E2=80=99t properly aligned.
>
>> +#
>> +# @prealloc-size: how much to preallocate, default 134217728 (128M)
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'struct': 'BlockdevOptionsPreallocate',
>> +  'base': 'BlockdevOptionsGenericFormat',
>> +  'data': { '*prealloc-align': 'int', '*prealloc-size': 'int' } }
>> +
>>  ##
>>  # @BlockdevOptionsQcow2:
>>  #
>> @@ -3979,6 +3996,7 @@
>>        'null-co':    'BlockdevOptionsNull',
>>        'nvme':       'BlockdevOptionsNVMe',
>>        'parallels':  'BlockdevOptionsGenericFormat',
>> +      'preallocate':'BlockdevOptionsPreallocate',
>>        'qcow2':      'BlockdevOptionsQcow2',
>>        'qcow':       'BlockdevOptionsQcow',
>>        'qed':        'BlockdevOptionsGenericCOWFormat',
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> new file mode 100644
>> index 0000000000..bdf54dbd2f
>> --- /dev/null
>> +++ b/block/preallocate.c
>> @@ -0,0 +1,291 @@
>> +/*
>> + * preallocate filter driver
>> + *
>> + * The driver performs preallocate operation: it is injected above
>> + * some node, and before each write over EOF it does additional preallo=
cating
>> + * write-zeroes request.
>> + *
>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>> + *
>> + * Author:
>> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "qemu/option.h"
>> +#include "qemu/units.h"
>> +#include "block/block_int.h"
>> +
>> +
>> +typedef struct BDRVPreallocateState {
>> +    int64_t prealloc_size;
>> +    int64_t prealloc_align;
>> +
>> +    /*
>> +     * Filter is started as not-active, so it doesn't do any preallocat=
ions nor
>> +     * requires BLK_PERM_RESIZE on its child. This is needed to create =
filter
>> +     * above another node-child and then do bdrv_replace_node to insert=
 the
>> +     * filter.
>
> A bit weird, but seems fair.  It=E2=80=99s basically just a cache for whe=
ther
> this node has a writer on it or not.
>
> Apart from the weirdness, I don=E2=80=99t understand the =E2=80=9Canother=
 node-child=E2=80=9D.
> Say you have =E2=80=9Cformat=E2=80=9D -> =E2=80=9Cproto=E2=80=9D, and the=
n you want to insert
> =E2=80=9Cprealloc=E2=80=9D.  Wouldn=E2=80=99t you blockdev-add prealloc,f=
ile=3Dproto and then
> blockdev-replace format.file=3Dprealloc?  So what is that =E2=80=9Cother =
node-child=E2=80=9D?
>
>> +     *
>> +     * Filter becomes active the first time it detects that its parents=
 have
>> +     * BLK_PERM_RESIZE on it.
>> +     * Filter becomes active forever: it doesn't lose active status if =
parents
>> +     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink the =
file on
>> +     * filter close.
>
> Oh, the file is shrunk?  That wasn=E2=80=99t clear from the documentation.
>
> Hm.  Seems like useful behavior.  I just wonder if keeping the
> permission around indefinitely makes sense.  Why not just truncate it
> when the permission is revoked?
>
>> +     */
>> +    bool active;
>> +
>> +    /*
>> +     * Track real data end, to crop preallocation on close  data_end ma=
y be
>
> s/on close /when closed./
>
>> +     * negative, which means that actual status is unknown (nothing cro=
pped in
>> +     * this case)
>> +     */
>> +    int64_t data_end;
>> +} BDRVPreallocateState;
>> +
>> +#define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
>> +#define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
>> +static QemuOptsList runtime_opts =3D {
>> +    .name =3D "preallocate",
>> +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>> +    .desc =3D {
>> +        {
>> +            .name =3D PREALLOCATE_OPT_PREALLOC_ALIGN,
>> +            .type =3D QEMU_OPT_SIZE,
>> +            .help =3D "on preallocation, align file length to this numb=
er, "
>> +                "default 1M",
>> +        },
>> +        {
>> +            .name =3D PREALLOCATE_OPT_PREALLOC_SIZE,
>> +            .type =3D QEMU_OPT_SIZE,
>> +            .help =3D "how much to preallocate, default 128M",
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static int preallocate_open(BlockDriverState *bs, QDict *options, int f=
lags,
>> +                            Error **errp)
>> +{
>> +    QemuOpts *opts;
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +
>> +    /*
>> +     * Parameters are hardcoded now. May need to add corresponding opti=
ons in
>> +     * future.
>> +     */
>> +    opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
>> +    s->prealloc_align =3D
>> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_ALIGN, 1 * MiB=
);
>> +    s->prealloc_size =3D
>> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * Mi=
B);
>> +    qemu_opts_del(opts);
>
> Should we have some validation on these parameters?  Like,
> prealloc_align being at least 512, or maybe even file.request_alignment?
>
> (I suppose anything for prealloc_size is fine, though 0 doesn=E2=80=99t m=
ake
> much sense...)
>
>> +
>> +    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_b=
ds,
>> +                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>> +                               false, errp);
>> +    if (!bs->file) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    s->data_end =3D bdrv_getlength(bs->file->bs);
>> +    if (s->data_end < 0) {
>> +        return s->data_end;
>> +    }
>> +
>> +    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
>> +        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
>> +
>> +    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
>> +        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>> +            bs->file->bs->supported_zero_flags);
>> +
>> +    return 0;
>> +}
>> +
>> +static void preallocate_close(BlockDriverState *bs)
>> +{
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +
>> +    if (s->active && s->data_end >=3D 0 &&
>> +        bdrv_getlength(bs->file->bs) > s->data_end)
>> +    {
>> +        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0=
, NULL);
>
> Now that I think more about it...  What if there are other writers on
> bs->file?  This may throw data away.  Maybe BDS.wr_highest_offset can
> help to make a better call?
>
>> +    }
>> +}
>> +
>> +static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
>> +                                   BdrvChildRole role,
>> +                                   BlockReopenQueue *reopen_queue,
>> +                                   uint64_t perm, uint64_t shared,
>> +                                   uint64_t *nperm, uint64_t *nshared)
>> +{
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +
>> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, =
nshared);
>> +
>> +    s->active =3D s->active || (perm & BLK_PERM_RESIZE);
>> +
>> +    if (s->active) {
>> +        /* Force RESIZE permission, to be able to crop file on close() =
*/
>> +        *nperm |=3D BLK_PERM_RESIZE;
>> +    }
>> +}
>> +
>> +static coroutine_fn int preallocate_co_preadv_part(
>> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
>> +{
>> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offs=
et,
>> +                               flags);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
>> +                                               int64_t offset, int byte=
s)
>> +{
>> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
>> +}
>> +
>> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t o=
ffset,
>> +                                       int64_t bytes, bool write_zero)
>> +{
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +    int64_t len, start, end;
>> +
>> +    if (!s->active) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end >=3D 0) {
>> +        s->data_end =3D MAX(s->data_end,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZ=
E));
>> +    }
>> +
>> +    len =3D bdrv_getlength(bs->file->bs);
>
> I=E2=80=99d rename @len so it=E2=80=99s clear that it has nothing to do w=
ith the request
> length.  Like, file_len.
>
> (Because...
>
>> +    if (len < 0) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end =3D MAX(len,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZ=
E));
>> +    }
>> +
>> +    if (offset + bytes <=3D len) {
>> +        return false;
>> +    }
>> +
>> +    start =3D write_zero ? MIN(offset, len) : len;
>
> ...I got confused here for a bit)
>
>> +    end =3D QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->preallo=
c_align);
>
> Ah, I expected offset + s->prealloc_size.  But OK.
>
>> +    return !bdrv_co_pwrite_zeroes(bs->file, start, end - start,
>> +            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_W=
AIT);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *=
bs,
>> +        int64_t offset, int bytes, BdrvRequestFlags flags)
>> +{
>> +    if (do_preallocate(bs, offset, bytes, true)) {
>> +        return 0;
>> +    }
>> +
>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>> +}
>> +
>> +static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *b=
s,
>> +                                                    uint64_t offset,
>> +                                                    uint64_t bytes,
>> +                                                    QEMUIOVector *qiov,
>> +                                                    size_t qiov_offset,
>> +                                                    int flags)
>> +{
>> +    do_preallocate(bs, offset, bytes, false);
>> +
>> +    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_off=
set,
>> +                                flags);
>> +}
>> +
>> +static int coroutine_fn
>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>> +                        bool exact, PreallocMode prealloc,
>> +                        BdrvRequestFlags flags, Error **errp)
>> +{
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +    int ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, fla=
gs, errp);
>> +
>> +    /* s->data_end may become negative here, which means unknown data e=
nd */
>> +    s->data_end =3D bdrv_getlength(bs->file->bs);
>
> What would be the problem with just setting data_end =3D offset?  We only
> use data_end to truncate down on close, so basically repeat the
> bdrv_co_truncate() call here, which seems correct.
>
>> +
>> +    return ret;
>> +}
>> +
>> +static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
>> +{
>> +    return bdrv_co_flush(bs->file->bs);
>> +}
>> +
>> +static int64_t preallocate_getlength(BlockDriverState *bs)
>> +{
>> +    /*
>> +     * We probably can return s->data_end here, but seems safer to retu=
rn real
>> +     * file length, not trying to hide the preallocation.
>
> I don=E2=80=99t know.  The auto-truncation on close makes that a bit weir=
d, in
> my opinion.  But since this filter is probably never directly below a
> BlockBackend (i.e., the length is never exposed to anything outside of
> the block layer), but always below a format driver, it should be fine.
> (In fact, those drivers do probably rather care about the true file
> length rather than whatever they may have truncated it to, so you=E2=80=
=99re
> right, it should be safer.)
>
> Max
>
>> +     *
>> +     * Still, don't miss the chance to restore s->data_end if it is bro=
ken.
>> +     */
>> +    BDRVPreallocateState *s =3D bs->opaque;
>> +    int64_t ret =3D bdrv_getlength(bs->file->bs);
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end =3D ret;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +BlockDriver bdrv_preallocate_filter =3D {
>> +    .format_name =3D "preallocate",
>> +    .instance_size =3D sizeof(BDRVPreallocateState),
>> +
>> +    .bdrv_getlength =3D preallocate_getlength,
>> +    .bdrv_open =3D preallocate_open,
>> +    .bdrv_close =3D preallocate_close,
>> +
>> +    .bdrv_co_preadv_part =3D preallocate_co_preadv_part,
>> +    .bdrv_co_pwritev_part =3D preallocate_co_pwritev_part,
>> +    .bdrv_co_pwrite_zeroes =3D preallocate_co_pwrite_zeroes,
>> +    .bdrv_co_pdiscard =3D preallocate_co_pdiscard,
>> +    .bdrv_co_flush =3D preallocate_co_flush,
>> +    .bdrv_co_truncate =3D preallocate_co_truncate,
>> +
>> +    .bdrv_co_block_status =3D bdrv_co_block_status_from_file,
>> +
>> +    .bdrv_child_perm =3D preallocate_child_perm,
>> +
>> +    .has_variable_length =3D true,
>> +    .is_filter =3D true,
>> +};
>> +
>> +static void bdrv_preallocate_init(void)
>> +{
>> +    bdrv_register(&bdrv_preallocate_filter);
>> +}
>> +
>> +block_init(bdrv_preallocate_init);
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index 19c6f371c9..f8e6f16522 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -44,6 +44,7 @@ block-obj-y +=3D crypto.o
>>  block-obj-y +=3D aio_task.o
>>  block-obj-y +=3D backup-top.o
>>  block-obj-y +=3D filter-compress.o
>> +block-obj-y +=3D preallocate.o
>>  common-obj-y +=3D monitor/
>>  block-obj-y +=3D monitor/
>>=20=20
>>=20

dme.
--=20
I think I waited too long, I'm moving into the dollhouse.

