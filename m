Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D890C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA6720643
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmIj+edK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA6720643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUarz-00075L-2O
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUaqK-0004A8-LM
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUaqJ-0002nx-Ga
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:57:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUaqJ-0002iQ-12
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:56:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so7418116wra.7
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2Z8kPg8M8gs5leyjcTxtANjJyqd276kt+Ig/tH2leNQ=;
 b=cmIj+edKd4MjwYLRKMjUsXlYDQej8tDHW5/maUDPgsW5FBS3Kvzx1Izfw5ZgjCnAmb
 TTfxCqDvwIBDezfYVRXgMMxZwDc9RRQB7sRWVSH+8uUcJbu2a90aRX0GUC7QH/2rpVvB
 muhhWEWogAsWZzdi29xXcqZ6jJWXIVHm1X4eX1bFFLxO7/rxfEgvOsZsF50aSK+ZNniC
 VPEs5PPVXMaYyF6Oa3qzgy70nkPpNYf8JGZzsmPTf0q81mD1uTfso7ahAfx+pz2ST83a
 cuiyccVCjYn33auDCgqWDlIIYbuf+HlvwJp4LLp0dUHAYQ4hMA06BBsKshPjQw1mKS4h
 YuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2Z8kPg8M8gs5leyjcTxtANjJyqd276kt+Ig/tH2leNQ=;
 b=jB0Fo91ZoJOX0Q0hNPhsc5wMPCTzHQg8DIdYdVrmWGeCDXyIk5wem1k13nH2V9ox+k
 JQakh6uRO+kOzUQEQTj2/0VO1RVqC2ud2N2oasvOYYnRpvda6G0AizLb1poIlA8fkUTU
 kNY3GXxpUK+k7jrEqvefxTY7VCX3pO8ZS4cGp3+q/D2QDBllcNFVRoM1ZRAMTBuO8nFX
 eKekB5KwZjJHS5Qv20ABqPHj2XTkDsL13vyBqa0L5RF3vlvmvwVB/AEUhnQj399ABAyV
 LgnWpJVOWf/TjRegr3AusaHdGIIVfq0qdT+N0HyCE2ZouAQzv0Lkwd0lHb3axY+rnh39
 Xd8w==
X-Gm-Message-State: AGi0PuZ4/i0ys198EDIfFOMgoawaahKTVk1QxuGOl0hTWqJLQ8r3Vt2y
 DjzbSV8n+wpQ524mQ0cV5egH8w==
X-Google-Smtp-Source: APiQypIsHFB40UEHRfi+3mFximUWVBEPifsVlbx2TWzvjrg2SQpyuNaD8fQUKITvLjQ/96xQfmA9rA==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr5577221wrx.203.1588359417042; 
 Fri, 01 May 2020 11:56:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm2542911wrt.69.2020.05.01.11.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 11:56:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E4311FF7E;
 Fri,  1 May 2020 19:56:55 +0100 (BST)
References: <alpine.DEB.2.21.2005010037350.30535@digraph.polyomino.org.uk>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 2/4] softfloat: fix floatx80 pseudo-denormal addition /
 subtraction
In-reply-to: <alpine.DEB.2.21.2005010037350.30535@digraph.polyomino.org.uk>
Date: Fri, 01 May 2020 19:56:55 +0100
Message-ID: <87h7wziivc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> The softfloat function addFloatx80Sigs, used for addition of values
> with the same sign and subtraction of values with opposite sign, fails
> to handle the case where the two values both have biased exponent zero
> and there is a carry resulting from adding the significands, which can
> occur if one or both values are pseudo-denormals (biased exponent
> zero, explicit integer bit 1).  Add a check for that case, so making
> the results match those seen on x86 hardware for pseudo-denormals.

Hmm running the super detailed test:

  fp-test -s -l 2 -r all  extF80_add extF80_sub

I don't see any difference between before and after the patch. This
makes me wonder if we are (or rather TestFloat) is missing something in
it's test case.

>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ac116c70b8..6094d267b5 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -5866,6 +5866,12 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx=
80 b, flag zSign,
>          zSig1 =3D 0;
>          zSig0 =3D aSig + bSig;
>          if ( aExp =3D=3D 0 ) {
> +            if ((aSig | bSig) & UINT64_C(0x8000000000000000) && zSig0 < =
aSig) {
> +                /* At least one of the values is a pseudo-denormal,
> +                 * and there is a carry out of the result.  */
> +                zExp =3D 1;
> +                goto shiftRight1;
> +            }
>              if (zSig0 =3D=3D 0) {
>                  return packFloatx80(zSign, 0, 0);
>              }
> --=20
> 2.17.1


--=20
Alex Benn=C3=A9e

