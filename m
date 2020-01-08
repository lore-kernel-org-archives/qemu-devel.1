Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C4020720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqOqwZat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C4020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHIm-0001Vx-CG
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 14:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ipHHp-0000tD-7n
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ipHHm-0004Jr-Jb
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:46:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ipHHi-0004Fe-SG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578512789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2iupHp4YzzDky9VQwhZ8ZcouBSBpLfaTHpRe+DvuDg=;
 b=hqOqwZatztNEzNnfLmQrVjPUHZcbdxBAx6NY3lSYbz1Qmu9FQiWZto9fwag4CNX7nzaChL
 /t1ip+tVjjqggjBFO9jdrirVgnt9FBuJ32TEZuDUaka7B94Qvk4ExwqOI6siBkj7CyXbC0
 jZ28eGDhLpYBi4oM+8da07eZXdGXm7Y=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-8P_6XBnkOdiXALr4LB_O7g-1; Wed, 08 Jan 2020 14:46:28 -0500
Received: by mail-oi1-f197.google.com with SMTP id x75so2185223oix.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 11:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=98UA0fDsDzR8wnLN3s0tc7+S9P0J4TwsYOf1c5PtHYk=;
 b=deZRgWpPPiaRBOapG2rxUQlJnr3OioWFezoHMZuYqHr2Udrfh474GNABTs5XtFCwMH
 b0f0mu4WJKSIWm/V0+cooKjxyytXlGKcSagTHYEdsfcb4D1ci04QsF/rla/ixkEdiuW+
 3nPabwoiQrZ2zchicaesnLloV6fWnb9+LCr4Fj/IdU3C8TPofjEZDS3FkGP3kAutPkyJ
 Pc9zJLqUjZbMRFhz1117WnSZCDLPgJ8afamalJXXeT6DqW5FcmPguLQWgzoKQv9mtLmE
 XxCFn+28+BNEvO+czdRWHhriefgXRaZIrNlg06F0x2rAPI/rDCuxJPWn+M2I0m+qoxN+
 fpww==
X-Gm-Message-State: APjAAAVSSyQgjyfYFVVCTPeI3yZm2p2VjVGQWxh2lX0xp23QTd6G+NYV
 IaO7ArLvhDTXHi765aHOkIzEUapPEm1gZCSdcYZw381pbCdBUJKVz+XiA8xJ2eWLSGpsR+sxHM8
 NQfkWRRyk4rW0aCA3wnaazihTrNrHTfE=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr198778oih.106.1578512787433; 
 Wed, 08 Jan 2020 11:46:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyN+twfmnxbMV6YJDmaECpneB2zpI0lLBlrhj4F/6utQPiKZkp93EDecmJiNX4nZVHrhtiF4Mih9L3eThXzi7g=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr198758oih.106.1578512787081; 
 Wed, 08 Jan 2020 11:46:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578505678.git.berto@igalia.com>
 <4a27dc359f8211700662949bdecdd992f8918c12.1578505678.git.berto@igalia.com>
In-Reply-To: <4a27dc359f8211700662949bdecdd992f8918c12.1578505678.git.berto@igalia.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 8 Jan 2020 21:46:11 +0200
Message-ID: <CAMRbyysKuC8cx7eaCDKwXG6ierQFEZGTQQ6PCtAjR9WQR5TvAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] qcow2: Require that the virtual size is a multiple of
 the sector size
To: Alberto Garcia <berto@igalia.com>
X-MC-Unique: 8P_6XBnkOdiXALr4LB_O7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 7:52 PM Alberto Garcia <berto@igalia.com> wrote:
>
> The qcow2 header specifies the virtual size of the image in bytes, but
> BlockDriverState stores it as a number of 512-byte sectors.
>
> If the user tries to create an image with a size that is not a
> multiple of the sector size then this is fixed on creation by
> silently rounding the image size up (see commit c2eb918e32).
> qcow2_co_truncate() is more strict and returns an error instead.
>
> However when an image is opened the virtual size is rounded down,
> which means that trying to access the last few advertised bytes will
> result in an error. As seen above QEMU cannot create such images and
> there's no good use case that would require us to try to handle them
> so let's just treat them as unsupported.

Making error impossible is best.

Can we require multiple of 4k to avoid unaligned read/write at the end
of an image
aligned to 512 bytes on storage with 4k sector size?

>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              | 7 +++++++
>  docs/interop/qcow2.txt     | 3 ++-
>  tests/qemu-iotests/080     | 7 +++++++
>  tests/qemu-iotests/080.out | 4 ++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7fbaac8457..92474849db 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1326,6 +1326,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
>          goto fail;
>      }
>
> +    if (header.size % BDRV_SECTOR_SIZE) {
> +        error_setg(errp, "Virtual size is not a multiple of %u",
> +                   (unsigned) BDRV_SECTOR_SIZE);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
>      if (header.header_length > sizeof(header)) {
>          s->unknown_header_fields_size =3D header.header_length - sizeof(=
header);
>          s->unknown_header_fields =3D g_malloc(s->unknown_header_fields_s=
ize);
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..891f5662d8 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -40,7 +40,8 @@ The first cluster of a qcow2 image contains the file he=
ader:
>                      with larger cluster sizes.
>
>           24 - 31:   size
> -                    Virtual disk size in bytes.
> +                    Virtual disk size in bytes. qemu can only handle
> +                    sizes that are a multiple of 512 bytes.
>
>                      Note: qemu has an implementation limit of 32 MB as
>                      the maximum L1 table size.  With a 2 MB cluster
> diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
> index 4bcb5021e8..2563b2c052 100755
> --- a/tests/qemu-iotests/080
> +++ b/tests/qemu-iotests/080
> @@ -48,6 +48,7 @@ header_size=3D104
>
>  offset_backing_file_offset=3D8
>  offset_backing_file_size=3D16
> +offset_virtual_size=3D24
>  offset_l1_size=3D36
>  offset_l1_table_offset=3D40
>  offset_refcount_table_offset=3D48
> @@ -197,6 +198,12 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\=
x00\x00\x00"
>  { $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
>  _check_test_img
>
> +echo
> +echo "=3D=3D Image size not a multiple of the sector size =3D=3D"
> +_make_test_img 64k

Logging the change here would make the test and the output more clear:

    echo "modifying virtual size to 65535"

> +poke_file "$TEST_IMG" "$offset_virtual_size" "\x00\x00\x00\x00\x00\x00\x=
ff\xff"
> +{ $QEMU_IO -c "write 65530 1" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
> index 45ab01db8e..e1c969e2ba 100644
> --- a/tests/qemu-iotests/080.out
> +++ b/tests/qemu-iotests/080.out
> @@ -104,4 +104,8 @@ Data may be corrupted, or further writes to the image=
 may corrupt it.
>
>  3 leaked clusters were found on the image.
>  This means waste of disk space, but no harm to data.
> +
> +=3D=3D Image size not a multiple of the sector size =3D=3D
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
> +qemu-io: can't open device TEST_DIR/t.qcow2: Virtual size is not a multi=
ple of 512

The output is confusing, looks like we created image with aligned
size, and on the next
line it complains about the size.

>  *** done
> --
> 2.20.1
>
>

Nir


