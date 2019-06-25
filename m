Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EE3C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7FF20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW/nPmEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7FF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffbP-0005QY-6X
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffZY-0003mL-FL
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffZV-0003wH-Jp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:08:54 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffZS-0003qF-Np
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:08:51 -0400
Received: by mail-io1-xd41.google.com with SMTP id h6so920191ioh.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NrxTGyxlKE0kJFBziVcMYQaYBhaoiB0V62qfl2THlNk=;
 b=tW/nPmEnmI7d868MJ1ZCQc61Wn6i7D2zBbT2Nftfg++Tbwiv1sYty/BRO63yPCRXsF
 HxGVUO/xmTEDTDQLS+ncJ8dDZ636a2rLrqUj3syYItJ+uE705mSD54/fZBpy0ITrJcmC
 OfTQHau+s6BfpcM9jIkJchWn4oxa+mxpkVB8RKubMxW/hwGt0dj3NSIAq6ZkwHQWKMYm
 ZZah5/oSEp3Ux9M758wo/1H67eAcm729WHiym1I71t2IcwnDszr3nvp2ugxwtjbU9nRs
 PHmzew5M70248/vCqtQLYVooPuM/t/DPHyxJj5WRQBzSrefKLAXrwBW4xStGofrwjMcl
 9g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NrxTGyxlKE0kJFBziVcMYQaYBhaoiB0V62qfl2THlNk=;
 b=EFY6+bu65Yg+eOfmutJTiFYpiHx3PrX3w10GgwFZpKcHUha9lPf/imqce43wXGp7kT
 q/TKKdr2iZr//sWGYVi0SB4TzXgzozUz2H4zxDI+tbMqQGv6jXjXy2QDoZR3ey2FJXvH
 Sds95sNB5ectjZY5icdS/kLBL6/xlsR0RjzMIukDVxvD2yOaV0rxntaCvBW/qWFds9km
 RMk+5IwScJRInIDf6VHyl9Du5Bmf504Z25CC2/HfB8bFTSD3O7E5T2BCK8LMq1hsgYPa
 skTNTMxrAnYBKVnndJ3vrPgmiTrtG2QtI6qjcptggLnulJFYZUUC/wSV9yjjZAsRHm8N
 8nXg==
X-Gm-Message-State: APjAAAXm2+Y7PdbbxgMrGa62DhlzEz/j/5GWEAOCoPUEO2g4wlcPSVT+
 Arsn3Sm/l7M1ijsM+29EdYIyhAq6u1zgqn3TRjc=
X-Google-Smtp-Source: APXvYqzsTvXQauO8yt6z1FNTfXbex0ToqEa9pyiBpCkOFwpcqEVS7kGTZOAl6z5Rn0Wm4d1rP0FotPm5gUn4u51A/b8=
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr892823ioc.257.1561446523629; 
 Tue, 25 Jun 2019 00:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-4-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-4-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:08:32 +0200
Message-ID: <CACXAS8DA9SwcsuYzvENW16g-and7QSC=Rjsrm20FiHh9Gv+v0A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH 3/9] hw/misc/empty_slot: Allow overide by
 device with higher priority
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> The 'empty_slot' models a ChipEnable (or ChipSelect) MMIO device
> pluggable on a bus.
> The bus allow such slots to be not connected ('empty), thus no
> bus errors are generated when this range is accessed.
>
> The device is mapped at priority -10000 to allow other devices
> to be mapped on top of it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/misc/empty_slot.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
> index 0adf7a26dc..53299cdbd1 100644
> --- a/hw/misc/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -68,7 +68,11 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
>
>          qdev_init_nofail(dev);
>
> -        sysbus_mmio_map(s, 0, addr);
> +        /*
> +         * We use a priority lower than the default UNIMPLEMENTED_DEVICE
> +         * to be able to plug a UnimplementedDevice on an EmptySlot.
> +         */
> +        sysbus_mmio_map_overlap(s, 0, addr, -10000);
>      }
>  }
>
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

