Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C00C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEBC2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIzVWh1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEBC2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Lm0-0001sS-RI
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Lky-0001Kh-3B
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Lkw-00040B-Oz
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:38:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Lkw-0003zf-I1
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:38:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id 16so13181653oiq.6
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YOpw9/8CF7yxsaYpT9hZb6dDlRxBOI8qBaE+1q63LEg=;
 b=dIzVWh1s36l9rhUuB535e7WO6clJEzS09mxxeTCz+auLFW0KS6H1TFq8NLPv9S5FX/
 1+g7DZihacfm1g+c2A63yWajEBviNGXUQSB8k7envnJzE4dMMHCug1V6Jp+xM2VM9vdw
 k4QdjH7HmjoJ+QZkscoj+nx9l+q8M9zBQILZl2Nt2TXuX2VqPRwAEIp8heMvB94EFWkp
 d22+/JKHxvhbEH2mvTwpT47iItSCQnjWRQj+J+SCtad/EFsnU1fUlvfZOA2W3GYO5uJZ
 LnXF1GVlgunWU3Lvgu5xi3+9qpPpc5X16JgH1jmsuajDfiMyiSnIEodagbXn+LthD5gZ
 l/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YOpw9/8CF7yxsaYpT9hZb6dDlRxBOI8qBaE+1q63LEg=;
 b=MRld4vjHSiNGHYk1+JXOLX98LdEe33oLeVWt7WSCpOHqg+gDA1zJTQ/afnL9SBsO6H
 mxDUueOLaT3zeauZ/AwLkiDRZrmHQeQuOyIB2dN/5Lp8ExgQttb07M549O+Q7TVCa3Pi
 3AM9RrAesdsa1JbzAg8J7xpGU7TcpUSxD7FrnbmJy5c2WBI+S7ukgXxcC6nqpS518Quy
 eRjAuyoize2IBAPdKuymJ/ElRZKgo5kDJDD8xixh1ln0W9lvX2Z9m06pX3bqV2B3RVNs
 thBDIrpoEFpW+vF5vVqYdRdirY/k7ibzD4prbN9RpcEO5S78Oaz394jqBDfVudBReK1g
 /3sA==
X-Gm-Message-State: APjAAAVXtMEZkKGFZ3AKxpx5cWAvGvyIyjGzNQL2KBvuEU4C5fgsmLcO
 ky4Wxjbf0LDg7foNfzDwdqI3uWSQnOI6mu1y/FMKbA==
X-Google-Smtp-Source: APXvYqzOhho587Kstvt1ZCOFF82ZGQztjhfxmuWQNW9Psau5H32OIoTIBxPQzD+EGn313/MU5ZLLEptFeAwsOffUKd4=
X-Received: by 2002:aca:4b86:: with SMTP id
 y128mr13848848oia.163.1566851905494; 
 Mon, 26 Aug 2019 13:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-63-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2019 21:38:14 +0100
Message-ID: <CAFEAcA-iBjMbeqC92A69Xn_Y0qnOu93+VhQwqw+hOeBYRXrBjw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 62/68] target/arm: Convert T16,
 Miscellaneous 16-bit instructions
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

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> diff --git a/target/arm/t16.decode b/target/arm/t16.decode
> index 98d60952a1..4ecbabd364 100644
> --- a/target/arm/t16.decode
> +++ b/target/arm/t16.decode
> @@ -210,20 +210,33 @@ REVSH           1011 1010 11 ... ...            @rdm
>
>  # Hints
>
> +%it_cond        5:3 !function=times_2
> +
>  {
> -  YIELD         1011 1111 0001 0000
> -  WFE           1011 1111 0010 0000
> -  WFI           1011 1111 0011 0000
> +  {
> +    YIELD       1011 1111 0001 0000
> +    WFE         1011 1111 0010 0000
> +    WFI         1011 1111 0011 0000
>
> -  # TODO: Implement SEV, SEVL; may help SMP performance.
> -  # SEV         1011 1111 0100 0000
> -  # SEVL        1011 1111 0101 0000
> +    # TODO: Implement SEV, SEVL; may help SMP performance.
> +    # SEV       1011 1111 0100 0000
> +    # SEVL      1011 1111 0101 0000
>
> -  # The canonical nop has the second nibble as 0000, but the whole of the
> -  # rest of the space is a reserved hint, behaves as nop.
> -  NOP           1011 1111 ---- 0000
> +    # The canonical nop has the second nibble as 0000, but the whole of the
> +    # rest of the space is a reserved hint, behaves as nop.
> +    NOP         1011 1111 ---- 0000
> +  }
> +  IT            1011 1111 ... imm:5             &ci cond=%it_cond

This is correct (same behaviour as the old decoder, but
it looks a bit odd here because it's not the same as
the fields defined by the architecture (in particular the
'cond' field is not the same set of bits as the 'firstcond'
field). We could maybe comment it:

  # Bits 7:0 in IT are architecturally simply the
  # new PSTATE.IT bits (despite the instruction description
  # splitting them into 'firstcond' and 'mask' fields).
  # In QEMU during translation we track the IT bits using
  # the DisasContext fields condexec_cond and condexec_mask,
  # so here we massage the bits from the insn into the form
  # that that optimization requires.

(Or equivalently we could just pass a single 8 bit immediate
to the trans_IT function and split it out there, I dunno.)

>  }
>
> +# Miscellaneous 16-bit instructions
> +
> +%imm6_9_3       9:1 3:5 !function=times_2

Would it be worth adding support to the decodetree script
for letting you specify fixed bits in this kind of field-decode,
so we could write '9:1 3:5 0' rather than having to specify
a multiply-by-2 function to put the 0 bit in ? Or is it
not likely to be common enough to be worth bothering with?
(Not something for this series, anyway.)

> +
> +HLT             1011 1010 10 imm:6              &i
> +BKPT            1011 1110 imm:8                 &i
> +CBZ             1011 nz:1 0.1 ..... rn:3        imm=%imm6_9_3
> +
>  # Push and Pop
>
>  %push_list      0:9 !function=t16_push_list
> --

In any case
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

