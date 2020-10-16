Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6320C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFF1207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYOW5Udj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFF1207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTcQ-0007ka-WE
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTXQ-0003UM-Hf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:29:09 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTXL-00010u-Ow
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:29:07 -0400
Received: by mail-pj1-x1043.google.com with SMTP id hk7so1896079pjb.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mLwIKPV87Apdm+fhKXzFgZFxnu6wc9e6pRZAwlAB/Ck=;
 b=RYOW5Udjn3f+I5Kiipt+2o6QjoWX6tj2kQxBfQfz/XH0ljnMd7j9e5W6yoK156eAhN
 BmkuCFL5ciZJwEeXhkXcJ405r0nvqpnsFOzcXCAR9too7YA5ReIuP2X0yJVTo1yKDA+F
 /iLYK9eFh0s7QlFwCk5Pd1C8UKNjPim0prTgpXIl/DSS1BEubNQrHTgI95olGdHLoEua
 dltwmWMoxA6AIWbjmREsuceZW5d3mazkBfzquqFUDVOnRdKi/ttBJQr6eU7OsQKF2mu9
 b1IROIMnCf8UJ07XAy9mY58NkJLRXRxjt2fe5ZT/h/fpTOUVxw97SQEucef5mykKJZW1
 jSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mLwIKPV87Apdm+fhKXzFgZFxnu6wc9e6pRZAwlAB/Ck=;
 b=Ra2J+fuqBoo2w9qvvG5fBeayZYmWA9fj8sxNNczasAWMKl1cjAawymFLMh2r0MXi36
 Kxor/mRqzpxglFf6wLCK+Cp4+NX8Eg0FskwZ41NId9yk0Jk+6itW7QQp2qdXPSp8LKHN
 8odZ1ryNaKx3me4oD4sHlttm0L1N/O3M1e6L5sAZ1a8UOynmOQ/RsIQytWrhBm3V8wso
 eYrqc0CQipBV6K1EJQArdc1esyUTNn/TVINzL8YpdqtMVw5obH9WJauIlbQUM75MctkR
 +Iae1S1r4uszyVUXlY0G//nyF5yW9HJGXelZ7sNbw0h2K7OzAcLUsqm5dh6WwSRSsunV
 MiPQ==
X-Gm-Message-State: AOAM530SLhVPuVOsJkp0IFrtqR9rsC9vLsdk9UZhJ7aPTceBqMeYJho5
 1yKKRywaxSDEHVOvj2JBej8DIg==
X-Google-Smtp-Source: ABdhPJzDBfFUHWwVZ2ntYTbGNl7Xh15xMgw80HVDwHqIkyj5VnkZxP+KojD3RmP5ms6iiImId5WB9Q==
X-Received: by 2002:a17:90a:3486:: with SMTP id
 p6mr5239003pjb.23.1602869341025; 
 Fri, 16 Oct 2020 10:29:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x9sm3261299pgr.22.2020.10.16.10.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 10:29:00 -0700 (PDT)
Subject: Re: [RFC PATCH v3] target/mips: Increase number of TLB entries on the
 34Kf core (16 -> 64)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Victor Kamensky <kamensky@cisco.com>
References: <20201016133317.553068-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <89c6f926-9692-2b8e-617c-6c950bfd1945@linaro.org>
Date: Fri, 16 Oct 2020 10:28:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016133317.553068-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Khem Raj <raj.khem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 6:33 AM, Philippe Mathieu-Daudé wrote:
> Per "MIPS32 34K Processor Core Family Software User's Manual,
> Revision 01.13" page 8 in "Joint TLB (JTLB)" section:
> 
>   "The JTLB is a fully associative TLB cache containing 16, 32,
>    or 64-dual-entries mapping up to 128 virtual pages to their
>    corresponding physical addresses."
> 
> There is no particular reason to restrict the 34Kf core model to
> 16 TLB entries, so raise its config to 64.
> 
> This is helpful for other projects, in particular the Yocto Project:
> 
>   Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
>   MIPS CI loop. It was observed that in this case CI test execution
>   time was almost twice longer than 64bit MIPS variant that runs
>   under MIPS64R2-generic model. It was investigated and concluded
>   that the difference in number of TLBs 16 in 34Kf case vs 64 in
>   MIPS64R2-generic is responsible for most of CI real time execution
>   difference. Because with 16 TLBs linux user-land trashes TLB more
>   and it needs to execute more instructions in TLB refill handler
>   calls, as result it runs much longer.
> 
> (https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html)
> 
> Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
> Reported-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: KISS
> Supersedes: <20201015224746.540027-1-f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/translate_init.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

