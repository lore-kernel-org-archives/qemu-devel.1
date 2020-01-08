Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F12C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF1D2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS4oaKL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF1D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipH6m-0002FW-1Z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 14:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ipH5q-0001jW-6s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ipH5o-0003SG-6B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:34:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ipH5n-0003QJ-Vx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578512050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bQFTfHgg5vqEn5hyWoVIVGSP8NH3IK9huE+y09X5tg=;
 b=FS4oaKL4tEMt+0TMj1ewD+vu7Md5aqBn8QsNBbnWjJ0M0j1R8BRg0PdeWrR0A5YvYLserX
 gId3Aauqb4iFmKWITj2E/sq6yPePSbRSnrYEyP0mnGLN2VpgWUUlGiLdGNjtVjfbgXJ8M1
 yVWd3/tUWXbFYBp4xxBosTBOA17TiP4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-H-dmZtg_OtafX_NwUhwEuQ-1; Wed, 08 Jan 2020 14:34:09 -0500
Received: by mail-ot1-f71.google.com with SMTP id v7so2266483otr.14
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 11:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qrMO107Ard/3oeRYxhHZ8HuxeMHP+qJysFjJW2gpRmc=;
 b=EUqxQOkixj3+JUIYAq7rJBp0KB2BebnDg0kT/uPPhP6e+dHTxSenBMphjYSm141IjP
 u6w3c8ohvbIJPjeefAHMQUrVOkXuJ6L6Fqoztc6deThbVonEYrJZwf9TMT0Mvls2HZNW
 t9F4oIwTqCy0plGydQ3lQvM0wr8EusSAP38wSgpYdcg50zfOsVd+GlcQFE+sx/hdQArv
 scGwPSEhBGfvbZaAYsEv/eIt2Vs0qitkFvyc9h7QxyoeumDpK6W6a5o3HqXqkFOsvSE2
 g3jrEKpu1L0OGiWmDxROrj/X6nEd6cymwzncIoXKxwtVwExA69jQeGxq6kh1fd+i6Z+C
 XFqw==
X-Gm-Message-State: APjAAAX3cRn37SnFP6BCZYsQoA63yJMNyKv3bwdlmzrGXKBVFX3JVTNK
 hmzIFFrb8XupAPAHDFFutmRTXPSnHlVNMbw6iLsO3vpOiEeUZq/Z7paIui26VMbQ9o6JyuAL0np
 TBdcs8SJ/2zRjVI5FU9zKqRnbnyeHwdc=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr5271760otg.132.1578512048227; 
 Wed, 08 Jan 2020 11:34:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPjYe7AQJ9qnlRzsPvw7JLrUP2GZE7fgCHtpsZ9CZ7m+Fok/zZHPyIVtBC3vzVF9xqvy5sEFL03h7m7HQm8U4=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr5271749otg.132.1578512047848; 
 Wed, 08 Jan 2020 11:34:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578505678.git.berto@igalia.com>
 <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
In-Reply-To: <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 8 Jan 2020 21:33:51 +0200
Message-ID: <CAMRbyyvpPWekM37XtzqUPA-3GZsk1bkEVbFX7qcs1TrpHA9JPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
To: Alberto Garcia <berto@igalia.com>
X-MC-Unique: H-dmZtg_OtafX_NwUhwEuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Wed, Jan 8, 2020 at 7:50 PM Alberto Garcia <berto@igalia.com> wrote:
>
> This replaces all remaining instances in the qcow2 code.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c |  2 +-
>  block/qcow2.c         | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 932fc48919..777ca2d409 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t off=
set,
>   * Writes one sector of the L1 table to the disk (can't update single en=
tries
>   * and we really don't want bdrv_pread to perform a read-modify-write)
>   */
> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index e8ce966f7f..6427c75409 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2175,7 +2175,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockD=
riverState *bs,
>                                            offset, bytes, qiov, qiov_offs=
et);
>
>      case QCOW2_CLUSTER_NORMAL:
> -        if ((file_cluster_offset & 511) !=3D 0) {
> +        if ((file_cluster_offset % BDRV_SECTOR_SIZE) !=3D 0) {

All the alignment checks should use QEMU_IS_ALIGNED.

>              return -EIO;
>          }
>
> @@ -2514,7 +2514,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
>              goto out_locked;
>          }
>
> -        assert((cluster_offset & 511) =3D=3D 0);
> +        assert((cluster_offset % BDRV_SECTOR_SIZE) =3D=3D 0);
>
>          ret =3D qcow2_pre_write_overlap_check(bs, 0,
>                                              cluster_offset + offset_in_c=
luster,
> @@ -3283,7 +3283,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>
>      /* Validate options and set default values */
>      if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
> -        error_setg(errp, "Image size must be a multiple of 512 bytes");
> +        error_setg(errp, "Image size must be a multiple of %u bytes",
> +                   (unsigned) BDRV_SECTOR_SIZE);
>          ret =3D -EINVAL;
>          goto out;
>      }
> @@ -3839,7 +3840,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>          case QCOW2_CLUSTER_NORMAL:
>              child =3D s->data_file;
>              copy_offset +=3D offset_into_cluster(s, src_offset);
> -            if ((copy_offset & 511) !=3D 0) {
> +            if ((copy_offset % BDRV_SECTOR_SIZE) !=3D 0) {
>                  ret =3D -EIO;
>                  goto out;
>              }
> @@ -3904,7 +3905,7 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
>              goto fail;
>          }
>
> -        assert((cluster_offset & 511) =3D=3D 0);
> +        assert((cluster_offset % BDRV_SECTOR_SIZE) =3D=3D 0);
>
>          ret =3D qcow2_pre_write_overlap_check(bs, 0,
>                  cluster_offset + offset_in_cluster, cur_bytes, true);
> @@ -3961,8 +3962,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
>          return -ENOTSUP;
>      }
>
> -    if (offset & 511) {
> -        error_setg(errp, "The new size must be a multiple of 512");
> +    if (offset % BDRV_SECTOR_SIZE) {
> +        error_setg(errp, "The new size must be a multiple of %u",
> +                   (unsigned) BDRV_SECTOR_SIZE);
>          return -EINVAL;
>      }
>
> --
> 2.20.1

Otherwise looks good.

Nir


