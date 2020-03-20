Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1217C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B552070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WR3F/Dd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B552070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJsV-0007dh-Rl
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJWy-0008Q4-KW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJWw-0000mS-Uo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFJWw-0000ly-Ml
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:50 -0400
Received: by mail-oi1-x243.google.com with SMTP id w13so6879016oih.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LM0R6c7gyqkVm72hYpNIy/ZiQiEiTK7MEo9RwsbsZao=;
 b=WR3F/Dd5tELX+Gxb99NFCqWWuFwSsjrcwRWuWHHbRDXxoKHRIwdKT6Oz4S2AdeOaZ4
 lDcNJSixvItltFe7uSlQLYEU+3bOdiyekNhGw8EN1wsW1v93spHsXd/yk20I3QX6HKem
 yk4ing6CPb32TNVz4L2baHIkiiq355Mjz5xScDH4+xwv7jqQyWU0fz95UBYGU1PdCiiQ
 SwxSfODydNeraaN97lJJMLOt1IP3sXf8SDJOAHdRLk0kci2x1zCMR1JPZdpzVmOqieNf
 GEqgSD4DwgVuDN3rAWsCRTafVrO/GXfuGxnJlVjOBQkPYKZa/2kALRbzhfZum9/DV+cE
 Eyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LM0R6c7gyqkVm72hYpNIy/ZiQiEiTK7MEo9RwsbsZao=;
 b=SS2/hRONnm2WGGsUZXT2rkz2CuaLqQEgJ0aTYqggmJUK+QFbDkSkXzxzhYV5volFxS
 mkeWJuMwW+do1PmfR0C/wiTXxhEvesheZMyFkhX4bpo44EJpk7rPAcPNfnE/1WlrFexC
 aKgsjoJ/wdXybqoHloJ4uTgfqPUK/Ccm0cLxzJQba+Gx2med+Ym7m+bNN8pNE0t/zNfo
 baD4/Dt2g02caTgxed/nXudj13uszBBcdl1acAmMLJPAktint4RdT6uBCIoCw5P5ZEP8
 2SkIVzDBxixXZLfc/0CBNixLC2DN4c6wgmFE7mRvVoE4Pws3Mclu3SFtXCai/zDrppgv
 H7Eg==
X-Gm-Message-State: ANhLgQ21kljg8RTvWFkzr1EhYBeesERVKuaq9nD1aU/nNW5QzvQYHynM
 rP7bzDffeN3UqdmW33GxgKw6iPuX+L3P76jAFsZb0A==
X-Google-Smtp-Source: ADFU+vs4vcqKxoA1xh5iVh0B7uEGeKa+ZUFiQ51OqMkYAEy2BKdnlM+qnUhKMNSHnCXZqfHcw0LZ/EsrnK3DVsLpybY=
X-Received: by 2002:a05:6808:8f3:: with SMTP id
 d19mr2459679oic.146.1584717949539; 
 Fri, 20 Mar 2020 08:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190311220843.4026-1-armbru@redhat.com>
 <20190311220843.4026-9-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-9-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 15:25:38 +0000
Message-ID: <CAFEAcA_2pgp0yg3hd1TsT+VkMoMDKvvr=Fjz_kmUn0E-Fe6RZw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 08/27] ppc405_boards: Don't size flash memory
 to match backing image
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Mar 2019 at 22:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> Image size is rounded up to the next multiple of 64KiB.  Useless,
> because pflash_cfi02_realize() fails with "failed to read the initial
> flash content" unless the rounding is a no-op.
>
> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> other stuff.  No idea how that would play out, but useful outcomes
> seem unlikely.
>
> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> regardless of image size, to match the physical hardware.
>
> Machine "taihu" maps its boot flash memory similarly.  The code even
> has a comment /* XXX: should check that size is 2MB */, followed by
> disabled code to adjust the size to 2MiB regardless of image size.
>
> Its code to map its application flash memory looks the same, except
> there the XXX comment asks for 32MiB, and the code to adjust the size
> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> to read the initial flash content" for images smaller than 32MiB.
>
> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> to match the physical hardware.  Delete dead code from application
> flash mapping, and simplify some.
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190308094610.21210-9-armbru@redhat.com>
> ---
>  hw/ppc/ppc405_boards.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)

Hi; Coverity has just noticed a minor bug in this patch
(CID 1421917):

> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index bb73d6d848..fe8e3cad12 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -156,7 +156,7 @@ static void ref405ep_init(MachineState *machine)
>      target_ulong kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      int linux_boot;
> -    int fl_idx, fl_sectors, len;
> +    int len;
>      DriveInfo *dinfo;
>      MemoryRegion *sysmem =3D get_system_memory();
>
> @@ -177,20 +177,16 @@ static void ref405ep_init(MachineState *machine)
>                             &error_fatal);
>      memory_region_add_subregion(sysmem, 0xFFF00000, sram);
>      /* allocate and load BIOS */
> -    fl_idx =3D 0;
>  #ifdef USE_FLASH_BIOS
> -    dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> +    dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        fl_sectors =3D (bios_size + 65535) >> 16;
> +        bios_size =3D 8 * MiB;
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                NULL, "ef405ep.bios", bios_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,

This code is inside the "if (dinfo)" condition, so testing again
here whether it is NULL is unnecessary.

> +                              64 * KiB, bios_size / (64 * KiB), 1,
>                                2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> -        fl_idx++;
>      } else
>  #endif
>      {
> @@ -425,7 +421,7 @@ static void taihu_405ep_init(MachineState *machine)
>      target_ulong kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      int linux_boot;
> -    int fl_idx, fl_sectors;
> +    int fl_idx;
>      DriveInfo *dinfo;
>
>      /* RAM is soldered to the board so the size cannot be changed */
> @@ -450,15 +446,11 @@ static void taihu_405ep_init(MachineState *machine)
>  #if defined(USE_FLASH_BIOS)
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        /* XXX: should check that size is 2MB */
> -        //        bios_size =3D 2 * 1024 * 1024;
> -        fl_sectors =3D (bios_size + 65535) >> 16;
> -        pflash_cfi02_register((uint32_t)(-bios_size),
> +        bios_size =3D 2 * MiB;
> +        pflash_cfi02_register(0xFFE00000,
>                                NULL, "taihu_405ep.bios", bios_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,

Same here...

> +                              64 * KiB, bios_size / (64 * KiB), 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
>          fl_idx++;
> @@ -491,14 +483,10 @@ static void taihu_405ep_init(MachineState *machine)
>      /* Register Linux flash */
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        /* XXX: should check that size is 32MB */
>          bios_size =3D 32 * MiB;
> -        fl_sectors =3D (bios_size + 65535) >> 16;
>          pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bio=
s_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,

...and here.

> +                              64 * KiB, bios_size / (64 * KiB), 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
>          fl_idx++;


Anybody feel like sending a patch?

thanks
-- PMM

