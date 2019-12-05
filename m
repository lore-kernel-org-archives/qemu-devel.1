Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2CC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFB922525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUe4zR5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFB922525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvqB-00073H-Lo
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1icvh5-0005mO-Ca
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1icvh3-00010m-Fy
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:38 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1icvh1-0000yO-Df
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:36 -0500
Received: by mail-wm1-x344.google.com with SMTP id c20so3269728wmb.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C0Aqo9JI+SHft2+750uwyw+c5t9jPXYtEpsKMl00T4I=;
 b=cUe4zR5FMz88YG4bWpjOGQ1NZ1dzg8CliWktQYcijfz3x6TzF7wR+D1phpYRUQ+h9l
 3hX7Z3iTsSbnl+F2f4X2SRtasWQlqA0tNGvgKub9b5liKvDpvbiFePY8KhTnu6TJ9/U8
 PW9+TXjP0AcAiDt9tyMVbgHDsOCOJP0v1xh2w9VqJkHE9inHc2PAqR7dwFNTtRqze4Sb
 BDp5DhdlVtZQjX0ZpR/0xcAGI7qfZwqCzzhpWXsLmY/Z02bkRy76KFtVpVpnaFONmoKd
 4WAUXI/y4+zgl0SjNRYzLUEEtNpomy2K9R4TqbX0uqSl66ltjhnnZeR4TeA0HTALP0M7
 zlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C0Aqo9JI+SHft2+750uwyw+c5t9jPXYtEpsKMl00T4I=;
 b=RPsSpgILcZAlIVDk71YxaiqNdJo5W89C9nDDed15z+z8PnWP91WEyvGQwWM2V2OgXo
 WylhRDGld+vhkDJO1mlzDSWqMAyfZPaWaxadhA44l1f5xpkwysrafwFQglHi0CsWLikX
 B/mUVfTHR+X9ojH1Kpxe9BnrqopJVvYO7B71csEPJB6zB/Ka0qc4It7szxa5bFIgQ4MD
 GcYlmBze40RgSYWGr0xCRLR2mknsrLEc8AgotdUKK1VdERLJli9k1zM6k5EEd4m0CGlJ
 LzhkuvE0tcI7AX+wA7N30+6BP5HdeRufWhWRPzsNdaJLp0IHdMBCQw9n/F6b81Dilrrt
 G0SA==
X-Gm-Message-State: APjAAAWh3AIf7iKmDU8F1csyiqyLqPsGFK0f5CmFEPCjWTx7QbcqLpWL
 zqK7gNKcLZgYrjB6KQoggUsCi7gE4bFtEdkafrxGtA==
X-Google-Smtp-Source: APXvYqzhwrio2In0rtJYzISatatU06kv9uJ2ZAAA9NiKb6w8ALK0TSW8ZpTPB1WCXXkFXdrSdjrITYywwxMjsBEQiN8=
X-Received: by 2002:a7b:cb87:: with SMTP id m7mr6650708wmi.148.1575569851970; 
 Thu, 05 Dec 2019 10:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20191205180913.15263-1-philmd@redhat.com>
In-Reply-To: <20191205180913.15263-1-philmd@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 5 Dec 2019 18:17:28 +0000
Message-ID: <CAKv+Gu_DqSD9K3Ajsj0q2yQ_AT=pjfhSitn2t-irYXoW662jOg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs: Force armhf toolchain prefix on
 Debian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 at 18:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The Debian (based) distributions historically provides 2 ARM
> toolchains, documented as [1]:
>
> * The ARM EABI (armel) port targets a range of older 32-bit ARM
>   devices, particularly those used in NAS hardware and a variety
>   of *plug computers.
> * The newer ARM hard-float (armhf) port supports newer, more
>   powerful 32-bit devices using version 7 of the ARM architecture
>   specification.
>
> The EDK2 documentation suggests to use the hard-float toolchain.
>

We should probably fix that. tools_def.template mentions
arm-linux-gnueabi, and while it does not really matter in most cases,
if you are using Clang, you actually need the armel binutils (see
41203b9ab5d48e029f24e17e9a865e54b7e1643d for details)


> Force the armhf cross toolchain prefix on Debian distributions.
>
> [1] https://www.debian.org/ports/arm/#status
> [2] https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-=
cross-compiling
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/edk2-funcs.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index 3f4485b201..a546aa1d11 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>       ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); =
then
>      # no cross-compiler needed
>      :
> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); the=
n
> +    # force hard-float cross-compiler on Debian
> +    printf 'arm-linux-gnueabihf-'
>    else
>      printf '%s-linux-gnu-\n' "$gcc_arch"
>    fi
> --
> 2.21.0
>

