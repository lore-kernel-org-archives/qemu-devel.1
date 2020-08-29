Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA94AC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927A7206B5
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da3mt0K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927A7206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC30A-00009x-P4
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2zG-0007lM-FU
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:41:50 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2zD-00087K-GE
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:41:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id 10so1024359plg.8
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MIye0GUIECW6T9cQ/OGHia2XvAUrDXWvoc/M6bni3tw=;
 b=da3mt0K0SqlH2tY95bD4e1K4ANUYuxVeDE8B1vzCjciTxIndST4o3YUaRe53o4P0b5
 wf+j6fhi2JfUhMALXRbDXPpw2EbBiIZ1YvlAhSM2a0RXHbFhcIqnM4ZsaCiTpKYaY/G9
 aPkmz3wo63FtDK32AWYRXuzXJlnnhjSr4rsPTRV7ZIbCgMqkd6yfZ82PlEOMMXI53znI
 sH1aTmo3yKiFrT2IwuIJ7EJULnBJq9OgilkZO96zuDIp89iFFZMxZh6avOjy2CfTAXZj
 vTccf0II0Vyo+PrHW1HIFsvP7fRVV70UtHlJdQ+BV/5ZazwIj091intpgm7S4YBQ2M5o
 GCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MIye0GUIECW6T9cQ/OGHia2XvAUrDXWvoc/M6bni3tw=;
 b=DqH9yghi90a9fGNX1tZQMTU447+u68cZ8dZkvQLcii9kb/K7qPZ5LFAt/ZHHGh8C6Z
 eTSzM9H1YbJtNMoD2S8fpYz7DxS8ZKrOtM8HC7Dy2gLCVB0OmlMMQvBj2KZiMZiACSwS
 mlCvL3urKtWmGlRS1Wu5NhxwM7TAo/UqUdj8TGlL2mfl9XX5/KYwe4twNqceSh2URuy1
 MRpe0cbFLJW/qBx5vlHed9vqUI+PLIjRn4z++uxKjACoB4xC2kcewxULUZBJiuHg+hYb
 n5u/VO9soZbOG22PcZpwABLt4JqNZxjALezIoOtSuH1piQPiR7xdnDLfvDVYEpRrZ94h
 CBSQ==
X-Gm-Message-State: AOAM531ueKsNvT6jUXbceVltYzNvosowjDOpOOfswcFkex8ewEyghxf5
 zKFU5krMCuxLHFwaGf/vJud54A==
X-Google-Smtp-Source: ABdhPJzEsG39bkWvNM/YStPkeXZENXgSe85BPnYcQZYXyPMQXdENqhiqbX83qLDOW059r2ry3HXdoQ==
X-Received: by 2002:a17:902:bd42:: with SMTP id
 b2mr3135806plx.246.1598715705940; 
 Sat, 29 Aug 2020 08:41:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s129sm2963346pfb.39.2020.08.29.08.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:41:44 -0700 (PDT)
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200822142127.1316231-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
Date: Sat, 29 Aug 2020 08:41:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822142127.1316231-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Michael Lorenz <macallan@NetBSD.org>, Andreas Gustafsson <gson@gson.org>,
 1892540@bugs.launchpad.net, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/20 7:21 AM, Philippe Mathieu-Daudé wrote:
> The S24/TCX datasheet is listed as "Unable to locate" on [1].
> 
> However the NetBSD revision 1.32 of the driver introduced
> 64-bit accesses to the stippler and blitter [2]. It is safe
> to assume these memory regions are 64-bit accessible.
> QEMU implementation is 32-bit, so fill the 'impl' fields.
> 
> [1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
> [2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32
> 
> Reported-by: Andreas Gustafsson <gson@gson.org>
> Buglink: https://bugs.launchpad.net/bugs/1892540
> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1:
> - added missing uncommitted staged changes... (tcx_blit_ops)
> ---
>  hw/display/tcx.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

