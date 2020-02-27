Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835CC3F35F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821A246AE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOOJyQkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821A246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JXY-0000uD-Gt
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7JWf-00009I-IU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7JWd-0007cQ-IK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:48:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46616
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7JWd-0007bx-Ek
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582811307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwb8X6EeCvrkFppM4g4CNur5V+u+BcTq1JmoWGW5aLo=;
 b=WOOJyQknLmRU1i/6XygtYlNuOHVI0AniE3nSWTbYyD9eUTRLL0yKSAWbld6nHygazPQfga
 Wb0Gc5rBDfbn2RquVdlj+CqXge1E46djLIJoAMWS8yBVCjT67RJWuI2wns9JFh4SW4JadH
 oSRVhynOF+fJ/IfJG4jV0cPfkIH+rYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-WxNfUEBGPnO4AOegyOW7VA-1; Thu, 27 Feb 2020 08:48:19 -0500
X-MC-Unique: WxNfUEBGPnO4AOegyOW7VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB96E107ACC4;
 Thu, 27 Feb 2020 13:48:17 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 425345DA7C;
 Thu, 27 Feb 2020 13:48:17 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
Date: Thu, 27 Feb 2020 07:48:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227072953.25445-2-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:29 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to Qcow2 that indicates which allow to use different compression

to qcow2, allowing the use of different

> methods for image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/qcow2.c             | 105 ++++++++++++++++++++++++++++++++++++++
>   block/qcow2.h             |  31 ++++++++---
>   include/block/block_int.h |   1 +
>   qapi/block-core.json      |  22 +++++++-
>   4 files changed, 150 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3c754f616b..2ccb2cabd1 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1242,6 +1242,50 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
>       return ret;
>   }
>   
> +static int validate_compression_type(BDRVQcow2State *s, Error **errp)
> +{
> +    /*
> +     * Sanity check
> +     * according to qcow2 spec, the compression type is 1-byte field
> +     * but in BDRVQcow2State the compression_type is enum sizeof(int)
> +     * so, the max compression_type value is 255.
> +     */
> +    if (s->compression_type > 0xff) {
> +        error_setg(errp, "qcow2: compression type value is too big");
> +        return -EINVAL;
> +    }

Hmm - I think it may be worth a tweak to qcow2.txt to call out:

104: compression_type
105 - 111: padding, must be 0

or else call out:

104-111: compression type

and just blindly use all 8 bytes for the value even though really only 1 
or two values will ever be defined.  Of course, that moves the byte in 
question from 104 to 111, thanks to our big endian encoding, but as this 
series is the first one installing a non-zero value in those 8 bytes, 
and as we just finished documenting that the header length must be a 
multiple of 8, there is no real impact - we can make such tweaks up 
until the 5.0 release.

> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        error_setg(errp, "qcow2: unknown compression type: %u",
> +                   s->compression_type);
> +        return -ENOTSUP;
> +    }

Having two checks feels redundant, compared to just letting the default 
catch all unrecognized values in that field.

> +
> +    /*
> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZLIB
> +     * the incompatible feature flag must be set
> +     */
> +    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
> +        if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must not be set");
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must be set");
> +            return -EINVAL;
> +        }
> +    }

Matches what we documented in the spec.

> +
> +    return 0;
> +}
> +
>   /* Called with s->lock held.  */
>   static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>                                         int flags, Error **errp)
> @@ -1357,6 +1401,26 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>       s->compatible_features      = header.compatible_features;
>       s->autoclear_features       = header.autoclear_features;
>   
> +    /*
> +     * Handle compression type
> +     * Older qcow2 images don't contain the compression type header.
> +     * Distinguish them by the header length and use
> +     * the only valid (default) compression type in that case
> +     */
> +    if (header.header_length > offsetof(QCowHeader, compression_type)) {
> +        /*
> +         * don't deal with endians since compression_type is 1 byte long
> +         */
> +        s->compression_type = header.compression_type;

Changes if you go with my suggestion of just making the compression_type 
field occupy 8 bytes in the qcow2 header.  (And if you want to keep it 1 
byte, I still think the spec should call out explicit padding bytes).

> +    } else {
> +        s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
> +    }
> +
> +    ret = validate_compression_type(s, errp);
> +    if (ret) {
> +        goto fail;
> +    }
> +
>       if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>           void *feature_table = NULL;
>           qcow2_read_extensions(bs, header.header_length, ext_end,
> @@ -2720,6 +2784,12 @@ int qcow2_update_header(BlockDriverState *bs)
>       total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
>       refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
>   
> +    ret = validate_compression_type(s, NULL);
> +
> +    if (ret) {
> +        goto fail;
> +    }
> +
>       *header = (QCowHeader) {
>           /* Version 2 fields */
>           .magic                  = cpu_to_be32(QCOW_MAGIC),
> @@ -2742,6 +2812,7 @@ int qcow2_update_header(BlockDriverState *bs)
>           .autoclear_features     = cpu_to_be64(s->autoclear_features),
>           .refcount_order         = cpu_to_be32(s->refcount_order),
>           .header_length          = cpu_to_be32(header_length),
> +        .compression_type       = (uint8_t) s->compression_type,

Is the cast necessary?

>       };
>   
>       /* For older versions, write a shorter header */
> @@ -2839,6 +2910,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                   .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                   .name = "lazy refcounts",
>               },
> +            {
> +                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,

Ordering: please group all the incompatible bits side-by-side (this 
should come before the lazy refcount bit).

> +                .bit  = QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
> +                .name = "compression type",

This change breaks iotests; at least 31, 36, and 61 need updates (I've 
got a similar patch pending which fixes the fact that we forgot the 
autoclear bit [1]).  You'll need to squash in fixes for those at the 
same time.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08069.html

> +            },
>           };
>   
>           ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -3401,6 +3477,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           .refcount_table_offset      = cpu_to_be64(cluster_size),
>           .refcount_table_clusters    = cpu_to_be32(1),
>           .refcount_order             = cpu_to_be32(refcount_order),
> +        .compression_type           = (uint8_t) QCOW2_COMPRESSION_TYPE_ZLIB,

Is the cast necessary?

>           .header_length              = cpu_to_be32(sizeof(*header)),
>       };
>   
> @@ -3420,6 +3497,26 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>               cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
>       }
>   
> +    if (qcow2_opts->has_compression_type &&
> +        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
> +
> +        if (qcow2_opts->compression_type > 0xff) {
> +            error_setg_errno(errp, -EINVAL, "Too big compression type value");
> +            goto out;
> +        }
> +
> +        switch (qcow2_opts->compression_type) {
> +        default:
> +            error_setg_errno(errp, -EINVAL, "Unknown compression type");
> +            goto out;
> +        }

This should probably be an assert that qcow2_opts->compression_type is 
in range, rather than a switch statement and error_setg.  Callers of 
qcow2_co_create should not be handing us unknown values.

> +
> +        header->compression_type = (uint8_t) qcow2_opts->compression_type;

Why the cast?

> +
> +        header->incompatible_features |=
> +            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION_TYPE);
> +    }
> +
>       ret = blk_pwrite(blk, 0, header, cluster_size, 0);
>       g_free(header);
>       if (ret < 0) {
> @@ -3602,6 +3699,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt

> +++ b/block/qcow2.h
> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>   
>       uint32_t refcount_order;
>       uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t  compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t  padding[7];
>   } QEMU_PACKED QCowHeader;

You're changing the size of this struct, which WILL break iotests (and 
even more than just the 3 I pointed out above for the feature name table).

/me looks ahead

Aha - you even noticed it: patch 7/8 fixes test 80.  That fix needs to 
be squashed in here, where the change is made.

>   
>   typedef struct QEMU_PACKED QCowSnapshotHeader {
> @@ -213,16 +219,20 @@ enum {
>   
>   /* Incompatible feature bits */
>   enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
> -    QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
> -    QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> -    QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            = 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          = 1,
> +    QCOW2_INCOMPAT_DATA_FILE_BITNR        = 2,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR = 3,
> +    QCOW2_INCOMPAT_DIRTY                  = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_DATA_FILE              = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =
> +        1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,

Uggh. I hate realigning = just because we added a longer name, 
especially when you then can't even keep things on one line because of 
length.  If it were me, I'd leave the existing lines alone, and/or 
switch everything to just use 'BITNR = ' rather than trying to align =.

Bikeshedding - since the new name is so long, can you get by with the 
shorter QCOW2_INCOMPAT_COMPRESSION_BITNR (drop the _TYPE)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


