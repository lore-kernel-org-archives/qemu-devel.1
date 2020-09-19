Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E3C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 17:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC9C20795
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxzqQoFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC9C20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJgMr-00053O-LT
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 13:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJgL7-00049p-1t
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 13:07:57 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:34135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJgL5-0007WV-5H
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 13:07:56 -0400
Received: by mail-vs1-xe41.google.com with SMTP id y190so5600662vsy.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=18YTLxHNbCR8a0/G2zyogZ28CfKzJIiiTrsyrBDitWc=;
 b=nxzqQoFcKIFKEk+VgYG3GoK5HbBzvukPjvI+eZXDSOVFNo3Zco5wUCEVXS3xSWZ6Rd
 kKS3cOqfl/uNgcPq1/v9ZHbsEuSdwWMg63EKSxHXNs4kjk6wpvPiD1UT4OThF+YzovLC
 +eOtkfETrPLCaiTGx+3XKltUIfYEXdHk2TvpxV7YSRJi8E2xv9NLNEfjASJe/GhoMY+/
 +9KJfw754DEMOKmc8Waf8SfLMY558Y45bnemoK/kh0Cjbo0c6YBAMT1gZ6aCjHc6y8P1
 Y++VltrJgKkiM0tlGiNvAUxGvtI8Ui966czG/El8e7hPXodsZModZ5AAJLI1REziqI4F
 6YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=18YTLxHNbCR8a0/G2zyogZ28CfKzJIiiTrsyrBDitWc=;
 b=J9Uws6DzSnz/RpoTbZKEi8eQXFiM9lxMFE0M4ioddHjRfQiu+zrp9oi+5bY5p/DISd
 UfqrmdR8NIKmz96VZwOUeKE9oCx/Dz6dT6pOLdoKUyzjfSacmwp1XhxRmD1t8QLiJ99x
 al8V6LGByghljVHAqxUNW5Qjz7BxyOg9JOdB4IijWSc2zcEmQQhWxvK73uRB70ln7oiI
 tdlQ24ovNDQ5jf4QEPQy7maegMQz+c28GsFMId9iqjYnbHuBp6MBuoF42ud/VodCK2DI
 e0reAtlT64tK3FvsOjRMSdfr4YnI6oVKsiZLNJD4+3ZeSyfHZaBFg9Bd+3b+SIpGl97V
 zAFw==
X-Gm-Message-State: AOAM533kEn6AG3vvixHLT+p/7Q6TM+5Uf6UuS2a4nCiNIm6n8PsKXumc
 AxzwpK2yyJBJI2CwPwlmpxXLrMWhu2mv9VOl0/Zvjg==
X-Google-Smtp-Source: ABdhPJx4Wv5ftIzX8O2X+boYuFC3YkHPJGkMWGv3iUoENcNnDRL20Bdu7Qg4DlNO7VNnnsQQFwzAuTA1bQp55M6/xOI=
X-Received: by 2002:a05:6102:379:: with SMTP id
 f25mr15578576vsa.47.1600535270762; 
 Sat, 19 Sep 2020 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200919132435.310527-1-f4bug@amsat.org>
In-Reply-To: <20200919132435.310527-1-f4bug@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Sat, 19 Sep 2020 10:07:39 -0700
Message-ID: <CAFQmdRZsS3=CkCZFHSmSqC8HpikqGxBt0uL9NJP2E4AgB6vHSA@mail.gmail.com>
Subject: Re: [PATCH] hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Tyrone Ting <kfting@nuvoton.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 19, 2020 at 6:24 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Fix integer handling issues handling issue reported by Coverity:
>
>   hw/ssi/npcm7xx_fiu.c: 162 in npcm7xx_fiu_flash_read()
>   >>>     CID 1432730:  Integer handling issues  (NEGATIVE_RETURNS)
>   >>>     "npcm7xx_fiu_cs_index(fiu, f)" is passed to a parameter that ca=
nnot be negative.
>   162         npcm7xx_fiu_select(fiu, npcm7xx_fiu_cs_index(fiu, f));
>
>   hw/ssi/npcm7xx_fiu.c: 221 in npcm7xx_fiu_flash_write()
>   218         cs_id =3D npcm7xx_fiu_cs_index(fiu, f);
>   219         trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, =
cs_id, addr,
>   220                                       size, v);
>   >>>     CID 1432729:  Integer handling issues  (NEGATIVE_RETURNS)
>   >>>     "cs_id" is passed to a parameter that cannot be negative.
>   221         npcm7xx_fiu_select(fiu, cs_id);
>
> Since the index of the flash can not be negative, return an
> unsigned type.
>
> Reported-by: Coverity (CID 1432729 & 1432730: NEGATIVE_RETURNS)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>

Thanks!

> ---
>  hw/ssi/npcm7xx_fiu.c | 12 ++++++------
>  hw/ssi/trace-events  |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> index 104e8f2b963..5040132b074 100644
> --- a/hw/ssi/npcm7xx_fiu.c
> +++ b/hw/ssi/npcm7xx_fiu.c
> @@ -103,7 +103,8 @@ enum NPCM7xxFIURegister {
>   * Returns the index of flash in the fiu->flash array. This corresponds =
to the
>   * chip select ID of the flash.
>   */
> -static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu, NPCM7xxFIUFlash *f=
lash)
> +static unsigned npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu,
> +                                     NPCM7xxFIUFlash *flash)
>  {
>      int index =3D flash - fiu->flash;
>
> @@ -113,20 +114,19 @@ static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fi=
u, NPCM7xxFIUFlash *flash)
>  }
>
>  /* Assert the chip select specified in the UMA Control/Status Register. =
*/
> -static void npcm7xx_fiu_select(NPCM7xxFIUState *s, int cs_id)
> +static void npcm7xx_fiu_select(NPCM7xxFIUState *s, unsigned cs_id)
>  {
>      trace_npcm7xx_fiu_select(DEVICE(s)->canonical_path, cs_id);
>
>      if (cs_id < s->cs_count) {
>          qemu_irq_lower(s->cs_lines[cs_id]);
> +        s->active_cs =3D cs_id;
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: UMA to CS%d; this module has only %d chip sel=
ects",
>                        DEVICE(s)->canonical_path, cs_id, s->cs_count);
> -        cs_id =3D -1;
> +        s->active_cs =3D -1;
>      }
> -
> -    s->active_cs =3D cs_id;
>  }
>
>  /* Deassert the currently active chip select. */
> @@ -206,7 +206,7 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwa=
ddr addr, uint64_t v,
>      NPCM7xxFIUFlash *f =3D opaque;
>      NPCM7xxFIUState *fiu =3D f->fiu;
>      uint32_t dwr_cfg;
> -    int cs_id;
> +    unsigned cs_id;
>      int i;
>
>      if (fiu->active_cs !=3D -1) {
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 2f83ef833fb..612d3d6087a 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -19,4 +19,4 @@ npcm7xx_fiu_deselect(const char *id, int cs) "%s desele=
ct CS%d"
>  npcm7xx_fiu_ctrl_read(const char *id, uint64_t addr, uint32_t data) "%s =
offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
>  npcm7xx_fiu_ctrl_write(const char *id, uint64_t addr, uint32_t data) "%s=
 offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
>  npcm7xx_fiu_flash_read(const char *id, int cs, uint64_t addr, unsigned i=
nt size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x=
%" PRIx64
> -npcm7xx_fiu_flash_write(const char *id, int cs, uint64_t addr, unsigned =
int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0=
x%" PRIx64
> +npcm7xx_fiu_flash_write(const char *id, unsigned cs, uint64_t addr, unsi=
gned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u val=
ue: 0x%" PRIx64
> --
> 2.26.2
>

