Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91059C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B3720897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiEU3RWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B3720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4yp-0007bP-Km
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc4yE-0007BN-ER
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc4yA-0005Kq-8G
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604919856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTKQGM5wKTk0mpwTVs+taXSRAicuiouWH1f/79qyJkI=;
 b=GiEU3RWbHVPX65OAzv+0MPogCPP3LsP0pB3bRoCrTC/7hyJhf9+1BTV5b2um07wCceaL8g
 CFdfZWX3HAF57d9Y8lAUt0Ty6W5uhq6BecRzqCX/Ove+tkLiPuVzcRTeRqdWNwhPy+f0Gi
 Xv9HOjGQMnANct7PBTQea8A6MY/TsaA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-cJOJj4i_MXCM2dbo0SfqkQ-1; Mon, 09 Nov 2020 06:04:14 -0500
X-MC-Unique: cJOJj4i_MXCM2dbo0SfqkQ-1
Received: by mail-wr1-f72.google.com with SMTP id k1so2851810wrg.12
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 03:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TTKQGM5wKTk0mpwTVs+taXSRAicuiouWH1f/79qyJkI=;
 b=eU2poKgC/04GA2DtXIL2yO1B7VH/FP66XznI2ng2tA07skAYIfIjWplTjOQCb8XMwN
 PwV8qauXsvkoE5Gv0n4VgkNjlfMz9yfRpmvgpr3HhBD9m9ugX1sc0RtPsN0n5e3X1mCB
 Z2Ir1AUd8KKZcTomNwd/HaKT/rtQUHdFC8/9xPQwAgQpazsuRlgdFElQmLIKJ8d+mivJ
 GMVzev5rsoKkSIJNiql7Fl1S0TadeLCRGLJsk7U5AI63oILFS5sQgrZO6d+UXtJgv1x5
 SszoCcXEqlPCGNoQyVmM9Q+E3I6P8TvJUBaUUDem5qw+FqGoE4cwsg8dNlDWzJDTNH+D
 TIkQ==
X-Gm-Message-State: AOAM531cXe8vbdxvd/gYq56sG12GJRYVQPb2R3CBzrHrgtFTGJpXv9WD
 Ad+3VLTl/ihXTOgLEtANjCF/TjnBAfsFhPGVGVdSXGCX/L0F7vUtKbZqbNK72BYgK7LgDMZvWd2
 yhl14zaPK5NcPAXI=
X-Received: by 2002:a5d:690c:: with SMTP id t12mr17254092wru.405.1604919852339; 
 Mon, 09 Nov 2020 03:04:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBDrsbiaEO9myMh800ygMQyeIaKjuAiGdxzwvCDeh5b3LS7Md4rmqskG4TSNJp+3EyoQuB5Q==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr17254060wru.405.1604919852197; 
 Mon, 09 Nov 2020 03:04:12 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s8sm8761325wrn.33.2020.11.09.03.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 03:04:11 -0800 (PST)
Subject: Re: [PATCH-for-6.0 v4 07/17] gitlab-ci: Move job testing
 --without-default-devices across to gitlab
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-8-philmd@redhat.com>
 <1498febb-afdf-0510-7b7b-57bf1c43cfe0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <268d47cb-e814-da62-daf6-44fb0a94d42f@redhat.com>
Date: Mon, 9 Nov 2020 12:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1498febb-afdf-0510-7b7b-57bf1c43cfe0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 11:20 AM, Thomas Huth wrote:
> On 08/11/2020 21.45, Philippe Mathieu-Daudé wrote:
>> Similarly to commit 8cdb2cef3f1, move the job testing the
>> '--without-default-devices' configure option to GitLab.
>>
>> Since building all softmmu targets takes too long, split
>> the job in 2.
>>
>> As smoke test, run the qtests on the AVR and m68k targets.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>
>> v3 had:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  .travis.yml    |  8 --------
>>  2 files changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index b98800462ed..3fc3d0568c6 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -315,6 +315,52 @@ build-user-plugins:
>>      MAKE_CHECK_ARGS: check-tcg
>>    timeout: 1h 30m
>>  
>> +build-system-ubuntu-without-default-devices 1/2:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: ubuntu2004
>> +    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
>> +    TARGETS:
>> +      aarch64-softmmu
>> +      alpha-softmmu
>> +      arm-softmmu
>> +      avr-softmmu
>> +      cris-softmmu
>> +      hppa-softmmu
>> +      i386-softmmu
>> +      m68k-softmmu
>> +      microblazeel-softmmu
>> +      microblaze-softmmu
>> +      mips64el-softmmu
>> +      mips64-softmmu
>> +      mipsel-softmmu
>> +      mips-softmmu
>> +      moxie-softmmu
>> +    MAKE_CHECK_ARGS: check-qtest-avr check-qtest-m68k
>> +
>> +build-system-ubuntu-without-default-devices 2/2:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: ubuntu2004
>> +    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
>> +    TARGETS:
>> +      nios2-softmmu
>> +      or1k-softmmu
>> +      ppc64-softmmu
>> +      ppc-softmmu
>> +      riscv32-softmmu
>> +      riscv64-softmmu
>> +      rx-softmmu
>> +      s390x-softmmu
>> +      sh4eb-softmmu
>> +      sh4-softmmu
>> +      sparc64-softmmu
>> +      sparc-softmmu
>> +      tricore-softmmu
>> +      x86_64-softmmu
>> +      xtensaeb-softmmu
>> +      xtensa-softmmu
> 
> Could you please add a MAKE_CHECK_ARGS here, too? check-qtest-rx or
> check-qtest-sh4 sound like good candidates...

OK.

> And could you please also use Fedora and/or CentOS for these tests now?
> We're using --without-default-devices in downstream RHEL, so testing with
> that option in Fedora and CentOS would be helpful for us.

I wanted to do that, but expected someone to object as "we are not
testing the same than before". I'll change one (maybe CentOS 8, which
is less tested than Fedora).

> 
>  Thanks,
>   Thomas
> 


