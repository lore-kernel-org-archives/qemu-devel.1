Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E57C742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEC821019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuFfgyAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEC821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwJL-0000kQ-6y
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <christophe.lyon@linaro.org>) id 1hlwJA-0000EU-3C
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1hlwJ8-0003Tj-Mq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:13:56 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1hlwJ7-0003QN-5u
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:13:53 -0400
Received: by mail-lj1-x241.google.com with SMTP id p17so9516254ljg.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uhJpzbsC/oFdCLwbLV5P5ufOUnvxcC9mJVeSTRIcE7Y=;
 b=zuFfgyAQcKdXDsWNwlh5r+NYd4gSQE8Sblm+hI3uVJAEdjjDZAu5c7vLnp1lu7BAAG
 RR36T9i6whI7QR5B9WHbDxCdYnN/QTXTMyHppDra+nErjfRtXYl8naJaWjPLgI0gZLhK
 ulnwtAwgdXvWhAEFu65FR3HUqfHHcp5nGm+1OzrJZcY1DaErAZ0oGuGIzCw8VBzYRQAg
 fOhq8g+Y9+YfnhWzN6iC/IdxwCgOh2BMO8svvVPGwk1E715EBY8F5qGqFsvCEhEC3bPa
 JwoRBe5YrumeurSkW5EapYGgKyFu9S0U9NL6nRA4Sg0Qfpi8wXirZ4VGixRHpf1BThSM
 akYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uhJpzbsC/oFdCLwbLV5P5ufOUnvxcC9mJVeSTRIcE7Y=;
 b=ryaMsf4BkC9TXETvumBJk+0w5CUiSxYtrq0X842lFl15U4tjxL+1LP0KyMRsxKj+VF
 JUNOVBToakMSMV1v1Khb/hXxyK2o+8wTlCNdfKwtuEPtHo72giWcF2VFzijfrI68B1gm
 ijxpYg9RykAe9rCVr+QvGfXb7NrQSK6+peAHnGSJe4/77F4XBCUY5LNcKXZyrljEkApj
 4LPcwrnaee9iscW3h4FRxV81EzaXJUBai3Cp+srWReRqgY9pKDWncb4thirfXLoZwQa6
 tcCA5sz0f1lKfqhMjN3/U92Vr1BY73Xnz5a77LTO/FLLcpEQhMYC3avRHXbG5LFWq+v6
 UV/Q==
X-Gm-Message-State: APjAAAUSUplmywqp1d4i5a1CdRslr2Tkg/G/lsncgd1XkBsN5Xfcm7YC
 XAvFVRhFabyKnaSHKee7FsuJH331t/0sppfohD9e0Q==
X-Google-Smtp-Source: APXvYqy11XsrnjNSEFKOh9vTkHRmdSkFjA9IPhEHkV0qY2KgiwUig2qolpPayq8LTYOHMpugnv5v+vUcwMYbI3ML/rQ=
X-Received: by 2002:a2e:800c:: with SMTP id j12mr5823282ljg.22.1562940830223; 
 Fri, 12 Jul 2019 07:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190711131241.22231-1-peter.maydell@linaro.org>
In-Reply-To: <20190711131241.22231-1-peter.maydell@linaro.org>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Fri, 12 Jul 2019 16:13:38 +0200
Message-ID: <CAKdteOYTgv1OenmRhbVMTjC4vtc+8B7w_=ZtaOD3q8Y8zNeqKA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1] target/arm: Set VFP-related
 MVFR0 fields for arm926 and arm1026
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 15:12, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> The ARMv5 architecture didn't specify detailed per-feature ID
> registers. Now that we're using the MVFR0 register fields to
> gate the existence of VFP instructions, we need to set up
> the correct values in the cpu->isar structure so that we still
> provide an FPU to the guest.
>
> This fixes a regression in the arm926 and arm1026 CPUs, which
> are the only ones that both have VFP and are ARMv5 or earlier.
> This regression was introduced by the VFP refactoring, and more
> specifically by commits 1120827fa182f0e76 and 266bd25c485597c,
> which accidentally disabled VFP short-vector support and
> double-precision support on these CPUs.
>
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 1120827fa182f0e
> Fixes: 266bd25c485597c
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836192
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> v1->v2: just move the arm1026_initfn() part up a few lines;
> this seems trivial so I've retained the reviewed-by tags.
>

For v1:
Tested-by: Christophe Lyon <christophe.lyon@linaro.org>

Works for me, thanks!

>  target/arm/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e75a64a25a4..05b78ba2662 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1666,6 +1666,12 @@ static void arm926_initfn(Object *obj)
>       * set the field to indicate Jazelle support within QEMU.
>       */
>      cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZE=
LLE, 1);
> +    /*
> +     * Similarly, we need to set MVFR0 fields to enable double precision
> +     * and short vector support even though ARMv5 doesn't have this regi=
ster.
> +     */
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
>  }
>
>  static void arm946_initfn(Object *obj)
> @@ -1702,6 +1708,12 @@ static void arm1026_initfn(Object *obj)
>       * set the field to indicate Jazelle support within QEMU.
>       */
>      cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZE=
LLE, 1);
> +    /*
> +     * Similarly, we need to set MVFR0 fields to enable double precision
> +     * and short vector support even though ARMv5 doesn't have this regi=
ster.
> +     */
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
>
>      {
>          /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0=
,0,2 */
> --
> 2.20.1
>

