Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82534C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEC1246AD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ca1srChw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEC1246AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnWE-0003Jm-FB
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnQl-0008EZ-Vd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:32:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnQd-0008NW-Mf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:32:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id n16so2967902pgv.13
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qMCGCMxNu05t0BOq9LAHrQRdxysIBp4boivRz8gf6SA=;
 b=ca1srChwQrRbEvjn9w0ytMZ0YeDHDZ3Cn7g+xLM40wRqBar27XnhXKlNlKvbe/mBAU
 2yW7MLEyL0vKQRkWq2FdS0joSWo4wtStVNlIcW5jx5uYHnv7qu0Sb4mZpltSKN1/bpEZ
 S8s3nU7kYO8Y7EsFNY9M1MQMWTdV7H3eJUsCTUmDCvOm/h2Ia9rHlKpho+Of2uJcEs0o
 GvTUxM8fKcCPNs747NDub+2cYwIQslJ3w79l+w8cDqmP4D2GmpVaRLnvw4clgZb5BsRA
 FavyarTzcA9zw0zW6ybtMHa4jtf8iZ81hvPJLxiL2tax1PeTysZOVf+NGFVgAyqPC5YS
 yR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qMCGCMxNu05t0BOq9LAHrQRdxysIBp4boivRz8gf6SA=;
 b=LPA3MPqolrV5ayB7kmvIXB4HQ2RCr4jZxDca+FhQssV27DSq2zi0rmhhqVWryrs6l1
 OBNQjQc3s7YWD8/3OlBHneIGah3YiVrTY0PN2qdoT2737hNTtWcOgtflcmV94pjLZMWj
 vTsEi+M6YRPjl0tCXIMXWE0Q5LAjgf7SsEKrB0HbeuapcP64lSMGNYJI24udC0RUwGEh
 d7qM7JvqlvNf42IQLiIijlbeu1L9yvV2ZtI97HqqnMp7DYvvMHFsbPQfjgGF8glHNlIk
 xD1VAbI3MTpp2wFcK8MuQb0RzsW9iqE4dLKWnW/ZHAN8a5fWeyEAE0jy5vtMsQTImjh9
 9R7g==
X-Gm-Message-State: AOAM533OB4G21riJ0ky6qKhSVcpdYlqPCkuz90aSYx4nPcDOHJcJME/M
 ko3TXNMFg7lFV9Ua9vxpuSuhnw==
X-Google-Smtp-Source: ABdhPJz5PZBeCGANwlteJy94gblIbZlVY7VhVwNE8S5N5FEpNWsT5mncsX2Vcgelebu0igtMUEpdbw==
X-Received: by 2002:a62:92c5:0:b029:156:6a7f:ccff with SMTP id
 o188-20020a6292c50000b02901566a7fccffmr7783555pfd.39.1603899118236; 
 Wed, 28 Oct 2020 08:31:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 13sm6550255pfj.100.2020.10.28.08.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:31:57 -0700 (PDT)
Subject: Re: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b69cd31b-9a0d-7244-aa79-f035b4bcacac@linaro.org>
Date: Wed, 28 Oct 2020 08:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 9:18 PM, Chen Qun wrote:
> The current "#ifdef TARGET_X86_64" statement affects
> the compiler's determination of fall through.
> 
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/i386/translate.c: In function ‘gen_shiftd_rm_T1’:
> target/i386/translate.c:1773:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>          if (is_right) {
>             ^
> target/i386/translate.c:1782:5: note: here
>      case MO_32:
>      ^~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index caea6f5fb1..4c353427d7 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -1777,9 +1777,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
>          } else {
>              tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
>          }
> -        /* FALLTHRU */
> -#ifdef TARGET_X86_64
> +        /* fall through */
>      case MO_32:
> +#ifdef TARGET_X86_64
>          /* Concatenate the two 32-bit values and use a 64-bit shift.  *
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

