Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CEC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639022173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1AhVJQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639022173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42CU-0003Ge-HR
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j42Bm-0002kX-Em
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j42Bl-0000Fl-1W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:41:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j42Bk-0000FF-PF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zW4NSoi5gjgysU1oQwv6LsHcZfbRywwyVGL7muJFvBM=;
 b=Z1AhVJQAmyB5Qy7kdMUobhpUC2y6wTobab3P3aTU/3ignsWgoS6n/U7/jNKhU6cyDYlVtT
 4rYq+jB7+Yc2ur/OguPcZuid5iYkN0ztKiPmyW25nmHJG0K/3tyt0V7UV7j9/PEQCYfUiA
 eQHWr3TarjWfj2LvJKnnZaaCbU4XrCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-dhDdJl1QMuiiRl-x4yo0WA-1; Tue, 18 Feb 2020 07:41:16 -0500
Received: by mail-wm1-f71.google.com with SMTP id f66so1052905wmf.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 04:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G8QacokMAz6qPJRkMBDLXByiVc2NNbN3hP4O35y+c6o=;
 b=j43v0lxT33aTmd4XVMpjGIqYcCXzdK+iJqb5KjLWxU5CfBCsc2qNlhn2DBb3D+uWc0
 TIrJvuDkWGN6WTlRgTd6Fzs4pR/SD4X6vUyFw0obch4wwhq8skd1dV2AqvS5b0YJ3Qvc
 MAHphjmYztv5uf0lEOTRGbKeOvKCEqpzAKky0bkousI1qby3vQMMDtCZMbZmYUbqHnmm
 TZpHntf3KPrWgN7KyEkHb4zEEkbyzdtBbyt2L+lmcUGtNh0DwYWGaVHOSWZwKgJRqABq
 oCbtG1yWyRyCZK8CpqJp+qfv1zldYo30GgEa61uhTnyF18Q9zX6u5Hy2WzXaVO1MQU/G
 +9YQ==
X-Gm-Message-State: APjAAAXPfQnvp/z3zukoUnhG19hKKN+Nn9ObQsAmcjEUpOaPXVsMsfmv
 FwpwYdluX0yUQLPg9KX2YCvkrRMeJkGREY9efHnecJUcv9prWaJLH8o/Qm7LYEv2j+YGxpDEqNk
 ivBw3ruYMDzylsWM=
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr28392215wrx.336.1582029674947; 
 Tue, 18 Feb 2020 04:41:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0hm8SAgkLQ02oCHKeTRCRTmtKRjlRz9ycIQsBzjKfwws9srN3lwMsMW9rg6bqhWazbnYgDg==
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr28392200wrx.336.1582029674706; 
 Tue, 18 Feb 2020 04:41:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x11sm3277281wmg.46.2020.02.18.04.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 04:41:13 -0800 (PST)
Subject: Re: [PATCH] migration/block: rename BLOCK_SIZE macro
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200218110209.800294-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <69b0672d-7bf1-e2ba-24a4-575a61dd5937@redhat.com>
Date: Tue, 18 Feb 2020 13:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218110209.800294-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: dhDdJl1QMuiiRl-x4yo0WA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 12:02 PM, Stefan Hajnoczi wrote:
> Both <linux/fs.h> and <sys/mount.h> define BLOCK_SIZE macros.  Avoiding
> using that name in block/migration.c.
>=20
> I noticed this when including <liburing.h> (Linux io_uring) from
> "block/aio.h" and compilation failed.  Although patches adding that
> include haven't been sent yet, it makes sense to rename the macro now in
> case someone else stumbles on it in the meantime.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   migration/block.c | 39 ++++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index c90288ed29..737b6499f9 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -27,8 +27,8 @@
>   #include "migration/vmstate.h"
>   #include "sysemu/block-backend.h"
>  =20
> -#define BLOCK_SIZE                       (1 << 20)
> -#define BDRV_SECTORS_PER_DIRTY_CHUNK     (BLOCK_SIZE >> BDRV_SECTOR_BITS=
)
> +#define BLK_MIG_BLOCK_SIZE           (1 << 20)
> +#define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_=
BITS)
>  =20
>   #define BLK_MIG_FLAG_DEVICE_BLOCK       0x01
>   #define BLK_MIG_FLAG_EOS                0x02
> @@ -133,7 +133,7 @@ static void blk_send(QEMUFile *f, BlkMigBlock * blk)
>       uint64_t flags =3D BLK_MIG_FLAG_DEVICE_BLOCK;
>  =20
>       if (block_mig_state.zero_blocks &&
> -        buffer_is_zero(blk->buf, BLOCK_SIZE)) {
> +        buffer_is_zero(blk->buf, BLK_MIG_BLOCK_SIZE)) {
>           flags |=3D BLK_MIG_FLAG_ZERO_BLOCK;
>       }
>  =20
> @@ -154,7 +154,7 @@ static void blk_send(QEMUFile *f, BlkMigBlock * blk)
>           return;
>       }
>  =20
> -    qemu_put_buffer(f, blk->buf, BLOCK_SIZE);
> +    qemu_put_buffer(f, blk->buf, BLK_MIG_BLOCK_SIZE);
>   }
>  =20
>   int blk_mig_active(void)
> @@ -309,7 +309,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDe=
vState *bmds)
>       }
>  =20
>       blk =3D g_new(BlkMigBlock, 1);
> -    blk->buf =3D g_malloc(BLOCK_SIZE);
> +    blk->buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
>       blk->bmds =3D bmds;
>       blk->sector =3D cur_sector;
>       blk->nr_sectors =3D nr_sectors;
> @@ -350,7 +350,8 @@ static int set_dirty_tracking(void)
>  =20
>       QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
>           bmds->dirty_bitmap =3D bdrv_create_dirty_bitmap(blk_bs(bmds->bl=
k),
> -                                                      BLOCK_SIZE, NULL, =
NULL);
> +                                                      BLK_MIG_BLOCK_SIZE=
,
> +                                                      NULL, NULL);
>           if (!bmds->dirty_bitmap) {
>               ret =3D -errno;
>               goto fail;
> @@ -548,7 +549,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigD=
evState *bmds,
>               bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
>  =20
>               blk =3D g_new(BlkMigBlock, 1);
> -            blk->buf =3D g_malloc(BLOCK_SIZE);
> +            blk->buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
>               blk->bmds =3D bmds;
>               blk->sector =3D sector;
>               blk->nr_sectors =3D nr_sectors;
> @@ -770,7 +771,7 @@ static int block_save_iterate(QEMUFile *f, void *opaq=
ue)
>  =20
>       /* control the rate of transfer */
>       blk_mig_lock();
> -    while (block_mig_state.read_done * BLOCK_SIZE <
> +    while (block_mig_state.read_done * BLK_MIG_BLOCK_SIZE <
>              qemu_file_get_rate_limit(f) &&
>              block_mig_state.submitted < MAX_PARALLEL_IO &&
>              (block_mig_state.submitted + block_mig_state.read_done) <
> @@ -874,13 +875,13 @@ static void block_save_pending(QEMUFile *f, void *o=
paque, uint64_t max_size,
>       qemu_mutex_unlock_iothread();
>  =20
>       blk_mig_lock();
> -    pending +=3D block_mig_state.submitted * BLOCK_SIZE +
> -               block_mig_state.read_done * BLOCK_SIZE;
> +    pending +=3D block_mig_state.submitted * BLK_MIG_BLOCK_SIZE +
> +               block_mig_state.read_done * BLK_MIG_BLOCK_SIZE;
>       blk_mig_unlock();
>  =20
>       /* Report at least one block pending during bulk phase */
>       if (pending <=3D max_size && !block_mig_state.bulk_completed) {
> -        pending =3D max_size + BLOCK_SIZE;
> +        pending =3D max_size + BLK_MIG_BLOCK_SIZE;
>       }
>  =20
>       DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
> @@ -901,7 +902,7 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
>       int nr_sectors;
>       int ret;
>       BlockDriverInfo bdi;
> -    int cluster_size =3D BLOCK_SIZE;
> +    int cluster_size =3D BLK_MIG_BLOCK_SIZE;
>  =20
>       do {
>           addr =3D qemu_get_be64(f);
> @@ -939,11 +940,11 @@ static int block_load(QEMUFile *f, void *opaque, in=
t version_id)
>  =20
>                   ret =3D bdrv_get_info(blk_bs(blk), &bdi);
>                   if (ret =3D=3D 0 && bdi.cluster_size > 0 &&
> -                    bdi.cluster_size <=3D BLOCK_SIZE &&
> -                    BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
> +                    bdi.cluster_size <=3D BLK_MIG_BLOCK_SIZE &&
> +                    BLK_MIG_BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
>                       cluster_size =3D bdi.cluster_size;
>                   } else {
> -                    cluster_size =3D BLOCK_SIZE;
> +                    cluster_size =3D BLK_MIG_BLOCK_SIZE;
>                   }
>               }
>  =20
> @@ -962,14 +963,14 @@ static int block_load(QEMUFile *f, void *opaque, in=
t version_id)
>                   int64_t cur_addr;
>                   uint8_t *cur_buf;
>  =20
> -                buf =3D g_malloc(BLOCK_SIZE);
> -                qemu_get_buffer(f, buf, BLOCK_SIZE);
> -                for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
> +                buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
> +                qemu_get_buffer(f, buf, BLK_MIG_BLOCK_SIZE);
> +                for (i =3D 0; i < BLK_MIG_BLOCK_SIZE / cluster_size; i++=
) {
>                       cur_addr =3D addr * BDRV_SECTOR_SIZE + i * cluster_=
size;
>                       cur_buf =3D buf + i * cluster_size;
>  =20
>                       if ((!block_mig_state.zero_blocks ||
> -                        cluster_size < BLOCK_SIZE) &&
> +                        cluster_size < BLK_MIG_BLOCK_SIZE) &&
>                           buffer_is_zero(cur_buf, cluster_size)) {
>                           ret =3D blk_pwrite_zeroes(blk, cur_addr,
>                                                   cluster_size,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


