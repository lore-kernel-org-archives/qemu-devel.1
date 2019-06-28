Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7506520645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpYIqkf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7506520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguEu-0001eE-NH
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtqb-0008TP-Qf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtqZ-0004eC-4o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:35:37 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtqY-0004dI-GY; Fri, 28 Jun 2019 12:35:34 -0400
Received: by mail-lf1-x144.google.com with SMTP id z15so4347818lfh.13;
 Fri, 28 Jun 2019 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D+wXCB66jnKZG2cMBBezUE1NCkDNQf8ea/KR76ELM5I=;
 b=QpYIqkf5rJsSAgt4es9MjgCbyFUgMpdHXYZ2i16NCYYg2fEAofWdG0cEgbzyz4TGvh
 eXkgHVyPDwaDMtPuQyQ2d71il6LLJ3+0XblQKrEGQsf+v/mMGs9pYBBrSNDas6TNZWZD
 MTYz/Gi/T2Bov99bLr/y1wAA9QXwLgs/skKdEjk3AKEUD1gLNrHvDMfKfwSGQycrDrJk
 PlGUr2d9qZbZLEaCWfKHmlzuuaTZTs0gg4PHLxRc+nCmbXy+z/jrCt2y4Cn2XYMdXEY5
 TuRBHN09BYoItIGwSJptglpUA+rLiDtHu2uRxlM/+/2Sp84fAAW2IeQD/fQsSwsF8ZZa
 OE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D+wXCB66jnKZG2cMBBezUE1NCkDNQf8ea/KR76ELM5I=;
 b=OVi9mEwALdzT100AzOP4Z5wXDXMws3qS9KUKgM+RfD6ZDOWUFPl6QelYHSEmpx43mq
 huBy9VpC3Y0V2wngpnPtdhA6lenTb+hujPvRg5FSzgoKCOGtSeL7yQcFr3Ov6WZjPInC
 8pyDoT9L3k6Nf8OgR8BcQLDVHpxOtGNeEqKjmJAkzWFkRunvPBkIcfkW7xies8k7xvuy
 g0P0UWoSx6YxbyufvyXOwBqnZyDJ0VVSRj/3CZ3lkjsbUfW+ZkfNFZljeadUvM2F99iT
 b4+aIKrdpo7+86lsWJw9RsJ4Z9Oox0MRgTh3KixHHpuX00iqAz/LC5aoPGmTCBniz1T0
 wyDA==
X-Gm-Message-State: APjAAAXYqrQFcM3r+bQttR6I2BDFle2fY+cAbmQSsZY+vP9/gRsHgMQr
 5ysWDvPmTz94bWQ6Tk2bJ/UMFANeT5RPgtV5xmw=
X-Google-Smtp-Source: APXvYqwOhYlWm0RID2qAqFdtTeN5oleToKZHH2Dp2KOBCPpyPA22c/3hnw7DgUPsKpYfWe2z78asEHxQfDWhoDh7ljU=
X-Received: by 2002:a05:6512:29a:: with SMTP id
 j26mr5335453lfp.44.1561739733128; 
 Fri, 28 Jun 2019 09:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-15-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-15-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:32:32 -0700
Message-ID: <CAKmqyKOG87K2vZHRsoGtmce6pVsJCW9yrq6WhAiKBsuBPMd4BA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v5 14/28] hw/block/pflash_cfi02: Remove
 pointless local variable
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:59 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We can directly use pfl->total_len, remove the local 'chip_len'
> variable.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 4be3837be5..1a794fa83c 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -409,7 +409,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              /* Chip erase */
>              DPRINTF("%s: start chip erase\n", __func__);
>              if (!pfl->ro) {
> -                memset(pfl->storage, 0xFF, pfl->chip_len);
> +                memset(pfl->storage, 0xff, pfl->chip_len);
>                  pflash_update(pfl, 0, pfl->chip_len);
>              }
>              set_dq7(pfl, 0x00);
> @@ -490,7 +490,6 @@ static const MemoryRegionOps pflash_cfi02_ops =3D {
>  static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  {
>      PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
> -    uint32_t chip_len;
>      int ret;
>      Error *local_err =3D NULL;
>
> @@ -507,18 +506,17 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
>          return;
>      }
>
> -    chip_len =3D pfl->sector_len * pfl->nb_blocs;
> +    pfl->chip_len =3D pfl->sector_len * pfl->nb_blocs;
>
>      memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
>                                    &pflash_cfi02_ops, pfl, pfl->name,
> -                                  chip_len, &local_err);
> +                                  pfl->chip_len, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>
>      pfl->storage =3D memory_region_get_ram_ptr(&pfl->orig_mem);
> -    pfl->chip_len =3D chip_len;
>
>      if (pfl->blk) {
>          uint64_t perm;
> @@ -533,8 +531,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>      }
>
>      if (pfl->blk) {
> -        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, chip_le=
n,
> -                                         errp)) {
> +        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
> +                                         pfl->chip_len, errp)) {
>              vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
>              return;
>          }
> @@ -594,7 +592,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>      /* Max timeout for chip erase */
>      pfl->cfi_table[0x26] =3D 0x0D;
>      /* Device size */
> -    pfl->cfi_table[0x27] =3D ctz32(chip_len);
> +    pfl->cfi_table[0x27] =3D ctz32(pfl->chip_len);
>      /* Flash device interface (8 & 16 bits) */
>      pfl->cfi_table[0x28] =3D 0x02;
>      pfl->cfi_table[0x29] =3D 0x00;
> --
> 2.20.1
>
>

