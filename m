Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D654C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EB92073E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJoevMRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EB92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGVde-0000P6-6q
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 18:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGVcl-0008Mz-Or
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGVcj-0008UT-Ie
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:32:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGVcg-0008TJ-8S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:32:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id b72so8232696pfb.11
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B1oZ3xJQlrTnwzdoP0iQy9GJ+m+WfSwOXkbFFTIIFrw=;
 b=vJoevMRvgz4Kub1jCXQAxSKRHjwQybzSdNl2GIxDt6xYJx1fcqN6BC7X2wNnpXH/IQ
 2qyG89RlZkRjDBdIHSD9ueqwGcezcRBUZ5BIZixWdHJotLFrQWgQs9kvM+VPwDKJ1Y+P
 vmwExlhl5KRaw2bPan/ddHZjUBfP2LN1SaPcNCJyqFmwpJ6IEdlnAj7NWz4PnmUx5rhz
 ItFGDzYrcYGRYMmc0HAGi2XAv/lCxzJdpy6EoWt8jrrJKu39/U7b04/v3Ks860frFYJ4
 VayBxcFiD4cLpna1Oj977g9Vh9rmk0Fphht3lzLwTg0i/ZuHR/lhZRnVARekPr4qAKoF
 qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B1oZ3xJQlrTnwzdoP0iQy9GJ+m+WfSwOXkbFFTIIFrw=;
 b=UDgFUtHz6QwqfH55G87AtFqejQDVwYZy2jm0G6NOzphXepVelC0/2VM8X7yu33pM8j
 nPfVOLDeS9WcP+j3TtQvkzIRrfs5umiKHW+BcOHoPyg0KFtb05dIyXXGQPgCdjB6IKH+
 22ZVGdbVR23NSRbPF+dfEwIv5vrbPQb+cQ/DuLQmglQyypOnDnMWqq1mytzlbLPU52fe
 gslqzwT0VipE+jG7YvVfXmJ3/OJR3aEsVFeUG+PIS95Ubzj2AwQO016YWVO8+eC2mheH
 10YyxqPRleAvah1YKu2sNajMzfoAx6gUJVHMptQDHF2HPO1f8jSva3tm8yPVR+9/9+lp
 djsg==
X-Gm-Message-State: ANhLgQ2hZWj9f3olO9Y6aI0dg4jw7ujJarEwEchzBMMmrI77+cWhMw7t
 7Vn/RNHsIkjIghqIoV7CesWfdu7urOM=
X-Google-Smtp-Source: ADFU+vs12ITDrvyKCdEnDq7oq5vOufSHjna5i3zY8ww4MjfweETIzGYxSAavfP/x1hecjGuhcsr2+A==
X-Received: by 2002:a63:ca0f:: with SMTP id n15mr22650091pgi.311.1585002760618; 
 Mon, 23 Mar 2020 15:32:40 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f8sm14113610pfn.2.2020.03.23.15.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 15:32:39 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Daniel Brodsky <dnbrdsky@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
Date: Mon, 23 Mar 2020 15:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 2:46 PM, Daniel Brodsky wrote:
> On Mon, Mar 23, 2020 at 6:25 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Fri, Mar 20, 2020 at 06:43:23AM -0700, no-reply@patchew.org wrote:
>>> /tmp/qemu-test/src/util/thread-pool.c:213:5: error: unused variable 'qemu_lockable_auto1' [-Werror,-Wunused-variable]
>>>     QEMU_LOCK_GUARD(&pool->lock);
>>>     ^
>>> /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from macro 'QEMU_LOCK_GUARD'
>>
>> Apparently gcc suppresses "unused variable" warnings with g_autoptr() so
>> we didn't see this warning before.
>>
>> clang does report them so let's silence the warning manually.  Please
>> add G_GNUC_UNUSED onto the g_autoptr variable definition in the
>> QEMU_LOCK_GUARD() macro:
>>
>>   #define QEMU_LOCK_GUARD(x) \
>>       g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ G_GNUC_UNUSED = \
>>               qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))
>>
>> The WITH_*_LOCK_GUARD() macros should not require changes because the
>> variable is both read and written.
>>
>> You can test locally by building with clang (llvm) instead of gcc:
>>
>>   ./configure --cc=clang
> 
> Using --cc=clang is causing the following error in several different places:
> qemu/target/ppc/translate.c:1894:18: error: result of comparison
> 'target_ulong' (aka 'unsigned int') <= 4294967295
> is always true [-Werror,-Wtautological-type-limit-compare]
>         if (mask <= 0xffffffffu) {
>             ~~~~ ^  ~~~~~~~~~~~
> 
> these errors don't come up when building with gcc. Any idea how to fix
> this? Or should I just suppress it?

I'm of the opinion that it should be suppressed.

This is the *correct* test for ppc64, and the warning for ppc32 is simply
because target_ulong == uint32_t.  True is the correct result for ppc32.

We simply want the compiler to DTRT: simplify this test and remove the else as
unreachable.


r~

