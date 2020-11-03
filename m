Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8EC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922A72224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGwbVatP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922A72224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka38Q-0006Ex-I2
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka37s-0005nf-9e
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka37q-0008Ky-Hn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604436113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRvx1VL21X5OW94ng9zVuHm86LUweB1trVCgMh+lH80=;
 b=hGwbVatP8NAMGm4nKyyeeFbla4MWIzfDPJKUQE22I0LrTE4t1+hyH1Quv+h8xmsT68ESzX
 8CChwN3EMOhwuZFn20ary7o0goJva1xcndDe0HzezSRXLdwZWFQyLo6AWLKprPi8OOJ/6R
 P5eBNBrWsZLI8qCZGoGukMRO95eSNXc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-M18gRx8pPbaA3Wmo0yCUuQ-1; Tue, 03 Nov 2020 15:41:49 -0500
X-MC-Unique: M18gRx8pPbaA3Wmo0yCUuQ-1
Received: by mail-wm1-f71.google.com with SMTP id z7so244666wme.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MRvx1VL21X5OW94ng9zVuHm86LUweB1trVCgMh+lH80=;
 b=ZGatLbmgLs7sLLdb4UEBur498OxAfkVOgob5S/U3vvPgdGkcbH86Uzw+Fg4n211slM
 L4TFLrmAJat9PR6E9GPZyU+k2AicOWoaZ6/oj4eZ9c7ig8QZ6zI11LhS/0yWMPu/KbJo
 m0VVHGZrtZWVNhOC2Vs4bYYeDQKaSZMwB2busioCaYkziSqA0La39r8qDatyA/wD6ieD
 CIrRgTnFxp0FX+ZccLfaut1lhjuaPoY0aeD3gcJ0qCXJFlZM7CiKz+jdG2Cqiq3y+0Tf
 lFS545bBIOfxymO72odF10xIn/BL9kVo2HMwkqcN7z0MftvmraQHCzNO8TCrArwpxTqk
 qgoA==
X-Gm-Message-State: AOAM5309xgMFFYJERLaMHFVJ1jR0s+1ogeBKNEimWETSkGsatNOL8SAI
 o++WQpaNqg/uWbmXzZmwflhgMTxF3iHjJr6+b20oHZzrCvoa3Yb6iHeBWPr08UCiNUJOYcMDqMl
 XWzRSrkU5hqlZvo4=
X-Received: by 2002:adf:a551:: with SMTP id j17mr30031811wrb.217.1604436108182; 
 Tue, 03 Nov 2020 12:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAki+CAD4DgrJyCAAumSMJfsOkx5Q3DG9R9aHpsrXJbCjw/Ab825SXyZurMWyPdeBIc8LJLQ==
X-Received: by 2002:adf:a551:: with SMTP id j17mr30031777wrb.217.1604436107946; 
 Tue, 03 Nov 2020 12:41:47 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u23sm3846865wmc.22.2020.11.03.12.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:41:47 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <70b50ba2-f0e8-4cf7-b5ff-14178e03d595@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <01ec47fa-4e0d-1be9-e4e6-312b9d810d74@redhat.com>
Date: Tue, 3 Nov 2020 21:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <70b50ba2-f0e8-4cf7-b5ff-14178e03d595@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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

On 11/3/20 7:43 PM, Thomas Huth wrote:
> On 03/11/2020 17.46, Philippe Mathieu-Daudé wrote:
>> We test './configure --without-default-devices' since commit
>> 20885b5b169 (".travis.yml: test that no-default-device builds
>> do not regress") in Travis-CI.
>>
>> As we prefer to use GitLab-CI, add the equivalent job there.
>>
>> One minor difference: the GitLab Ubuntu docker image has the
>> Xen devel packages installed. As it is automatically selected,
>> we need to disable it with the --disable-xen option, else the
>> build fails:
>>
>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
>>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
>>   collect2: error: ld returned 1 exit status
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  .gitlab-ci.yml | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 3b15ae5c302..6ee098ec53c 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -262,6 +262,17 @@ build-user-plugins:
>>      MAKE_CHECK_ARGS: check-tcg
>>    timeout: 1h 30m
>>  
>> +build-system-ubuntu-without-default-devices:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: ubuntu2004
>> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-xen --disable-tools --disable-docs
>> +    MAKE_CHECK_ARGS: check-build
> 
> AFAIK "check-build" is pretty much a no-op since the convertion to meson ...
> could you maybe replace with a set of qtest targets that work, to make sure
> that we do not regress here? E.g.:
> 
> MAKE_CHECK_ARGS: check-qtest-avr check-qtestcris check-qtest-m68k
> check-qtest-microblaze check-qtest-mipsel check-qtest-moxie ...

qtests don't work with --without-default-devices, as we don't check
for (un-)available devices.

I'll try check-unit.

Thanks,

Phil.


