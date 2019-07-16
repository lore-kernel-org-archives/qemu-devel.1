Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B660C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4257C20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNDB-0001pm-IB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCq-0000S4-9z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCm-0002ya-Ae
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnNCg-0002us-TU; Tue, 16 Jul 2019 09:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F7A8B2DCD;
 Tue, 16 Jul 2019 13:09:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D67A6101E1D6;
 Tue, 16 Jul 2019 13:09:05 +0000 (UTC)
Message-ID: <23139c8bd12df39817d92fab836b4bd039b599b2.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 16:09:05 +0300
In-Reply-To: <20190712173600.14554-5-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-5-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 16 Jul 2019 13:09:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] block: Generic file
 creation fallback
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> If a protocol driver does not support image creation, we can see whether
> maybe the file exists already.  If so, just truncating it will be
> sufficient.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/block.c b/block.c
> index c139540f2b..5466585501 100644
> --- a/block.c
> +++ b/block.c
> @@ -531,20 +531,63 @@ out:
>      return ret;
>  }
>  
> -int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
> +static int bdrv_create_file_fallback(const char *filename, BlockDriver *drv,
> +                                     QemuOpts *opts, Error **errp)
>  {
> -    BlockDriver *drv;
> +    BlockBackend *blk;
> +    QDict *options = qdict_new();
> +    int64_t size = 0;
> +    char *buf = NULL;
> +    PreallocMode prealloc;
>      Error *local_err = NULL;
>      int ret;
>  
> +    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> +    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
> +                               PREALLOC_MODE_OFF, &local_err);
> +    g_free(buf);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +
> +    if (prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Unsupported preallocation mode '%s'",
> +                   PreallocMode_str(prealloc));
> +        return -ENOTSUP;
> +    }
> +
> +    qdict_put_str(options, "driver", drv->format_name);
> +
> +    blk = blk_new_open(filename, NULL, options,
> +                       BDRV_O_RDWR | BDRV_O_RESIZE, errp);
> +    if (!blk) {
> +        error_prepend(errp, "Protocol driver '%s' does not support image "
> +                      "creation, and opening the image failed: ",
> +                      drv->format_name);
> +        return -EINVAL;
> +    }
> +
> +    ret = blk_truncate_for_formatting(blk, size, errp);
> +    blk_unref(blk);
> +    return ret;
> +}
> +
> +int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
> +{
> +    BlockDriver *drv;
> +
>      drv = bdrv_find_protocol(filename, true, errp);
>      if (drv == NULL) {
>          return -ENOENT;
>      }
>  
> -    ret = bdrv_create(drv, filename, opts, &local_err);
> -    error_propagate(errp, local_err);
> -    return ret;
> +    if (drv->bdrv_co_create_opts) {
> +        return bdrv_create(drv, filename, opts, errp);
> +    } else {
> +        return bdrv_create_file_fallback(filename, drv, opts, errp);
> +    }
>  }
>  
>  /**
> @@ -1420,6 +1463,24 @@ QemuOptsList bdrv_runtime_opts = {
>      },
>  };
>  
> +static QemuOptsList fallback_create_opts = {
> +    .name = "fallback-create-opts",
> +    .head = QTAILQ_HEAD_INITIALIZER(fallback_create_opts.head),
> +    .desc = {
> +        {
> +            .name = BLOCK_OPT_SIZE,
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Virtual disk size"
> +        },
> +        {
> +            .name = BLOCK_OPT_PREALLOC,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Preallocation mode (allowed values: off)"
> +        },
> +        { /* end of list */ }
> +    }
> +};
> +
>  /*
>   * Common part for opening disk images and files
>   *
> @@ -5681,14 +5742,12 @@ void bdrv_img_create(const char *filename, const char *fmt,
>          return;
>      }
>  
> -    if (!proto_drv->create_opts) {
> -        error_setg(errp, "Protocol driver '%s' does not support image creation",
> -                   proto_drv->format_name);
> -        return;
> -    }
> -
>      create_opts = qemu_opts_append(create_opts, drv->create_opts);
> -    create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
> +    if (proto_drv->create_opts) {
> +        create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
> +    } else {
> +        create_opts = qemu_opts_append(create_opts, &fallback_create_opts);
> +    }
>  
>      /* Create parameter list with default values */
>      opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);

Looks good!


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


