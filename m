Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884C32070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shbeQe+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884C32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Fjo-0003GE-Uq
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fik-0002Pi-3j
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:04:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:35952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fii-0000jH-Fe
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:04:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id ha11so5707881pjb.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TgGbxaoTeOpITs3pejBEYIEgWpvdIhMkvcMoI1f7RWE=;
 b=shbeQe+c/qw0cBnEjEwsiR5Erw37xGdurXZDZfVjd4Du2didmR7mmFVr7S/QZf9DQb
 x88I+6z+gEPlXCMjbi5zCQp3Dal6i/82YF2GiBORa6FZeDNnAY4uZHe+GwGNEWEfcAyq
 FTABVfJ7UjzRVEq2WcKrbtXwXIAKtM0e5WIBMp6hdFr0OgUUGpaI90ey1weqYGiJz0DN
 XHj51xP+auHhXkhQx8KiKHECrWe9w0jf+RhLHsZ0b8OXrSNPUwhzJnzvsdv5LXWTJzrD
 CxIo4du0r6XcNJEVPoYfIrcC6Tfn+0pd0dRFkmlxm75pLY/bK4r0xaSNlHbxu/B8WJuG
 T2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgGbxaoTeOpITs3pejBEYIEgWpvdIhMkvcMoI1f7RWE=;
 b=fj+T4jO92MnpzkWA+69nH6POclcZUHd04u8qvBH7bIzOqxPtr2ev4MDKEHmo9GE7D+
 chjV40GO+2exa1lKbyCNwAG0HoedWlXPnKkGW1LEODQDGW16NfImjBKorXB5Z++C5Z01
 TGKBjtQnJrJmMrV1uQQGHYlFzhuXzg8Ds40QPTt+SUmE9xmBFUQhLKgeptktSngEfVbp
 0ILsNFcqRfB5gCpyhgcgG/pec3W6/5jVklvrM8ork6ZbRfw7ckR19HytBnqqU5lDa2Xe
 54YDfvrnOrcS8BkblBErxbpgONOFRENak4+GLHTOPvSAYegwmDazN6L5PzgCU567x5D+
 v9qw==
X-Gm-Message-State: AOAM5308WK8Wpayz2xiQ2f4F9lGgExpfhZpKvDldWD2OhKM92NJ0AAQS
 4Uk0isE8kuDRfhoTsebRVkhmIg==
X-Google-Smtp-Source: ABdhPJwz9opH+49CFPJcEpZMpbpCs/PElJaj1F3IEXIMTbO6DEkaXicQDXYA1hnMN5jjRefuwfXBNA==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr959659pjf.88.1596143047303; 
 Thu, 30 Jul 2020 14:04:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g10sm6382927pjs.20.2020.07.30.14.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:04:06 -0700 (PDT)
Subject: Re: [RFC v2 48/76] target/riscv: rvv-0.9: widening integer
 multiply-add instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-49-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19f6b6ba-4cf0-ba84-bd08-dff2f3d06c56@linaro.org>
Date: Thu, 30 Jul 2020 14:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-49-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

