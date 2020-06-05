Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1615DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28CB207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1VFvqyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28CB207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGR2-0001dl-2Z
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGPH-0000fS-Ff
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:45:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGPF-0005oM-Dq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:45:27 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so3979861plb.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fGMDhJbBlN1Bl9emP+Ss5jMSTecA4OVxD1vFXgajnUI=;
 b=x1VFvqyT0IjkAwuU87JKaFJnRKyJgfRLrYBmLEzpb0GaesZ8Y9b0cp96JDZZHuDUET
 ffU9xehAnfzJYMtEaXorhGd+Oo6NNp6u4E4HVr3LqCRRV5rluuNH6Apso9hMlphx+rnn
 lb4Lv2BWM5Ux9n0zMmAfMZNru3pjeEu/Uny45tO3tat6ekkRcvviwbLxEBkraV7D4dyB
 sMZuSTwVBH9ncsN2V7NHov4cshM8jZjrFnJEPFYuKwmD57pABlTT1sMRXGeZMuq206qV
 /2ttP4PxzBU7qiiafPOaaMaVwIYJSlpmV9/TDhqFLQ88lZIdqmx1UP/D2mxUqDh7vQZ4
 lLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fGMDhJbBlN1Bl9emP+Ss5jMSTecA4OVxD1vFXgajnUI=;
 b=cDid0YH2hCg8zs+ERUNWm+4YUWjyJOC6b/yjad8ihF7huYH95GPy4//WFQnfKY9cRE
 edOK+sxvxyJBE6uJurrnnAToqjJKg/P4iOxCnMkzAZxZRoqGE+erCAMQDls4fGWOVoVv
 R3C591TVfnOFtAiYkSRZn3tzerSjPVDSV+prltt5CgCfGCEqruAzAZbovFOUhQATAaz2
 9rqB1D55jFJbHv4/P6LDpH3uGcD+lOv0Me7Ebju5c0VEYhekSA7Fyiej+IzDnl+O6L2D
 NZxFILwpE6q4iV7hHV93fF/zyClFiJewW0MLlaSF72Iue5K8h+7Zseoy2TgB39LQq9fv
 E/pw==
X-Gm-Message-State: AOAM530QGASFEASI9IGk4E6d8VyuSXD622JWDL76smeFAyoNWr8hJnjd
 lbcAu5LOck8umKzQEfT73wWoOmIjfUc=
X-Google-Smtp-Source: ABdhPJxmvVEdpWXr2cSHC7cuSFYq9Jh22IKfKOZnQ39UpWc+0kTwIrShoM/65vBh58zVVI9vI1178Q==
X-Received: by 2002:a17:90a:376e:: with SMTP id
 u101mr4287848pjb.126.1591379122706; 
 Fri, 05 Jun 2020 10:45:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id w192sm205466pff.126.2020.06.05.10.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:45:21 -0700 (PDT)
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <87bllx4igz.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <535cf85f-96d7-0e98-c69e-c09b976bc251@linaro.org>
Date: Fri, 5 Jun 2020 10:45:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87bllx4igz.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 8:53 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Clang 10 enables this by default with -Wtype-limit.
>>
>> All of the instances flagged by this Werror so far have been
>> cases in which we really do want the compiler to optimize away
>> the test completely.  Disabling the warning will avoid having
>> to add ifdefs to work around this.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  configure | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configure b/configure
>> index f087d2bcd1..693f01327f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2009,6 +2009,8 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>>  gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
>> +gcc_flags="$gcc_flags -Wno-tautological-type-limit-compare"
>> +
> 
> nit: the pattern is reversed compared to the previous lines (foo $gcc_flags)

Not a nit.  The -Wno- must follow -Wtype-limit, or -Wtype-limit will turn it
back on.


r~

> 
> I had exactly the same patch in my local tree but it wasn't enough for
> clang-9 which I was using for a sanitiser build. I ended up
> having to apply --disable-werrror to the configuration.
> 
> Anyway:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 


