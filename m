Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB87AC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7241F22453
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3hhkLYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7241F22453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbD1-0005Lu-EK
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb8y-0001FP-NA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb8w-0007H1-BW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksPKBsHGw1d9og8ybW3biRjlo4kbYsMsj5bBVchxT0s=;
 b=c3hhkLYfpPFTMvc8wjJM1o5hkSa3oUX+/A7VK1ZYcB5dzrwyo+PwNhrs+dfOg0dQX/BEG4
 xjhu8RvWf8EW9Z9ORo+TIkZqUNlWsu6rWozR517m5EiAmpa5WQrrmQfRVjUJmO5WjPoMZg
 J9fjDqUFzdLwwc8kSW2peTi+dw33c80=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-6knZpXg0PUqJe-2xoCg82g-1; Mon, 02 Nov 2020 09:49:05 -0500
X-MC-Unique: 6knZpXg0PUqJe-2xoCg82g-1
Received: by mail-wr1-f72.google.com with SMTP id v5so6568757wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ksPKBsHGw1d9og8ybW3biRjlo4kbYsMsj5bBVchxT0s=;
 b=b0ujjlmtoC6NoHvKjn4mAgrr2ieB4EprvUaJwIfRngKwBFY5lGuCSXmC0vDzq2jGvE
 xslMEByQsO6Gn5VKFCWx2cjXaw7J4BK0FFnPuop2krJ/FENvBSCkOo/KXfGUnuWHE/sj
 spjjx7Bdqiydnv/qfwBXuOnVpeGe4nHMrRwQWR8DDWz5DLgy43tglagfW2exG7IGwmM3
 M9pv14AQFg8NDkyAC1imT6TuNh6SX31IJXjI0waStK8YHe+fYGHvRi6esPzJMj8/nd0a
 PadX/HH49EbLzTdAWqu/3Ei2mwppEirfYp4KGyIK3hlVP1L3AXEe1/yZynSya9Abt9uI
 IXBA==
X-Gm-Message-State: AOAM5330I8F8xNCgZcE4Y2Rtc6bD3E40uRryeU4bArmMpZyMTW5j6NsD
 u8zXoqIL8ExO9ugZSAjJnJGUKEm9xEf+hepS8BRs9dQdmet3AYjnJIWRnt0XlMhLHqXAVR+XZ4/
 Q+FI5TffH9X23kPU=
X-Received: by 2002:a05:6000:36f:: with SMTP id
 f15mr20536443wrf.78.1604328543305; 
 Mon, 02 Nov 2020 06:49:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQJF7eRrmt3je6U+ap6D2N1PBctm1aCW2B2mgNZQYbKh0VFjj3eWKGPoLNdFWyrQu0Ctd5Qg==
X-Received: by 2002:a05:6000:36f:: with SMTP id
 f15mr20536424wrf.78.1604328543108; 
 Mon, 02 Nov 2020 06:49:03 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 4sm22293812wrp.58.2020.11.02.06.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 06:49:02 -0800 (PST)
Subject: Re: [PATCH 1/4] gitlab: publish the docs built during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-2-berrange@redhat.com>
 <e496d701-c943-6bac-073b-97a9bb7567f0@redhat.com>
 <20201102142134.GC138796@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aff807da-ed0d-636f-2e95-6a7f57549d43@redhat.com>
Date: Mon, 2 Nov 2020 15:49:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102142134.GC138796@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 3:21 PM, Daniel P. Berrangé wrote:
> On Mon, Nov 02, 2020 at 02:50:19PM +0100, Philippe Mathieu-Daudé wrote:
>> On 11/2/20 2:09 PM, Daniel P. Berrangé wrote:
>>> Most of the build jobs will create the sphinx documentation. If we
>>> expose this as an artifact of a "pages" job in a "public" directory, it
>>> will get published using GitLab Pages. This means a user can push a
>>> branch with docs changes to GitLab and view the results at
>>>
>>>   https://yourusername.gitlab.io/qemu/
>>
>> Do we want that only for forks or also for the main repo?
>>
>> For the main repo we need to keep older releases archived
>> but accessible.
> 
> I'm not suggesting we use this as the actual hosting we direct end
> users to.
> 
> Instead, whatever cronjob on www.qemu.org currently builds
> 
> https://www.qemu.org/docs/master/
> 
> can simply download the published artifact from CI for the master
> branch, and any release tags, and unpack them on www.qemu.org host.
> 
> IOW, we avoid need to run builds on www.qemu.org server.
> 
>>
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  .gitlab-ci.yml | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 3b15ae5c30..a41725d6f7 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -423,3 +423,17 @@ check-dco:
>>>        - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
>>>    variables:
>>>      GIT_DEPTH: 1000
>>> +
>>> +pages:
>>> +  image: $CI_REGISTRY_IMAGE/qemu/ubuntu2004:latest
>>> +  stage: test
>>> +  needs:
>>> +    - job: build-system-ubuntu
>>> +      artifacts: true
>>> +  script:
>>> +    - mkdir public
>>
>> I'd rather use public/$CI_COMMIT_BRANCH, that way we can
>> diff between 2 versions.
>>
>> What about adding a manual job to clean public/$CI_COMMIT_BRANCH?
>> (depending on push-pages success).
> 
> The publishing isn't additive - whatever is in the "public" dir
> is exactly what is visible on gitlab pages. You can't publish
> multiple different branches.

Oh OK.

Then:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Essentially this "pages" job published an artifact containing
> the entire content, and this is unpacked on the gitlab.io
> service.
> 
> This is why I suggest www.qemu.org cronjob pull down the
> artifact for "master", and also pull down the artifacts for
> any release git tags, and unpack them in suitable subdirs.
> 
>>
>>> +    - mv build/docs/index.html public/
>>> +    - for i in devel interop specs system tools user ; do mv build/docs/$i public/ ; done
>>> +  artifacts:
>>> +    paths:
>>> +      - public
> 
> Regards,
> Daniel
> 


