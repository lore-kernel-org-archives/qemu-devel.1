Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E6922B49
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/P1S8TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E6922B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WRQ-00073x-96
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WQV-0006HO-TY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:42:59 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WQU-00049y-4L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:42:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id o21so12579842oie.12
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j4Ij35fRpTx09Eu9TXQeLgPpnNUgEAdrNeYMHBaYYuw=;
 b=J/P1S8TWP7ixA7KKfaPf/ccM/4d3DTbAQsvonZoM71Mf86jKFOGMIqZ4PRn1Zh1+BF
 E2sIbBzAp2uB3Ix/v1JUEPZ+p8ulph2hFteykO1hTNF6+geYYj1orw1d+AunB0lDGMAK
 LM8p/g9DfAwKu7ua6J/u2POOkpEpK20QE4TMHvhOKYYHiqK2JUYkuZB/uTxpfu49hDbN
 tsEgP8jeHC2ibCnTOsoAlbGb3SfNuTYzlzB50AWTDAZt30tW/H1oFG75LJ7Q9Sp+/zYw
 bM8MahSdUT3r5gZSa8Pd4b9QRaByAPMcCptDJnYQeWhwJqzvQ/cdUYdwLLCCHOCUqRPy
 e7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j4Ij35fRpTx09Eu9TXQeLgPpnNUgEAdrNeYMHBaYYuw=;
 b=VdCoqkqe8s9q3k8XDOK8u+SnNZzHe7qSfe+Hxbxc0tBurJJXIa7Gp9JQMNJHbiIn2A
 pCqqrBckUdO/p5CZIGLiyRKARexRPK+1SK0BG8k/YntUdfy12dehYGROU2mi/LL6mv9G
 oHTSBHcjtcGV2NdYqFRlH1tIl3694BlVlqUBUclYf+PnD07uhYz50kWgxmmKAcfmx3E6
 IqMzQwW16SyTzaE7UXBNNViPbasVktq6mTXd/DFxXiZ/XNf9lPLIgmkbn9+cPtqGleWZ
 dugpKdz23wcrN0Vjyu2Gq4iXdDgJQUhohEZ9ut2AhmTFvveCvj6RzOMoDhE/iCyfLg9p
 1FgA==
X-Gm-Message-State: AOAM532gocpKJzZJCX1loim7SnUuYzbshpWxIHutTBCf5/lyuoFwUd5O
 uZkzg2hGfxA61L0OIA0ir+/P/6JK8Fv26gQSTcM=
X-Google-Smtp-Source: ABdhPJwZ7LzJxAExm0USwyLI6Muo1ryPnpfx6aM8fMUr5vCoWdCjwLxob0mT+0wtBm3w9QlYImTywEAzxTOVCI6M2v4=
X-Received: by 2002:aca:1117:: with SMTP id 23mr4059999oir.97.1597160576791;
 Tue, 11 Aug 2020 08:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-6-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-6-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 11 Aug 2020 23:42:20 +0800
Message-ID: <CAKXe6SLmTYsV1WYmPRWNgcFgT8=Q8pqeKBOsgQtad_wnLYYDjA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] nvram: add nrf51_soc flash read method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add nrf51_soc mmio read method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/nvram/nrf51_nvm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> Update v4: add explanatory comment and Reviewed-by tag
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05309.ht=
ml
>
> diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
> index f2283c1a8d..7b3460d52d 100644
> --- a/hw/nvram/nrf51_nvm.c
> +++ b/hw/nvram/nrf51_nvm.c
> @@ -273,6 +273,15 @@ static const MemoryRegionOps io_ops =3D {
>          .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
> +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    /*
> +     * This is a rom_device MemoryRegion which is always in
> +     * romd_mode (we never put it in MMIO mode), so reads always
> +     * go directly to RAM and never come here.
> +     */
> +    g_assert_not_reached();
> +}
>
>  static void flash_write(void *opaque, hwaddr offset, uint64_t value,
>          unsigned int size)
> @@ -300,6 +309,7 @@ static void flash_write(void *opaque, hwaddr offset, =
uint64_t value,
>
>
>  static const MemoryRegionOps flash_ops =3D {
> +    .read =3D flash_read,
>      .write =3D flash_write,
>      .valid.min_access_size =3D 4,
>      .valid.max_access_size =3D 4,
> --
> 2.26.2
>

