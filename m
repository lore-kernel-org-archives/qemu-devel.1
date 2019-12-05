Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0076C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C1D224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqUaMfXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C1D224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwwg-0000uz-Ow
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icwvS-0008QL-QS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icwvR-0005lY-AO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:36:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icwvQ-0005et-Sr
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:36:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id q8so2074416pfh.7
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+wif4h4CRxcxxjYAPak4RRxF1JnlVEgWYO5ih4Y0pfY=;
 b=SqUaMfXFSihNvxOnqqn7pBDj/km17ZmaTt2ghEyxmNKVReuGMXYwRwFbm7AF+Tfm2S
 OQX2YmzuBWoZoOgGvqlZXaaUyv4IWDvSX8GhvCTLbxqGUE+O7i+MRABgkBLJadN/xzNB
 VIui/zF5+z5N9+yG+x9usNyvNCTwdLX26TTyf2KixlqQa8Zjy6CTnr3fphZ6vF+3N+zs
 SrTbzJsdqyc8sczMRWBsh5fFRKQFqwxW1jRROEeR/vNFnc6Sd0k8kQlqoWfP/a18Hqrf
 upqqdOzQ0i7XcTsYmrWjIQ8cfXoMl5NE3yniNLYfECx2C6EOM1PCTTOCfDTVH5G6r0Hj
 yUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+wif4h4CRxcxxjYAPak4RRxF1JnlVEgWYO5ih4Y0pfY=;
 b=VUyUNxcLSA5Ma0WwUlN+yoJjBy/C4sgYkBZ/g9WsnvoL7/JQ4TJ10iVgyeymMh+Qaz
 CVqJCtoKIBVnh6tvzCUwUbXwBLxA25p8+GDNurS0YILhZaJbh97MFV1scXiRNK7HLhUg
 5CsgvQO32P0HH37XI+8cfMXksRrWsYZRpY7oegqAaS/LX1Sb9q9XuurdE2sE4+sik3Uv
 H7NOCqoJtCR7IJo059QXfUUURjYNJn3NhYJMtXIFwW+7+RNUMVZevFqr88143TxKnQKt
 aNfuxB6gBVRhlR2kTIc7Wkzt9FwPVSKenL3R1TsLdcmG1NzOZrz0dROjh2e/7eZmwXIM
 v9Hg==
X-Gm-Message-State: APjAAAWnfAZ9bgzoklS++IUJDYcT5fdMwSfwIgyKVvTewLfqS5+z50Rs
 XHb2ySKgPGnpncVOdaOtczyjkA==
X-Google-Smtp-Source: APXvYqyEQ8RZvjSBrBG4nwRogjPgebId2z/n0JyheG+9wEeMCqNdh8TPoFdVtVUThjYW4+VDiqITSQ==
X-Received: by 2002:a63:2acc:: with SMTP id q195mr10878365pgq.26.1575574589524; 
 Thu, 05 Dec 2019 11:36:29 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h3sm12499284pgr.81.2019.12.05.11.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 11:36:28 -0800 (PST)
Subject: Re: [PATCH v2 11/14] target/arm: default SVE length to 64 bytes for
 linux-user
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-12-alex.bennee@linaro.org>
 <9362663d-6452-39aa-2a8d-1cfd853d7faa@linaro.org> <87o8wm7k6v.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc54dbf6-01ed-f92d-5088-efe7e917b870@linaro.org>
Date: Thu, 5 Dec 2019 11:36:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87o8wm7k6v.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 9:31 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 11/30/19 8:45 AM, Alex Bennée wrote:
>>> The Linux kernel chooses the default of 64 bytes for SVE registers on
>>> the basis that it is the largest size that won't grow the signal
>>> frame. When debugging larger sizes are also unwieldy in gdb as each
>>> zreg will take over a page of terminal to display.
>>>
>>> The user can of course always specify a larger size with the
>>> sve-max-vq property on the command line:
>>>
>>>   -cpu max,sve-max-vq=16
>>>
>>> This should not make any difference to SVE enabled software as the SVE
>>> is of course vector length agnostic.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  target/arm/cpu64.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>
>> 6 is the largest size that doesn't grow the signal frame.
>> I imagine 4 was chosen because that's the only real hw atm.
>>
>>> +        /* Default sve-max-vq to a reasonable numer */
>>> +        cpu->sve_max_vq = 4;
>>
>> I also agree that we should match the kernel, but this is not the right way.
>> Changing max vq is not the same as changing the default vq.
>>
>> You should change the value of env->vfp.zcr_el[1] in arm_cpu_reset(), and the
>> user can increase the length with prctl(2) as they would be able to on real
>> hardware that would have support for longer vector lengths.
> 
> No the intention is to default to a lower max VQ because...
> 
>> Also, I don't think you should mix this up with gdb stuff.
> 
> it is what we use for sizing the registers for the gdbstub. The other
> option would be to use the effective zcr_el1 value at the time of the
> gdbstub connecting but then things will go horribly wrong if the user
> execute a prctl and widens their size.

Why would you care about the size of the registers as passed by default?  You
shouldn't need or want to change that default to make gdbstub work.

The gdbstub should be passing along the vq value (via the "vg" pseudo-register,
iirc), and gdb should be working out what to display based on that.

If that isn't happening, and you are only changing the default so that gdb
quits displaying massive registers when they aren't in use, then you're doing
something wrong with gdb and gdbstub.


r~

