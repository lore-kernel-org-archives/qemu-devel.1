Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9620866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpUbO8x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zzY-0005FI-Lj
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zx9-0003SJ-Q0
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:50:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zx7-000410-OY
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596797420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyTt32KyUcfs0r4BStZnkjET5YSm9dMgedu2C11FpIc=;
 b=WpUbO8x5blcls4c/CZ4t9+Kgp389CIoSvKJeeTLIhM8L7pf379GBZx4R9AJlUltHV2bb37
 seKPrP8q/zPWvi8J4IO3KjdgEWDoFbX2Hf4yjU1Ckl0GAnriWBvLcjTQzQxYeMq0K/4wkj
 RZI3RAxu907hm+vcoi99ChHTZQY7tS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-XNZEl3oOPsi_m2ExhgbWaw-1; Fri, 07 Aug 2020 06:50:18 -0400
X-MC-Unique: XNZEl3oOPsi_m2ExhgbWaw-1
Received: by mail-wr1-f71.google.com with SMTP id d6so586638wrv.23
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SyTt32KyUcfs0r4BStZnkjET5YSm9dMgedu2C11FpIc=;
 b=ftEULnz652PsSUUom7iFSUqXIbFRWnKNDvHUodBlLKr0xeKJX8wxMASpOB16rOQecD
 T++9413Uoh34FhV7FVfD5SfcFwqeAxiE+GOucSvabmVXsfxBTXitDiFeavoTGXsWX7/R
 PWxzjDv0sCx7bH/4tra6Zem0VDA++PCy8NWeqeN8QHGWdtIz8cwi16FdV3Vvf+ssvCvD
 tbBB2I7pJc0rc1n+Iv+waQEr5FHeqqBjKuGd12x3BehOf+AFPc1KxWwKdfxk83ZIV/q4
 sQTISUL79sSWPb+0JEf1irKu10a2mUh/jFa6i4ziqusj6lF/abPfiUdjOi5IvMGq0ofd
 k0HA==
X-Gm-Message-State: AOAM530xnB10vDxaTH3mHmx0guZ/ckKQEDQKtrSIZFxjUUITN8+KeWE1
 4JjqpKWOHuQy62tsMTMsVyZH8PZ9zyUH/O8bgxSh1kEyduFPFsnMkyDrCgdnboMAEumrMfhIY95
 4fFvI7XI2GpLySZw=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr11765640wrv.104.1596797417487; 
 Fri, 07 Aug 2020 03:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo6dclrNl2DxEDYu7jJt8Yb4IdPkqZr5QwlzxIyt3dZNMvmaHBBHlHfjcqlV4Cubt+ywoM5A==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr11765616wrv.104.1596797417245; 
 Fri, 07 Aug 2020 03:50:17 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id k4sm10741137wrd.72.2020.08.07.03.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:50:16 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
 <f4233923-f82e-6edf-8a56-2e4f62038d0e@redhat.com>
 <73398402-2038-ccf7-203b-e6e911d056a0@redhat.com>
 <20200807122541.31681bec.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <264044bc-6bbd-07b7-fe6e-8d6312559aaa@redhat.com>
Date: Fri, 7 Aug 2020 12:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807122541.31681bec.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 12:25, Cornelia Huck wrote:
> On Fri, 7 Aug 2020 12:08:17 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 07/08/20 12:02, Thomas Huth wrote:
>>> Thanks! With the fix, it now gets a little bit further, but then stops with:
>>>
>>>   ../meson.build:1258:3: ERROR: Key CONFIG_QEMU_PRIVATE_XTS is not in dict
>>>  https://gitlab.com/huth/qemu/-/jobs/675699330#L130  
>>
>> diff --git a/meson.build b/meson.build
>> index d14d4bb..5bcfa09 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -944,12 +944,12 @@ summary_info += {'GNUTLS support':    config_host.has_key('CONFIG_GNUTLS')}
>>  summary_info += {'libgcrypt':         config_host.has_key('CONFIG_GCRYPT')}
>>  if config_host.has_key('CONFIG_GCRYPT')
>>     summary_info += {'  hmac':            config_host.has_key('CONFIG_GCRYPT_HMAC')}
>> -   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
>> +   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
>>  endif
>>  # TODO: add back version
>>  summary_info += {'nettle':            config_host.has_key('CONFIG_NETTLE')}
>>  if config_host.has_key('CONFIG_NETTLE')
>> -   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
>> +   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
>>  endif
>>  summary_info += {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
>>  summary_info += {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}
> 
> That one also seems to have fixed my x86 build woes.

Great.  That was an unusual case of things breaking with *newer* distros
(that do have XTS in the system library).  Please just pull again as
that has many fixes for other things that Thomas reported.

FWIW, impressions on reviewing these mini patches are very welcome.
After all reviewing small patches is more common than reviewing the
whole 140 patch thing, so it's important that people can quickly get an
idea of what's going on in a small patch.

Paolo


