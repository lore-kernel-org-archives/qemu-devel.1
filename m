Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A56DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E2D21739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM313SSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E2D21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k3Q-0004F9-7B
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k1y-0001vV-Cp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k1w-0001Wi-Jy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k1w-0001WS-C0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:18:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so10936019wmb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1LDY01giTz+RuIzVY2+lKm8+sZab6Cfbiq5jvenVBCw=;
 b=sM313SSyuOtRPsEf6co4sHgG85TDv8WS/7wMeJrFPqdSQ6wZTyANDuvKioCwsbuEJ2
 8rZZfTszulNeKi+z0hy9U5cqbnAR2Ye3xOP5n99Ivl7ZlUveCLzs6VQ6KF+My4ICwZZG
 /BpjRzqWe7g78DffzLhv1qzblbIHA097bhmJsL/lUuoN5pnS9w84S1IYHInmBMcWKvA4
 4hSnEM2RO4p27cKH/2jPASuRJNWNpv4Ihfh5a+lbRwS/691patdAy7DwwZpFBwf7ooUQ
 prPpawsH2PruIsrnIMIt4erwMbsJkRTUHMHcWn6sU8IPpkysAepYKiqBcqw0X6Kww/C8
 x2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1LDY01giTz+RuIzVY2+lKm8+sZab6Cfbiq5jvenVBCw=;
 b=UCeexZBI9JMj2JtDJSzANg9TROQkVtr05TfpbaVg/n1c3HB6DR/dukL1kCT57PAGot
 od7Q0vTrRVwYzEDwlyi/gmvulOINWLLFgVa+M4r7+fgxkBBdWkhJ2pQnKo9LzUICBvPq
 dbWPcJ+SbeMFpLOO73y49TUGQKtyt60gSUOCD5eGQA68PR0uqv5vJOXA5b9glXMs07Lw
 Gb5eGqipvX9SE6sF8EshL0/lEpmgBMWqBHsSL+WcTjWuaee2sINy0UyZ5lymA6IMXlXK
 dNMfS3bA6fiE7zUupXzYhwBlYtoJX34yCLY4TVNEXzaADk3DM1VrYInTcImob8OQUvr2
 gCYg==
X-Gm-Message-State: APjAAAVM1bmVu6u1ciiFewtkb0bcPi7mHjDNeH2Ae7WBetjvdk+b36pP
 D7dxPaQXMh1Jb+dfz9ifVJjp/w==
X-Google-Smtp-Source: APXvYqzD8n3q/+b+JdJSBF5wUjiIwM6UfW+x6+Z3BtxrsEgfAzijHsnCd0DcsMZEHRBxbHz3eWMYew==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr19479917wmi.0.1583151518891;
 Mon, 02 Mar 2020 04:18:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w22sm15198941wmk.34.2020.03.02.04.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:18:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53C1B1FF87;
 Mon,  2 Mar 2020 12:18:37 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-24-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 23/33] docs: Roll semihosting option information into
 qemu-options.hx
In-reply-to: <20200228153619.9906-24-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:18:37 +0000
Message-ID: <87mu8z9cgy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

> Currently the per-target documentation for those targets that
> implement semihosting includes a bit of text that goes into both the
> manual and the manpage about options specific to the target.  This
> text is redundant with the earlier generic option description of the
> semihosting option produced from qemu-options.hx. To avoid having
> to create a lot of stub include files to include into the rST
> generated qemu.1 manpage, roll target-specific bits of information
> into the qemu-options.hx text, so the user doesn't have to look
> in two places for this information.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> Yes, it would in theory make sense to do this before generating
> the rst from the texi docs, but I didn't realize this was a
> good idea until well after Paolo had done that part.
> ---
>  docs/system/target-arm.rst     | 10 ----------
>  docs/system/target-arm.texi    | 18 ------------------
>  docs/system/target-m68k.rst    | 11 -----------
>  docs/system/target-m68k.texi   | 19 -------------------
>  docs/system/target-xtensa.rst  | 12 ------------
>  docs/system/target-xtensa.texi | 20 --------------------
>  qemu-options.hx                | 18 ++++++++++++++++++
>  7 files changed, 18 insertions(+), 90 deletions(-)
>
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 0490be55871..d2a3b44ce88 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -215,13 +215,3 @@ emulation includes the following elements:
>=20=20
>  A Linux 2.6 test image is available on the QEMU web site. More
>  information is available in the QEMU mailing-list archive.
> -
> -The following options are specific to the ARM emulation:
> -
> -``-semihosting``
> -   Enable semihosting syscall emulation.
> -
> -   On ARM this implements the \"Angel\" interface.
> -
> -   Note that this allows guest direct access to the host filesystem, so
> -   should only be used with trusted guest OS.
> diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
> index c56b5f6ebfe..eb80dd35f0b 100644
> --- a/docs/system/target-arm.texi
> +++ b/docs/system/target-arm.texi
> @@ -243,21 +243,3 @@ Three on-chip UARTs
>  A Linux 2.6 test image is available on the QEMU web site. More
>  information is available in the QEMU mailing-list archive.
>=20=20
> -@c man begin OPTIONS
> -
> -The following options are specific to the ARM emulation:
> -
> -@table @option
> -
> -@item -semihosting
> -Enable semihosting syscall emulation.
> -
> -On ARM this implements the "Angel" interface.
> -
> -Note that this allows guest direct access to the host filesystem,
> -so should only be used with trusted guest OS.
> -
> -@end table
> -
> -@c man end
> -
> diff --git a/docs/system/target-m68k.rst b/docs/system/target-m68k.rst
> index 50b7dd9d639..d28d3b92e5e 100644
> --- a/docs/system/target-m68k.rst
> +++ b/docs/system/target-m68k.rst
> @@ -19,14 +19,3 @@ The AN5206 emulation includes the following devices:
>  -  MCF5206 ColdFire V2 Microprocessor.
>=20=20
>  -  Two on-chip UARTs.
> -
> -The following options are specific to the ColdFire emulation:
> -
> -``-semihosting``
> -   Enable semihosting syscall emulation.
> -
> -   On M68K this implements the \"ColdFire GDB\" interface used by
> -   libgloss.
> -
> -   Note that this allows guest direct access to the host filesystem, so
> -   should only be used with trusted guest OS.
> diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
> index a77b19ea0f1..dcce7bc8c56 100644
> --- a/docs/system/target-m68k.texi
> +++ b/docs/system/target-m68k.texi
> @@ -23,22 +23,3 @@ MCF5206 ColdFire V2 Microprocessor.
>  @item
>  Two on-chip UARTs.
>  @end itemize
> -
> -@c man begin OPTIONS
> -
> -The following options are specific to the ColdFire emulation:
> -
> -@table @option
> -
> -@item -semihosting
> -Enable semihosting syscall emulation.
> -
> -On M68K this implements the "ColdFire GDB" interface used by libgloss.
> -
> -Note that this allows guest direct access to the host filesystem,
> -so should only be used with trusted guest OS.
> -
> -@end table
> -
> -@c man end
> -
> diff --git a/docs/system/target-xtensa.rst b/docs/system/target-xtensa.rst
> index 43cab8dc4da..8d703ad769e 100644
> --- a/docs/system/target-xtensa.rst
> +++ b/docs/system/target-xtensa.rst
> @@ -25,15 +25,3 @@ The Avnet LX60/LX110/LX200 emulation supports:
>  -  16550 UART
>=20=20
>  -  OpenCores 10/100 Mbps Ethernet MAC
> -
> -The following options are specific to the Xtensa emulation:
> -
> -``-semihosting``
> -   Enable semihosting syscall emulation.
> -
> -   Xtensa semihosting provides basic file IO calls, such as
> -   open/read/write/seek/select. Tensilica baremetal libc for ISS and
> -   linux platform \"sim\" use this interface.
> -
> -   Note that this allows guest direct access to the host filesystem, so
> -   should only be used with trusted guest OS.
> diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.t=
exi
> index 40327de6fa7..1e6c04dccd6 100644
> --- a/docs/system/target-xtensa.texi
> +++ b/docs/system/target-xtensa.texi
> @@ -33,23 +33,3 @@ A range of Xtensa CPUs, default is the DC232B
>  @item
>  OpenCores 10/100 Mbps Ethernet MAC
>  @end itemize
> -
> -@c man begin OPTIONS
> -
> -The following options are specific to the Xtensa emulation:
> -
> -@table @option
> -
> -@item -semihosting
> -Enable semihosting syscall emulation.
> -
> -Xtensa semihosting provides basic file IO calls, such as open/read/write=
/seek/select.
> -Tensilica baremetal libc for ISS and linux platform "sim" use this inter=
face.
> -
> -Note that this allows guest direct access to the host filesystem,
> -so should only be used with trusted guest OS.
> -
> -@end table
> -
> -@c man end
> -
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5fbfa2797cb..4bc8048f60b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4116,6 +4116,12 @@ STEXI
>  @item -semihosting
>  @findex -semihosting
>  Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
> +
> +Note that this allows guest direct access to the host filesystem, so
> +should only be used with a trusted guest OS.
> +
> +See the -semihosting-config option documentation for further information
> +about the facilities this enables.
>  ETEXI
>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
>      "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,c=
hardev=3Did][,arg=3Dstr[,...]]\n" \
> @@ -4126,6 +4132,18 @@ STEXI
>  @item -semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,=
chardev=3Did][,arg=3Dstr[,...]]
>  @findex -semihosting-config
>  Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
> +
> +Note that this allows guest direct access to the host filesystem, so
> +should only be used with a trusted guest OS.
> +
> +On Arm this implements the standard semihosting API, version 2.0.
> +
> +On M68K this implements the "ColdFire GDB" interface used by libgloss.
> +
> +Xtensa semihosting provides basic file IO calls, such as
> +open/read/write/seek/select. Tensilica baremetal libc for ISS and
> +linux platform "sim" use this interface.
> +
>  @table @option
>  @item target=3D@code{native|gdb|auto}
>  Defines where the semihosting calls will be addressed, to QEMU (@code{na=
tive})


--=20
Alex Benn=C3=A9e

