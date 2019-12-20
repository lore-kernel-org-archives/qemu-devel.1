Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8082C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BEA206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwf3UMwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BEA206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55941 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIRy-0006d9-Mg
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIRI-00064Y-Sl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIRH-0007AQ-CW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:35:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiIRH-00074e-2d
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:35:31 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so9275548wma.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=G+iQsJvaVXNLiyWLBVqwIH7BRJSQmJmfrqs6m115aPc=;
 b=Cwf3UMwMtIPiPFQltF3FXMgMkWXLDHTd8MDTFXrYF+waYLmyKLoCu9iyvdKKUaCJSq
 R5vDH1K5dlkaewCSE6kcneExtNReHYz3IIkP0lnba/jzV4XHrqA4ELGxRMIk9OyxC7jZ
 zz8SucyOtOwfB2ED6MdrcOH8a73/3WOaU0pvsNSTT6ZMIq3hFJrEvsdbuEMstySqPAOD
 wvPUGfE1mfocfDv62k+Zz67wmz3buKE+BkLJ9XoSKGAdaYJVFgZqjYOMAJLR8ZWWTqPb
 8bWQDHEhu0Vz64DPFe1FPJ+d5mbfuvm5TektuIa3kDG44O6ANiFRQqHJzce1q0nPU14U
 ro4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=G+iQsJvaVXNLiyWLBVqwIH7BRJSQmJmfrqs6m115aPc=;
 b=VqYWn9/9/+eudKgO+2kiTrFItqxXHHQYYHWiTzSGhxtcSMQve1lK0t1ossf3CvbNV+
 rWRAnlidEba9OwBL+LdIOHnuL4VRbli00ml3OAitgZSMMlmW+MZvirN4yQHPctk3o5OG
 gnxSUZT6b3SpG+SuiUkHbmyUJJJlwX16KD8pxfskzKCHSPVO1Vu2LgxIUPoKjwh/14F6
 7qGCg3w++GQO68lZRSOaQk6hhJTpl5IMoiFmu/Rj9RT1w3yUDSFelG8CUMlHkARq8jYB
 FLVf6N1OZBnY2PpgdIhs0A+zn4yMBPUdcYRQ1ekrMDK76nZtdVWKTiIkItD0Ta8P7nyE
 rr3Q==
X-Gm-Message-State: APjAAAUFA93hJ1zNGUV0Vf7ojmDlz/tfhtcsXhmjhyZPpnbsP6Hsz0EX
 xryJIXVURgcer7yNBewTzIfWDg==
X-Google-Smtp-Source: APXvYqwWQobrRNNQvR84oyliOdNWoF76i2FkwHUsXKIpfZyVLRcI0l5zONja5UQN63uZarB97lHvHA==
X-Received: by 2002:a1c:145:: with SMTP id 66mr17092252wmb.11.1576848929812;
 Fri, 20 Dec 2019 05:35:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g2sm9375403wrw.76.2019.12.20.05.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:35:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8287A1FF87;
 Fri, 20 Dec 2019 13:35:27 +0000 (GMT)
References: <20191219185609.16748-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Set ISSIs16Bit in make_issinfo
In-reply-to: <20191219185609.16748-1-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 13:35:27 +0000
Message-ID: <87bls3dsrk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> During the conversion to decodetree, the setting of
> ISSIs16Bit got lost.  This causes the guest os to
> incorrectly adjust trapping memory operations.
>
> Fixes: 46beb58efbb8a2a32

It's not really obvious from this commit where we end up now calling...


> Cc: qemu-stable@nongnu.org
> Reported-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2b6c1f91bf..9f0afbdb75 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8556,6 +8556,9 @@ static ISSInfo make_issinfo(DisasContext *s, int rd=
, bool p, bool w)
>      /* ISS not valid if writeback */
>      if (p && !w) {
>          ret =3D rd;
> +        if (s->base.pc_next - s->pc_curr =3D=3D 2) {
> +            ret |=3D ISSIs16Bit;
> +        }

this function.

Should I be seeing op_load_rr/ri in the included generated functions?

>      } else {
>          ret =3D ISSInvalid;
>      }


--=20
Alex Benn=C3=A9e

