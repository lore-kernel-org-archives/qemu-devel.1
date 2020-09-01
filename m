Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E91C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7352078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiwJi22O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7352078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDyS-0000QE-Kf
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDDxX-0008Fc-Tb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:36:55 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDDxW-0004L5-5S
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:36:55 -0400
Received: by mail-io1-xd43.google.com with SMTP id g14so3465731iom.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=22P4lDeoN/y/BGuFV2vfPfrwjSHJvhOCH5zS8LmX16E=;
 b=iiwJi22O3kDXGtFxvOn7Q3bpO6+HrVTByLCuA4R+Zq21ML2+//YCJ//dNpewQCCi+l
 9JT2vHK5t6cf8Z8XZH4qr3ng1G9kvnhW3+mPmNmh9XvVMfax1uP0LxyseW6j4sDOGiWb
 bpKOAGaceW2K952LQ9Q94RAyAHZ5IZvIbCXAleKqJfnsVezENUanyMzjE4yOP2qDRxVL
 tbjVh/8xCe43zZj37se62Po5vA6iMiwIutnGHlnB+grP5uXV3Ej8zjpxJilREULDw0b5
 tBytMmAaNpxY4Rt7ejtykUw0kOVHiE+Y/cDTcLVzNnwmrEoTmLDvbE/a07wwRYOpJDlB
 DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22P4lDeoN/y/BGuFV2vfPfrwjSHJvhOCH5zS8LmX16E=;
 b=YWiGMq15DG4tFSuONs2zBtljViuXiP3+9SH1PYSPNFtic3t6JSNM5s0N3ISGOW6vXe
 wzJcOxiC3y4hLJnzGEH1eWJKBtxIrH6E/VpSOeSTQX3lb/YDXPN+eAvCIj4+m2Oyc8k0
 yR8/PTAx+j+b+tCY+03ANC/BPTQgB/HOdvKm9J2yHIfGD5oWBTy43xsyU4b6AtgGg1Hq
 dTFfjLEbIbcjbIC0G0RcdOgnx1QbCmVCnzecVea0RCXVa6cfir2r4JnThQitDQefz6LM
 +5tc2yrSBzpEUYcWAeTQa8v8M+hQgg2tI7az5i0Yiro28SZi+Rbc8gtLWBYxc+A1aQuJ
 yg1g==
X-Gm-Message-State: AOAM531uNp2FS6OghgxZy/8Dxnc1gNbBZm+Z4eE+8o7PAWfGVdA/yh+P
 YjgH9S5qavKHbGyfd/NacGLs2w==
X-Google-Smtp-Source: ABdhPJwMlOVZlKgfqP72OsfVSVW1rWzrpR97VhRiMWQvegUAAz6wGe/D8DGeVclyTunZ3VCYoCKKBA==
X-Received: by 2002:a5d:954f:: with SMTP id a15mr914334ios.53.1598996212909;
 Tue, 01 Sep 2020 14:36:52 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:4b79:8545:2b44:3b48:7db9?
 ([2607:fb90:27d2:4b79:8545:2b44:3b48:7db9])
 by smtp.gmail.com with ESMTPSA id e23sm1077510iot.28.2020.09.01.14.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 14:36:52 -0700 (PDT)
Subject: Re: [PATCH 2/7] hw/hppa: Make number of TLB and BTLB entries
 configurable
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4627473-3272-59e7-a8b6-0f223e69b198@linaro.org>
Date: Tue, 1 Sep 2020 14:36:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901183452.24967-3-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:34 AM, Helge Deller wrote:
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 90aeefe2a4..e9d84d0f03 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -72,6 +72,14 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>      fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
>                      g_memdup(&val, sizeof(val)), sizeof(val));
> 
> +    val = cpu_to_le64(HPPA_TLB_ENTRIES);

I guess you don't have a cpu structure here against which you could apply
ARRAY_SIZE?

>      /* ??? The number of entries isn't specified by the architecture.  */
> +    #define HPPA_TLB_ENTRIES        256
> +    #define HPPA_BTLB_ENTRIES       0

What's a btlb entry?
The indented defines are weird.


r~

