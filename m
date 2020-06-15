Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E5FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62ED207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6DSp/yA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62ED207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuzb-0001Li-Tk
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jkuqw-0002CF-8M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:33:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jkuqs-0005U4-Tj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592249580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+XmhHOQCukJ3uHEnY1lz75CJaE1mVNGMeIxWKMwUMhU=;
 b=e6DSp/yAT0s+DmSMWKx7ZBL4udqW2EWb9dz63+ZY9qN6401hN5TD/qXXm49bqvUMoFL96T
 6Wp6jyD35R9vQNBXBKX/EDv/HbMfnp4qfuBICom1S6Oo28eiNt60mm5qC08zE7y2b20PUO
 Dc22yhLwwt6U4tVB4zk33ZB3xFTfGFw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-gu0AMQ9QOtG0T9ZxI2UmYg-1; Mon, 15 Jun 2020 15:32:58 -0400
X-MC-Unique: gu0AMQ9QOtG0T9ZxI2UmYg-1
Received: by mail-oi1-f199.google.com with SMTP id s9so9482612oih.20
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+XmhHOQCukJ3uHEnY1lz75CJaE1mVNGMeIxWKMwUMhU=;
 b=l7RYswwouf+7gVgV2EAJRE4pe9nGqBFVk968qBoGf085Bt0fhqudOzipMVB+w9YQj2
 ESE2w7IriZlApWyScDAJdQTeSnuAvY5cZznyBX2RC+Yp5vcEQP8RDy1dpZmMCROGRyqi
 Miq/pa9rgFg++gu0NbYkIN2AkxtAowUSYb3G7pBcrXdkd21flwApzTGwpktV7TmJ2BGq
 5mqmWqJJlrmwBLFCSC2ihRFwhSEbbiRXafkZAMtmFQLlH4MYIEiGOLe7kx05FUFGhzLa
 uJWtvwWHU5fv0Q81iibYpw0ycxMHpdvnRn0qxZw7lNdn3jBLmmGCU5LgI1AOIaShT9o2
 Yqng==
X-Gm-Message-State: AOAM533ttOC4BiitjBva3b5oWwu1TNwxu4y9ulln51YPz/7F1QfwfG/W
 GXGCyQ1oiP8Ul4arSyfNU5nkcWVIUmwf2T71/hFb9UCKOrIR0w/Xj4Iu1GArYqlQs9hp2PC6yNK
 cSal3EVap8BAnXXjkd6NSbPHjwh6E2Mg=
X-Received: by 2002:aca:e044:: with SMTP id x65mr843991oig.56.1592249577052;
 Mon, 15 Jun 2020 12:32:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4nrQo1jUksz/xo9siwSQG9fxsSbLx+EL7g5v4XSCD70y8FydYVvRBYa0SpYJc63MgtegTo3WndY0AmjZElXY=
X-Received: by 2002:aca:e044:: with SMTP id x65mr843965oig.56.1592249576645;
 Mon, 15 Jun 2020 12:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200613170826.354270-1-nsoffer@redhat.com>
In-Reply-To: <20200613170826.354270-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 15 Jun 2020 22:32:40 +0300
Message-ID: <CAMRbyyswkaedF0dN2nPb3H8fj5+pmhLWh9GHGor4wUk_Su=b8A@mail.gmail.com>
Subject: Re: [PATCH] block: file-posix: Fail unmap with NO_FALLBACK on block
 device
To: nirsof <nirsof@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 13, 2020 at 8:08 PM Nir Soffer <nirsof@gmail.com> wrote:
>
> Punching holes on block device uses blkdev_issue_zeroout() with
> BLKDEV_ZERO_NOFALLBACK but there is no guarantee that this is fast
> enough for pre-zeroing an entire device.
>
> Zeroing block device can be slow as writing zeroes or 100 times faster,
> depending on the storage. There is no way to tell if zeroing it fast
> enough.  The kernel BLKDEV_ZERO_NOFALLBACK flag does not mean that the
> operation is fast; it just means that the kernel will not fall back to
> manual zeroing.
>
> Here is an example converting 10g image with 8g of data to block device:
>
> $ ./qemu-img info test.img
> image: test.img
> file format: raw
> virtual size: 10 GiB (10737418240 bytes)
> disk size: 8 GiB
>
> $ time ./qemu-img convert -f raw -O raw -t none -T none -W test.img /dev/test/lv1
>
> Before:
>
> real    1m20.483s
> user    0m0.490s
> sys     0m0.739s
>
> After:
>
> real    0m55.831s
> user    0m0.610s
> sys     0m0.956s

I did more testing with real server and storage, and the results confirm
what I reported here in my vm based environment and poor storage.


Testing this LUN:

# multipath -ll
3600a098038304437415d4b6a59684a52 dm-3 NETAPP,LUN C-Mode
size=5.0T features='3 queue_if_no_path pg_init_retries 50'
hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=50 status=active
| |- 18:0:0:0 sdb     8:16  active ready running
| `- 19:0:0:0 sdc     8:32  active ready running
`-+- policy='service-time 0' prio=10 status=enabled
  |- 20:0:0:0 sdd     8:48  active ready running
  `- 21:0:0:0 sde     8:64  active ready running


The destination is 100g logical volume on this LUN:

# qemu-img info test-lv
image: test-lv
file format: raw
virtual size: 100 GiB (107374182400 bytes)
disk size: 0 B


The source image is 100g image with 48g of data:

# qemu-img info fedora-31-100g-50p.raw
image: fedora-31-100g-50p.raw
file format: raw
virtual size: 100 GiB (107374182400 bytes)
disk size: 48.4 GiB


We can zero 2.3 g/s:

# time blkdiscard -z test-lv

real 0m43.902s
user 0m0.002s
sys 0m0.130s

(I should really test with fallocate instead of blkdiscard, but the results look
the same.)

# iostat -xdm dm-3 5

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util

dm-3            20.80  301.40      0.98   2323.31     0.00     0.00
0.00   0.00   26.56  854.50 257.94    48.23  7893.41   0.73  23.58

dm-3            15.20  297.20      0.80   2321.67     0.00     0.00
0.00   0.00   26.43  836.06 248.72    53.80  7999.30   0.78  24.22


We can write 445m/s:

# dd if=/dev/zero bs=2M count=51200 of=test-lv oflag=direct conv=fsync
107374182400 bytes (107 GB, 100 GiB) copied, 241.257 s, 445 MB/s

# iostat -xdm dm-3 5

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util

dm-3             6.60 6910.00      0.39    431.85     0.00     0.00
0.00   0.00    2.48    2.70  15.19    60.73    64.00   0.14  98.84

dm-3            40.80 6682.60      1.59    417.61     0.00     0.00
0.00   0.00    1.71    2.73  14.92    40.00    63.99   0.15  97.60

dm-3             6.60 6887.40      0.39    430.46     0.00     0.00
0.00   0.00    2.15    2.66  14.92    60.73    64.00   0.14  98.22


Testing latest qemu-img:

# rpm -q qemu-img
qemu-img-4.2.0-22.module+el8.2.1+6758+cb8d64c2.x86_64

# time qemu-img convert -p -f raw -O raw -t none -W
fedora-31-100g-50p.raw test-lv
    (100.00/100%)

real 2m2.337s
user 0m2.708s
sys 0m17.326s

# iostat -xdm dm-3 5

pre zero phase:

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util

dm-3            24.00  265.40      1.00   2123.20     0.00     0.00
0.00   0.00   36.81  543.52 144.99    42.48  8192.00   0.70  20.14

dm-3             9.60  283.60      0.59   2265.60     0.00     0.00
0.00   0.00   35.42  576.80 163.78    62.50  8180.44   0.70  20.58

dm-3            24.00  272.00      1.00   2176.00     0.00     0.00
0.00   0.00   22.89  512.40 139.77    42.48  8192.00   0.67  19.90

copy phase:

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util

dm-3            27.20 10671.20      1.19    655.84     0.00     0.00
0.00   0.00    2.70   10.99 111.98    44.83    62.93   0.09  96.74

dm-3             6.40 11537.00      0.39    712.33     0.00     0.00
0.00   0.00    3.00   11.90 131.52    62.50    63.23   0.08  97.82

dm-3            27.20 12400.20      1.19    765.47     0.00     0.00
0.00   0.00    3.60   11.16 132.31    44.83    63.21   0.08  95.50

dm-3             9.60 11312.60      0.59    698.20     0.00     0.20
0.00   0.00    3.73   11.69 126.64    63.00    63.20   0.09  97.70


Testing latest qemu-img + this patch:

# rpm -q qemu-img
qemu-img-4.2.0-25.module+el8.2.1+6815+1c792dc8.nsoffer202006140516.x86_64

# time qemu-img convert -p -f raw -O raw -t none -W
fedora-31-100g-50p.raw test-lv
    (100.00/100%)

real 1m42.083s
user 0m3.007s
sys 0m18.735s

# iostat -xdm dm-3 5

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util

dm-3             6.60 7919.60      0.39   1136.67     0.00     0.00
0.00   0.00   14.70   15.32 117.43    60.73   146.97   0.10  77.84

dm-3            27.00 9065.00      1.19    571.38     0.00     0.20
0.00   0.00    2.52   14.64 128.21    45.13    64.54   0.11  97.46

dm-3             6.80 9467.40      0.40    814.75     0.00     0.00
0.00   0.00    2.74   12.15 110.25    60.82    88.12   0.10  90.46

dm-3            29.00 7713.20      1.32    996.48     0.00     0.40
0.00   0.01    5.40   14.48 107.98    46.60   132.29   0.11  83.76

dm-3            11.60 9661.60      0.70    703.54     0.00     0.40
0.00   0.00    2.26   11.22 103.56    61.72    74.57   0.10  97.98

dm-3            23.80 9639.20      0.99    696.82     0.00     0.00
0.00   0.00    1.98   11.54 106.49    42.80    74.03   0.10  93.68

dm-3            10.00 7184.60      0.60   1147.56     0.00     0.00
0.00   0.00   12.84   15.32 106.58    61.36   163.56   0.09  68.30

dm-3            35.00 6771.40      1.69   1293.37     0.00     0.00
0.00   0.00   17.44   18.06 119.48    49.58   195.59   0.10  66.46




>
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 3ab8f5a0fa..cd2e409184 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1621,6 +1621,16 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>      /* First try to write zeros and unmap at the same time */
>
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +    /*
> +     * The block device fallocate() implementation in the kernel does set
> +     * BLKDEV_ZERO_NOFALLBACK, but it does not guarantee that the operation is
> +     * fast so we can't call this if we have to avoid slow fallbacks.
> +     */
> +    if (aiocb->aio_type & QEMU_AIO_BLKDEV &&
> +        aiocb->aio_type & QEMU_AIO_NO_FALLBACK) {
> +        return -ENOTSUP;
> +    }
> +
>      int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                             aiocb->aio_offset, aiocb->aio_nbytes);
>      if (ret != -ENOTSUP) {
> --
> 2.25.4
>


