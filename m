Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B94DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C985C20882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXthO5+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C985C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMh6M-0001ds-3J
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMh5I-000164-CP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMh5H-0001jM-6a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:27:32 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMh5G-0001j2-Vh; Mon, 21 Oct 2019 19:27:31 -0400
Received: by mail-lj1-x244.google.com with SMTP id m7so15156980lji.2;
 Mon, 21 Oct 2019 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xDVnpCw12NPl8Yg69y0FQgbfDnbxu2t1uwrVMr+Nmo0=;
 b=MXthO5+lFbbSJmbn7ZiO4pw8oDBeqj0u8hujz85p4mTVe10FdhHvlKsAY788YDN4lp
 iQjXVtwabgsD4CPX+EAcTBQJ4tHWT+4B6y+rk0rpJyppI5WieVKFCtozrB5bv3RrK4Fe
 muLI8Lm35jikokmXTjzGFCsIBMu35Kf75fj/M6yycuysEfpPg4YxivQ+5tFPPjYvRELi
 6yvl1GnVy8sfLWy1eVLlRF+G9SjgV+OHvM/gpHonMTQrBvaKDTMffYhl086Xmt/Q1ykK
 g6wU9lChgLuoO3U1dqnxvbiqmL9Bjz8NK4Oq03wAmmn/3U5g83Q7QBGkf2Hf7qs6ET24
 vp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xDVnpCw12NPl8Yg69y0FQgbfDnbxu2t1uwrVMr+Nmo0=;
 b=dssblM1MKivgAgDEAQPtWwgELqvCf1YoUIZ9TjwVwKwXljhCBepXiTWJFZpaOpBW3J
 kmf5AMKRwGAsOATBtj5HZvwD5V3pxhFPtngYLPrL5n1yurgree65YKzCK2bZ624MM2ZD
 j5rjb4pIQHY3MQba1Dv4+sEtVg57FQ13PKCWt5B9XaEds3gEU+2YTmAx0TsrkJwsdC7g
 1/4HfwpGq5OFIKFzDC63uGwV9N46ZuF3Fp41aDH0Vm8aQlx6gQhTKL2lZKqOZwgo+FMK
 EEjhPAQGVkaKeiXLDxW1EfTvIUOV1BgDUpdsQNPoXYVV0KCCNvoVZ1erdnX4H/Qet9vx
 //jA==
X-Gm-Message-State: APjAAAUiQarvIDYAP0mRG89SuFCFTw2q5smv68bZuvblDuUDqw8Iuz4D
 jGiTRVvaOFbJYd4i62elM0TQkmsVGASc2wBB/5Y=
X-Google-Smtp-Source: APXvYqzWeZqah5Hwn8U2ftZQ80HJtThFICAswr1bKSwXBkEsMhmnpLh0rAfPeP0Q4QnwWSMHSCuoR4DH+vakpDnD9DM=
X-Received: by 2002:a2e:9604:: with SMTP id v4mr17035928ljh.101.1571700449336; 
 Mon, 21 Oct 2019 16:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-11-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-11-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:22:13 -0700
Message-ID: <CAKmqyKPAv+QQEr-pbmThDEmXXwwOaF4E7TeovOWhNW5ok2J_uQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] hw/arm/raspi: Use AddressSpace when using
 arm_boot::write_secondary_boot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:56 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> write_secondary_boot() is used in SMP configurations where the
> CPU address space might not be the main System Bus.
> The rom_add_blob_fixed_as() function allow us to specify an
> address space. Use it to write each boot blob in the corresponding
> CPU address space.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/raspi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index a12459bc41..569d85c11a 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -60,12 +60,14 @@ static void write_smpboot(ARMCPU *cpu, const struct a=
rm_boot_info *info)
>      QEMU_BUILD_BUG_ON((BOARDSETUP_ADDR & 0xf) !=3D 0
>                        || (BOARDSETUP_ADDR >> 4) >=3D 0x100);
>
> -    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
> -                       info->smp_loader_start);
> +    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
> +                          info->smp_loader_start,
> +                          arm_boot_address_space(cpu, info));
>  }
>
>  static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *inf=
o)
>  {
> +    AddressSpace *as =3D arm_boot_address_space(cpu, info);
>      /* Unlike the AArch32 version we don't need to call the board setup =
hook.
>       * The mechanism for doing the spin-table is also entirely different=
.
>       * We must have four 64-bit fields at absolute addresses
> @@ -92,10 +94,10 @@ static void write_smpboot64(ARMCPU *cpu, const struct=
 arm_boot_info *info)
>          0, 0, 0, 0
>      };
>
> -    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
> -                       info->smp_loader_start);
> -    rom_add_blob_fixed("raspi_spintables", spintables, sizeof(spintables=
),
> -                       SPINTABLE_ADDR);
> +    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
> +                          info->smp_loader_start, as);
> +    rom_add_blob_fixed_as("raspi_spintables", spintables, sizeof(spintab=
les),
> +                          SPINTABLE_ADDR, as);
>  }
>
>  static void write_board_setup(ARMCPU *cpu, const struct arm_boot_info *i=
nfo)
> --
> 2.21.0
>
>

