Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F5F208B3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdv8Vjq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F5F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsrZ-0001bM-KC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsqq-00015o-Vx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:16:45 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsqp-00010o-AN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:16:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k15so1862028pji.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xIZy0jftdHuJ7as1pN+crDXM1ZKn8Kb3tUg6jOECea0=;
 b=jdv8Vjq1o0gEPKGVSirYaYb4gPtK3Sn1q+NdUxRC3kolHsyX/Q4ZF4HX9LMzst5mUu
 +LhWmB/87P+F1Q1kMqpqQ4pQhRb9oi7PEQKGkRP0yPuJSVJAqezvL76lpWgEgF5X1GkG
 i38j69wM+aPObd+5ExccYGwVdD5HxksHr7+TgQVo6QeONdj5zNoq4bzj2rkeNujA+BL7
 AumylVOKQoFomJ1Ux80HcBnXvnB6nvU9BmjKRWXNTS55jUxxpikRXkj1W5w9xb0EfmTu
 /EeBSgvSuywCQmk/E+JvRZPmEXwKlFW8jIwYNHOfExIxPAGvCw/z+8Cf+beai3QXNhjk
 lLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xIZy0jftdHuJ7as1pN+crDXM1ZKn8Kb3tUg6jOECea0=;
 b=SQTauwENMlS7MDnu543vMqoH9IHQx9Ez/SRoeiGcmENijVpH+rmQROv1jX5vtj3BgA
 IiPt7uUM+/+naaXLn58rUQqT7Hh/py+Xu1BVmm/Uzr3DY8JxIVe3v7KjSu4KSngPGKs7
 msreWIC3W0PWxAR2fW90N4KbmWORHDTzkXsrk2TCG/u5pthXq3RavhZUu4lq8FIM4XPC
 yFxOz2oyS8Jg/vb6nUnM7dv/8Saj5qHUV68dKzOTAtkVhOjfW4XcHjnhh682B/jOVy6J
 12N01qZLZTnqvhF8Bsk3R+PNQggzQDwOccFc8hvgQxyqn+YSOMk4h2FBsy0r1LdOr6KV
 DRNg==
X-Gm-Message-State: AOAM530HUAroyDAKME058QuM+L8lKeyqvLi+Lf+hQEwMhdf5Yp90T8xw
 n7Y4q9c6XIiuMKcIK/TR5d7E+w==
X-Google-Smtp-Source: ABdhPJw2Wv8DjKmSeSxinKnLpeqf/CGYRpoT3Ybm/mqklmmVF51T6ZjA+Q3SXDE1nzMbGCgY12usqQ==
X-Received: by 2002:a17:90a:aa90:: with SMTP id
 l16mr4156422pjq.210.1599153401689; 
 Thu, 03 Sep 2020 10:16:41 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b18sm3189760pgk.36.2020.09.03.10.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 10:16:40 -0700 (PDT)
Subject: Re: [PATCH v1 7/8] target/mips: simplify gen_compute_imm_branch logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <64aaeb37-04fd-d57d-3c1b-3a8d70ec9f2a@linaro.org>
Date: Thu, 3 Sep 2020 10:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903112107.27367-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com, f4bug@amsat.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 4:21 AM, Alex Bennée wrote:
> One of the Travis builds was complaining about:
> 
>   qemu/include/tcg/tcg.h:437:12: error: ‘cond’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>        return (TCGCond)(c ^ 1);
>   ../target/mips/translate.c:20031:13: note: ‘cond’ was declared here
>        TCGCond cond;
> 
> Rather than figure out exactly which one was causing the complaint I
> just defaulted to TCG_COND_ALWAYS and allowed that state to double up
> for the now defunct bcond_compute variable.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/mips/translate.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

This looks like a good cleanup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

