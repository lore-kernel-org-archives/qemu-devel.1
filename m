Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7676C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4ED22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJGGGpZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4ED22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZkri-00068w-L5
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZkq1-0005cA-JP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:10:17 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:42179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZkpy-0005D5-1O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:10:17 -0500
Received: by mail-pf1-x42d.google.com with SMTP id x13so12735665pfa.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 17:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KSszRMDd4+eA01aQy2aWcAJsA/utkHB+D2Z2NTnk/IM=;
 b=KJGGGpZFLJzEPlwhdXTL1oFuyPfh0pYqfzPgpg24kgLdhNkuOXSTFSKIMVKD9bENnz
 ca/FRBHVu/uhupazBtnpUsd1RcmVmVVvMcT4dr7he1TTCprRPkbFT2S6DHakZAVT9TP0
 HG2kp6lXw/VtOPJe6yjijDkRdIgYsSxMR4/sN2EPVhMJHBWYCyW5YNqFiHFwAYVcHCN7
 bRDl8DjZYCfBHesCqlA56XycWVxMX31BueeexbKbys9Y/dkXHeQScb5lXF1K/C9YsdAo
 ZJBzHkunilB0xZTWgoTtkxc/pIkuSpVmji+0T7Xr7gdXFKGTO5lahrQtGBTzypLW7zn4
 YPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KSszRMDd4+eA01aQy2aWcAJsA/utkHB+D2Z2NTnk/IM=;
 b=Yr7uxD7FPqiEnrtRm5ZXKlhEyra+hZeWEqEpc8p4ibF6mLLhDD2EESgvWjzs6LEpQq
 FwtxkdRylLMiMkV3cjJxvtweQNUK2gKZkXE1GINsrT0hk+1ozYYCEg2RFRonCbv+ztRT
 OcjNBkJiK5wQVEz8Urvf9K6l3YzI3dxcY2vW2CjnVYKeRewpVlL/kMg4YAgX1sU80EqR
 XlnvWSTm810p3sKO0CKdBbcPfqBBsQfzHdhqQMxfGz8JqtF/tLqIb8dYbnPGcbJp2EeE
 hIfvuuSzR+triUygBO9Zn1zlADNkRoxnobb1jjYxG7rjyQu+UHu3VTAYMT11nAq1KUiZ
 VYhA==
X-Gm-Message-State: AOAM531RDHaM9Nf2uRNzQl3yapMAtEVQBKWVr+YmkE/3CPL6HwbJwiD7
 mPsnGhyYudE4gba8CEEnrwlmaA==
X-Google-Smtp-Source: ABdhPJxnmowCIlm2Fwx6dwO1/EMfkxm4NS3koiXZXzu6mUvWhNHRRc/u9WBGFFQJK3M8LnFGy+tZVw==
X-Received: by 2002:a17:90a:4a12:: with SMTP id
 e18mr1037385pjh.9.1604365812267; 
 Mon, 02 Nov 2020 17:10:12 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id t15sm2116279pjq.3.2020.11.02.17.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 17:10:11 -0800 (PST)
Subject: Re: [PATCH-for-5.2] target/mips: Deprecate nanoMIPS ISA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201102202710.2224691-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4833a38e-1d28-fe73-bdc6-1dcc52039862@linaro.org>
Date: Mon, 2 Nov 2020 17:10:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102202710.2224691-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 12:27 PM, Philippe Mathieu-Daudé wrote:
> The nanoMIPS ISA has been announced in 2018 for various projects:
> 
> GCC:   https://gcc.gnu.org/legacy-ml/gcc/2018-05/msg00012.html
> Linux: https://lwn.net/Articles/753605/
> QEMU:  https://www.mail-archive.com/qemu-devel@nongnu.org/msg530721.html
> 
> Unfortunately the links referenced doesn't work anymore (www.mips.com).
> 
> From this Wayback machine link [1] we can get to a working place to
> download a toolchain (a more recent release than the one referenced
> in the announcement mails):
> http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/downloads.html
> 
> The toolchain page mention LLVM but simply links http://llvm.org/
> where there is no reference on nanoMIPS.
> 
> The only reference in the GCC mailing list, is the nanoMIPS
> announcement: https://gcc.gnu.org/pipermail/gcc/2018-May.txt
> 
> The developer who authored the announcements have been emailed [2]
> to ask for more information but all their emails are now bouncing:
> 
> - Your message to Stefan.Markovic@mips.com couldn't be delivered.
> 
> - Your message to smarkovic@wavecomp.com couldn't be delivered.
> 
> - Couldn't deliver the message to the following recipients:
>     Robert.Suchanek@mips.com, matthew.fortune@mips.com,
>     marcin.nowakowski@mips.com
> 
> Our deprecation policy do not allow feature removal before 2 release,
> therefore declare the nanoMIPS ISA code deprecated as of QEMU 5.2.
> This gives time to developers to update the QEMU community, or
> interested parties to step in to maintain this code.
> 
> [1] https://web.archive.org/web/20180904044530/https://www.mips.com/develop/tools/compilers/
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg756392.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

