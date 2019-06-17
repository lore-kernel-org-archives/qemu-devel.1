Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68847C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406E82086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406E82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsh6-0002HT-Go
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsN7-0007uD-Nr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsN6-00036g-7C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcsN2-00033q-JV; Mon, 17 Jun 2019 10:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E92230832D1;
 Mon, 17 Jun 2019 14:12:22 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 825175E7C6;
 Mon, 17 Jun 2019 14:12:14 +0000 (UTC)
Message-ID: <875c51dadb3f4c65cc0875a76f71c006eefecd7b.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 17:12:13 +0300
In-Reply-To: <20190610134905.22294-9-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-9-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 17 Jun 2019 14:12:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 08/12] block/file-posix.c: extend to use
 io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-10 at 19:19 +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/file-posix.c | 85 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 16 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index d018429672..211dfe5337 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -154,6 +154,7 @@ typedef struct BDRVRawState {
>      bool has_write_zeroes:1;
>      bool discard_zeroes:1;
>      bool use_linux_aio:1;
> +    bool use_linux_io_uring:1;
Maybe an enum instead?


>      bool page_cache_inconsistent:1;
>      bool has_fallocate;
>      bool needs_alignment;
> @@ -423,7 +424,7 @@ static QemuOptsList raw_runtime_opts = {
>          {
>              .name = "aio",
>              .type = QEMU_OPT_STRING,
> -            .help = "host AIO implementation (threads, native)",
> +            .help = "host AIO implementation (threads, native, io_uring)",
>          },
>          {
>              .name = "locking",
> @@ -482,9 +483,15 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          goto fail;
>      }
>  
> -    aio_default = (bdrv_flags & BDRV_O_NATIVE_AIO)
> -                  ? BLOCKDEV_AIO_OPTIONS_NATIVE
> -                  : BLOCKDEV_AIO_OPTIONS_THREADS;
> +    if (bdrv_flags & BDRV_O_NATIVE_AIO) {
> +        aio_default = BLOCKDEV_AIO_OPTIONS_NATIVE;
> +#ifdef CONFIG_LINUX_IO_URING
> +    } else if (bdrv_flags & BDRV_O_IO_URING) {
> +        aio_default = BLOCKDEV_AIO_OPTIONS_IO_URING;
> +#endif
> +    } else {
> +        aio_default = BLOCKDEV_AIO_OPTIONS_THREADS;
> +    }
>      aio = qapi_enum_parse(&BlockdevAioOptions_lookup,
>                            qemu_opt_get(opts, "aio"),
>                            aio_default, &local_err);
> @@ -493,7 +500,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          ret = -EINVAL;
>          goto fail;
>      }
> +
>      s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
> +#ifdef CONFIG_LINUX_IO_URING
> +    s->use_linux_io_uring = (aio == BLOCKDEV_AIO_OPTIONS_IO_URING);
> +#endif
Same as above

>  
>      locking = qapi_enum_parse(&OnOffAuto_lookup,
>                                qemu_opt_get(opts, "locking"),
> @@ -557,7 +568,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      s->shared_perm = BLK_PERM_ALL;
>  
>  #ifdef CONFIG_LINUX_AIO
> -     /* Currently Linux does AIO only for files opened with O_DIRECT */
> +    /* Currently Linux does AIO only for files opened with O_DIRECT */
>      if (s->use_linux_aio) {
>          if (!(s->open_flags & O_DIRECT)) {
>              error_setg(errp, "aio=native was specified, but it requires "
> @@ -579,6 +590,22 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      }
>  #endif /* !defined(CONFIG_LINUX_AIO) */
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        if (!aio_setup_linux_io_uring(bdrv_get_aio_context(bs), errp)) {
> 
> +            error_prepend(errp, "Unable to use io_uring: ");
> +            goto fail;
> +        }
> +    }
> +#else
> +    if (s->use_linux_io_uring) {
> +        error_setg(errp, "aio=io_uring was specified, but is not supported "
> +                         "in this build.");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +#endif /* !defined(CONFIG_LINUX_IO_URING) */
> +
>      s->has_discard = true;
>      s->has_write_zeroes = true;
>      if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
> @@ -1875,16 +1902,20 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
>       * If this is the case tell the low-level driver that it needs
>       * to copy the buffer.
>       */
> -    if (s->needs_alignment) {
> -        if (!bdrv_qiov_is_aligned(bs, qiov)) {
> -            type |= QEMU_AIO_MISALIGNED;
> +    if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
> +                type |= QEMU_AIO_MISALIGNED;
indention is wrong.

> +#ifdef CONFIG_LINUX_IO_URING
> +    } else if (s->use_linux_io_uring) {
> +        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
> +        assert(qiov->size == bytes);
> +        return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
> +#endif
>  #ifdef CONFIG_LINUX_AIO
> -        } else if (s->use_linux_aio) {
> -            LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> -            assert(qiov->size == bytes);
> -            return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
> +    } else if (s->use_linux_aio && s->needs_alignment) {
You can probably drop the s->needs_alignment here as it is set iff the file if opened with O_DIRECT which is a requirement
for the linux aio.

Maybe while at it, maybe update that comment prior to the 's->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)'
since it is somewhat outdated.

I think it should state:

"When using O_DIRECT, the request must be aligned to be able to use either libaio or io_uring interface.
If not fail back to regular thread pool read/write code which emulates this for us if we set QEMU_AIO_MISALIGNED"

Or something like that.



> +        LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> +        assert(qiov->size == bytes);
> +        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
>  #endif
> -        }
>      }
>  
>      acb = (RawPosixAIOData) {
> @@ -1920,24 +1951,36 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
>  
>  static void raw_aio_plug(BlockDriverState *bs)
>  {
> +    BDRVRawState __attribute__((unused)) *s = bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s = bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
>          laio_io_plug(bs, aio);
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
> +        luring_io_plug(bs, aio);
> +    }
> +#endif
>  }
>  
>  static void raw_aio_unplug(BlockDriverState *bs)
>  {
> +    BDRVRawState __attribute__((unused)) *s = bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s = bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
>          laio_io_unplug(bs, aio);
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
> +        luring_io_unplug(bs, aio);
> +    }
> +#endif
>  }
>  
>  static int raw_co_flush_to_disk(BlockDriverState *bs)
> @@ -1963,8 +2006,8 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
>  static void raw_aio_attach_aio_context(BlockDriverState *bs,
>                                         AioContext *new_context)
>  {
> +    BDRVRawState __attribute__((unused)) *s = bs->opaque;
>  #ifdef CONFIG_LINUX_AIO
> -    BDRVRawState *s = bs->opaque;
>      if (s->use_linux_aio) {
>          Error *local_err;
>          if (!aio_setup_linux_aio(new_context, &local_err)) {
> @@ -1974,6 +2017,16 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
>          }
>      }
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (s->use_linux_io_uring) {
> +        Error *local_err;
> +        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
> +            error_reportf_err(local_err, "Unable to use linux io_uring, "
> +                                         "falling back to thread pool: ");
> +            s->use_linux_io_uring = false;
> +        }
> +    }
> +#endif
>  }
>  
>  static void raw_close(BlockDriverState *bs)


Other that minor notes,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


