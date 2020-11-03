Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08337C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8130B20756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFPDn77x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8130B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka43H-0003zD-Ky
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka42Q-00033D-NK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:40:22 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka42O-0008UK-2k
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:40:22 -0500
Received: by mail-pf1-x441.google.com with SMTP id b3so15493811pfo.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R3+cOjWcFo31OFROQoX97xc/l9gjamcF+P2uhNEru8k=;
 b=AFPDn77xm5t9Edm7bs4O/M+0dSzn01lfYc97s/tFAYrvrRcI2P3w0SBekSAA/wOrc4
 K0XENgEyPEyk2sKsn/D/rEN/X6LoDb48EKCcCciYnBvE1yATr2L8HQmrqhSQsRkl2gtg
 WHzjgSwvb4HqX8u3yJWuNJUSsOgIjy6H7V4/TjoHVE6RLSpgQGwxLdo45qRcBlGzvFLJ
 tVPVdgdOTFMSCPKn2noxLbTSZoOzt3Z72bi9qKUxYGRc7RnbEN5V359Vmkle9kiSajxq
 mASM1JiQofAXFNgcdeAdc5XTOD8nPKiUE6uHQrmwy2GJqV5NYJmBHMr+rlfAamX/UyXR
 vfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R3+cOjWcFo31OFROQoX97xc/l9gjamcF+P2uhNEru8k=;
 b=XB0YFMKXIc8OqsmbmvP1wsf8+OoE8JB1B6hf3sBYdp+36n0dxmTv4EX5yLIZFJYiWS
 dmvbBgkrFcEGCwnUweH8IcUPnszU5jyZDsJFfvAZmfKa8sNKoRjMNylG9pmtaW+O2kIi
 SZ2qe+2OP2R0RCFl6SjosPJ1hkK5ymuX+ZBNdyQWvispp3ohZmc0m8dsB+NZ51EHAU8G
 Ku98wERouvX2eCOBxwOCCOjUpblLl17dx4nLmfEpBxv8osYq+njMCYIodn8el2PSmSDw
 meJ/GTssa8FKVmjDnFds7k3XH1vEKek8H5EnhkUz2X2lRnNU9q2FmW/VOJc+l2//3LHg
 fFIg==
X-Gm-Message-State: AOAM531SK997mNjsS1s/Nr9yJWgf3w0bZR4/ZtTn6R4cUVu0yJiTnSjT
 D1mut6Ji+TycWi9vSpNnJWFTgYzlQML9Fg==
X-Google-Smtp-Source: ABdhPJw9Vcfdj403a5aQGAiTn9McG93WVj2FsEFDDhMzByjbf8vZLQ+l+uicUIHNyz6+NdkIQ41XdA==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr18092532pgk.244.1604439618369; 
 Tue, 03 Nov 2020 13:40:18 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id m2sm71545pfh.44.2020.11.03.13.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:40:17 -0800 (PST)
Subject: Re: [PATCH 09/14] target/arm: add ARMv8.4-SEL2 system registers
To: Peter Maydell <peter.maydell@linaro.org>
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-9-remi.denis.courmont@huawei.com>
 <d26e76be-9be6-e658-48c7-0f5246508517@linaro.org>
 <CAFEAcA-jnWsR_CM1t6DNu09f84m7HTSpfnOiV0DEBFDdP-DQzg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbed5325-5602-04a2-5e80-62fa5db86667@linaro.org>
Date: Tue, 3 Nov 2020 13:40:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jnWsR_CM1t6DNu09f84m7HTSpfnOiV0DEBFDdP-DQzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 remi.denis.courmont@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 1:09 PM, Peter Maydell wrote:
> On Tue, 3 Nov 2020 at 19:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
>>> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
>>>
>>> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
>>> ---
>>>  target/arm/cpu.h    |  2 ++
>>>  target/arm/helper.c | 24 ++++++++++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>
>> These need a new VMStateDescription section in machine.c.
> 
> Do they? I think they're handled by the existing generic
> migration-of-sysregs code...

Doh, yes indeed.  ARM magic...


r~

