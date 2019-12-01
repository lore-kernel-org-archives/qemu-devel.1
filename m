Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0CC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3BA2146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bygmteVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3BA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibYyO-000558-7Y
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 18:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibYxZ-0004fM-TY
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibYxY-0002Rw-Gd
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:01 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:46670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibYxY-0002RL-9w
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:00 -0500
Received: by mail-pj1-x1042.google.com with SMTP id z21so4489969pjq.13
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 15:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e8ZBpdzbyTgon36jg4SQEpCtS5cPGf/yo6QyGHTzcZQ=;
 b=bygmteVI7Bw7NjeIj5B0SvT8XxZ0lQGKGJJTd1sIs4SUA5dtFvavzuOkyEIB3JYhr4
 Zi/GiWDnXqOKRi3YuviG1uSxnzMAhoIDKCwO/Gt35ihaD9LhgvCxz7jWmnJfLY/U3SMj
 Rh031Cy5udwfpniCWwKBp91hTUAS722OiDwFnUW7C9tJe+bwQ/yTXd4hAhr8QSeM6+2v
 OLn2XGA1mVQ+HImvelILP1ZMTGprGvUZXOwy8ttgxuKdgQuXdHzp15coUO9xjKT+1DPw
 z1rEzMak+tosZnSBZxppWay/JDBb3N9xsOuMqJ3KEa53i2QAUoCiNUZswq5fv83pzRVK
 h40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e8ZBpdzbyTgon36jg4SQEpCtS5cPGf/yo6QyGHTzcZQ=;
 b=c3emFLMUXgtZ6hjykByvmN1DuJNN91dekx9wGa+vRyBsv4ogopAfBYXzFJ6pa8G2SI
 YX8wg0XnRS+f0OQKp7D5YpdNS4u4/XVqz8akmLaV/lU66gf1cKWcARMxDLl7wzGye1bg
 Bg3lQDaZxpsaRxuF7covO5b4ANoMHVPYuFyzGEfxGX25DK+UOaC4yYpouZsCwCEqhWY1
 u3/UXYr4RamV7qQJWVRzXj+JEJgtex2w3sye6QclFYvET92927tV3X69rAJwvUWeOxM0
 fXnGpaAOqwO3KpOaMB8Plb6/klEVdefG5Gg/FJHAeJJTDGNBM8PDMnuGxc/E3dk55kRu
 Rdyg==
X-Gm-Message-State: APjAAAXABs60C/EkFa+9XoydiaWgCXtJlsWZwAsTELP25dFlOKZRg+ez
 BqgTdyL2uMh/Ti5V/qX7RjMm1A==
X-Google-Smtp-Source: APXvYqykyZATZzBCQn44nBUiItJCKPOo72uUUOMWue9CbXEVFXXOdMaTuU+9pC0caVs+JyZGj2fbcA==
X-Received: by 2002:a17:902:aa4c:: with SMTP id
 c12mr24321626plr.309.1575244138209; 
 Sun, 01 Dec 2019 15:48:58 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r14sm5440775pfh.10.2019.12.01.15.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 15:48:57 -0800 (PST)
Subject: Re: [PATCH 1/2] exec: flush CPU TB cache in breakpoint_invalidate
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
 <20191127220602.10827-2-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c02ba4a-11fe-4d6a-e6d9-f1d164528d85@linaro.org>
Date: Sun, 1 Dec 2019 15:48:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127220602.10827-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 10:06 PM, Max Filippov wrote:
> When a breakpoint is inserted at location for which there's currently no
> virtual to physical translation no action is taken on CPU TB cache. If a
> TB for that virtual address already exists but is not visible ATM the
> breakpoint won't be hit next time an instruction at that address will be
> executed.
> 
> Flush entire CPU TB cache in breakpoint_invalidate to force
> re-translation of all TBs for the breakpoint address.
> 
> This change fixes the following scenario:
> - linux user application is running
> - a breakpoint is inserted from QEMU gdbstub for a user address that is
>   not currently present in the target CPU TLB
> - an instruction at that address is executed, but the external debugger
>   doesn't get control.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes RFC->v1:
> - do tb_flush in breakpoint_invalidate unconditionally

Unlike Paolo, I don't think this is a good idea.

If I was going to change anything here, I'd change this to not use
cpu_get_phys_page_attrs_debug but using the caching available from the actual
cputlb, using cc->tlb_fill() in probe mode -- something akin to probe_access(),
but not returning a host address, nor handling watchpoints nor notdirty.

This would help flushing too much by distinguishing different tbs for the same
virtual address mapping to a different physical address.


r~

