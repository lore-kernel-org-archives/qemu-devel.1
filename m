Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A37C43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3999206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zew4FXlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3999206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ1Lw-0004WI-RL
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 17:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ1JU-00035l-2T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:19:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ1JO-0008UZ-7T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:19:31 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kk9so1857550pjb.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WCnT6Rgl9JKIGNiA6bpt7/p9/f5K940npedgCJgKS78=;
 b=Zew4FXlEwJHqJXsh/iohG/QjfuW9I/cjGeWY26Kj+2fHz/8PeOVCgdkPbAnTfEcSCW
 yKIvtUxUwuy1V1kQDvQIkvd4T7rzsVJsNdo2kUA3TsuY3PIXB5yvsn/HrG0teqlkQKt9
 KClNGz+D6NAjvZYIoFr3Gk7D5qe/2krfAb4gG9dRFlCwsZpPUyVFl7+hdixRCFS+usVb
 xDPlkaanbkPi+R7I9KV5s3OMeuNlDynk85iQw+5bC8n1kuJLxky5NX4Aj6RpSbom9rV0
 cfhbnbf7wnYgdcdwzQLBrauYuExvZ5fFb1nAtUWmNtFPHVkoEEFvVQD++EOaKu7Daw0S
 q5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WCnT6Rgl9JKIGNiA6bpt7/p9/f5K940npedgCJgKS78=;
 b=Cfj/vv4F/8CPJYDKqoEjjB6xxW12DrxdcbxBaC31JUSOlsOBU9PAjFHQXoik04AQIg
 0J9+PW6IjcJ/z3E9plYiVWwoXgyixGVgX0KBEXK1HMMQkO+/ElytkMGBaKjTZ2qjiq9s
 oMQ91r7UucnIj3Zntfd7LeLG3atxUhS0RjYRn7jfFbG8bONMqZoun6JYnpCT9n3v6KqJ
 SmfGCwpw1m+eG2NiSXObjGzcHL012dUEuf2Dhq6YG7AD282xMHY4RMMePEZHCLSpSfXC
 7NTVV+gNRYXOVxiwWEU44LZUwiLWUixUgWkhlg4WRrzsf5F5etuDNzA70IbYTMYTqVbf
 GNOQ==
X-Gm-Message-State: AOAM533S+8tOXW0gY0Z1e4WUMZx4DPFeQX3kKeoV16Vj+aq4aVIJTdkD
 uLEn5UZEXXS6Z4Lrmt00WAMW/g==
X-Google-Smtp-Source: ABdhPJwfF1E5diP2RQLUcovGxBeSN2zOLuUfoKlQlHydOlzHz2+yNQXpqUTeq/2YhCDFks0n31JYcg==
X-Received: by 2002:a17:902:c20a:b029:d1:e598:400d with SMTP id
 10-20020a170902c20ab02900d1e598400dmr12547345pll.71.1600377563071; 
 Thu, 17 Sep 2020 14:19:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k3sm581836pfp.41.2020.09.17.14.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 14:19:22 -0700 (PDT)
Subject: Re: [PATCH 3/4] qemu/bswap: Add const_le64() and const_be64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200917163106.49351-1-philmd@redhat.com>
 <20200917163106.49351-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9049a746-54c9-6428-9239-b306f591bb9d@linaro.org>
Date: Thu, 17 Sep 2020 14:19:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917163106.49351-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 9:31 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> We already have the const_endian() macros for 16-bit and
> 32-bit values. Implement the 64-bit equivalent macros.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/bswap.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 6885984e00c..de256cea3ab 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -83,11 +83,20 @@ static inline void bswap64s(uint64_t *s)
>  #endif
>  
>  /*
> - * Same as cpu_to_{be,le}{16,32} described below, except that gcc will
> + * Same as cpu_to_{be,le}{16,32,64} described below, except that gcc will
>   * figure the result is a compile-time constant if you pass in a constant.
>   * So this can be used to initialize static variables.
>   */
>  #if defined(HOST_WORDS_BIGENDIAN)
> +# define const_le64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))
>  # define const_le32(_x)                          \
>      ((((_x) & 0x000000ffU) << 24) |              \
>       (((_x) & 0x0000ff00U) <<  8) |              \
> @@ -96,11 +105,22 @@ static inline void bswap64s(uint64_t *s)
>  # define const_le16(_x)                          \
>      ((((_x) & 0x00ff) << 8) |                    \
>       (((_x) & 0xff00) >> 8))
> +# define const_be64(_x) (_x)
>  # define const_be32(_x) (_x)
>  # define const_be16(_x) (_x)
>  #else
> +# define const_le64(_x) (_x)
>  # define const_le32(_x) (_x)
>  # define const_le16(_x) (_x)
> +# define const_be64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))
>  # define const_be32(_x)                          \
>      ((((_x) & 0x000000ffU) << 24) |              \
>       (((_x) & 0x0000ff00U) <<  8) |              \
> 

This duplication suggests that we define these as const_bswap64, and define
const_le64/be64 on top of that.  Similar for the other defines as you're moving
them.


r~

