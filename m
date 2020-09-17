Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AF1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527B22072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDYIlizJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527B22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoCG-0003Si-Dw
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIoBZ-0002wU-52
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIoBW-00017Z-4v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600327104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0mg7l8fSD8OC+hLvKntNqWk2rLwJkbIBms8Q2gkZY4=;
 b=WDYIlizJ3o+aTMY2X9GIq9VAMBz8X+pLY/TR7YGBx+b8TStKH1lWx3w34Pz87Uek0AJ/NM
 Dk/gcW1R/s15k+4qdNL1u80CxMDKuCrtcJ6PTv2up3yYeUT1QoBdYK85+gJmQ8lmUgdXuH
 YZDDr5leReeTpw663OGCY8fZ0Ar/brk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-LXN-QZ8uMkG4dhhswEVR2g-1; Thu, 17 Sep 2020 03:18:21 -0400
X-MC-Unique: LXN-QZ8uMkG4dhhswEVR2g-1
Received: by mail-wm1-f71.google.com with SMTP id u5so411374wme.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J0mg7l8fSD8OC+hLvKntNqWk2rLwJkbIBms8Q2gkZY4=;
 b=Q5h9dhdW/HNPm1snxKUAASpkBXL0rJOlhlKHW9CrA/Tss8jnTnu3U3S1SCzBnXaslH
 a797K5ZLY0q2u7Kizy9Up3uvfn/PNGXd5wMz9HMG4sm/77dWzmwZz66/JDxS3Mi7Nkml
 Pwa1cPEEG6YoJPzHx1p4qYsthCsIxrgnQIFOw7niAaWSODSq019vX/MjSdSDSh8NlDgm
 R8/VPM2dxPggqLXboAMdBeqxljrFMwp3NvY3IZ3BQsm5qjWjSiM0rwsm1CQqAm7xDTy7
 zlEh/5Jj1NajsTH0Ps5tTWGFmFi9CT90pHtMgbPu286WB05ZxMqzI/mUDjAtPtjo303c
 aD7g==
X-Gm-Message-State: AOAM533iNc5koAiXjIQi3YSpkFAYGzx3durP6azDHHl34jBUwOQdjFyQ
 p6v0gzk9lSlbSkuZL3wZsIjqSiiqTtzlFKkurLS9X0vbITJsLlRoRAyYr14r6mp+4XKt0E2NcPd
 kSCcBThuR5CJv8Zw=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr32256888wru.180.1600327100025; 
 Thu, 17 Sep 2020 00:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+PAeD59V/Ntd6yzkU+CSOJAv8ujM5iD5oyi3X7OZDLhDK9h96un3Fjbqcwrw77dQlGzIJhg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr32256857wru.180.1600327099654; 
 Thu, 17 Sep 2020 00:18:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d003:b94f:6314:4839?
 ([2001:b07:6468:f312:d003:b94f:6314:4839])
 by smtp.gmail.com with ESMTPSA id y5sm9654084wmg.21.2020.09.17.00.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:18:19 -0700 (PDT)
Subject: Re: [PATCH] migration: Silence compiler warning in
 global_state_store_running()
To: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20200916171913.148681-1-thuth@redhat.com>
 <93744d31-0f33-5bb1-fb76-42ca3a5fa401@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e44e5105-baba-3d0d-6477-37f24531d39f@redhat.com>
Date: Thu, 17 Sep 2020 09:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <93744d31-0f33-5bb1-fb76-42ca3a5fa401@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 08:30, Thomas Huth wrote:
> On 16/09/2020 19.19, Thomas Huth wrote:
>> GCC 9.3.0 on Ubuntu complains:
>>
>> In file included from /usr/include/string.h:495,
>>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
>>                  from ../migration/global_state.c:13:
>> In function ‘strncpy’,
>>     inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
>> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> ... but we apparently really want to do the strncpy here. Silence the
>> warning with QEMU_NONSTRING.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  migration/global_state.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 25311479a4..f1355d7d97 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -43,9 +43,9 @@ int global_state_store(void)
>>  void global_state_store_running(void)
>>  {
>>      const char *state = RunState_str(RUN_STATE_RUNNING);
>> +    QEMU_NONSTRING char *dest = (char *)global_state.runstate;
>>      assert(strlen(state) < sizeof(global_state.runstate));
>> -    strncpy((char *)global_state.runstate,
>> -           state, sizeof(global_state.runstate));
>> +    strncpy(dest, state, sizeof(global_state.runstate));
>>  }
> 
> Darn, I was sending too fast here, sorry, but seems like this does *not*
> fix the issue with GCC 9.3:
> 
>  https://travis-ci.com/github/huth/qemu/jobs/385871010#L2930
> 
> ... so maybe we should simply switch to strpadcpy() instead?

Yes, and probably do so everywhere that strncpy is used.

Paolo




