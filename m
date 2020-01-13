Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A0C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 11:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7932081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIyvoYlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7932081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqyEw-0008H2-Ei
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 06:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iqyDx-0007CB-IA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iqyDv-0006vx-5v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:49:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iqyDu-0006uN-Pm
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578916173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHrAAQkGBZpUKREzmpIoBJLz61jD/xc1nSJzAXb+asc=;
 b=gIyvoYlmTyvk0cBe8/t0Bl0xmaHhI1zRJz8f5or8OsevKfoovSnh9DizJm+dSOKFLKoVPH
 55kqx2NvcrnLDQjhj/W3LdiowjYKcnwabLAbrCBpu7igZUYDzWSeSYJU7s2s4kQpeTLocT
 z2vzONpXHz1uSJIZsZUcFsYb/rJDBVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-gpybiGsoOT23yGHJ5wjExQ-1; Mon, 13 Jan 2020 06:49:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so4905028wrw.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 03:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9zQkQ7ClwoypMuxO3g92z3l4mFsxtkXgId0KEdzXXFA=;
 b=lNTr1EpCweOJXmZDK02s9rL1wX9jN+Y68HdTTkGoAbzpto1swE2oGKz1Uwm7hWaOld
 teOtafRX/6G83ABCkuo9RzvcpVAMm+VXlF0GBuMwFeOkYduWlBuPno0yB4OlqkICZPBk
 nhK2sD0LwHr3L1o5y759bImAiJH9mGQ2lEf1tt2XNAS3tlV3pw3wS+87DqqJwRHdL/P1
 F6ogGiVtj/KZNfyxTetASoTLYxjWuTSAwCT/aWUtDvKC7cGLChMs7PXY4CT/PjLqwvGn
 eJ/n7aonILNoiShL19lJxyNV3bB30Ky52s5EtOFS60mZ9FnJrRyDKklD1K4YiMFUM5UI
 RQaQ==
X-Gm-Message-State: APjAAAVw9ptDIBhnzQ6QmN2WT1kEhQxx/h6HNfWcuaoXzHyhyWrZkXMZ
 URWfdVNipe/K28kHjhlSOn46Z04HrI7bHFeBDMEt4n/6JD/cSf9GEkwhFGQIVAnl4n4Y+rOH41W
 VrDKiFLvxzskfRKM=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr19832405wmg.163.1578916171084; 
 Mon, 13 Jan 2020 03:49:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHPK4DUBQlhn7Lh/OqTDPocbfuyXtVyYjBYyuutZlNTzuTmquCFhBOwA3zgKtm3JEERtHbRA==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr19832365wmg.163.1578916170767; 
 Mon, 13 Jan 2020 03:49:30 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id d8sm14951211wre.13.2020.01.13.03.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 03:49:30 -0800 (PST)
Date: Mon, 13 Jan 2020 12:49:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 08/15] block/file-posix.c: extend to use io_uring
Message-ID: <20200113114927.zbse5mlua5mq4hct@steredhat>
References: <20191218163228.1613099-1-stefanha@redhat.com>
 <20191218163228.1613099-9-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218163228.1613099-9-stefanha@redhat.com>
X-MC-Unique: gpybiGsoOT23yGHJ5wjExQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 oleksandr@redhat.com, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 04:32:21PM +0000, Stefan Hajnoczi wrote:
> From: Aarushi Mehta <mehta.aaru20@gmail.com>
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 95 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 75 insertions(+), 20 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 1b805bd938..a42a90e59d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -156,6 +156,7 @@ typedef struct BDRVRawState {
>      bool has_write_zeroes:1;
>      bool discard_zeroes:1;
>      bool use_linux_aio:1;
> +    bool use_linux_io_uring:1;
>      bool page_cache_inconsistent:1;
>      bool has_fallocate;
>      bool needs_alignment;
> @@ -444,7 +445,7 @@ static QemuOptsList raw_runtime_opts =3D {
>          {
>              .name =3D "aio",
>              .type =3D QEMU_OPT_STRING,
> -            .help =3D "host AIO implementation (threads, native)",
> +            .help =3D "host AIO implementation (threads, native, io_urin=
g)",
>          },
>          {
>              .name =3D "locking",
> @@ -503,9 +504,11 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
>          goto fail;
>      }
> =20
> -    aio_default =3D (bdrv_flags & BDRV_O_NATIVE_AIO)
> -                  ? BLOCKDEV_AIO_OPTIONS_NATIVE
> -                  : BLOCKDEV_AIO_OPTIONS_THREADS;
> +    if (bdrv_flags & BDRV_O_NATIVE_AIO) {
> +        aio_default =3D BLOCKDEV_AIO_OPTIONS_NATIVE;
> +    } else {
> +        aio_default =3D BLOCKDEV_AIO_OPTIONS_THREADS;
> +    }

This is only a cosmetic change?

>      aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup,
>                            qemu_opt_get(opts, "aio"),
>                            aio_default, &local_err);
> @@ -514,7 +517,11 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
>          ret =3D -EINVAL;
>          goto fail;
>      }
> +
>      s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
> +#ifdef CONFIG_LINUX_IO_URING
> +    s->use_linux_io_uring =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_IO_URING)=
;
> +#endif
> =20
>      locking =3D qapi_enum_parse(&OnOffAuto_lookup,
>                                qemu_opt_get(opts, "locking"),
> @@ -578,7 +585,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
>      s->shared_perm =3D BLK_PERM_ALL;
> =20
>  #ifdef CONFIG_LINUX_AIO
> -     /* Currently Linux does AIO only for files opened with O_DIRECT */
> +    /* Currently Linux does AIO only for files opened with O_DIRECT */

Also this is a not related fix, if you respin maybe we should split in a
new patch or say something in the commit message.

>      if (s->use_linux_aio) {
>          if (!(s->open_flags & O_DIRECT)) {
>              error_setg(errp, "aio=3Dnative was specified, but it require=
s "
> @@ -600,6 +607,22 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
>      }
>  #endif /* !defined(CONFIG_LINUX_AIO) */
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        if (!aio_setup_linux_io_uring(bdrv_get_aio_context(bs), errp)) {
> +            error_prepend(errp, "Unable to use io_uring: ");
> +            goto fail;
> +        }
> +    }
> +#else
> +    if (s->use_linux_io_uring) {
> +        error_setg(errp, "aio=3Dio_uring was specified, but is not suppo=
rted "
> +                         "in this build.");
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +#endif /* !defined(CONFIG_LINUX_IO_URING) */
> +
>      s->has_discard =3D true;
>      s->has_write_zeroes =3D true;
>      if ((bs->open_flags & BDRV_O_NOCACHE) !=3D 0) {
> @@ -1877,21 +1900,25 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
te *bs, uint64_t offset,
>          return -EIO;
> =20
>      /*
> -     * Check if the underlying device requires requests to be aligned,
> -     * and if the request we are trying to submit is aligned or not.
> -     * If this is the case tell the low-level driver that it needs
> -     * to copy the buffer.
> +     * When using O_DIRECT, the request must be aligned to be able to us=
e
> +     * either libaio or io_uring interface. If not fail back to regular =
thread
> +     * pool read/write code which emulates this for us if we
> +     * set QEMU_AIO_MISALIGNED.
>       */
> -    if (s->needs_alignment) {
> -        if (!bdrv_qiov_is_aligned(bs, qiov)) {
> -            type |=3D QEMU_AIO_MISALIGNED;
> +    if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
> +        type |=3D QEMU_AIO_MISALIGNED;
> +#ifdef CONFIG_LINUX_IO_URING
> +    } else if (s->use_linux_io_uring) {
> +        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
> +        assert(qiov->size =3D=3D bytes);
> +        return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
> +#endif
>  #ifdef CONFIG_LINUX_AIO
> -        } else if (s->use_linux_aio) {
> -            LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_contex=
t(bs));
> -            assert(qiov->size =3D=3D bytes);
> -            return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
> +    } else if (s->use_linux_aio) {

This code block was executed if "s->needs_alignment" was true, now we don't
check it. Could this be a problem?

> +        LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
> +        assert(qiov->size =3D=3D bytes);
> +        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
>  #endif
> -        }
>      }
> =20
>      acb =3D (RawPosixAIOData) {
> @@ -1927,24 +1954,36 @@ static int coroutine_fn raw_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
> =20
>  static void raw_aio_plug(BlockDriverState *bs)
>  {
> +    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s =3D bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
>          laio_io_plug(bs, aio);
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
> +        luring_io_plug(bs, aio);
> +    }
> +#endif
>  }
> =20
>  static void raw_aio_unplug(BlockDriverState *bs)
>  {
> +    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s =3D bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
>          laio_io_unplug(bs, aio);
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
> +        luring_io_unplug(bs, aio);
> +    }
> +#endif
>  }
> =20
>  static int raw_co_flush_to_disk(BlockDriverState *bs)
> @@ -1964,14 +2003,20 @@ static int raw_co_flush_to_disk(BlockDriverState =
*bs)
>          .aio_type       =3D QEMU_AIO_FLUSH,
>      };
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
> +        return luring_co_submit(bs, aio, s->fd, 0, NULL, QEMU_AIO_FLUSH)=
;
> +    }
> +#endif
>      return raw_thread_pool_submit(bs, handle_aiocb_flush, &acb);
>  }
> =20
>  static void raw_aio_attach_aio_context(BlockDriverState *bs,
>                                         AioContext *new_context)
>  {
> +    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s =3D bs->opaque;
>      if (s->use_linux_aio) {
>          Error *local_err =3D NULL;
>          if (!aio_setup_linux_aio(new_context, &local_err)) {
> @@ -1981,6 +2026,16 @@ static void raw_aio_attach_aio_context(BlockDriver=
State *bs,
>          }
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        Error *local_err;
> +        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
> +            error_reportf_err(local_err, "Unable to use linux io_uring, =
"
> +                                         "falling back to thread pool: "=
);
> +            s->use_linux_io_uring =3D false;
> +        }
> +    }
> +#endif
>  }
> =20
>  static void raw_close(BlockDriverState *bs)
> --=20
> 2.23.0
>=20
>=20


