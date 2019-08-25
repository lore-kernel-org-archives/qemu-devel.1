Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F09C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E469D2053B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/YNuK5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E469D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1upi-00008F-2q
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 11:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1up1-00089L-OT
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1up0-0004re-E6
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:52:51 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1up0-0004rO-5H
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:52:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id r20so13004434ota.5
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W0IcHQridGAGqKfGqNzNcl38G0UTF3CBokZbn4Mntks=;
 b=g/YNuK5NvXmXb2O80G/S9qH/dsGowtd5lR5vkec1uEbwfkXZkV8g1/acGZ0y1Hzzt2
 NAYSZNJRaXhSDLJnk60x/NWMMG/FEMpQHY5od3AmyaaLB8HHhuAGQj+qRQC+39XS8KEe
 PxBpHXXzD9b0U35o3nSXniD5c5rSzolne9xo9OOp4Ewi0MTVHWsrBVrZ/GWuUXlJO/NZ
 3T7B29EkolN7wWz7AYgrgKnO+hNsI9vmDJ3wrdYZG6Ldq6szVU9YUBJyedHo0UCo/cEf
 qiWQMIy0jY/VVt0qvNGZUJbWsPurzb4HbRT68qjzyGJ837tPQgRPVDWNT7nOSe/11r3n
 eCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W0IcHQridGAGqKfGqNzNcl38G0UTF3CBokZbn4Mntks=;
 b=lJ1YkD3mHMgQmLhCoZwGjwbzMeod9ztRNaSyO1QXx66dVxoQjtQVb1/+P8TKbAuA00
 5O/Ipy++AV5OpDbQO/mRrJaEVvp0PMteidUWz4IYAIJeJyNXbIgQyRH+K5jJTbzPHMVw
 gy/rQCk9gTYbex7Wt0rudYKtAja54oKnTPZW3SW8TmPwF5/Rw0qSsPIbxHj6V+6eGeAE
 MZsF/5dJpMOhDcQt02KI85Ik27Yl8Bz6vq0AhneDAMjSHrFo2EvSpzJoEK35Zp5QPHKH
 Xd4SaWCVyGNcE6GJAvIoSSJahsCUbhEx4n/vNDs8fUtn1FX5cEw8nNZHTx/Or3pbVL0Q
 Xe4A==
X-Gm-Message-State: APjAAAXlTxp3L3wRKAjn2AX22iM6f/gdcYz0z66UhCzwztNMJ+YQQR2v
 PKtkE61b4ZGvEZXRjiFsyWKdQDW7KIv4PrVNpDLwyw==
X-Google-Smtp-Source: APXvYqwkLz4RNsaVpCs9vhvyFN0sFpxYVaZaRpOLn/P9P+Voi2uOQq1IBMyZVCzyJ7AXJxzmcIOd1rMUVqI7e1gghD8=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr11412380otq.221.1566748369374; 
 Sun, 25 Aug 2019 08:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-35-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 16:52:37 +0100
Message-ID: <CAFEAcA9Fgqp2n7WraoePuW==4MW9iJ6WWR=xAfPf2sOhmAuD=w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 34/68] target/arm: Convert
 Clear-Exclusive, Barriers
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
>  target/arm/translate.c       | 122 +++++++++++++++--------------------
>  target/arm/a32-uncond.decode |  10 +++
>  target/arm/t32.decode        |  10 +++
>  3 files changed, 73 insertions(+), 69 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e268c5168d..6489bbc09c 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10038,6 +10038,58 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
>      return true;
>  }
>
> +/*
> + * Clear-Exclusive, Barriers
> + */
> +
> +static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
> +{
> +    if (!ENABLE_ARCH_6K) {
> +        return false;
> +    }
> +    gen_clrex(s);
> +    return true;
> +}
> +
> +static bool trans_DSB(DisasContext *s, arg_DSB *a)
> +{
> +    if (!s->thumb && !ENABLE_ARCH_7) {
> +        return false;
> +    }
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    return true;
> +}
> +
> +static bool trans_DMB(DisasContext *s, arg_DMB *a)
> +{
> +    return trans_DSB(s, NULL);
> +}
> +
> +static bool trans_ISB(DisasContext *s, arg_ISB *a)
> +{
> +    /*
> +     * We need to break the TB after this insn to execute
> +     * self-modifying code correctly and also to take
> +     * any pending interrupts immediately.
> +     */
> +    gen_goto_tb(s, 0, s->base.pc_next);
> +    return true;
> +}

The guard conditions on these don't look right for the
Thumb case -- the old Thumb decoder has them exist only if
we have feature V7 or feature M. Are they really equivalent?


> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index c8a8aeceee..18c268e712 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -305,6 +305,16 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
>        # of the space is "reserved hint, behaves as nop".
>        NOP        1111 0011 1010 1111 1000 0000 ---- ----
>      }
> +
> +    # Miscelaneous control

"Miscellaneous"

> +    {
> +      CLREX      1111 0011 1011 1111 1000 1111 0010 1111
> +      DSB        1111 0011 1011 1111 1000 1111 0100 ----
> +      DMB        1111 0011 1011 1111 1000 1111 0101 ----
> +      ISB        1111 0011 1011 1111 1000 1111 0110 ----
> +      SB         1111 0011 1011 1111 1000 1111 0111 0000
> +    }


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

