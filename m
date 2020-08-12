Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B1206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO32Cvb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B1206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nQ4-00009v-PM
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5nLk-0002bO-Hw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:47:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5nLi-0007HC-HY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597225628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fisb5KYwmkj8zR54NkRmW04JIJUf3d3+AbYmwzs6PuE=;
 b=EO32Cvb/E1xZwlxDlT0XFE8Jny6eDVaOL+4p5vlAAB7N4c56hFUCeE4IfuPDX6Y/NTwevp
 2fB5MU1VyxPHNUMeq3I61V5QYGUrEKNJJr+VW83TfVeFHdQxZSHx3Tw2Jjb5VxnlhKAKtt
 1iAYZiGO/4NwmptlCXlwFv4Birttzx4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Fpx3quN7MnCP_ILQTGABSg-1; Wed, 12 Aug 2020 05:47:05 -0400
X-MC-Unique: Fpx3quN7MnCP_ILQTGABSg-1
Received: by mail-wm1-f69.google.com with SMTP id z10so682065wmi.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 02:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fisb5KYwmkj8zR54NkRmW04JIJUf3d3+AbYmwzs6PuE=;
 b=ThuutfbhCFb1W+sr3d/BdXf2xpDxOmJoty2NosVV1XtT6dm5fI5A17jnprBQY5xTUo
 2vfA76gdfeHE8EHx9x7baBru7DVvagdPrcnPel3ZNWJJTfSbDERui+eESO3L6VqHsE+R
 y0dq6oiU0/WZVvTysPCwoE1H+Cj2MDdEzLXwRPI7hibIDJufoWMgEaafDWAED7vF+89f
 898BnOTZmLNIzA+YVU3xlpjW/gb1/9OCKVswmRSNX4bL4G6ELfhVdYZo4GDbIdHyiFSg
 tAlWLvkf4iPA8af7XUdza70MWR/zMhA4ZFxpRUU/yuV08sCuPsA+5iMyWWSIj+3kyEoa
 Ff6A==
X-Gm-Message-State: AOAM533+PcnarQ6iMEG6vILChC6B2i5OO0VGKtZAeL9+9yujs/S1qmVq
 aSjiIvDYEDokma4kdHX+7KEUORqVJTj49exoS7EXji9A3wT/N1UQhRU92u9HV7uZGSOIVc21S9c
 a/wp0cFZZs2U3TDA=
X-Received: by 2002:adf:c552:: with SMTP id s18mr31922592wrf.209.1597225624111; 
 Wed, 12 Aug 2020 02:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7ArIYiBmc3CEykdJZ8rASdxc0Hm8N3XJV6UHdnYu33jg8lXOD9qH3rQjZUkOhU2FgOWr5hQ==
X-Received: by 2002:adf:c552:: with SMTP id s18mr31922568wrf.209.1597225623836; 
 Wed, 12 Aug 2020 02:47:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:744e:cb44:4103:26d3?
 ([2001:b07:6468:f312:744e:cb44:4103:26d3])
 by smtp.gmail.com with ESMTPSA id t11sm2986720wrs.66.2020.08.12.02.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 02:47:03 -0700 (PDT)
Subject: Re: [PATCH 08/11] stubs/notify-event: Mark qemu_notify_event() stub
 as "weak"
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-9-thuth@redhat.com>
 <1cd4b50f-7195-ac05-cd37-c7681747fbf3@linaro.org>
 <cecf29fe-f079-ba44-2096-27a049a9647d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce06de15-c72a-a334-6b5c-41799b236f54@redhat.com>
Date: Wed, 12 Aug 2020 11:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cecf29fe-f079-ba44-2096-27a049a9647d@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/20 20:20, Thomas Huth wrote:
> On 04/08/2020 19.50, Richard Henderson wrote:
>> On 8/4/20 10:00 AM, Thomas Huth wrote:
>>> Otherwise there is a linker error with MinGW while compiling the tests:
>>>
>>>   LINK    tests/test-timed-average.exe
>>>  libqemuutil.a(main-loop.o): In function `qemu_notify_event':
>>>  /builds/huth/qemu/util/main-loop.c:139: multiple definition of
>>>   `qemu_notify_event'
>>>  tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5:
>>>   first defined here
>>>  collect2: error: ld returned 1 exit status
>>>  /builds/huth/qemu/rules.mak:124: recipe for target
>>>   'tests/test-timed-average.exe' failed
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  stubs/notify-event.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> That doesn't make sense.  Since the symbol is satisfied from main-loop.c, it
>> should not be pulled in from libqemuutil.a.
>>
>> What's really happening here?
> 
> Honestly, I don't have a clue. But since commit ebedb37c8d2aa4775, both
> the code from util/ and from stubs/ are put into the same library,
> libqemuutil.a, which is causing the trouble here, I guess.
> Maybe the linker pulled in the code from the stub first, then some other
> part used another function from  util/main-loop.c which caused the
> linker to pull in main-loop.o, too, so that it finally found that there
> is a clash? ... but that's just a plain guess, of course. Paolo (as
> author of commit ebedb37c8d2), do you have an idea what might be going
> on here?

I think your analysis is right but is the stub needed at all, since te
linker can include util/main-loop.c instead?

Paolo


