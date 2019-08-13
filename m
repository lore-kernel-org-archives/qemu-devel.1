Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E3C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 05:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36F920840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 05:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTKYwsg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36F920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOwx-0005FY-Bq
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 01:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOw4-0004NG-TN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOw2-0008Dg-Qz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:01:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOw2-0008Bj-Jk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 01:01:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so106611493wru.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XRX+Nqb80b+BOXQ1E9eo281yYke+SDQdkxWxU2DJ+c8=;
 b=xTKYwsg2nTwaTjnpilOZUalEH/kJ7qO7lzKXZNfK3wDlqdRG0mYOsodiY8OYCrKnds
 raPF/w8bdm66L7iY2xsHWfZ8uqWSR410cK4emBrj7uxk0h54vrQK6ZDAZlnUWCbQUMuk
 GC1e3iD8sZRfbV2vDd7ld9N1ZKqhcHo+sDb42R7nwxUbpm2+FOZkhwHqD+BKrOcJ4umn
 VLPsWoXcanCDAtBp7GZcgKDjGLa9oks5WMgaH+4PmPCjojsJ0lsC38QLWfmXvbq7DHeW
 5W4otA9q+IVjmGsRlWzgEpNgQi8eu8vdeg1DdsclM8ZU4LZ4rSNFhA7LTaMwZ8uJS21h
 9FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XRX+Nqb80b+BOXQ1E9eo281yYke+SDQdkxWxU2DJ+c8=;
 b=PfMRKqfc3tus49f9FLKgsh8FshkLdeOZJKUl0Y9YS5cT/m9yqDWMByJh85h0lD8WdA
 J/BoWvodhOzBMLGePHrJa7cn3I8I4cHl1GhakuvIwIthBboUD+pdFC7As1B0XJXctWN3
 dIqkPgLa1/DX3mmSYRNBUElumeRSG/K67hsksEx/kCrKzxBKnt2u+IMd2ZTZEp62OkNl
 5D05SZPR5RSEVvah0GidsSAJqKXwzFr8cReaisdVWwc28ipijR2A49rW8d0pyExJBHms
 UHkUxQcT7Qej7lm+6pOpWgnwrCpRlo+nIPihuRv1mHDs3ArziPNAxtjhx2TlXGlUQeoL
 FARQ==
X-Gm-Message-State: APjAAAUqIzTpI17RnOC8C+6FZ4J6zu8Xg/lP3sQEjTWsOb4+TNwACSV7
 OaGdQIbXsMhr2sdROw2ayRv7DFXB8GPndw==
X-Google-Smtp-Source: APXvYqwHrTsh1A7vu3/jwAxLn70tMCtGIGtbI/+kc7JNkolgti5rPP32Fglefp7tLprTHMu3GfK4PA==
X-Received: by 2002:adf:c613:: with SMTP id n19mr43956692wrg.109.1565672484655; 
 Mon, 12 Aug 2019 22:01:24 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id a8sm420665wma.31.2019.08.12.22.01.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 22:01:24 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-15-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3d450527-5bdd-9da2-f56b-341051f6ba23@linaro.org>
Date: Tue, 13 Aug 2019 06:01:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-15-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/39] target/i386: introduce
 mnemonic aliases for several gvec operations
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> It is helpful to introduce aliases for some general gvec operations as
> it makes a couple of instruction code generators simpler (added
> later).
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 23550a21d3..03b49411e5 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4493,6 +4493,13 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-function"
>  
> +#define tcg_gen_gvec_andn(vece, dofs, aofs, bofs, oprsz, maxsz) \
> +    tcg_gen_gvec_andc(vece, dofs, bofs, aofs, oprsz, maxsz)
> +#define tcg_gen_gvec_cmpeq(vece, dofs, aofs, bofs, oprsz, maxsz)        \
> +    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz)
> +#define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        \
> +    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
> +
>  static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
>  {
>      enum {
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


