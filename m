Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FDB20725
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSsDdC9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FDB20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQaIc-0000cT-OZ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQaHx-00006M-HF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:05:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQaHu-0005YF-Rh
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:05:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id n61so6345574ota.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xRePpg2o5XBZSI86KvKhqkw+l7jkaMotD5KhSHRs6HU=;
 b=QSsDdC9C8IqERPcA1zgLCgm6VQhDifX0G1ibyTyY3ib37IsE/4vc5sdmAeaC+KXN+0
 EkvmhhXJCsu6+kKhFmn91m5v1zZAullc5o/16rea7RoUJ8OTYDNs980uGQKtGRnJ9E8y
 AjHCyFBRSX8Sqige66u5geD+JNVUkptsDcvrgDOiOj9eBhkzPG0RE6SJkfYtdjsztIz0
 YP0m7PeMs25zObKJXUKsctj/h93xAKbqd/cpCLUWGhQ0mbjL9JaBuQvI3S7KZdJBSetC
 XuM452dp0hSJrZgDYBTJErQYZdfKms8xAMOXeVxr/V7ivZ88hya9KuI5Z70CJZwR62oO
 51NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xRePpg2o5XBZSI86KvKhqkw+l7jkaMotD5KhSHRs6HU=;
 b=m+ObSVVpNRQBSf9rnV/lmyvp5qdnrunPIz/4ZPJ274n1nyhYV70Th/qtCQlS+q81kP
 +eKmti24QH1xUT2M3jt1WoFmIHrToQ/XHaDRNbyMwPA6IDQx4b4MftHqxwJIdaVhSjLB
 zHVp3dQcQ+9D5OgvJBnW4UlSmuZnoWwv6MSX9EVHHkcackjzIhib/yK/yaFjz4mBo2l0
 u/x1XghZf4Oq+ArvwXZYN2IjFEZLW8uHHIIuhx8rp3uz9+G6vxsLuIzlW7knfeywHRhN
 rqV8ELwUel//6OEs24MTdJFzvoP2KtIjzh/P6yKyqg/PdG+Lp8QNRrNlXHboQhsNAmkt
 2gNw==
X-Gm-Message-State: AOAM530Ek0h28gAPUiIKQWt5BANjkATKOeVZJRSBGmif7FIMVagyu8iC
 cdoa1Bg0Q4iRziTMJwpYgCzYnNPQlt7REeey
X-Google-Smtp-Source: ABdhPJxBgg2bt5Vif5CWbeNRGXRrUMctkyBFwyXCZr18TLGwefKxir36ZUYjD2prfckzEeg23HSgvw==
X-Received: by 2002:a9d:ecc:: with SMTP id 70mr6135216otj.66.1602180308917;
 Thu, 08 Oct 2020 11:05:08 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id 12sm5120917oir.57.2020.10.08.11.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 11:05:07 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
Date: Thu, 8 Oct 2020 13:05:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 12:53 PM, Claudio Fontana wrote:
> On 10/8/20 7:44 PM, Richard Henderson wrote:
>> On 10/8/20 10:02 AM, Paolo Bonzini wrote:
>>> On 08/10/20 16:48, Claudio Fontana wrote:
>>>> on master, a build without tcg like:
>>>>
>>>> exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"
>>>>
>>>> make -j120 check
>>>> Generating qemu-version.h with a meson_exe.py custom command
>>>> make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
>>>> make: *** Waiting for unfinished jobs....
>>>>
>>>> qemu-system-aarch64 is required for check-block now?
>>>
>>> No, it's not, it's an unnecessary dependency.  This will fix it:
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 5aca98e60c..1ca70d88ce 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
>>>  check: check-block
>>>  check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>>>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
>>> -		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
>>> +		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))
>>
>> Why doesn't the original line work?  Waiting until all of the configured
> 
> The original line breaks because without TCG built-in there will be no qemu-system-aarch64 to wait for.

But aarch64 should not be in TARGET_DIRS (for x86 host) with --disable-tcg.
There must be some other problem.

I can reproduce this though, just as you say.

Ah, TARGET_DIRS isn't being pruned anymore when a target is disabled for lack
of accelerator.

Paolo, side effect of 8a19980e3f ("configure: move accelerator logic to
meson")?  I guess we should move the setting of TARGET_DIRS to meson as well.


r~

