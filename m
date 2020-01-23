Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72184C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A96F20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnRpekCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96F20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulRy-0002GJ-Ba
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iulR1-0001C2-Ej
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iulQz-0006LY-LT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:58:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iulQz-0006K3-Gj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579820324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x8bav70GoKVrgQZ+EqRGya0cDjCLXW9vd/VGh4/0rQ=;
 b=GnRpekCurZBdj7XY+cDets7x+PHP5EqotKfIP8CKkvd7w8lqbMV7dnrTUyId+fxvLgw+lj
 +BQoI2SDtES45cPO7A7VrRLpsy0vrCNvZGY5Icp2nJT/f85AVz+V4kP5muRyuXNIwX2/kn
 Omrn+zF4fRJLqOHwH3xhNHGvsX005o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-md7RVGOHPTqlJWtKZCg0pQ-1; Thu, 23 Jan 2020 17:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AE4477;
 Thu, 23 Jan 2020 22:58:41 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 717E560BE1;
 Thu, 23 Jan 2020 22:58:40 +0000 (UTC)
Message-ID: <9280b6f092b82114643cb1fb71eebe52cac777ff.camel@redhat.com>
Subject: Re: [PATCH v2 2/5] block: Generic file creation fallback
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Fri, 24 Jan 2020 00:58:39 +0200
In-Reply-To: <20200122164532.178040-3-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
 <20200122164532.178040-3-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: md7RVGOHPTqlJWtKZCg0pQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-01-22 at 17:45 +0100, Max Reitz wrote:
> If a protocol driver does not support image creation, we can see whether
> maybe the file exists already.  If so, just truncating it will be
> sufficient.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 147 insertions(+), 12 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 99ce26d64d..e167eca04b 100644
> --- a/block.c
> +++ b/block.c
> @@ -532,20 +532,139 @@ out:
>      return ret;
>  }
>  
> -int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
> +/**
> + * Helper function for bdrv_create_file_fallback(): Resize @blk to at
> + * least the given @minimum_size.
> + *
> + * On success, return @blk's actual length.
> + * Otherwise, return -errno.
> + */
> +static int64_t create_file_fallback_truncate(BlockBackend *blk,
> +                                             int64_t minimum_size, Error **errp)
>  {
> -    BlockDriver *drv;
> +    Error *local_err = NULL;
> +    int64_t size;
> +    int ret;
> +
> +    ret = blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, &local_err);
> +    if (ret < 0 && ret != -ENOTSUP) {
> +        error_propagate(errp, local_err);
> +        return ret;
> +    }
> +

...


> +    size = blk_getlength(blk);
> +    if (size < 0) {
> +        error_free(local_err);
> +        error_setg_errno(errp, -size,
> +                         "Failed to inquire the new image file's length");
> +        return size;
> +    }
> +
> +    if (size < minimum_size) {
> +        /* Need to grow the image, but we failed to do that */
> +        error_propagate(errp, local_err);
> +        return -ENOTSUP;
> +    }

Very minor nitpick:

The above code basically handles case when truncate is not supported,
by trying to see file size is large enough anyway.
If truncate succeed this is a bit redundant, but doesn't hurt to be honest.
If truncate is not supported, it also works, but I am thinking that
maybe its is better to create a generic truncate failback instead
that will 'work' when asked for same size resize or smaller that existing size + exact=false.

Currently when the above failback doesn't work (meaning that we indeed have to enlarge the file)
we get this error message because truncate is not supported.

[root@fedora31vm ~/qemu]# qemu-img create -f raw nvme://0000:03:00.0 10000M
Formatting 'nvme://0000:03:00.0', fmt=raw size=10485760000
qemu-img: nvme://0000:03:00.0: Image format driver does not support resize

If we had generic truncate failback, it could maybe be smarter about this and say something like
'Can increase the size of the image'

But if you feel like that is not important, I don't have any issue to keep this as is,
since the code does work.


> +    error_free(local_err);
> +    local_err = NULL;
> +
> +    return size;
> +}
> +
> +/**
> + * Helper function for bdrv_create_file_fallback(): Zero the first
> + * sector to remove any potentially pre-existing image header.
> + */
> +static int create_file_fallback_zero_first_sector(BlockBackend *blk,
> +                                                  int64_t current_size,
> +                                                  Error **errp)
> +{
> +    int64_t bytes_to_clear;
> +    int ret;
> +
> +    bytes_to_clear = MIN(current_size, BDRV_SECTOR_SIZE);
> +    if (bytes_to_clear) {
> +        ret = blk_pwrite_zeroes(blk, 0, bytes_to_clear, BDRV_REQ_MAY_UNMAP);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret,
> +                             "Failed to clear the new image's first sector");
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int bdrv_create_file_fallback(const char *filename, BlockDriver *drv,
> +                                     QemuOpts *opts, Error **errp)
> +{
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
> +    size = create_file_fallback_truncate(blk, size, errp);
> +    if (size < 0) {
> +        ret = size;
> +        goto out;
> +    }
> +
> +    ret = create_file_fallback_zero_first_sector(blk, size, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    ret = 0;
> +out:
> +    blk_unref(blk);
> +    return ret;
> +}

Looks all right, very good code.

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
> @@ -1422,6 +1541,24 @@ QemuOptsList bdrv_runtime_opts = {
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
> @@ -5749,15 +5886,13 @@ void bdrv_img_create(const char *filename, const char *fmt,
>          return;
>      }
>  
> -    if (!proto_drv->create_opts) {
> -        error_setg(errp, "Protocol driver '%s' does not support image creation",
> -                   proto_drv->format_name);
> -        return;
> -    }
> -
>      /* Create parameter list */
>      create_opts = qemu_opts_append(create_opts, drv->create_opts);
> -    create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
> +    if (proto_drv->create_opts) {
> +        create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
> +    } else {
> +        create_opts = qemu_opts_append(create_opts, &fallback_create_opts);
> +    }
>  
>      opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);

I also tested the code a bit on the qemu virtual nvme drive.
Thanks for the patch series,

Best regards,
	Maxim Levitsky





