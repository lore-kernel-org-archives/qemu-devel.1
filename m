Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E5C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DACE206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/q1rwsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DACE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6dp-0002ek-NC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6dE-0002AI-Pb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6dD-0007xe-Q6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:28:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6dD-0007wi-Lb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:28:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id q4so16208491oij.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G/BuWzqNtq5jAyvfb8olfDJnA/QVrRW3asuSmhAdjVk=;
 b=y/q1rwsSc1GgE6sPP+McQtxnVvMxtv/pmc7hx4RgUCz1BhaG8GxI99e0eBjHTd3HFG
 AI49eVzL/YT3B2bku/0QLYfcvgF9g19QVrBkKntfgMfrIoRwuHlwoeHyk4e8zAufVmE5
 b/CrKmFIZENIk3AhGRlWJ9O/2W1EyuKgqQFKfP64UjYPbrCzEubmzUnuoe33ONwU/idW
 36l22JQ4PXhJ7eNu1WJ8gcdnTcLcbiTJ+kH+aMJIzT1I9EYya7nncVYzv1JMIlDranVl
 sW9eUA2tAu4lfBmG6U4+qTP2maPhvCRFXx4VS52NEwIG/T+7sY62nrA3WIej8XLrXIcg
 92LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G/BuWzqNtq5jAyvfb8olfDJnA/QVrRW3asuSmhAdjVk=;
 b=rprxa066zGD56M7T7LDTY4tzOb258wlWo3Ih7abh5jCHqT+6vO49H3vJMsS5dvYDQv
 GyxDFXGKAOYkfVxy7LKEYfHT4vZg2dj2r6YVC33+h8bu00WX38tI9mh3kaKzlcCRjMOF
 CizFr4X/OFwIx/j7uhUuv8H242JGeeFAHqnz5ENxQAB7N3U79lpFYdkFsWT4pGAz49sB
 RdgK+tvKkWQotnyHbqKWoBZa1MAboyK+rzbGW1yXZeF/IUdoBkluDsZ+KKf3ae932JNN
 HBUx618CXGLGWOIDqIboMs/6dBwxQQrJOHD0dy/y6wQ4YT2mvwIPsk41upZH+V9PF6xo
 34jg==
X-Gm-Message-State: APjAAAWQwS1q1FzJPDfXgTS/QY7Pn8EZXF4Pix11Bs/X8sbk4qOhdJZm
 jDI8pCVyqRXJsL/deu/IGwtMioTgbPYtPE4ZqRKfsQ==
X-Google-Smtp-Source: APXvYqxBsYHtIwQHZcthHeTtum77cnojxokSbK5cLQ2JxwOoOixjI3jSICIA4pyfoW3kLJjMJ0PStRsFRHlRJie4qGs=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr55776444oib.163.1564410486916; 
 Mon, 29 Jul 2019 07:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-10-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:27:56 +0100
Message-ID: <CAFEAcA-H-EsfZHHBp9Q6aFRWA2oK27AihTQDSGO4g_gWudC4wQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 09/67] target/arm: Fold a pc load into
 load_reg
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e316eeb312..53c46fcdc4 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9161,11 +9161,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                              }
>                          } else {
>                              /* store */
> -                            if (i == 15) {
> -                                /* special case: r15 = PC + 8 */
> -                                tmp = tcg_temp_new_i32();
> -                                tcg_gen_movi_i32(tmp, s->pc_read);
> -                            } else if (user) {
> +                            if (user && i != 15) {
>                                  tmp = tcg_temp_new_i32();
>                                  tmp2 = tcg_const_i32(i);
>                                  gen_helper_get_user_reg(tmp, cpu_env, tmp2);
> --
> 2.17.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

