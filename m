Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD6C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D512133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kocD5iBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D512133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2h8-0001k0-2c
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg2fo-0008Et-F2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg2fn-0004xC-8O
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:48:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg2fm-0004uq-Tk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:48:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id r16so1464473wrl.11
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=clJr5Kgf8rNpIsygI48thRCVYe5Ho9N/9bfnCdo91XY=;
 b=kocD5iBu0ayOwrH6NymlCWnj5Yt+kvrT+rH78zlllk/3cMxpgwpwWOaK5xrZDvXXuw
 GB84iYvSM6/juY602OEsLjBwcyeug+aeAxEL3BIo1K1a6SJUo+J7uf3JzvcN/PFRWOuW
 HMuodVuW+TmczmaP+lHO2Kvkl3jdDotPOH1mefuuDjuZRaKzYvI+QeCCWa7GPUfrtJ59
 cyhr2skc9KX621Ay37xLKpKxGDI8YeQ9vaTA9J5HlqqC9XHovcQDK9eRBqYjIFZimXg/
 lyEC7Sb68PGfrcQKLsS5IfeYhsewhek0FBuIPc6zRckusV244m6ZpnwaBlkyfDRnwTtJ
 PXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=clJr5Kgf8rNpIsygI48thRCVYe5Ho9N/9bfnCdo91XY=;
 b=OUSOV0Xva8UKzu2s91fGfkxo0ima9Q0J44WK7sxWygu0MYjUCbSj7WzOrF9olDVo5w
 QaYmdtWbrIGefDSpey3iSDfmjr8hdLRrpONfJ+FaZHXXKTzQ10W53mydvDFx4lyla3eO
 K/MRQ5HocV7aiHceeqzatWNy4N0Kan8/DMLfsznlsGohMLfZe8feAiA/ij4gW9pvk5DK
 8S7qpIxxAyt4lE/mCBb4F0EHgKu59iy2FPVUh+jQWEqJ31KxEOfNULIBpsvByVIcE8bw
 L2dXkhKT7i5VFlrt0gdp0IIV5bOGpuQSD69+0fKzBpVGwlLh8yDVbRXv/U82jcnVYX/P
 iYzw==
X-Gm-Message-State: APjAAAXIYhy7SR4eSATbQEhElfOzxpAGbR7T4vTfKjxeVDVTrJC9kOK1
 Ngp+UlkeIcT4AOBZEXtilQ9aqw==
X-Google-Smtp-Source: APXvYqw27uDt9M1G3TwySWhPauhK6/69sNU/MKlecfmFNMIMY+XsRR3u21blVfVFN5/cAm5q/1+Q7w==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr2265274wrv.268.1561535333005; 
 Wed, 26 Jun 2019 00:48:53 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id s10sm1411600wmf.8.2019.06.26.00.48.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 00:48:52 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-3b5978c4-bfb8-4757-ae5b-0731f2851d30@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5711ab6f-610c-b05a-c728-4a35a0963a2b@linaro.org>
Date: Wed, 26 Jun 2019 09:48:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-3b5978c4-bfb8-4757-ae5b-0731f2851d30@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 joel@sing.id.au, Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 8:07 AM, Palmer Dabbelt wrote:
> On Tue, 25 Jun 2019 08:36:28 PDT (-0700), richard.henderson@linaro.org wrote:
>> On 6/24/19 8:08 PM, Joel Sing wrote:
>>> Regarding the alignment for reservations, the
>>> specification does require this, although I do not recall seeing any
>>> enforcement
>>> of this by qemu itself.
>>
>> Ah, I see it now.  Enforcement begins here:
>>
>> static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>> {
>>     REQUIRE_EXT(ctx, RVA);
>>     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>>                            ^^^^^^^^
>>
>> This will force softmmu (but notably not linux-user; a design limitation) to
>> generate an alignment fault for an unaligned address.
> 
> That was probably correct at the time the code went in, as the ISA used to
> allow these to succeed but not be atomic.  No implementations did this, so as
> part of the ratification process we just mandated that unaligned atomics always
> trap.
> 
> Is there a better way to fix this than just doing the alignment check
> explicitly?

You misunderstand.  The code is exactly correct as-is.  The alignment check
happens implicitly as a part of the softmmu tlb resolution.


r~

