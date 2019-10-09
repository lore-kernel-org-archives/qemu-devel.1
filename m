Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D0C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EED8206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVnNCyPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EED8206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIKQW-00024U-Bo
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 18:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIKPV-0001ZO-GY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIKPT-00081B-GQ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:26:21 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIKPT-0007zK-8p
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:26:19 -0400
Received: by mail-yb1-xb41.google.com with SMTP id q143so1266084ybg.12
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LaS05mr5CmE0QtmsOPdEjMDX00OVSXW57laxAy1lnew=;
 b=QVnNCyPUIlo/pq8TYshSC4UJ/slOuyxsIW56w6bTBcpHgA9O24aJ5vmhSSCNkwyTvO
 WOqh05xysaG1e5vEVQznto094tMyWEEpgWXxa/zps6j1CIV3ytM6VRr4QIDUXvsZ00TV
 uSowZX8o5YDmPG1Y2VdhBaxLg8k1orTTFdITo0Qa+PlOV8NTwu2LP+viry6dfu4UCc7g
 04LU7jsaaJ9di8C+IX+vhklaGiXcXM9hQyW3Dx4yK726oghNv+zqnKsOhXGlVyhja3u4
 vTrLBqJPSbzlVvORduXV3xd6YBqP+h/JTRIg3WKgIOMWY4jXwpSkdH16TIAeiFAuw66f
 tHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LaS05mr5CmE0QtmsOPdEjMDX00OVSXW57laxAy1lnew=;
 b=Y5197JCTkEly2TvfAK3v0pMGk+mWIBaP8l3zTwQelK+dniNrCdGNcVqAckEu5T6nJF
 d1LXPMc8ZTaBwD6RDH1wfkOU//SspdfzgRJNoAngNNMNGJ8FHWDN129QTd4/zRxbG4gk
 FbIIfL9fpaxjR8KnbzooVg9sTFDhVmO5ed7JhKSh/4ZAqy4zSHbrC7nE1QeOgoJmFvMu
 bkK1EH7eTgYJLv4YEVa0sTPi9OJiymQL4NZDsGT+9oIZdf4XClQxElzuRvuB1zjx0vft
 3uJgOwviq+1rBfH+r+p7EUapdlfXEQnr+/QgUBImZ4d8G0g7E+ID2JcuitZyBaP/9+NJ
 m9ag==
X-Gm-Message-State: APjAAAXXpK2aUWy7V4zGu/jb7t4HG91B04WMKQ0+gjWNbyzzKKVUuWad
 pJ6BM9KveIbjuCmfDAtXH7Y5OqLLL8c=
X-Google-Smtp-Source: APXvYqxwo2Byu1T/bZdvB9YOjDTY5BZm6p6xbfnnI3Bly10YI0Sg4K3ddR1favkwrVtnv7k9yqBelQ==
X-Received: by 2002:a25:742:: with SMTP id 63mr1960806ybh.214.1570659977996;
 Wed, 09 Oct 2019 15:26:17 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id y205sm890128ywc.6.2019.10.09.15.26.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 15:26:17 -0700 (PDT)
Subject: Re: [PATCH] RISC-V: fcvt can set fflags, so set FS accordingly
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
References: <20191009211541.9937-1-palmer@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6acbc2de-66b2-a363-cbaa-bf1f458fdf62@linaro.org>
Date: Wed, 9 Oct 2019 18:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009211541.9937-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 5:15 PM, Palmer Dabbelt wrote:
> A user pinged me to say "my floating point heavy code works in user mode
> but not system mode", which I'm guessing is the result of a lazy FP
> save/restore issue as those still crop up from time to time as long tail
> bugs.  I figured it was worth giving the FP stuff a look to see if
> anything jumps out, and it turns out that there is a bug: converting
> float to integer can set the invalid flag, which is supposed to mark FS
> as dirty, but the emulation routine doesn't do so.
> 
> This patch unconditionally marks FS as dirty for fcvt instructions that
> convert into X registers (fcvt into F registers already did so).  I
> haven't actually tried to manifest a bug here, but as far as I can tell
> the soft float stuff does set the invalid flag.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvd.inc.c | 2 ++
>  target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

