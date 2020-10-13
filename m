Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F809C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DF424801
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/vhdE79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DF424801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSL9C-0003Mn-9I
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSL8W-0002ck-HA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSL8S-00085F-Gh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602598719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVwEzqqUM/NsTY6fZgbELMwK927wLl8n+rgKE8jrbY4=;
 b=P/vhdE79hFULqnPwd5/kbVo11SvktcHbCru3XfLvO4EjCNvsGuI2xOdN+HSi9QfyDd8ufx
 BCxqo1QPbxXv4sSsRP4DXZmB6v204lxhCjIwLK5IsjO9KBKD9jiytp2LZwXIV9O7FolTDp
 4MM6wTSfg+OGknoUkNu/kOUKEqYb1gA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-eGRhHhbIPDWSR8PWBNtaLg-1; Tue, 13 Oct 2020 10:18:37 -0400
X-MC-Unique: eGRhHhbIPDWSR8PWBNtaLg-1
Received: by mail-wr1-f71.google.com with SMTP id k14so10226570wrd.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tVwEzqqUM/NsTY6fZgbELMwK927wLl8n+rgKE8jrbY4=;
 b=VT6YOEIQGQg9+J4SU5P+OZvc1G4D7UcVAyEFRcy3kB7MSZ2SkwKePyoipmHlr2PjIK
 d45rmFyIuctj9j9snROR2IbeN8rqLGpHSKlsLqQWvXeZHSg2+kJYAgtZqjZ3k3Z50FmD
 VQxLG34d0gK1avrAmeFMyLszAsrqiMiPCKjdziJSd3CysLG+XlMzlh2fRaVNgKbAjxfd
 bv5aVNJcEgIOPiQNVLsoONpJg0adYeayEw77fbJ9J3EjUOGtFOicBFEZlDf5Nq8yIYIg
 8W9i+MrdBxBCST4MQcOnkAlDSLQiXj7c9k/CsNIyVbRs1mFY0vFNMzNa+yw5YlKqb4sW
 cmjA==
X-Gm-Message-State: AOAM530jI83r2/oq3vAqTuQX7IBRlzsI1l0YAvYHwQ2GZOxL7TOMByor
 V8I2e9rXEnxPsu3a1xdfZT2ygD2JqCqVDHFwgybW4FJdFPedfq+wd5fADMpHIcCALd50sY6XSpU
 hKE/i5id6JtMBViQ=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr35594893wrs.406.1602598716476; 
 Tue, 13 Oct 2020 07:18:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Cmv/y4sknVyeJZulGDg0pX6qq5GmkeFF5Nx99Hr9+MSniq8rWJ2M8JHOQLyeOtO43Y6pCg==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr35594859wrs.406.1602598716165; 
 Tue, 13 Oct 2020 07:18:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j134sm85512wmj.7.2020.10.13.07.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 07:18:35 -0700 (PDT)
Subject: Re: [PULL 5/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
 <20200528101039.24600-6-thuth@redhat.com>
 <955bad5e-51ca-5b3f-c68f-a0374fc00a43@redhat.com>
 <20201012140131.GH39408@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9bfcca65-7e22-3e23-b4e6-787ee5a006dd@redhat.com>
Date: Tue, 13 Oct 2020 16:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012140131.GH39408@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 4:01 PM, Daniel P. Berrangé wrote:
> On Mon, Oct 12, 2020 at 03:44:00PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Thomas, Alex,
>>
>> +Daniel
>>
>> On 5/28/20 12:10 PM, Thomas Huth wrote:
>>> We have a dedicated folder for the gitlab-ci - so there is no need
>>> to clutter the top directory with these .yml files.
>>>
>>> Message-Id: <20200525131823.715-5-thuth@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       | 0
>>>    .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml | 0
>>>    .gitlab-ci.yml                                     | 4 ++--
>>>    MAINTAINERS                                        | 2 +-
>>>    4 files changed, 3 insertions(+), 3 deletions(-)
>>>    rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
>>>    rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)
>>>
>>> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
>>> similarity index 100%
>>> rename from .gitlab-ci-edk2.yml
>>> rename to .gitlab-ci.d/edk2.yml
>>> diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
>>> similarity index 100%
>>> rename from .gitlab-ci-opensbi.yml
>>> rename to .gitlab-ci.d/opensbi.yml
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index bc6aee6aba..5208d93ff8 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -1,6 +1,6 @@
>>>    include:
>>> -  - local: '/.gitlab-ci-edk2.yml'
>>> -  - local: '/.gitlab-ci-opensbi.yml'
>>> +  - local: '/.gitlab-ci.d/edk2.yml'
>>> +  - local: '/.gitlab-ci.d/opensbi.yml'
>>
>> It seems these jobs are now always run, the "rules:changes"
>> to restrict them is ignored.
>>
>> I searched a bit and found a plausible explanation here:
>> https://docs.gitlab.com/ee/ci/yaml/#onlychangesexceptchanges
>>
>> "Caution: In pipelines with sources other than the three above changes can’t
>> determine if a given file is new or old and always returns true. This
>> includes pipelines triggered by pushing new tags. Configuring jobs to use
>> only: changes with other only: refs keywords is possible, but not
>> recommended."
>>
>> I don't understand what they mean by "three", is a directory considered
>> a three? Then that would explain the change.
> 
> The edk2.yml file as a "when: always" clause attached to every rule,
> so surely this negates the point of filtering by making it always
> run ?

I understand it runs regardless a job in any previous stage failed.

 From https://docs.gitlab.com/ee/ci/yaml/#when

* always - execute job regardless of the status of jobs from prior stages.
* on_success - execute job only when all jobs from prior stages succeed 
(or are considered succeeding because they have allow_failure: true). 
This is the default.

I think I used that because at the time I sent that patch
some docker image builds were failing. But we don't really
need it, I'll remove.

Anyhow this used to work with "when: always", see:
https://gitlab.com/qemu-project/qemu/-/pipelines/168158357

> 
> Regards,
> Daniel
> 


