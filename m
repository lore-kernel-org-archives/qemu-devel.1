Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7597C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E1A2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBotuyK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E1A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbms4-0007QL-HQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbmr5-0006K9-5K
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:11:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbmr3-0008Mh-TV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fMQF5s9brPeHq3E0r/0oSX5bDTcqtj74XT+MabGkXs=;
 b=VBotuyK7R0nNthfatJCPNBUOpmRyRVQ37XELQsy7IxIi2Qo15cnZf0qVVTuD6212jWEEEa
 CwWI1njCntIoVslZgQoE8jc7NLse0FpApooN7oTt+YjL1kAblaGcatr+5oLpNkcBr8anJX
 ESJxkemAQFbVek0GthmD74cUVvXOMv4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-Q3gCgAAfMrCje9qchfn9qg-1; Thu, 21 May 2020 11:11:25 -0400
X-MC-Unique: Q3gCgAAfMrCje9qchfn9qg-1
Received: by mail-ot1-f70.google.com with SMTP id b15so3247956oti.23
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0fMQF5s9brPeHq3E0r/0oSX5bDTcqtj74XT+MabGkXs=;
 b=MCjHABnZ/BboehqeOms7lSzJJlSFzuxlYpTE3UJ5AMCaVjtRUsaBmQCZvwNzI4um9E
 dC4VewuVi1XBB98oVFLq48vsHeE/ltzWVs2ZvaX0X/vpvoRX/EEBqA3asncTZ7no92KJ
 kcwQWU9pMZokR8wS+FPXlXx3xjZmr7UFgy56KT6ZrPElk9o8tO+lt8F6OpY68uGBowJ6
 kwuqmWIdpfJALeZD2UlIZNMY2Xbe8Kf/zwHANArUYzxpga5me5XzXUwihQX3YixYCkVI
 Vr4b3bOLXLaGs/7SOVdc/gl3o9cAI15JnAxhAa2QY+3zTs2voMhKtDmDX2wz6Ud8POkt
 bX1w==
X-Gm-Message-State: AOAM532c3tdcOXUrSxAZa1TE2sIov6a7XIztfEml37b2B2OIWzocqWkP
 HOUsRwUH3PdWUQGwTY0NKGyBMyV+6WvkuCe809TjT3+fpis9GTpFUw3TLMSTJ2+3MEzXRB+txYW
 p7266wSWRlro/+Cvi4D3G1nZAqDcIgyE=
X-Received: by 2002:a9d:4c6:: with SMTP id 64mr7718546otm.315.1590073884737;
 Thu, 21 May 2020 08:11:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+HKeoqK4oOj6xEhl+bHASYkBvw+hrKPFD5ouOabKx1n5Rf0Q023vxVxw5G5GxVk8bYeRHJi9f7Y6IiYBAIsY=
X-Received: by 2002:a9d:4c6:: with SMTP id 64mr7718454otm.315.1590073883455;
 Thu, 21 May 2020 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-5-eblake@redhat.com>
In-Reply-To: <20200520220118.1037094-5-eblake@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 21 May 2020 18:11:07 +0300
Message-ID: <CAMRbyyvYifirLrb6kTej6mUPBnhr8rsFOx-QeMGDrWG=Zi4i0Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] qemu-img: Add convert --bitmaps option
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
>
> Make it easier to copy all the persistent bitmaps of (the top layer
> of) a source image along with its guest-visible contents, by adding a
> boolean flag for use with qemu-img convert.  This is basically
> shorthand, as the same effect could be accomplished with a series of
> 'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
> commands, or by QMP commands.
>
> Note that this command will fail in the same scenarios where 'qemu-img
> measure --bitmaps' fails, when either the source or the destanation
> lacks persistent bitmap support altogether.

If we remove --bitmaps option from qemu-img measure, we need to remove
this note.

>
> See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1779893
>
> While touching this, clean up a couple coding issues spotted in the
> same function: an extra blank line, and merging back-to-back 'if
> (!skip_create)' blocks.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20200513011648.166876-9-eblake@redhat.com>
> ---
>  docs/tools/qemu-img.rst |  6 +++-
>  qemu-img.c              | 77 +++++++++++++++++++++++++++++++++++++++--
>  qemu-img-cmds.hx        |  4 +--
>  3 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 9a8112fc9f58..35050fc51070 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -162,6 +162,10 @@ Parameters to convert subcommand:
>
>  .. program:: qemu-img-convert
>
> +.. option:: --bitmaps
> +
> +  Additionally copy all persistent bitmaps from the top layer of the sou=
rce
> +
>  .. option:: -n
>
>    Skip the creation of the target volume
> @@ -397,7 +401,7 @@ Command description:
>    4
>      Error on reading data
>
> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-=
opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] =
[-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_=
PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]]=
 OUTPUT_FILENAME
> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-=
opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT]=
 [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [=
-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILE=
NAME2 [...]] OUTPUT_FILENAME
>
>    Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
>    to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
> diff --git a/qemu-img.c b/qemu-img.c
> index c1bafb57023a..1494d8f5c409 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -192,6 +192,7 @@ static void QEMU_NORETURN help(void)
>             "       hiding corruption that has already occurred.\n"
>             "\n"
>             "Parameters to convert subcommand:\n"
> +           "  '--bitmaps' copies all top-level persistent bitmaps to des=
tination\n"
>             "  '-m' specifies how many coroutines work in parallel during=
 the convert\n"
>             "       process (defaults to 8)\n"
>             "  '-W' allow to write to the target out of order rather than=
 sequential\n"
> @@ -2139,6 +2140,39 @@ static int convert_do_copy(ImgConvertState *s)
>      return s->ret;
>  }
>
> +static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState =
*dst)
> +{
> +    BdrvDirtyBitmap *bm;
> +    Error *err =3D NULL;
> +
> +    FOR_EACH_DIRTY_BITMAP(src, bm) {
> +        const char *name;
> +
> +        if (!bdrv_dirty_bitmap_get_persistence(bm)) {
> +            continue;
> +        }
> +        name =3D bdrv_dirty_bitmap_name(bm);
> +        qmp_block_dirty_bitmap_add(dst->node_name, name,
> +                                   true, bdrv_dirty_bitmap_granularity(b=
m),
> +                                   true, true,
> +                                   true, !bdrv_dirty_bitmap_enabled(bm),
> +                                   &err);
> +        if (err) {
> +            error_reportf_err(err, "Failed to create bitmap %s: ", name)=
;
> +            return -1;
> +        }
> +
> +        do_dirty_bitmap_merge(dst->node_name, name, src->node_name, name=
,
> +                              &err);
> +        if (err) {
> +            error_reportf_err(err, "Failed to populate bitmap %s: ", nam=
e);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  #define MAX_BUF_SECTORS 32768
>
>  static int img_convert(int argc, char **argv)
> @@ -2160,6 +2194,8 @@ static int img_convert(int argc, char **argv)
>      int64_t ret =3D -EINVAL;
>      bool force_share =3D false;
>      bool explict_min_sparse =3D false;
> +    bool bitmaps =3D false;
> +    size_t nbitmaps =3D 0;
>
>      ImgConvertState s =3D (ImgConvertState) {
>          /* Need at least 4k of zeros for sparse detection */
> @@ -2179,6 +2215,7 @@ static int img_convert(int argc, char **argv)
>              {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OP=
TS},
>              {"salvage", no_argument, 0, OPTION_SALVAGE},
>              {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
> +            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
>              {0, 0, 0, 0}
>          };
>          c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2304,6 +2341,9 @@ static int img_convert(int argc, char **argv)
>               */
>              s.has_zero_init =3D true;
>              break;
> +        case OPTION_BITMAPS:
> +            bitmaps =3D true;
> +            break;
>          }
>      }
>
> @@ -2365,7 +2405,6 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
>
> -
>      /* ret is still -EINVAL until here */
>      ret =3D bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrou=
gh);
>      if (ret < 0) {
> @@ -2525,6 +2564,27 @@ static int img_convert(int argc, char **argv)
>          }
>      }
>
> +    /* Determine how many bitmaps need copying */
> +    if (bitmaps) {
> +        BdrvDirtyBitmap *bm;
> +
> +        if (s.src_num > 1) {
> +            error_report("Copying bitmaps only possible with single sour=
ce");
> +            ret =3D -1;
> +            goto out;
> +        }
> +        if (!bdrv_supports_persistent_dirty_bitmap(blk_bs(s.src[0]))) {
> +            error_report("Source lacks bitmap support");
> +            ret =3D -1;
> +            goto out;
> +        }
> +        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
> +                nbitmaps++;
> +            }
> +        }
> +    }
> +
>      /*
>       * The later open call will need any decryption secrets, and
>       * bdrv_create() will purge "opts", so extract them now before
> @@ -2533,9 +2593,7 @@ static int img_convert(int argc, char **argv)
>      if (!skip_create) {
>          open_opts =3D qdict_new();
>          qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_ab=
ort);
> -    }
>
> -    if (!skip_create) {
>          /* Create the new image */
>          ret =3D bdrv_create(drv, out_filename, opts, &local_err);
>          if (ret < 0) {
> @@ -2573,6 +2631,13 @@ static int img_convert(int argc, char **argv)
>      }
>      out_bs =3D blk_bs(s.target);
>
> +    if (nbitmaps > 0 && !bdrv_supports_persistent_dirty_bitmap(out_bs)) =
{
> +        error_report("Format driver '%s' does not support bitmaps",
> +                     out_fmt);
> +        ret =3D -1;
> +        goto out;
> +    }
> +
>      if (s.compressed && !block_driver_can_compress(out_bs->drv)) {
>          error_report("Compression not supported for this file format");
>          ret =3D -1;
> @@ -2632,6 +2697,12 @@ static int img_convert(int argc, char **argv)
>      }
>
>      ret =3D convert_do_copy(&s);
> +
> +    /* Now copy the bitmaps */
> +    if (nbitmaps > 0 && ret =3D=3D 0) {
> +        ret =3D convert_copy_bitmaps(blk_bs(s.src[0]), out_bs);
> +    }
> +
>  out:
>      if (!ret) {
>          qemu_progress_print(100, 0);
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 235cc5fffadc..e9beb15e614e 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -46,9 +46,9 @@ SRST
>  ERST
>
>  DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [--target-image-opts] [=
--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src=
_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] =
[-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [=
...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [--target-image-opts] [=
--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t ca=
che] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snap=
shot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename =
[filename2 [...]] output_filename")
>  SRST
> -.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-=
opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] =
[-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_=
PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILE=
NAME2 [...]] OUTPUT_FILENAME
> +.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-=
opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT]=
 [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [=
-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FI=
LENAME [FILENAME2 [...]] OUTPUT_FILENAME
>  ERST
>
>  DEF("create", img_create,
> --
> 2.26.2
>


