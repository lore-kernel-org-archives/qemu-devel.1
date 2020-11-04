Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626C42236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iduirS90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626C42236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHG7-0001WL-1Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHEy-0000Oj-3a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHEw-00045d-Fn
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604490369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ6UvOteCY0ZWeh7Mw4XRrMKRHPNR8jqMo8V65SijDk=;
 b=iduirS904Oim262opps9yD9fO3mhlwXilwPYFmV93a8s/Bc8E5ckvHUaxw9sHkgrH5FfyP
 sHBY3VoPsbyt4TVR9V5ELEPWCqWlAq7WBjrQp5uQYI6Jm5cTuTxKyLArVzATpD3Ov4wIbR
 GUGcbOmZt6ezTjfYq24OzZotQRjA4N0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-PoAEyW65NGWnudvPYOl1kA-1; Wed, 04 Nov 2020 06:46:08 -0500
X-MC-Unique: PoAEyW65NGWnudvPYOl1kA-1
Received: by mail-wr1-f70.google.com with SMTP id e11so1659996wrw.14
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LJ6UvOteCY0ZWeh7Mw4XRrMKRHPNR8jqMo8V65SijDk=;
 b=piTWT7/BSDRpJXjPfhbKYyXb377rn3xGe40f8/4I05xRHYAbY72NzfdN/tw872XKCW
 oj6AF8l8JUv7PbHVeFljhI9IhSJv+vKZGJwd8MPvAysN87jPN9vhJimB8TKLueMBdsfK
 RwzAmhBvGqsyBgslgklLZ+zAzYp2OX99tyoUmY6NwZ3JYtXej3rTEWGw8LzUN8aaU4AE
 LRvjW51Bk1AVhjf3gLJw/mMNZGNXop+hp+tzgnz3lSuSI1oM+lQ9/yng9IQT2gtB750r
 7iKJhXSo9fF7kpz9m8Fl3NqetH5rc+2rBwqFTwzqSwcp4J8rZisP9Yv5Y5gr0dz8Y8lN
 N4YQ==
X-Gm-Message-State: AOAM530tuxwV2UJvdpxI1Scp2/AKubURpMxD+1QSv/b8HdBuKgon58us
 pscDml82qez+gEde+R1Kc7xqOi31Rae9PBdQElJHd5FY8oJaKe2jbRq/bxh0FwU+9qRsjMRlcMx
 6rgnt9GCrKjnwV+g=
X-Received: by 2002:a5d:4987:: with SMTP id r7mr30001146wrq.327.1604490367030; 
 Wed, 04 Nov 2020 03:46:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSps66OD361E9PzDgoJ2TVU9ZazXO5OtzOKoxWePNctVAV1wXAmHmPpi/JyqpuGznXCQmqKw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr30001115wrq.327.1604490366846; 
 Wed, 04 Nov 2020 03:46:06 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r18sm2112952wrj.50.2020.11.04.03.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:46:06 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2 3/4] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201104084327.3010593-1-philmd@redhat.com>
 <20201104084327.3010593-4-philmd@redhat.com>
 <dddf54a0-a940-c842-844f-7dbf71af3203@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aadc739b-eaba-5ab8-048e-7c3a8cb5edc3@redhat.com>
Date: Wed, 4 Nov 2020 12:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <dddf54a0-a940-c842-844f-7dbf71af3203@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 10:17 AM, Thomas Huth wrote:
> On 04/11/2020 09.43, Philippe Mathieu-Daudé wrote:
>> We test './configure --without-default-devices' since commit
>> 20885b5b169 (".travis.yml: test that no-default-device builds
>> do not regress") in Travis-CI.
>>
>> Since having a single CI to look at is easier, and GitLab-CI
>> is the preferred one, add the equivalent job there.
>>
>> As smoke test, run the qtests on the AVR target. Since the
>> boards are simple SoC, there is not issue with unavailable
>> default devices there.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  .gitlab-ci.yml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 3b15ae5c302..321cca2c216 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -262,6 +262,13 @@ build-user-plugins:
>>      MAKE_CHECK_ARGS: check-tcg
>>    timeout: 1h 30m
>>  
>> +build-system-ubuntu-without-default-devices:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: ubuntu2004
>> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-tools --disable-docs
>> +    MAKE_CHECK_ARGS: check-qtest-avr
> 
> As mentioned in my other mail, we can also use -m68k if you prefer that
> instead of -avr.

I guess I send this series before reading it.
Let's use both, to support each others =)

> 
>>  build-clang:
>>    <<: *native_build_job_definition
>>    variables:
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


