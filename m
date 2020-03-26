Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE1620774
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Omqd3PtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE1620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaBc-0003Fv-KU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHa93-0000RY-Fk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHa92-0006t7-7T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:34:33 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHa92-0006sE-1l
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:34:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id k9so6957419oia.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HknmFa0YRfLIIhNE8hZfw18tHx3/w1ozQbxIJrAl5oo=;
 b=Omqd3PtI3mQcyJ2xNWeF8z6p7opwItOYl20pCfmWzCAM+LvMi89Vlswey280wQt5WR
 YJX6lazpkF788P6Y6pGPVhGhG/6DoFVW5WpA7ssWLoEg65kNg2B2gbXTUFwgjNssiq7p
 4DLU8B4vqmYHwv4XiL0s28x7s4bAjpYWa+ac0dRv4YXW+p3fzl82VNrtJYQrUcASrhv7
 XOXnAvMcXyou9um4tam7aFT4U24EMudcETK7q3uEPKNHF+zoH+ppVO7KcjsnV2uyAE83
 k+EmbYZOBduKa0OmaIJYq4pwzQg0wJ7RX4RG1XjtoyYIWj7/QeJvAhdvMZdHxDV9ptHm
 D73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HknmFa0YRfLIIhNE8hZfw18tHx3/w1ozQbxIJrAl5oo=;
 b=pQlU5+bz7n6GjacuJx/ee+PkyzT4ua0LVnqK8vKy1JELj+GLY7jtTWCyCrC+s5L69D
 NkQ4AtezajkUQWzutWIkHtyW4oXUEe4arPV0RIp9YPhg6dqhtrKBySzeEAQt5ulWmpYM
 e4S4kRfCHKWcJp6Azk9Q9B6d4y8OXTlfUqqbb55TqD/eKOx8MwG87BUbfmS7JTNjlCLb
 m3Wkc6tA1niSkRhEOWj9eCckMqlq+p7Kn4Qf2wE2Le3eym4bV2fw+/ls5rr1NxKy6mrh
 XC2rRdQJbWjVymZSlLlc6uqS/bz3eKyQWhCNcja9RBg+0CGzTYUQaA0LgHUvZA3m4cXU
 vgcg==
X-Gm-Message-State: ANhLgQ1olSuBeR9f9Ng3U/HNaukwCZ3hENX2U9No3sQUwesLMRveHoMz
 xbxbcZoHHwSDio7f6QuAyXnVDlOKf/i7y+5Xz8htLQ==
X-Google-Smtp-Source: ADFU+vsgRovvewGBXHI8bmJ2ustTblZuXorArefOaFYkd3VI8GTLZIl4nSsn0KASmn+awk7Oz0w7SFU1T83lbPgpTEY=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr1795744oih.146.1585258471238; 
 Thu, 26 Mar 2020 14:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-3-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:34:19 +0000
Message-ID: <CAFEAcA-9w4GRLv=gFUAkNryhDR+8JNTS-=UAe6oh7eso5Uyhag@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 02/12] hw/arm/bcm2835_peripherals: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index edcaa4916d..a111e91069 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -133,254 +133,262 @@ static void bcm2835_peripherals_init(Object *obj)
>  static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>  {
>      BCM2835PeripheralState *s =3D BCM2835_PERIPHERALS(dev);
>      Object *obj;
>      MemoryRegion *ram;
>      Error *err =3D NULL;
>      uint64_t ram_size, vcram_size;
>      int n;

Is there a reason this patch has such an enormous amount of
context around the changes it's making ? It looks like it's
quoting the entire function.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

