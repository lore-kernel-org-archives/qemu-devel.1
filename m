Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A2EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1524A206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mop84M4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1524A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1vGT-0008Gu-Vh
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1vFl-0007iH-27
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1vFj-0008AU-GX
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:20:28 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1vFj-00089t-9Q
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:20:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id k22so10399740oiw.11
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bthpOSkptiRcOaVel/B0pY+FzMDQ06IxESBvlkjlF4Q=;
 b=Mop84M4Ypl18fn2SF6YlKzZfMJv4t6U2n23rVp4zfvpjjssrXhSK0P02TLkSec/KF2
 WcGBaR6zrIW6Fft85P9ng764zyHdnMprpJTYJJZlSPeQNd/zXre+EfSMKYEd7Ryk0iuR
 84CKD3dd/5NnP3n+A0VAQNbDujmKJZ8ktw8iKv69LQQkGbhFFFUz6l9DFVfuJ2SiFL+D
 iaakPNjdtAsLgeb2drqmgtVB43aW/yCt16Zj/hKlYchdz2ApaysidaDgoe+B1x7d9ljV
 Ec0PqLd1ck0m1AFq37Hf2ZbYpoQzfEQoha4G3ArvwVoCvgrIaflFGWi3mIqJbzqnRsl5
 cIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bthpOSkptiRcOaVel/B0pY+FzMDQ06IxESBvlkjlF4Q=;
 b=jj2uzTPBLbsWEZbD1a5OlS0d08jb86tZ9yWDcIFLzikmaRvDToqh6QqRSj4kDS8xcz
 5rS+j54FoepPVvaIASmcJWM9FiRSMlzNwFeaNRYyoC3wFVRHAaLglA6rzAImkjKY1D2B
 U7tnxjAs5TNoRB2YjIp3S57eGwwhNE/A5H/PdLjj7SIh3lm4nDENOxkp8eBt1Elvvb5F
 I8YbpCVuD5tHUIW2GccxX519pYzWEBHALcQtQXlzQ2NaKHOBM0E3fz8Ay80IlBE1PgQw
 pZdN/62lCRyVc0+SdPbd0HQDds9JHaoZe+7PBvy/HOxT9SZrSiDYs7dQh7Q0gKiJegiC
 cS7A==
X-Gm-Message-State: APjAAAX88bcDbCxTCSXmu10DH3JYwoE7KFOQmp1e8yfHP17DHAUhyWE7
 hubaDfur0mLExp9cAnw3bffVIJuZnwmJGVpnRdKOUg==
X-Google-Smtp-Source: APXvYqyTYTETxYgyjvGYp7FEcDJt+3fd1AyWigYayBJpYjIY9NgR2OdaUDp3O3uV7cziIOBkYfdMauoTlsS9aW5hqdQ=
X-Received: by 2002:a54:4718:: with SMTP id k24mr9348351oik.146.1566750026184; 
 Sun, 25 Aug 2019 09:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 17:20:15 +0100
Message-ID: <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 35/68] target/arm: Convert CPS
 (privileged)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c       | 87 +++++++++++++++---------------------
>  target/arm/a32-uncond.decode |  3 ++
>  target/arm/t32.decode        |  3 ++
>  3 files changed, 42 insertions(+), 51 deletions(-)
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index 18c268e712..354ad77fe6 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -44,6 +44,7 @@
>  &bfi             !extern rd rn lsb msb
>  &sat             !extern rd rn satimm imm sh
>  &pkh             !extern rd rn rm imm tb
> +&cps             !extern mode imod M A I F
>
>  # Data-processing (register)
>
> @@ -340,6 +341,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
>      SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
>      HVC          1111 0111 1110 ....  1000 .... .... ....     \
>                   &i imm=%imm16_16_0
> +    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
> +                 &cps

In T32 the CPS insn overlaps with the hint space (hint insns have
bits [10:8] all-zeroes, whereas all the valid CPS insns have either
M set or one of the imod bits set) -- why doesn't it need to be
in the same insn group as the hints? If we're going to put it
separated in the .decode file from the insns it overlaps with
I guess a comment to that effect would help so it doesn't get
inadvertently reordered with them.

CPS shouldn't exist at all for M-profile, but the legacy decoder
got this wrong too, so we should put that on the todo list for
fixing later (along, maybe, with UNDEFing on some of the
unpredictable combinations of M/imod/etc for A profile?).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

