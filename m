Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52BC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2F62065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFOkYnnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2F62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1NB-0006NG-Ur
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jv1M3-0005IQ-Ud
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:30:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jv1M1-00048j-Rz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594657856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bJV6qHtYb2OsRijYM1eKmbn+5H4uHEasSDEIDj0EMQ=;
 b=gFOkYnnPJUpJamLyBgCgxQji6M5EOOLDPR+3b9M7hw5Jx7fZzJT4AT/e+N/eBIHuPfpabG
 Vz4kzVl80v3YzGlst+fnSMQaEZ9hxOSIWnRl0rB5vkb8gZHH0tijsUokD6LdR+OaTeGjvT
 M5Wi8bg+l2W4XN0mZfd/2yRs6XiP5z4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-TrPC0pPOOVOafsfDUIQIAg-1; Mon, 13 Jul 2020 12:29:44 -0400
X-MC-Unique: TrPC0pPOOVOafsfDUIQIAg-1
Received: by mail-ot1-f72.google.com with SMTP id x12so7637283oto.19
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8bJV6qHtYb2OsRijYM1eKmbn+5H4uHEasSDEIDj0EMQ=;
 b=aYZJOW7YukmBEGd7UElCiGVOkNSSslsih0hcMx1UmZXZJd2tCiPCxkgOntlkgAJHkA
 YvXuftNOtem/ixMhMhV8F47keTwPaw4ST7af8S6N7HUuD0r85orzBUryo9fyX/qr6RUn
 dtnTMwzi+c87msfQ8lxWS9G+UJQ7SiAiQUr0GgOunrsUTLDKgnd4Rf5Al0TT70uQ+epc
 5TuuxA5bw9E2V5Rm2Xv2R+E8IP6qO8q9xL0I9DpDGvmEtXKqdKKjV/Cg5Agm5sLp65B7
 Oaz5XxhPWXv2nlhupaYBQuZq4K6+8vY4hZBzRwe7Hk3xE6CZBb/MH36uLLqfs935fGg1
 qQYQ==
X-Gm-Message-State: AOAM533XV8N/jgJJ/k8PpHH43QXlY3BP7i5rCfOApnOA24YEgu0t2LNu
 Tg210q+a1SZUgqTd1cojwi3TPvvpBYU7c/qmrN3U7VT+A3imw2bBMk9m8UVz9bYBqv2bpiH3j4L
 9xlkeJyoWfqQzOWlRvFP14G2jy+hvKF0=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr219371oid.56.1594657783356; 
 Mon, 13 Jul 2020 09:29:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz03bQnJ9pwmm344o5bvrJG1VzwosbGojMEjj4vx/kqE1yAjZj3xXtxTnXsrwXx56siQ6gWi6nOLJ8gyDxQZ9U=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr219334oid.56.1594657783040; 
 Mon, 13 Jul 2020 09:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-3-kwolf@redhat.com>
In-Reply-To: <20200710142149.40962-3-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 13 Jul 2020 19:29:26 +0300
Message-ID: <CAMRbyysF1j7rA_7NqdUSvri9Tck9EcVbTStoDEZU3EFbf5+rVg@mail.gmail.com>
Subject: Re: [PATCH for-5.1 2/2] file-posix: Allow byte-aligned O_DIRECT with
 NFS
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Since commit a6b257a08e3 ('file-posix: Handle undetectable alignment'),
> we assume that if we open a file with O_DIRECT and alignment probing
> returns 1, we just couldn't find out the real alignment requirement
> because some filesystems make the requirement only for allocated blocks.
> In this case, a safe default of 4k is used.
>
> This is too strict NFS, which does actually allow byte-aligned requests
> even with O_DIRECT. Because we can't distinguish both cases with generic
> code, let's just look at the file system magic and disable
> s->needs_alignment for NFS. This way, O_DIRECT can still be used on NFS
> for images that are not aligned to 4k.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 0c4e07c415..4e9dac461b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -62,10 +62,12 @@
>  #include <sys/ioctl.h>
>  #include <sys/param.h>
>  #include <sys/syscall.h>
> +#include <sys/vfs.h>
>  #include <linux/cdrom.h>
>  #include <linux/fd.h>
>  #include <linux/fs.h>
>  #include <linux/hdreg.h>
> +#include <linux/magic.h>
>  #include <scsi/sg.h>
>  #ifdef __s390__
>  #include <asm/dasd.h>
> @@ -300,6 +302,28 @@ static int probe_physical_blocksize(int fd, unsigned int *blk_size)
>  #endif
>  }
>
> +/*
> + * Returns true if no alignment restrictions are necessary even for files
> + * opened with O_DIRECT.
> + *
> + * raw_probe_alignment() probes the required alignment and assume that 1 means
> + * the probing failed, so it falls back to a safe default of 4k. This can be
> + * avoided if we know that byte alignment is okay for the file.
> + */
> +static bool dio_byte_aligned(int fd)
> +{
> +#ifdef __linux__
> +    struct statfs buf;
> +    int ret;
> +
> +    ret = fstatfs(fd, &buf);
> +    if (ret == 0 && buf.f_type == NFS_SUPER_MAGIC) {
> +        return true;
> +    }
> +#endif
> +    return false;
> +}
> +
>  /* Check if read is allowed with given memory buffer and length.
>   *
>   * This function is used to check O_DIRECT memory buffer and request alignment.
> @@ -631,7 +655,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>
>      s->has_discard = true;
>      s->has_write_zeroes = true;
> -    if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
> +    if ((bs->open_flags & BDRV_O_NOCACHE) != 0 && !dio_byte_aligned(s->fd)) {
>          s->needs_alignment = true;

I did not know we have needs_alignment. Isn't this the same as using
request_alignment = 1?

For example we can check if we are on NFS and avoid the fallback to max_align:

    if (!bs->bl.request_alignment) {
        int i;
        size_t align;
        buf = qemu_memalign(max_align, max_align);
        for (i = 0; i < ARRAY_SIZE(alignments); i++) {
            align = alignments[i];
            if (raw_is_io_aligned(fd, buf, align)) {
                /* Fallback to safe value. */
                bs->bl.request_alignment = (align != 1) ? align : max_align;
                break;
            }
        }
        qemu_vfree(buf);
    }

After this we will have correct bl.request_alignment and buf_align.
Hopefully this will not break code expecting request_alignment >= 512.

Assuming that needs_alignment is well tested, this patch may be safer.

Nir

>      }
>
> --
> 2.25.4
>


