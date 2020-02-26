Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D8C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D612072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqHhXS03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D612072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Ws-0001r8-4O
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j75VY-00007a-3g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j75VX-0001qO-0W
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:23 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j75VW-0001pk-Px
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:22 -0500
Received: by mail-pf1-x441.google.com with SMTP id j9so521590pfa.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CQMLeLQ/bkVIYCJZJZncIzXsdZ5tgDqx/ndr2z64TIA=;
 b=GqHhXS03bWEZ2jMlgcrBFaJgAHXzdqWTTv/o6xiITr0dcDZD89coyzGKyXtTEYB5WA
 8Oc3W1wjLGpoTGySKQBAKqMVsRSkG8hz1eJmqbyc16zheI95e50MtLlMJeH2fVUOmVTY
 ns6SlMZPpj+kZbImVOwdXTQSxWyV/lMF/mKuBB1UImHtsgZJZmaTcKfbRFRgJdetJNar
 ftDEEnDfFgJerT4DWswu0mQ9nj12jiiWv51haLQltdOteAPHvIAkpctauJpLPKXzGzmV
 +B565pvd+Lhcx6HNmsaLYM+SRJPWb7iorxJL2ll55RRzOmL0mOvK3Abo24M6AMwcfW3Z
 1ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CQMLeLQ/bkVIYCJZJZncIzXsdZ5tgDqx/ndr2z64TIA=;
 b=U1EpH5/qlYeVkXQVwlUPPfA2IdUI7x06Udo/A4p0sHXu/X9AYN44rFYmByLvKPmm5d
 I81ua2HoGFsBmG9Rf1g53S0GCsEZkwDRjNbLd892xo+cMOQfX2/nqgxm2Eue2LeNNJXp
 t6hM/ODTsLUb1DeMeywvJnXZ1t6MP19ZoEqVv8vqVHESwk9C06Iwhte/zjyx7V4ppteD
 +PRtqWlrl51lGvv6Upd2qLqSPUxSLAPxS+gznCSncNEndXzU0zQM6FwtJyjlOfDESRx2
 yLRa7sm4Ag32ByFTQ4+x7z1HQYmATdVqzVBB6F0t0baaNLuwAU+5FkH6a1HlqhJuVQyF
 vpfg==
X-Gm-Message-State: APjAAAUItC9a00Ym9Q1FHY0/ifzGq7OrM8qhdcEjr3npXkxJjz6fnfTR
 25uWMRagQmqhtnT7MK1gZbP1Eg==
X-Google-Smtp-Source: APXvYqz7HC5Yf7shVDwSYUQ+HEgeqbJZZQiy3tL/xzCZrCSvqK3DZ5Dxnioo6zT7S04CRtv6xjYwMA==
X-Received: by 2002:a63:a062:: with SMTP id u34mr1100295pgn.286.1582757421918; 
 Wed, 26 Feb 2020 14:50:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i27sm3750169pgn.76.2020.02.26.14.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 14:50:21 -0800 (PST)
Subject: Re: [PATCH v1 2/4] accel/tcg: remove link between guest ram and TCG
 cache size
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-3-alex.bennee@linaro.org>
 <CAPan3WrD5kpnyNM_TqKOZP4GG4E0npaEqbJe6KidqJW2toAe6A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a14cb6f2-01b2-187a-64f5-0ee62d237971@linaro.org>
Date: Wed, 26 Feb 2020 14:50:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WrD5kpnyNM_TqKOZP4GG4E0npaEqbJe6KidqJW2toAe6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 2:26 PM, Niek Linnenbank wrote:
> Hi Alex,
> 
> On Wed, Feb 26, 2020 at 7:10 PM Alex Bennée <alex.bennee@linaro.org
> <mailto:alex.bennee@linaro.org>> wrote:
> 
>     Basing the TB cache size on the ram_size was always a little heuristic
>     and was broken by a1b18df9a4 which caused ram_size not to be fully
>     realised at the time we initialise the TCG translation cache.
> 
> 
> Now I'm beginning to understand the issue better. So without this patch, the
> TCG translation
> cache effectively was disabled, causing the slowdown, correct?

Yes.


r~

