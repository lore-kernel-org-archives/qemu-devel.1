Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92931C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA7A2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRss9BQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA7A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaEEm-00046Q-Po
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEDu-0003fa-6H
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEDs-0004PG-Af
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604478770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLC3Cc5wjB3/jDE279ohkBMxyga1YQq8QNqQEdaWj4A=;
 b=KRss9BQdN6GgsdpcKLbNhGqUKLNDBH7abAbDNlGVR8/+6WgncATlGpt6KY6Ygn7d1SbOsV
 zsiGb/zR2ixBwZeUrUSOLG+hEerJweBujPk795Jaa6uSdczb6BzlmFEWAGCnnOcqToxBa5
 XHA5Kr9b7LVoU29ck9tus+KTwPkWIwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Qi5ouxAONk6hAb5O5w6Ejg-1; Wed, 04 Nov 2020 03:32:49 -0500
X-MC-Unique: Qi5ouxAONk6hAb5O5w6Ejg-1
Received: by mail-wm1-f72.google.com with SMTP id 13so932867wmf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tLC3Cc5wjB3/jDE279ohkBMxyga1YQq8QNqQEdaWj4A=;
 b=nTj3/mtiMPYQGnxnw67hGhJ8Wl4Vi3MJw/sncZlJJm6lWcl+yWkt+6em0ncDRoZFMX
 THrCF85aOneGHEHWFqGZqIOw8nF34+L7ym/NB39hl3ETt5PjfyGobtYMUDbFy7NfDZWc
 bcBizqplHSv5CyfFPVMrGxy+ksv6bZH1l93JF6msRIV51d70f58oF9d/UHUM6BHAhO5P
 EmHZk4ajZHLL239VyjVugE86Ds+ZzWY/T3IyacX5UgNCqbWBqJ+SXuuXnUEnP22dxD7+
 yQR/Z0AIngvtBYNAIzOnDf5NBwAkjyd2nR4wdr0TJSex6mRFt2+CWgR663wZldtvnu3V
 /HHA==
X-Gm-Message-State: AOAM532iVCKSvjYbU3+RI5NftGSqLtp+wDlVVQ3spjIu+2Nh+2x81CEt
 6fWLoLnhgXAp+UhiLsBpKv1d2gF5iAUWuM7b8SI89M1yTCTMrIADm68Y3Z9ZnGb5BCLjoS662Ka
 2N7lF7M61rT0eglI=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr3310438wmj.77.1604478767816;
 Wed, 04 Nov 2020 00:32:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUII14QktKWhIBzYx/0rJxuSoQ1hQqQbewWcuiin9TEPPNz5i4VOa/6VkJkJt6z3hKMGuO/A==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr3310405wmj.77.1604478767523;
 Wed, 04 Nov 2020 00:32:47 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e5sm1422715wrw.93.2020.11.04.00.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 00:32:46 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <70b50ba2-f0e8-4cf7-b5ff-14178e03d595@redhat.com>
 <01ec47fa-4e0d-1be9-e4e6-312b9d810d74@redhat.com>
 <8f79c67c-3851-06a3-8646-403041a793c5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c4c591c-4bb2-83b1-383a-e038aec62e27@redhat.com>
Date: Wed, 4 Nov 2020 09:32:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8f79c67c-3851-06a3-8646-403041a793c5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 7:21 AM, Thomas Huth wrote:
> On 03/11/2020 21.41, Philippe Mathieu-Daudé wrote:
>> On 11/3/20 7:43 PM, Thomas Huth wrote:
>>> On 03/11/2020 17.46, Philippe Mathieu-Daudé wrote:
> [...]
>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>> index 3b15ae5c302..6ee098ec53c 100644
>>>> --- a/.gitlab-ci.yml
>>>> +++ b/.gitlab-ci.yml
>>>> @@ -262,6 +262,17 @@ build-user-plugins:
>>>>      MAKE_CHECK_ARGS: check-tcg
>>>>    timeout: 1h 30m
>>>>  
>>>> +build-system-ubuntu-without-default-devices:
>>>> +  <<: *native_build_job_definition
>>>> +  variables:
>>>> +    IMAGE: ubuntu2004
>>>> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-xen --disable-tools --disable-docs
>>>> +    MAKE_CHECK_ARGS: check-build
>>>
>>> AFAIK "check-build" is pretty much a no-op since the convertion to meson ...
>>> could you maybe replace with a set of qtest targets that work, to make sure
>>> that we do not regress here? E.g.:
>>>
>>> MAKE_CHECK_ARGS: check-qtest-avr check-qtestcris check-qtest-m68k
>>> check-qtest-microblaze check-qtest-mipsel check-qtest-moxie ...
>>
>> qtests don't work with --without-default-devices, as we don't check
>> for (un-)available devices.
> 
> Sure, "make check-qtest" does not work, I know. But some targets work fine,
> e.g. "make check-qtest-avr", and that's what I've suggested.

Yes, I tested that successfully yesterday late.

> By testing
> those targets, we can make sure that the qtests don't regress any further
> with --without-default-devices.

Yes, but I'm being wary to use it with the sole AVR target, because
I don't want this target development to be limited by unrelated
technical debts (in case we add optional device on an AVR board).

> 
>> I'll try check-unit.
> 
> I think that does not have much benefit since it should be independent of
> the devices and is tested in the other pipelines already?

Ah, good point.

Regards,

Phil.


