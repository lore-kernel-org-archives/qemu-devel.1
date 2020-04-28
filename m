Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA97C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B623206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiltx4fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B623206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVEm-0006ii-9l
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTVD6-0003zx-4Z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTVD5-0003Q2-4F
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:43:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTVD4-0003HQ-MC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:43:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id k13so25952555wrw.7
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IOcV0bY8gdr/tyVtVkHx3bWBAqgjIhW68K1qDNQKb9s=;
 b=oiltx4foFbeM79RiDHbQOtzBkxbq89OZAyVxHlCc2P9CL7Sv2WEvD7vGky7unt6QF0
 uRgQYTcfk+IlnAzMPe6wvMfVwD6sm1giHPfEVU/rkNpfUbrn2GMCKiP/FnmrG3ES1Stu
 dwglzRq7NQUu4+IwcvYMvWHnN8v8lSc57AiFaiUMpptAGf9yIo1WQgSEldVMpkSb7skB
 d3RiGVtCC3H6BQxbcTe3T6UPtt7ImZGt60Nq/ZDBByi1ULmxdDbGXy9d0dCjUMq2Hl3p
 FCk8aKaCyr9qb3d5b10NmqjY+XmbgFkVdQeDrumaMvBry4NTQgI0iZ3cFUvVcQ9Um8jX
 Q1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IOcV0bY8gdr/tyVtVkHx3bWBAqgjIhW68K1qDNQKb9s=;
 b=rRbUjtsTlXUZ4z4kFEUoZz0oOYYPo1ACfDdsJLq4piNr8pQN8WJkbPCKVf+BKk1nhN
 Chq3fZoy5+8iEr73Hd9+ub+OGcULimvG/zOp3H8E3wYLxOadx8zDL0jWSdL79z3kVAud
 ohtxWYegzGnSUcR5Wu18jSx6FoAfSgTmtf1QqjTfi+kVnZMo0R3IQIz4vXUiJbCoNRaS
 hnDpx/w3ZWrAfELaHKtQ/k8nJnMvC0iKx33RRuo2Hx/4KeSklAWXhL0cIwD2Fi9p4zua
 H8cN/jaPyW1+zR2oLDlUAcMNyEAaiOFFc50J7i1RJ286FdlP0U7FY/wahR7wZ+Ms4Uwd
 MlCA==
X-Gm-Message-State: AGi0PuYXFaZg//LBWfuaE/13wtcvryqjEYkOU17pMWqwaUOtdXvOYzZ6
 2r601CWr9YdozVzzWtSbNR4B6g==
X-Google-Smtp-Source: APiQypK1guete58Z7KioX1rk78hZJXBLe798WpbmNeaRzZCcqapqTBsg0rBOZ4WTsWIF1v0uEXGrVg==
X-Received: by 2002:a5d:6cc2:: with SMTP id c2mr24227836wrc.60.1588099436993; 
 Tue, 28 Apr 2020 11:43:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w6sm27388599wrm.86.2020.04.28.11.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 11:43:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD6C81FF7E;
 Tue, 28 Apr 2020 19:43:54 +0100 (BST)
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
In-reply-to: <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
Date: Tue, 28 Apr 2020 19:43:54 +0100
Message-ID: <87d07rlac5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


KONRAD Frederic <frederic.konrad@adacore.com> writes:

> The MC68881 say about infinities (3.2.4):
>
> "*For the extended precision format, the most significant bit of the
> mantissa (the integer bit) is a don't care."
>
> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>
> The m68k extended format is implemented with the floatx80 and
> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
> accepts that the most significant bit of the mantissa can be 0.
>
> This bug can be revealed with the following code which pushes extended
> infinity on the stack as a double and then reloads it as a double.  It
> should normally be converted and read back as infinity and is currently
> read back as nan:

Do you have any real HW on which you could record some .ref files for
the various multiarch float tests we have (float_convs/float_madds)?
Does this different of invalid encoding show up when you add them?

>
>         .global _start
>         .text
> _start:
>         lea val, %a0
>         lea fp, %fp
>         fmovex (%a0), %fp0
>         fmoved %fp0, %fp@(-8)
>         fmoved %fp@(-8), %fp0
> end:
>         bra end
>
> .align 0x4
> val:
>         .fill 1, 4, 0x7fff0000
>         .fill 1, 4, 0x00000000
>         .fill 1, 4, 0x00000000
> .align 0x4
>         .fill 0x100, 1, 0
> fp:
>
> -------------
>
> (gdb) tar rem :1234
> Remote debugging using :1234
> _start () at main.S:5
> 5              lea val, %a0
> (gdb) display $fp0
> 1: $fp0 =3D nan(0xffffffffffffffff)
> (gdb) si
> 6             lea fp, %fp
> 1: $fp0 =3D nan(0xffffffffffffffff)
> (gdb) si
> _start () at main.S:7
> 7              fmovex (%a0), %fp0
> 1: $fp0 =3D nan(0xffffffffffffffff)
> (gdb) si
> 8             fmoved %fp0, %fp@(-8)
> 1: $fp0 =3D inf
> (gdb) si
> 9             fmoved %fp@(-8), %fp0
> 1: $fp0 =3D inf
> (gdb) si
> end () at main.S:12
> 12          bra end
> 1: $fp0 =3D nan(0xfffffffffffff800)
> (gdb) x/1xg $fp-8
> 0x40000120 <val+260>:   0x7fffffffffffffff
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  include/fpu/softfloat.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ecb8ba0..dc80298 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -688,7 +688,12 @@ static inline int floatx80_is_any_nan(floatx80 a)
>  *-----------------------------------------------------------------------=
-----*/
>  static inline bool floatx80_invalid_encoding(floatx80 a)
>  {
> +#if defined(TARGET_M68K)
> +    return (a.low & (1ULL << 63)) =3D=3D 0 && (((a.high & 0x7FFF) !=3D 0)
> +                                           && (a.high !=3D 0x7FFF));
> +#else
>      return (a.low & (1ULL << 63)) =3D=3D 0 && (a.high & 0x7FFF) !=3D 0;
> +#endif
>  }
>=20=20
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)


--=20
Alex Benn=C3=A9e

