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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD6C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA6620665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqjkqWUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA6620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffad-0004d8-SF
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffXv-0002qP-9f
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffXs-0002q9-3r
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:07:13 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffXr-0002oX-Hl
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:07:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id u19so813543ior.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sLw2Akk9vFEYFtKgoXwuNMcfg6tNknYCDHEdcP6DzUU=;
 b=qqjkqWUK2+OX/VsXeEfVTXPXOuFW4poiyiEgtEhafzx7IB8As6MU+sBe3SR8FTiGuV
 uGR2TraoOxJZjG1uGv/E95/y/4zObBaGzxExZTjbNak4RzDF1/xfW7q4whPJgbCNgBxO
 4YNVtdRUhsCZcUJ0sBwq6+hcDcirzBA2WCiBQ7Kjk+f0T03mfIMZue01PUrRPr2lKz+3
 bpdGpKJoLkxvf9bPDP02MHmg7m/ewkJo0ES/UOGhDAsjlflBvgFjzvcoUuZSFWPn/YIz
 SJBcZ2VCVrlVm1WggBpDII3x+sqlp+hb9AJhW5486caCb2I0lb1lrtkGZ+/ClpOfLnIy
 lVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sLw2Akk9vFEYFtKgoXwuNMcfg6tNknYCDHEdcP6DzUU=;
 b=R9pFCldwJ6Jzx+jeM2XQrCDLaVjNTy+wYo5+gJF3qgA50O6O4jQ8p9TJMX5FmTWJXg
 ussgRfHDBWbbzsiAKYFBg74dF4mvjegBjlTOAazpHw6o06QqIThbbayUp1d1tQuOp4o7
 GjbAV4J9xd/4h34PseDXqzFr5TwCM/dffvPcpZm2ugq0XUpssUKXXoiqqZnjAwqF/3NW
 +k+cwJn1kamcIKhQWBkeHxvJVTjOcYtcqP/WxQws7/kkA4xYGdEMj97XNXcACJ8rOjNV
 a8PZJOOowG9j4KKaZoyKH9QhJJ0m5Q4acCvHCdH5KQO7kU4tfbRAeeuIi92CFSjQcJ3R
 44Rg==
X-Gm-Message-State: APjAAAUkEJ74jVL/NIffrBUtiyRI7cLjPGh2Qeco16mZ/7FPs/3b71tv
 OcGzEYUeICtuQH/AoccseAQhcMNvEodmuB9Ks6I=
X-Google-Smtp-Source: APXvYqyB5y/X/g84yaejJSltDGYKH0Z+nO9o85lwDLQgrR8xTWXft0zIQv8h87R8e78UWpR/D81pS3LDHT6ufYOtGxE=
X-Received: by 2002:a5d:8497:: with SMTP id t23mr5969812iom.298.1561446429964; 
 Tue, 25 Jun 2019 00:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-3-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-3-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:06:59 +0200
Message-ID: <CACXAS8B0kFgZxaqJpjdoMSq4VJP5DFVxFJYs1LEqnN05Rs-Dfw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [RFC PATCH 2/9] MAINTAINERS: Add the 'empty_slot'
 device with the 'unimp' one
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
> The EmptySlot and UnimplementedDevice are very similar, the only
> difference is how they log guest accesses.
> Maintain them altogether.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
> Peter, are you OK with that? Do you prefer 2 distinct sections?
>
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b9487..abef4a1cfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1643,11 +1643,13 @@ F: docs/specs/vmgenid.txt
>  F: tests/vmgenid-test.c
>  F: stubs/vmgenid.c
>
> -Unimplemented device
> +Unimplemented device, empty slot device
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  S: Maintained
> +F: include/hw/misc/empty_slot.h
>  F: include/hw/misc/unimp.h
> +F: hw/misc/empty_slot.c
>  F: hw/misc/unimp.c
>
>  Standard VGA
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

