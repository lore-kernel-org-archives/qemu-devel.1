Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F385C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92F820665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8P99N1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92F820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUDo-00074A-0d
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUCl-0005ou-HH
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:23:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUCk-0005N2-2H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:23:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so280361wmd.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JbeFO4iy8pjMTwUjmCYxV22BIgGyGEynAMghR07D2Wg=;
 b=g8P99N1EbGEOg5WXrJNc+RymHEQvCKmnl2/n0lnRtKkCkkHOWeelUqSKl1BWb1JYJS
 ILicEIy1yCVxQ/nN4j0KTUvM1V6FZPz+A02nCHxXKZu/vYDZNFguZQ46Bat0nrbejJvA
 kZD19MtzHykHP4k1WqPGp7VrOU5wKNXBNS9NMLXHlt1OB912zpiWIQkE4DsUD8LKnSaD
 oNFLjpF7UUwr8klp4j6XhKIl91N5HKG89Ao+ZQ403YXOqZAQKgWbdJ6PKefoIDSxB679
 rVwI78+WQh1AAgnIHOncrPvVXhPC/jTN86resRD+HJFpvHGX3rKt89rueeKtayB9Ltmk
 MiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JbeFO4iy8pjMTwUjmCYxV22BIgGyGEynAMghR07D2Wg=;
 b=WIOfOvOw0jzg9sUxYVsN9uMERvaF8hDSE1tum8WEopdMAJ++mRRvPWQz6wgabXySY8
 IFuHXSlpkNQWXOpSyQq7gL4eH5wbHVQPLAOOAV3qJWD7RO20wZ7HhI+Cy5OPzbKTHWrJ
 FS9kafg3Sf1D0ecCLkCJwCKdA+7SFYbhVo7qZr8BC8PyPsKNMKC4FgeJFL109PynRxTp
 ulL7tfNAuRXVjo4piRpjym+PPaNg33zxfhWpYHZpLn6iCP0TBzguJyw+Lbm/ZkzQ38Ky
 uc4kbJ0f4osJengFFUNTGYkMf6NXCwf7V00Big43dpyq0ZfnLMH+rdQbSct8tJOsqjzT
 NH4A==
X-Gm-Message-State: AOAM531m5ebPdE26ciZi3FQax7n/SlMmCTimcQ9xJW4RD+U2D4jygh66
 mOQBahWEceD6/qFuMiQOdTc=
X-Google-Smtp-Source: ABdhPJxoPsjYugaZmB6ObEOhoHlshyLYw2PO9jfznAFiL3eSXfGGT6QUEXULQHCbGCvDRPUMZp0Fiw==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr445648wma.110.1601918596649;
 Mon, 05 Oct 2020 10:23:16 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y68sm257904wmd.39.2020.10.05.10.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:23:15 -0700 (PDT)
Subject: Re: [PATCH] tests/tcg/linux-test: Adjust getsockname for musl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201005165850.88425-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dc569ee2-fe47-0967-3239-01ced7a3aebd@amsat.org>
Date: Mon, 5 Oct 2020 19:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005165850.88425-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 6:58 PM, Richard Henderson wrote:
> Unlike glibc, musl does not use transparent unions to hide
> the different structures that overlap struct sockaddr.
> 
> Add an explicit cast to work around this.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/multiarch/linux-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
> index 8a7c15cd31..96bbad5823 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -296,7 +296,7 @@ static void test_socket(void)
>      server_fd = server_socket();
>      /* find out what port we got */
>      socklen = sizeof(server_addr);
> -    ret = getsockname(server_fd, &server_addr, &socklen);
> +    ret = getsockname(server_fd, (struct sockaddr *)&server_addr, &socklen);
>      chk_error(ret);
>      server_port = ntohs(server_addr.sin_port);
>  
> 


