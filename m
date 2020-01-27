Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DD4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DDE214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfouNVAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DDE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8La-0001qk-Om
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iw8Ku-0001Bz-0B
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iw8Ks-0003YL-QI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:38:07 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iw8Ks-0003VQ-IK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:38:06 -0500
Received: by mail-pg1-x542.google.com with SMTP id 4so5495877pgd.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sKlZwF1nTTenQJVX0Bf2bGCikj5aJwb8R5KOMOAv9fM=;
 b=mfouNVAaOaV6Q0a3fpubQSVXG4WeftAKJ9e/6dlxSuKeXBbnMBgLXxyvra5EEVogZu
 wgAil1nnxWBm5sT4hny0XSwVB/Z6qdkLlUCiNxbPYlQzDVZHagUWEXl0mZzIn/98s270
 yZAiuA9XA4usMKdy/UUZkSus/WTUk63sq5OfcJvPL4SrWYwiOGIHJGa3Rf6mlq9NwzAP
 RbJd8HCiD3mAWRXbxpJTKXHQ1PAtp3gEMcDLRnJo1ICfierVvuA1i+LBz2HO/UdH0b73
 jWwDfEaqF/pVZabso13baaaX/zsOrZD1YBXAHoZGjx7NLtXF1NpH4Ijv89mR3/gZn+us
 Rp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sKlZwF1nTTenQJVX0Bf2bGCikj5aJwb8R5KOMOAv9fM=;
 b=r0eFKlduOL6sLdQOJxWxhqUBKDJS1fXeD8LSt7XmGUuDyY3ppjaFZzIJPCsplUmlfR
 FK97ImCzenpfK3OXbJz8+s0HT8Tef9N8YZsbPGoTSJhTXEgFVfOIBMU1YUfGDidwSwWL
 rGvIx6M4RlmuK5CUbRfONc+5qXh32OHf/Ta3DFOiyd3vlpl0SHyjTzv0El/0sdo4Tyu3
 XN8mkXrIfZiO3c4yYNsB7YGD3eFGzki8CI5gMd1wyebKafiN/8w7vPeKLrkxDr2mlcyj
 lAGVceazKCqt6Do2SLWprACZVZ9oBsvMSgs78RdXxzVT/6lnsA7bYh1j19ueFJgkVTpt
 Pabw==
X-Gm-Message-State: APjAAAWuRN4ePDrwM4Km13u2/W2CfvokWGPZaDtPn0Etw+mHnGM5EH7O
 9X5swjjc/Vj039p+Vn9JYBR+6g==
X-Google-Smtp-Source: APXvYqz+uv1cExxRKrEFY3LRVGR07HpBy5MjEcfGZKLERzxzyXk0FxZSn1ik4i7RCjxPdG9swFt1Fg==
X-Received: by 2002:a65:6447:: with SMTP id s7mr21443731pgv.325.1580146685047; 
 Mon, 27 Jan 2020 09:38:05 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w3sm16528079pgj.48.2020.01.27.09.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 09:38:03 -0800 (PST)
Subject: Re: [PATCH] riscv: Add helper to make NaN-boxing for FP register
To: Ian Jiang <ianjiang.ict@gmail.com>, qemu-devel@nongnu.org
References: <20200127141051.12543-1-ianjiang.ict@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f82064c-4441-550a-7e18-806ab3e54171@linaro.org>
Date: Mon, 27 Jan 2020 09:38:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127141051.12543-1-ianjiang.ict@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 6:10 AM, Ian Jiang wrote:
> The function that makes NaN-boxing when a 32-bit value is assigned
> to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> Then it is applied in translating of the FLW instruction.
> 
> This also applies for other instructions when the RVD extension is
> present, such as FMV.W.W, FADD.S, FSUB.S and so on.

I wouldn't mention this yet, as it begs the question of what you are doing
about it.  Which is nothing, yet, since that will apply to a follow-up patch.


> 
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

