Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF98C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8766C2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffT/2LRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8766C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jDn-00076Y-Oe
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jCv-0006KE-IQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jCu-0006VI-01
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:25:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jCt-0006Uv-KH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:25:55 -0500
Received: by mail-wm1-x343.google.com with SMTP id a141so10294241wme.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iNoGXR8/KdZDH/mGYHq1LeISZaWgYX59zE3MiiQbJfg=;
 b=ffT/2LRmOIOzef/IuiF6oXnmLoipXTGcjAoTZSCDNsVZ0WsgmFxBSi8xgNek0HDy5K
 EJceUAfU78ZUTaqb3W67IAyYPu/yZEInqGPfaG0+g1pIPkoCFEgXc6pD4o9FzsAMMFWm
 3x0P7l8jPdElwrbjY1F/7tE9EfJww2NyqAwSB8tozaXIpoM5VtKUDknffFiEqVS7SRmg
 iTdJ0iLd7Xi2gLhYXAVLxpMnVMg6bgYgUGIkITzFwQUfvQlFJQaRSBkR1ndi/n1sZwd1
 pNkt9pjcfNm7FJRU0BqF1Sn2SLe47NoWWt7xpzRamXzKeX3EnXKmt5bpGwE2ZaI3cEbd
 mDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iNoGXR8/KdZDH/mGYHq1LeISZaWgYX59zE3MiiQbJfg=;
 b=rtlY/2SEbyAG9ffyGy760JU6P4WA5I52AO7zjOmg58E48Fmu73izY06IU9Z9nCjtn7
 cyGhk2xTVp3mz7qM7vqP5jIw1QdDxSl0fzyREaSqCOxZ8W6ALNmY+tY9qd9g0SWTC9y+
 PYEvFm9slCh6X/z1fvJ7eekz7O6YjlXtUekH0TtS0EG5lHoAT9moUhIIEHT6g6bx5o2I
 DyWMOD6GhkW2OXTvY5xU/CW69+kGrXjHkGCC/2sPqHgE3CSe1empTjb0LkGZB3Z+ddR5
 lW4hDsxi8fxdaK0glVfOseGeQ/andgoRzf0yM4t+tT+wtD7cfR1Wd1Xp5l1P6ZjfnSv8
 g/Mg==
X-Gm-Message-State: ANhLgQ0sWqHT6C2uNfIhHifomroRYoA81fIKvP83Z0E2KGVJR8g1vOVP
 jQtqOSy4JT1W+wrAoBb7kOvlcQ==
X-Google-Smtp-Source: ADFU+vuQRHeI09T3t5EEzwTYgucKp90pBEznE1vEUldXJsxKuVcoyT0B7haK7wWsJguyh7Sa883rVw==
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr5948381wmd.22.1583148354269; 
 Mon, 02 Mar 2020 03:25:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm15609634wmb.37.2020.03.02.03.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:25:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 989001FF87;
 Mon,  2 Mar 2020 11:25:52 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-7-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 06/33] qemu-doc: extract common system emulator
 documentation from the PC section
In-reply-to: <20200228153619.9906-7-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:25:52 +0000
Message-ID: <87tv37athb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Move the section on PC peripherals together with other targets.
> While some x86-specific information remains in the main system
> emulation chapter, it can be tackled more easily a section at a
> time.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-7-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/quickstart.texi |   2 +-
>  qemu-doc.texi               | 102 ++++++++++++++++++++----------------
>  2 files changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
> index 8cd5b4bc6e5..ed7295de7a2 100644
> --- a/docs/system/quickstart.texi
> +++ b/docs/system/quickstart.texi
> @@ -2,7 +2,7 @@
>  @section Quick Start
>  @cindex quick start
>=20=20
> -Download and uncompress a hard disk image with Linux installed (e.g.
> +Download and uncompress a PC hard disk image with Linux installed (e.g.
>  @file{linux.img}) and type:
>=20=20
>  @example
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 33d24caf946..88e84300e91 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -36,8 +36,8 @@
>=20=20
>  @menu
>  * Introduction::
> -* QEMU PC System emulator::
> -* QEMU System emulator for non PC targets::
> +* QEMU System emulator::
> +* QEMU System emulator targets::
>  * System requirements::
>  * Security::
>  * Implementation notes::
> @@ -127,19 +127,16 @@ accelerator is required to use more than one host C=
PU for emulation.
>=20=20
>  @end itemize
>=20=20
> -
> -@node QEMU PC System emulator
> -@chapter QEMU PC System emulator
> -@cindex system emulation (PC)
> +@node QEMU System emulator
> +@chapter QEMU System emulator
> +@cindex system emulation
>=20=20
>  @menu
> -* pcsys_introduction:: Introduction
> -* pcsys_quickstart::   Quick Start
> +* pcsys_quickstart::   Quick start
>  * sec_invocation::     Invocation
>  * pcsys_keys::         Keys in the graphical frontends
>  * mux_keys::           Keys in the character backend multiplexer
>  * pcsys_monitor::      QEMU Monitor
> -* cpu_models_x86::     Supported CPU model configurations on x86 hosts
>  * disk_images::        Disk Images
>  * pcsys_network::      Network emulation
>  * pcsys_usb::          USB emulation
> @@ -150,13 +147,57 @@ accelerator is required to use more than one host C=
PU for emulation.
>  * gdb_usage::          GDB usage
>  @end menu
>=20=20
> -@node pcsys_introduction
> -@section Introduction
> +@include docs/system/quickstart.texi
> +@include docs/system/invocation.texi
> +@include docs/system/keys.texi
> +@include docs/system/mux-chardev.texi
> +@include docs/system/monitor.texi
> +@include docs/system/images.texi
> +@include docs/system/net.texi
> +@include docs/system/usb.texi
> +@include docs/system/ivshmem.texi
> +@include docs/system/linuxboot.texi
> +@include docs/system/vnc-security.texi
> +@include docs/system/tls.texi
> +@include docs/system/gdb.texi
> +
> +@node QEMU System emulator targets
> +@chapter QEMU System emulator targets
> +@cindex system emulation (PC)
> +
> +QEMU is a generic emulator and it emulates many machines. Most of the
> +options are similar for all machines. Specific information about the
> +various targets are mentioned in the following sections.
> +
> +@menu
> +* x86 (PC) System emulator::
> +* PowerPC System emulator::
> +* Sparc32 System emulator::
> +* Sparc64 System emulator::
> +* MIPS System emulator::
> +* ARM System emulator::
> +* ColdFire System emulator::
> +* Cris System emulator::
> +* Microblaze System emulator::
> +* SH4 System emulator::
> +* Xtensa System emulator::
> +@end menu
> +
> +@node x86 (PC) System emulator
> +@section x86 (PC) System emulator
> +@cindex system emulation (PC)
> +
> +@menu
> +* pcsys_devices::      Peripherals
> +* cpu_models_x86::     Supported CPU model configurations on x86 hosts
> +@end menu
> +
> +@node pcsys_devices
> +@subsection Peripherals
>=20=20
>  @c man begin DESCRIPTION
>=20=20
> -The QEMU PC System emulator simulates the
> -following peripherals:
> +The QEMU PC System emulator simulates the following peripherals:
>=20=20
>  @itemize @minus
>  @item
> @@ -222,40 +263,9 @@ CS4231A is the chip used in Windows Sound System and=
 GUSMAX products
>=20=20
>  @c man end
>=20=20
> -@include docs/system/quickstart.texi
> -@include docs/system/invocation.texi
> -@include docs/system/keys.texi
> -@include docs/system/mux-chardev.texi
> -@include docs/system/monitor.texi
> +@lowersections
>  @include docs/system/cpu-models-x86.texi
> -@include docs/system/images.texi
> -@include docs/system/net.texi
> -@include docs/system/usb.texi
> -@include docs/system/ivshmem.texi
> -@include docs/system/linuxboot.texi
> -@include docs/system/vnc-security.texi
> -@include docs/system/tls.texi
> -@include docs/system/gdb.texi
> -
> -@node QEMU System emulator for non PC targets
> -@chapter QEMU System emulator for non PC targets
> -
> -QEMU is a generic emulator and it emulates many non PC
> -machines. Most of the options are similar to the PC emulator. The
> -differences are mentioned in the following sections.
> -
> -@menu
> -* PowerPC System emulator::
> -* Sparc32 System emulator::
> -* Sparc64 System emulator::
> -* MIPS System emulator::
> -* ARM System emulator::
> -* ColdFire System emulator::
> -* Cris System emulator::
> -* Microblaze System emulator::
> -* SH4 System emulator::
> -* Xtensa System emulator::
> -@end menu
> +@raisesections
>=20=20
>  @node PowerPC System emulator
>  @section PowerPC System emulator


--=20
Alex Benn=C3=A9e

