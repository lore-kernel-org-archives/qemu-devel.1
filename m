Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD9C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F99206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8t2K+QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F99206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTrH-00039I-0O
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxTqZ-0002bi-Rh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxTqY-0007s2-P1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:07 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxTqY-0007rJ-J2
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id b1so2246577otp.6
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xWnOlc+rdYPEcW6/QFopxSziVcxOEotK2Z++W7oOqtk=;
 b=k8t2K+QM3Cs+1NE6tvrQpSPUMtcdJndKwfKYXtOrDr5aG/tIJ0ar484iYbzSDGO+zO
 X53EpJ7B9LXehYVH/pKb0Iss8nf2TnxjD1+8cXerDcb2CxIyX8yPvkUwihN/+zj7eFf5
 DKZV8rEbohkWAptPRBGlSz5/bnoAFV3Lu4ZlQ6QmUTfSLdugKFmdI8f7B7xn0ifYWuMY
 SaZJAkZ6VCCRuCkrBa3xDXC/XF0U/MxeC4M0+N8u3Po90LI8eV4+Cg22i/nr4lT393nf
 daeGoWgyf4DSv5EIQxsD9e8ABAcyqqePf4W4D8SEikb+NgYf+oBmsPOOWMQwO+g4o1mM
 Wlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xWnOlc+rdYPEcW6/QFopxSziVcxOEotK2Z++W7oOqtk=;
 b=WISfl4u2UKvoiVAcyUB/rwrrYM3tSS9p1XZPaCcb/sB6GI2O0HeowfoOxS8bp3xjpl
 NpO74rLacFLeMr12n4QfFhsJlk17WLs2ERlvGIsUejEYm7nrIx2hSpkQRjP31Knf3mqA
 y+F+MnRrkrFct8Pl8NoqqlwINmXRcB11lM5nWDuoY2IPTJ9t85hWVDbKtrTcgWf8Z46b
 doz9CtfEyUXSkLkm8nhPPqFLhrVSEDWtxsR5BbweYo2DP2tjCeCd25q9mKYmzWqDcxmf
 7o7IMVg26uDbz0FPrP1kfmUD37HKoBgRaF7GZuADr++a1NET7/Uh9sDRYHPySVkkQXSX
 lO2A==
X-Gm-Message-State: APjAAAVQ2mLtdJFFdiC0TW5qvI2g4mamtv5BHdZIs9syWLGqwVlzlUYR
 cO/AmBv95KusipGtTJW+KzUUT3vlrmizV4MpuxtDrw==
X-Google-Smtp-Source: APXvYqzLdbHcjSxSzc55lWLhA18AOKVhR5AiWQN55gQiyYc4A4Ta62GPi4XV0ltLIH3tn0RCN9C3+CApriK83e4O1MU=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr4395974otc.135.1565691365380; 
 Tue, 13 Aug 2019 03:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-2-huth@tuxfamily.org>
In-Reply-To: <20190709073222.26370-2-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 11:15:54 +0100
Message-ID: <CAFEAcA8s=JnNRJX0SdK2_pMbb6hyZWiOY0PN-vzr3ntKu556jQ@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 1/6] m68k: Add NeXTcube framebuffer
 device emulation
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 08:35, Thomas Huth <huth@tuxfamily.org> wrote:
>
> The NeXTcube uses a linear framebuffer with 4 greyscale colors and
> a fixed resolution of 1120 * 832.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
>
> and altered to fit the latest interface of the current QEMU (e.g.
> the device has been "qdev"-ified etc.).
>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  default-configs/m68k-softmmu.mak |   1 +
>  hw/display/Makefile.objs         |   1 +
>  hw/display/next-fb.c             | 145 +++++++++++++++++++++++++++++++
>  hw/m68k/Kconfig                  |   4 +
>  include/hw/m68k/next-cube.h      |   7 ++
>  5 files changed, 158 insertions(+)
>  create mode 100644 hw/display/next-fb.c
>  create mode 100644 include/hw/m68k/next-cube.h
> +static void nextfb_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->realize = nextfb_realize;
> +}
> +

Hi; this device seems to be missing a reset function and
also a vmsd pointer for the migration state. (If there
is in fact no migratable state, then a comment in the
class init function stating that helps to confirm that
it was not an accidental omission. Some day we might
provide some in-code way to say "has no migration state"
and then we could assert that vmsd wasn't accidentally
omitted; but we can't do that today.)

thanks
-- PMM

