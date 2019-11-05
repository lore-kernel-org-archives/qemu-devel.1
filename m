Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9759C1747C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A446E21928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru0dZVQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A446E21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRzzD-0006Ve-QE
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRzy6-00064m-3w
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRzy4-0000QT-Qe
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:38:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iRzy4-0000QB-M1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:38:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id s3so10198111otk.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QAoOhB3KV4Sec+eLe7JvBaFHkM0Yy6BuduPLpvzs8+M=;
 b=ru0dZVQeqyFJafnMAM0yw7Pf0W4yUR78z4QYPAEsaM1mHTkoTreYyS+n/33dC0FmlN
 ZEvjNHT9YITBF6WGyez28aDxOoGsagtek6b7CXJL7iAPCI/PIouQpE5lBe6iGohva0Zj
 AM4+MH3vdH4IRp8nKWRwg+MFoV/gJERHq0E3Nd1ZXS+S1Vu8jtkxCaQ7Gz1gMx1gwqD4
 c92hJHINi/eaHM4UnER5bzlnuWJoUiWxAoC9vollVKc9WAwKlDbMuB/Q+O7gMvpKUwDA
 rZaYVMe3OFXrsF0fwRJzMMg/jxOHMWjRmjLJd5nX6lF0etSQNkmf3nG2GkBVLgQUunby
 T8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QAoOhB3KV4Sec+eLe7JvBaFHkM0Yy6BuduPLpvzs8+M=;
 b=tPW/zOe4j5Utz+ryZlJlVifIr59DGwTQs+V6kMQ4Fn2u41MePTKSfEH9RPWZFi+xAF
 BXSl6viKjyb6YtfrzdAIrt/KvWRChgYz4E6YUX5f+6X80dU5UMUAXXTGNy6I6wev2h+h
 5BTCCJrgv9UxfVs7CGeytSlA1M4LVcKbT1Qwb9hvEn6ziKAwlK9ee/rDfW1VLjJz6RR0
 UKOeicaBJQPyZ8tDmpPmJ7F6SCd3L6bdSkRYHzMlWbO+0ekuPPn9QgmDYe217c3H7rDW
 OWrVJisxIxvAxg3p1UAeJdXvnczC2Hwin1AanKhNL20BuaYHaXrYKL3FOCW+OPCtIJoi
 Mgog==
X-Gm-Message-State: APjAAAV5In1xz+YCgm3nPIkUXt9hYRsK66nwJlhIRZe890CGwCcoUTZ6
 kDgQwLnf4xz8+kR65IGYA5uCLbqledW3Std/DKQ=
X-Google-Smtp-Source: APXvYqyZ0EcJYNs9sXwf4dZJ1XBkuFp76h2VFKRd9uXeVGXT9mnhcSL8/sU0S8B4MgsgpXAFqqWjXpExhQqYpinxbo8=
X-Received: by 2002:a9d:68da:: with SMTP id i26mr7553931oto.295.1572964679707; 
 Tue, 05 Nov 2019 06:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
 <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
 <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
In-Reply-To: <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 5 Nov 2019 15:37:48 +0100
Message-ID: <CAL1e-=g6ctnzUSgq3eRn98nOMPJ88ucUNX7xc5MxCr6J=k4YMg@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 5, 2019 at 2:23 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/5/19 10:46 AM, Aleksandar Markovic wrote:
> >
> >
> > On Tuesday, November 5, 2019, Aleksandar Markovic <aleksandar.m.mail@gmail.com
> > <mailto:aleksandar.m.mail@gmail.com>> wrote:
> >
> >
> >         +
> >         +/*
> >         + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> >         multiplication
> >         + *  and shifts the result one bit left.
> >         + */
> >         +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
> >         +{
> >         +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> >         +        return true;
> >         +    }
> >         +
> >         +    TCGv R0 = cpu_r[0];
> >         +    TCGv R1 = cpu_r[1];
> >         +    TCGv Rd = cpu_r[a->rd];
> >         +    TCGv Rr = cpu_r[a->rr];
> >         +    TCGv R = tcg_temp_new_i32();
> >         +    TCGv t0 = tcg_temp_new_i32();
> >         +
> >         +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> >         +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
> >         +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
> >         +
> >         +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
> >         +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> >         +
> >         +    tcg_gen_shli_tl(R, R, 1);
> >         +
> >         +    tcg_gen_andi_tl(R0, R, 0xff);
> >         +    tcg_gen_shri_tl(R1, R, 8);
> >         +    tcg_gen_andi_tl(R1, R1, 0xff);
> >         +
> >         +    tcg_temp_free_i32(t0);
> >         +    tcg_temp_free_i32(R);
> >         +
> >         +    return true;
> >         +}
> >         +
> >
> >
> >     Hi, Michael.
> >
> >     The way I understand the spec is that a->rd and a->rd must be between 16
> >     and 23:
> >
> >     https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html
> >     <https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html>
> >
> >     Is my interpretation right? If yes, where is the corresponding part in the
> >     implementation?
> >
> >
> > Or, perhaps,
> >
> > TCGv Rd = cpu_r[a->rd];
> >
> > should be
> >
> > TCGv Rd = cpu_r[a->rd + 16];
> >
> > (and the same for rs)
>
> This happens during decode:
>
> +%rd_b           4:3                         !function=to_B
> +%rr_b           0:3                         !function=to_B
> +@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
> +FMUL            0000 0011 0 ... 1 ...       @fmul
> +FMULS           0000 0011 1 ... 0 ...       @fmul
> +FMULSU          0000 0011 1 ... 1 ...       @fmul
>
> This means that a->rd = to_B(extract32(insn, 4, 3)), and
>
> > +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
>
> et voila.
>

OK. Thanks for clarification.

>
> r~

