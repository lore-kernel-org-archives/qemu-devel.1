Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EAC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA2E221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbC2miDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA2E221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGs7W-0002Dh-Iy
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 19:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGs6q-0001ik-Qt
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:05:36 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGs6o-0002y9-Sv
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:05:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id 34so7563724pgo.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AMv52cU5cZrXueN6b7RedaWn/lXH7YL31xZ12c9S/Zg=;
 b=mbC2miDTEQnLrwv+5Aof4s05UCsE40IIG2ecV6RRc24PhAe3MFteW4FvxEaexDLlQ0
 rqzIq4pMXbuAvr62/k+opfFlu+H7zIYE1d/K9QzAJjPwY4ERs0SC3Y8UwIrol91lRf0B
 3MNHAu6shatOFTauMsviBmykJ/vgNtyr99Mu9RcFIU6Xna3HckmhMC64OFQXIs2xaQux
 XFo+uY5saf/qHSWs+P5BGEA7/vq/go3HIr67oo5r9PHbmK3CebCtek5V+aIZCFcCIpYv
 MI9L7bdRfgUb8Q65FfIKnZk2ysqJQwPpls9TbTkxdx0XKf5iXzu/MQTAb9w06r7TjHuf
 u4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AMv52cU5cZrXueN6b7RedaWn/lXH7YL31xZ12c9S/Zg=;
 b=pssEoK6sxP1/19mSmxLzZsQiTc1ZGhAIeTw9dVmu5cqUw8nvn3itqMNySOjL3toxsY
 JupsbRN3sHYjZ1XfWnr4IuNG1c8opv2TLMeicpMFX57WPg8kWXfk2s80v+QYKvk3bv4C
 AMCgEb2+S4/PP47uFLKdoCvd2amDmois0dYl4bj79/fzzlyK5YYcrXm594w33M/T4c72
 HCX2N+9Ls8SE7ZMojgvt3MAkHXi1FUIQYMqCrdodiYzFlYxdW2feh0bttKfbXSDK0d4I
 09IDw4WRBtu9GSMJtugcUjaFadcYwYfKuKj8VddQfLouB9bd70p7rNXwwn9LLE6vCo5b
 NcDw==
X-Gm-Message-State: AOAM530AUdbprOoLewDnwWXcHPHp9fckbnNKM3U6xeMrYy2iM0xv2+h6
 K+rixLtqM8emQJ1AsBEe2abfew==
X-Google-Smtp-Source: ABdhPJy1cHeBP0R/dP1dzwAJfFHJlr/+LKydPNS4irjOmWjFxhTUeCxzuelvj/HCzao4oXtCBhcf4Q==
X-Received: by 2002:a62:1c4a:0:b029:13e:d13d:a136 with SMTP id
 c71-20020a621c4a0000b029013ed13da136mr4127604pfc.30.1599865533328; 
 Fri, 11 Sep 2020 16:05:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s19sm3406638pfc.69.2020.09.11.16.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 16:05:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] hw/char: Remove TYPE_SERIAL_IO
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907011538.818996-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca8aa7ae-5b5d-7607-477f-70601153f904@linaro.org>
Date: Fri, 11 Sep 2020 16:05:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907011538.818996-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/20 6:15 PM, Philippe Mathieu-Daudé wrote:
> Remove the TYPE_SERIAL_IO which is simply a superset of
> TYPE_SERIAL_MM, as suggested by Paolo and Peter here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg721806.html
> 
> Since v1:
> - Reword migration comment (Marc-André)
> 
> Philippe Mathieu-Daudé (2):
>   hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
>   hw/char/serial: Remove TYPE_SERIAL_IO (superset of TYPE_SERIAL_MM)
> 
>  include/hw/char/serial.h |  9 ---------
>  hw/char/serial.c         | 41 ----------------------------------------
>  hw/mips/mipssim.c        |  5 +++--
>  3 files changed, 3 insertions(+), 52 deletions(-)
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


