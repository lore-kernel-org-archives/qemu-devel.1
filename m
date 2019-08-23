Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E45C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF9621726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsdgFsPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF9621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CNT-0006wr-Vj
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CMG-00060P-Jx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CMF-0003O0-EF
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:24:12 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1CMF-0003N4-63
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:24:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id d85so6785857pfd.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l32KsYCTK7OT6MliknFHrDHpd8O4OI/S2wX0MFNBUPk=;
 b=YsdgFsPAYjJlZsgydT3yIu1TFjrYprsxPBuF4K1DwhsvY27FsKOfmo+b0LENs9O3d4
 EZbjTvXXagu0Gtq6znjL1lvoeoL3kaSqX691d02hJ2zuqGm/eY969gY5K1a38pOwuepL
 Ndo4F3u3WHZdOr0EvTyEx3IAmUUxOJQbHe6kty73G/Sb4GCCB44myrZQPp1tci6RbDCu
 4yOWIeNLvNNt0MPtx5k0Dr87/BkN3zUmy1U78scM+p7rYSIbkskQrwcRwIKLkOai/38S
 5hAyhtiVQ/Kk1ZKKTlBV5Jy1pUBvgxdv4SwqpGOMZ333F6TXIIqaQxGkLL6G8uaTPiKT
 od4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l32KsYCTK7OT6MliknFHrDHpd8O4OI/S2wX0MFNBUPk=;
 b=ryb/s2wNySOJVOQ3HjHZP7Y6M3E35b4ENq0cAPIeq+YJxwMabWfjqnwS7QkvSVxsQi
 knMPFmuNL0wupuv3P3FzD4x9C7ovd8C/eOCaYCzAeFvZ5p4j15fuRap8uorGaVjodbdt
 iibGw11swtWpMY9P8utQWm7Mw6wcZ4j6MCiYh96yNZ96VaqtKsoDHjdEN5R2x51ik0Qg
 MNxFg65fk/DapMw6lPbLCyXz//SzA2aiM8XDZJ4W4MILfKJ1j3GVYNcg4rqxbzkkPdAO
 3QUvBHHibb4/pkAJv6bI7vtsky6zC/kLq+m+aZ5MjFKwcbBrjTDG+z3ae8K/NH7w/dt4
 +qlA==
X-Gm-Message-State: APjAAAXAxJUhvGP+B3MrJ/stwIrcpU5zkJGs/Cm0qi8S3tiAlGYorUTc
 I/Ro50z3ckb7tsRRywMBhNEfRg==
X-Google-Smtp-Source: APXvYqz96MVsKX9ouIdvTNx0YBoP0s8x1+ZGIFLgLLIJ6eIytjF6ORzAq2goEHIDxbNXuOTKTZqZJw==
X-Received: by 2002:a65:6259:: with SMTP id q25mr4797652pgv.145.1566577449727; 
 Fri, 23 Aug 2019 09:24:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x1sm3229097pfj.182.2019.08.23.09.24.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:24:08 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-21-richard.henderson@linaro.org>
 <CAFEAcA85Ojy2u_G6frO_KL-kmTVCfpcOxsW5CCuKr=eKPcm+KQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1766ac0b-5bc5-d01e-7314-9366d2238292@linaro.org>
Date: Fri, 23 Aug 2019 09:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85Ojy2u_G6frO_KL-kmTVCfpcOxsW5CCuKr=eKPcm+KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 20/68] target/arm: Convert load/store
 (register, immediate, literal)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:54 AM, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 797 ++++++++++++++++++-----------------------
>>  target/arm/a32.decode  | 120 +++++++
>>  target/arm/t32.decode  | 141 ++++++++
>>  3 files changed, 615 insertions(+), 443 deletions(-)
> 
> This one is brutal to review. I got through review of all the
> decode file patterns but got bogged down when I started looking
> at the .c file changes... I might come back to it alter.

I'm not sure how to make it any easier.

In the old code, we pass around insn and extract bits where needed, including
subroutines.  In the new code we pass around a structure that has the bits
extracted.  I don't see how to make intermediate steps.

It might be easier to review the new code from first principles, since that's
pretty much how I wrote it.

Unless you have a better suggestion?


r~

