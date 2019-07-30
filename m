Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A38C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C784B20665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fU6oi9ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C784B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGuW-0002Qg-56
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 21:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGtm-0001pk-HG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGtk-0007gO-RO
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:25:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsGtk-0007ee-5n
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:25:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so29137179pgl.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qtiOURiJCf250/lSLL4nQKDPaqIyCQn/F48JhGRvEJ0=;
 b=fU6oi9ih4qCC60pXcy07gjvMPvAr1BZ5F2BPCmbHUAXkx+2eBRPougB7hcQw4mexuc
 9aNd6+RoBNbQQUp4CuFe9zbDljAkGt3STI9QIdB5TouZFZWbCyexpvsYOUk6MgilNyot
 Je+/uuUtPMfWBcAVkrHdG52fPJtFZxuo7vyZAimfCnwK1tLRM/4YlnbvRDhBbSGzyY9v
 CMbg0n71mmkZX5ZwoA+BPUsvj1I1uv6msQigXNjzlISGQzn9jt4cpIdnzPJgw2FLNl2o
 gTUzGNCYqjJje3UyiO4MJuGdR0C3HYECKNXPP7CrhbpfTaHkZ+Sz9Drf7K6qZzPYI18v
 4nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtiOURiJCf250/lSLL4nQKDPaqIyCQn/F48JhGRvEJ0=;
 b=e4PmZ2Z97nVTcMa/L6euLfw8IPeInaNzqhbHOO/Q+ThFTtvf4Y7NbqfKyVn5eY+eyj
 DeYxBGvV51q4UR2MtaF7WYx0uFJxfoEzNWlnszvKkwxkV+DyjKazOfGuqY8ZGOpcb7sV
 ocZj/VKtKep/+TjLpOR9V7/+SfzkuuAxVk4uO8rJvdVMaM4V5bAzkgjjinXzRGr39utI
 Y1SG5koCTO6YNA1NBgEE6gNkMw1iLPJ9sjaNmDM2TPH9Xz44WsjAw7dHKihvNK0F9Jw7
 Bv25fMjGvRHn7ef+n47rYB/NnBn82zhuQvlZqDMwfDak3elGB64hwpf9GQvwvNUlJ2pC
 YJWg==
X-Gm-Message-State: APjAAAXHWilwvTCy7LO/fVVnooROitAIrwNkVUrNR5BD+RIpjAuAivYY
 BWtM9OU5SzNfsLz1yF/KGI+ESg==
X-Google-Smtp-Source: APXvYqwvEz6uvJTT/fEBmEw218JiMaDLOOcIZPOGga61aLqMPUtCZSZ4GwXN2YMGfhV42Lmx+eZQMQ==
X-Received: by 2002:a17:90a:258b:: with SMTP id
 k11mr109922299pje.110.1564449949607; 
 Mon, 29 Jul 2019 18:25:49 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id o128sm68593609pfb.42.2019.07.29.18.25.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 18:25:48 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-14-richard.henderson@linaro.org>
 <CAFEAcA-DG5JXVTT5tz7eJa03VWMxmq4RrujbQTk0R7KO-TAa6w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f37848c2-2d74-14c9-1e0f-2026e162aaa0@linaro.org>
Date: Mon, 29 Jul 2019 18:25:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-DG5JXVTT5tz7eJa03VWMxmq4RrujbQTk0R7KO-TAa6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 13/67] target/arm: Convert Data Processing
 (reg, reg-shifted-reg, imm)
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 8:25 AM, Peter Maydell wrote:
> I'm afraid this patch is too big for me to digest :-(
> 
> I just spent about half an hour trying to figure out whether
> the changes just to the thumb dp-immediate insns were right
> and didn't manage to work through it all.

Hmm.  It is probably the largest of the patches, and is caused by me trying to
do all of the insns handled by that one A32 code block.

I could perhaps split this to add fewer insns at a time, but I'd have to leave
the legacy decoder alone until the last patch, when it would go away all at
once.  I'm not sure if that is more or less reviewable.


> Why do we split it up into all these different kinds of patterns
> where some insns have special cases for rn==15 and some have
> special cases for rd==15 ?
> The legacy decoder doesn't seem to do that -- it treats everything
> the same.

It sorta special cases them, without actually diagnosing the UNPREDICTABLE
cases of invalid unused operands.

ARM MOV + MVN special cases:

> -        if (op1 != 0x0f && op1 != 0x0d) {
> -            rn = (insn >> 16) & 0xf;
> -            tmp = load_reg(s, rn);
> -        } else {
> -            tmp = NULL;
> -        }
...
> -        if (op1 != 0x0f && op1 != 0x0d) {
> -            tcg_temp_free_i32(tmp2);
> -        }

Here we have TST, TEQ, CMP, CMN:

> -        case 0x08:
> -            if (set_cc) {
> -                tcg_gen_and_i32(tmp, tmp, tmp2);
> -                gen_logic_CC(tmp);
> -            }
> -            tcg_temp_free_i32(tmp);
> -            break;
> -        case 0x09:
> -            if (set_cc) {
> -                tcg_gen_xor_i32(tmp, tmp, tmp2);
> -                gen_logic_CC(tmp);
> -            }
> -            tcg_temp_free_i32(tmp);
> -            break;
> -        case 0x0a:
> -            if (set_cc) {
> -                gen_sub_CC(tmp, tmp, tmp2);
> -            }
> -            tcg_temp_free_i32(tmp);
> -            break;
> -        case 0x0b:
> -            if (set_cc) {
> -                gen_add_CC(tmp, tmp, tmp2);
> -            }
> -            tcg_temp_free_i32(tmp);
> -            break;

I don't see bit 20 (set_cc) as even being optional in the decode, though rd is
RES0/SBZ and is thus ignoring it is valid for CONSTRAINED UNPREDICTABLE.

Thumb2 MOV, MVN (and the rest UNPREDICTABLE):

>              /* Data processing register constant shift.  */
> -            if (rn == 15) {
> -                tmp = tcg_temp_new_i32();
> -                tcg_gen_movi_i32(tmp, 0);
> -            } else {
> -                tmp = load_reg(s, rn);
> -            }
...
> -                if (rn == 15) {
> -                    tmp = tcg_temp_new_i32();
> -                    tcg_gen_movi_i32(tmp, 0);
> -                } else {
> -                    tmp = load_reg(s, rn);
> -                }

TST, TEQ, CMP, CMN (and the rest UNPREDICTABLE):

> -                } else if (rd != 15) {
> -                    store_reg(s, rd, tmp);
> -                } else {
> -                    tcg_temp_free_i32(tmp);
> -                }

r~

