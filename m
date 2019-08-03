Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41DCC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 01:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF17A2166E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 01:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peAEqdQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF17A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htisU-0007Ej-UG
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 21:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htiqz-00063W-Og
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 21:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htiqy-0001YX-BL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 21:29:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htiqy-0001Vd-2l
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 21:29:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id y15so36856853pfn.5
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O2YN/QvQPLAClyEHRsWfCjD/z1AkYNw3I+YAPw1gM+M=;
 b=peAEqdQ/+jsPCbvSoNEMbZBGBEB7ki3rifLdsBrYOJ5QKxZWLx1r+73A+qAOYmq5mD
 UFghBw8pYHSMfttL1UUuMSG05BfX39qf5PZz+gdA0dHRPJp1XfiGz/H5P4Sv8v9VWu8e
 sC142ceEEwx9Qnyg/aOteuebeBAw7hzsmkWuruWg1To0qG+FtFjEIJYf7EZPOmero6wa
 M6oNh9j/hNaLxjBCirpPkbVsIemJlO5tXPEAVpWRAGIeUkvYzpiTZ4JmQr7/rBHMgqK8
 /sVlTbxaTIHb+Yj+HHw/eiE7uGIxUUhj+hk3mCJizkgW9XXv/prcPgaB1DQQ7GG60g0q
 oKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O2YN/QvQPLAClyEHRsWfCjD/z1AkYNw3I+YAPw1gM+M=;
 b=j09LiwVqDUukKTjd6bRfiXLHMp0rJq4um7lF8V4j4u0zyewhdSeIqIDDb09iRUK5Ll
 FKVlQYdPhZDa6O+YTHMtXdDr2D7JBCLiVCQ+4lqqA/gzhtB/yi50K0tJlg0IqfWAJ3NE
 Qd1bj1VC1Owgab6eO1xCAwln0rIPzRkASJCLKS0gOjzzMfzsEk1JcsoBoKIDkqgK10hh
 E14Zdy0B8oSamA+Z5Zkzz4WLQCSnHepP51gsU1zN1x9juhI9/oq482eJRZINfCaFywq9
 cmNbUHhLhZP4JiaH//H5yLGaT856gRSmRDaYD4xjU5TtvcjVN3tJ0mmmLpC4hxG8vp0p
 7RsQ==
X-Gm-Message-State: APjAAAVc+n7jfRrO8NukL2oAO37uDGv4Y0XJYoqBVVQKXRqj8rk2zl+H
 TDImXUU1vu1TLN28i287gk4aJw==
X-Google-Smtp-Source: APXvYqwnVSUZlfREhsnBw9LuHXiDiZQOlt95M3/uViEX+7mxMOn6jU98+8N42JxsR+pBkaRjBsNXqw==
X-Received: by 2002:a17:90a:8c90:: with SMTP id
 b16mr6967034pjo.133.1564795735351; 
 Fri, 02 Aug 2019 18:28:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v13sm89644104pfe.105.2019.08.02.18.28.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 18:28:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
Date: Fri, 2 Aug 2019 18:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 03/15] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 9:27 AM, Richard Henderson wrote:
> On 8/2/19 5:25 AM, Andrew Jones wrote:
>> Note, certainly more features may be added to the list of
>> advertised features, e.g. 'vfp' and 'neon'. The only requirement
>> is that their property set accessors fail when invalid
>> configurations are detected. For vfp we would need something like
>>
>>  set_vfp()
>>  {
>>    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
>>        cpu->has_vfp != cpu->has_neon)
>>        error("AArch64 CPUs must have both VFP and Neon or neither")
>>
>> in its set accessor, and the same for neon, rather than doing that
>> check at realize time, which isn't executed at qmp query time.
> 
> How could this succeed?  Either set_vfp or set_neon would be called first, at
> which point the two features are temporarily out of sync, but the error would
> trigger anyway.
> 
> This would seem to require some separate "qmp validate" step that is processed
> after a collection of properties are set.
> 
> I was about to say something about this being moot until someone actually wants
> to be able to disable vfp+neon on aarch64, but then...
> 
>> +A note about CPU feature dependencies
>> +-------------------------------------
>> +
>> +It's possible for features to have dependencies on other features. I.e.
>> +it may be possible to change one feature at a time without error, but
>> +when attempting to change all features at once an error could occur
>> +depending on the order they are processed.  It's also possible changing
>> +all at once doesn't generate an error, because a feature's dependencies
>> +are satisfied with other features, but the same feature cannot be changed
>> +independently without error.  For these reasons callers should always
>> +attempt to make their desired changes all at once in order to ensure the
>> +collection is valid.
> 
> ... this language makes me think that you've already encountered an ordering
> problem that might be better solved with a separate validate step?

It appears to me that we can handle both use cases with a single function to
handle validation of the cross-dependent properties.

It would need to be called at the beginning of arm_cpu_realizefn, for the case
in which we are building a cpu that we wish to instantiate, and

> +        if (!err) {
> +            visit_check_struct(visitor, &err);
> +        }

here, inside qmp_query_cpu_model_expansion for the query case.

Looking at the validation code scattered across multiple functions, across 4
patches, convinces me that the code will be smaller and more readable if we
consolidate them into a single validation function.


r~

