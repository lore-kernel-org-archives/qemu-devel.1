Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE7C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2FB20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9CzlT/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2FB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUSb-0006FM-F6
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUS1-0005om-GS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:47:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwURz-0003Wy-QU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:47:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id m16so5763296pls.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NPgI8bEX+bb9Zy2Bywb0uxLA487R6u8cQ4AYhpu7cZA=;
 b=b9CzlT/x1x9CJatIA17dQ9IG6opvx0EgNaQHuyb73P9r/+w5E4HDjKZqYr7juMt5U8
 Y0y/HNX2WQgIkd92iyny8snHJKTW+LereG7JW6bQAO8J/qMdXofq12MMIMgFbyen1s0R
 AMzWXAh+b93H4P4Aa8CBC+uncYIWwuqB/b5AW6O0QVwFmXiXx3TnYi13I4kFWymxT6to
 pZB+xdnKX0UelL4Z6rwhEs8xSqy+D7bz3CmF1uNzRI7EJS+5y9gWOaXT1i3ztSSEqd04
 s6SooZb2m3P/TsaFVLlhEbCpzc/3e4VFXXyszKIlpfK1MFN9bkxf6j2ad3CGbJV8MGcb
 tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NPgI8bEX+bb9Zy2Bywb0uxLA487R6u8cQ4AYhpu7cZA=;
 b=kOokBHOe6sgsjw89j/Y6otpbTh7K3N5o7ehg1xOWI4Ot+jQknGFaMuI02LOQnBiqPi
 akyKq6c7iVR6rIHVAp4EIVHjzTZhjD3Tsv8mCgT37z3l8av3sywATZD2G9PvqLjYgDYb
 4RR09249WrSzrf6voDzqeuijZkhJi1vrQY/fF+JF18u2X/vp8+03RX+CxP+Xsu1xzEfZ
 4NI4sOtYAL8C7gYkuqyo3UZgfneTkRNezRgLIcyn98yuijG1UvT2QRrp3vm2+B+UkFUB
 5DZOUxkU4yqlJ9yreNM0ATrt5ZMFMGG4+o9MxsSW79YeURORa8PxU93unTU32cHLRWin
 Xgqw==
X-Gm-Message-State: AOAM533W+QbKX1YIwQiMwuvAjmmNW48QrskQDLSTyhKuX7p/Va9hUyjg
 rxjty4zgnk757Nr9wcumL8nfGA==
X-Google-Smtp-Source: ABdhPJxmf4iUmqUGJBtYcKj/SMZTLhSp8B5UVfQ8jh6YlFKuEpbBW0li39tdD/rB+AxUpNtTxaRD9w==
X-Received: by 2002:a17:90a:bc98:: with SMTP id
 x24mr9955261pjr.63.1595008029766; 
 Fri, 17 Jul 2020 10:47:09 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 s187sm9494807pfs.83.2020.07.17.10.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 10:47:08 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] semihosting: don't send the trailing '\0'
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3198798d-84fd-7612-73fa-fc1107e50184@linaro.org>
Date: Fri, 17 Jul 2020 10:47:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717105139.25293-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, f4bug@amsat.org,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:51 AM, Alex Bennée wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Don't send the trailing 0 from the string.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
> ---
>  hw/semihosting/console.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index 22e7827824a..9b4fee92602 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
>  
>      do {
>          if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
> -            s = g_string_append_c(s, c);
> +            if (c) {
> +                s = g_string_append_c(s, c);
> +            }
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: passed inaccessible address " TARGET_FMT_lx,
> 

Next cycle, we could clean up this loop a bit, rather than testing c != 0
twice.  E.g.

    while (1) {
        if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0)) {
            error;
            break;
        }
        if (c == 0) {
            break;
        }
        s = g_string_append_c(s, c);
    }


r~

