Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997D9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1482068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTTFMEp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1482068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4KK-0002Oo-Ow
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4Jc-0001Nr-TJ; Mon, 13 Jul 2020 15:40:40 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4Jb-0001dQ-6e; Mon, 13 Jul 2020 15:40:40 -0400
Received: by mail-il1-x144.google.com with SMTP id h16so12203669ilj.11;
 Mon, 13 Jul 2020 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gkOqEUAksNhplG/qc3Bzoug/mE+3G1sJIiNH22fglYM=;
 b=UTTFMEp3yvZmK/dyaOf4UjBZyAKSOTWZN0cgu58h3zqGXEG5Xl+SiA6fwYO7z2oLPb
 yF2yG/v/aLQoWT7ImiJafJHE05R7i9FvwRtMainwwM/hTmDNemuKjow0Xxtacdj/JkW4
 BY4xZdxn6k4Adu5Lvl5WEX+VefwHFbh6X30H+CDJqhlY9sJBs7YZz4t5kqvkY6UqN13G
 cramvLuvY5lUcnPEPWM2g7K+2s8pTfuyeec/w0utFL0v8URWlR04RTNh/ETu6RbFdqFF
 ixP6wcKnzQ6FzbN8AWQmtqQ4Lp8+lAXLeUtdnqN6UyOU0+bQbIQi4EBIKIHGHeMIiQXh
 xhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gkOqEUAksNhplG/qc3Bzoug/mE+3G1sJIiNH22fglYM=;
 b=G/XGr9CFx9nCXJ09dHCDw2Zlw8GFAXKXlsisHqy9VVdzkbg9K3bQBD4b7t7xd9SVPM
 ByaJCoCuZlKPXi0b8/Vic7+7/G6h1fJoN8405/sF5XTQ7a6Z6LAvmLFbOEYQt2OSHuhT
 AwgxcHGU2Bezxc9ySWpmoYmc1nTJgbS3D/YkzFE6tu/IsVTQCSqWSIULgTxMLvpCB6iD
 j2LQqvQZ2hPHCVo7gRv7Nr+Nz9v7Lto1hNz1TTbSOEeKJYdcLdrRheyHfiymIGXYmQF4
 ipw7uUR6sOMTZjhPDsdbSRNoSYwfwQLP+ZWWs8iuO4Ng1m3eGh1x9T8TYhBOfrMvWbgK
 X4nw==
X-Gm-Message-State: AOAM530n7xJD7+xOacI53LDU72+r6+G5P+qanQxNesrKAyG7Wl7rCw7T
 bmZQ+fxLL0Ie0N5c1wERVTLQTevo7ppg8KVvYyA=
X-Google-Smtp-Source: ABdhPJxYH8LmkHJUSplyiTH6hz2PjZBhGhAbSrv5ZkQVJIxlty7AH3sgDi4KF1r1Klse1fvH9U8mibdkgoYGMmomb8w=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr1389417ilj.131.1594669237937; 
 Mon, 13 Jul 2020 12:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-8-f4bug@amsat.org>
In-Reply-To: <20200713183209.26308-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 12:30:39 -0700
Message-ID: <CAKmqyKN6M=FnXbQzbuLzAPwJXqid2L=0u6r_LrwhfoomKp6OTA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 11:33 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> QEMU allows to create SD card with unrealistic sizes. This could
> work, but some guests (at least Linux) consider sizes that are not
> a power of 2 as a firmware bug and fix the card size to the next
> power of 2.
>
> While the possibility to use small SD card images has been seen as
> a feature, it became a bug with CVE-2020-13253, where the guest is
> able to do OOB read/write accesses past the image size end.
>
> In a pair of commits we will fix CVE-2020-13253 as:
>
>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     occurred and no data transfer is performed.
>
>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     occurred and no data transfer is performed.
>
>     WP_VIOLATION errors are not modified: the error bit is set, we
>     stay in receive-data state, wait for a stop command. All further
>     data transfer is ignored. See the check on sd->card_status at the
>     beginning of sd_read_data() and sd_write_data().
>
> While this is the correct behavior, in case QEMU create smaller SD
> cards, guests still try to access past the image size end, and QEMU
> considers this is an invalid address, thus "all further data transfer
> is ignored". This is wrong and make the guest looping until
> eventually timeouts.
>
> Fix by not allowing invalid SD card sizes (suggesting the expected
> size as a hint):
>
>   $ qemu-system-arm -M orangepi-pc -drive file=3Drootfs.ext2,if=3Dsd,form=
at=3Draw
>   qemu-system-arm: Invalid SD card size: 60 MiB
>   SD card size has to be a power of 2, e.g. 64 MiB.
>   You can resize disk images with 'qemu-img resize <imagefile> <new-size>=
'
>   (note that this will lose data if you make the image smaller than it cu=
rrently is).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Since v1:
>   Addressed Alistair & Peter comments (error_append_hint message)
> ---
>  hw/sd/sd.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index edd60a09c0..5ab945dade 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -32,6 +32,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/cutils.h"
>  #include "hw/irq.h"
>  #include "hw/registerfields.h"
>  #include "sysemu/block-backend.h"
> @@ -2106,11 +2107,35 @@ static void sd_realize(DeviceState *dev, Error **=
errp)
>      }
>
>      if (sd->blk) {
> +        int64_t blk_size;
> +
>          if (blk_is_read_only(sd->blk)) {
>              error_setg(errp, "Cannot use read-only drive as SD card");
>              return;
>          }
>
> +        blk_size =3D blk_getlength(sd->blk);
> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> +            char *blk_size_str;
> +
> +            blk_size_str =3D size_to_str(blk_size);
> +            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> +            g_free(blk_size_str);
> +
> +            blk_size_str =3D size_to_str(blk_size_aligned);
> +            error_append_hint(errp,
> +                              "SD card size has to be a power of 2, e.g.=
 %s.\n"
> +                              "You can resize disk images with "
> +                              "'qemu-img resize <imagefile> <new-size>'\=
n"
> +                              "(note that this will lose data if you mak=
e the "
> +                              "image smaller than it currently is).\n",
> +                              blk_size_str);
> +            g_free(blk_size_str);
> +
> +            return;
> +        }
> +
>          ret =3D blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PER=
M_WRITE,
>                             BLK_PERM_ALL, errp);
>          if (ret < 0) {
> --
> 2.21.3
>
>

