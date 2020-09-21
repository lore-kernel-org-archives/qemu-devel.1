Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72991C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68D021789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dtVoeVFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68D021789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLeH-0005mB-W1
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKLb8-0002rs-Nn
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:11:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKLax-00086N-41
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:11:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id z19so9187175pfn.8
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E3Uop2aPPYb7ST3CIgpS26VER4TUosf83NThRyPxLZI=;
 b=dtVoeVFAOsX6uxuCImvtw0+a9EdGOZ3Oc6Ifv7OjhBGxmwZPVUYMpgO6G+kipJ1F5b
 oeBbMg7u6v5aOvp9E2YHGN3jsDbjPa/i5EkCFAqDfJ/1DmHGrOEK2/2G1ocPuUUlXzrO
 sa3gTnUrU357D5gXnsXbRYJPAF7uLLsycIG47TOL1oAKGbqWGkXmImClacU+tKK8U2YV
 4wD4bLGnvN3gscDrTMOxprfMzue4d8dqtvkK2MOMsdtSNma9222NDLp75jlo2j/NhBXd
 MgUM4fIJNC9oc9/qpnxjzDKanvdRfpMNTd2jWvwQLGRVP6dz6l2Xn4X6PzI/RHKqngfv
 Zlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3Uop2aPPYb7ST3CIgpS26VER4TUosf83NThRyPxLZI=;
 b=NqMdL6229FGk5VnL61RQ4iOunA5S6ONuVAscDxF7md30uT8tmfR/+hhCS0/wmvgK+D
 QgIc2/pBEPhQJv2y3881p/hHhFRlobzNoLBU+ew4zP54AkriSut55HmwCWTiYA8yQgOF
 dp9BJjW0z0+w/lO9vvXwdnHueXn2bqJ1pOWR9TSqFdx2qpfQ3+WNOsBWZszjuZpPX7Yo
 qxa6tVifJ4C/vIb1VA6jPsB5I7yUfbM0E7J7IvGG6Vge8dy48jZZRsNaY1jifWIh9uIH
 2st4dihoAI0CnPpoQoeNf+ZXuMLuwMD3+kjZsL59pAPon5ZVM8eUCRiHsL+c1UI+AppF
 URvw==
X-Gm-Message-State: AOAM533r3/FY12CU2F6weQFNV8LBNLrH9JbgwcxKLRB7JkoK3XszEkxo
 Rkh/HEWLdSFY6gRwSNLFA2tUNyH3/x+JlQ==
X-Google-Smtp-Source: ABdhPJyL6F/tsGhRlNB8ksB3Jiqt0IHKCWrNJyr6iyChziEKffEZERxPQcn1PgZF2fso+pKC3cfC0w==
X-Received: by 2002:aa7:939b:0:b029:142:2501:39de with SMTP id
 t27-20020aa7939b0000b0290142250139demr27107657pfe.45.1600693859853; 
 Mon, 21 Sep 2020 06:10:59 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id j13sm9052856pjn.14.2020.09.21.06.10.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 06:10:59 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 2/3] iqapi/run-state.json: introduce memory
 failure event
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
 <20200914134321.958079-3-pizhenwei@bytedance.com>
 <CAFEAcA-KX6p3aaKxmMx2i1G2n+9GdOXjDL2mqmHcngq3M_f+Gw@mail.gmail.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <348159b8-0e10-ab93-42ca-5e6d586d5abc@bytedance.com>
Date: Mon, 21 Sep 2020 21:10:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KX6p3aaKxmMx2i1G2n+9GdOXjDL2mqmHcngq3M_f+Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/21/20 8:48 PM, Peter Maydell wrote:
> On Mon, 14 Sep 2020 at 14:53, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>> Introduce 4 memory failure events for a guest. Then uplayer could
>> know when/why/what happened to a guest during hitting a hardware
>> memory failure.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>> +##
>> +# @MemoryFailureAction:
>> +#
>> +# Host memory failure occurs, handled by QEMU.
>> +#
>> +# @hypervisor-ignore: action optional memory failure at QEMU process
>> +#                     addressspace (none PC-RAM), QEMU could ignore this
>> +#                     hardware memory failure.
>> +#
>> +# @hypervisor-stop: action required memory failure at QEMU process address
>> +#                   space (none PC-RAM), QEMU has to stop itself.
> 
> I'm not entirely clear what the descriptions here are trying to say.
> These would be for memory failure events which are reported by the
> host and which are not in guest RAM but are in the memory QEMU itself
> is using ? ("PC-RAM" is a bit x86-specific.)
> 
>> +#
>> +# @guest-mce: action required memory failure at PC-RAM, and guest enables MCE
>> +#             handling, QEMU injects MCE to guest.
>> +#
>> +# @guest-triple-fault: action required memory failure at PC-RAM, but guest does
>> +#                      not enable MCE handling. QEMU raises triple fault and
>> +#                      shutdown/reset. Also see detailed info in QEMU log.
> 
> "triple fault" sounds rather x86-specific; other architectures
> also have support for host memory failure notifications, so we
> should design the QAPI events to have architecture-neutral
> definitions and descriptions.
> 
> I think the four cases you're trying to distinguish here are:
>   (1) action-optional memory failure in memory used by the hypervisor
>       (which QEMU has ignored other than to report this event)
>   (2) action-required memory failure in memory used by the hypervisor
>       (QEMU is stopping)
>   (3) action-required memory failure in guest memory, which QEMU
>       has reported to the guest
>   (4) action-required memory failure in guest memory, but the
>       guest OS does not support a mechanism for reporting it
> 
> Is that right?
> 
> Anyway, I think we should try to find names for the failure
> types that are not x86-specific.
> 
> thanks
> -- PMM
> 
Right, to make architecture-neutral, how about these changes:
'PC-RAM' -> 'guest-memory'
'guest-mce' -> 'guest-mce-inject'
'guest-triple-fault' -> 'guest-mce-fault'

-- 
zhenwei pi

