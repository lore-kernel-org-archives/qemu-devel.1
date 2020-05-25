Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 17:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA03A2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXFw0rYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA03A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdGz8-0003ac-TX
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdGyD-0002ux-9W
 for qemu-devel@nongnu.org; Mon, 25 May 2020 13:33:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdGyA-0001f4-Gb
 for qemu-devel@nongnu.org; Mon, 25 May 2020 13:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590427975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DbutgZuhylYKJS1PshBJbaT9rpO59vaHW+nsqOClHvk=;
 b=AXFw0rYak/Pnv6m5DdLG3pf+M59IafPovZe+466JnjTMoBD+O8SzkRMahCJmyHHgV/75o+
 owsgQfSOMYXhHEmVYDsn22O8kwnwnR6bwrcT1oyscPaBr0yj778Vvu9hZGDzxgZrsZVtTC
 Jfm+JZyvdwfsADtuD6zLKqkO8UcjBtY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-SzeMbCh4OUGdAGiwgpvj4Q-1; Mon, 25 May 2020 13:32:52 -0400
X-MC-Unique: SzeMbCh4OUGdAGiwgpvj4Q-1
Received: by mail-wr1-f69.google.com with SMTP id q24so3089199wra.14
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DbutgZuhylYKJS1PshBJbaT9rpO59vaHW+nsqOClHvk=;
 b=AdBvLfcGMAqRwbIp8TvZ67SKrofc/q9Dp9fP9gn9LUZ4iNOdlq9BB5wA5IlHmiiSw8
 tlDMDV/+2vtvhtXcRM/W2Vgamamw3RQun7bxRngU0vLJhF2VmayBPWP3u/HgwlSGNSqY
 +eBPczZzBzFpZ6U5rj6MlxMl24AsG+9Zz6AtP5huFYBpaYz95B1yMwJ6x6YL0JIvvuM7
 P5upv4710knmXt9eTN8u+oIiouQ0iNG8K5ar3M3v44I6FdeIVFU7P2lygva9rxF9/2b3
 8bOwzxuxh3Nc8vWUV4lVpiA19xa6K3FSZpbGXqQbGwQehAze+MvBQnj9ezWpNkv8UYuG
 4NuQ==
X-Gm-Message-State: AOAM530k0ikXJTs7rPxrGx0wM5PBxGZjXxHb51m5CtOXzisgDY7CpnoK
 kInLYlKoPfkL/bV13NgQo6byohnWPEbCBjDEyjyUR7ermlqGeFm5KsvNcO5uFBMcbLD26SzenFK
 OIMedOVxgmHikpx4=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr16776229wrq.374.1590427971626; 
 Mon, 25 May 2020 10:32:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjtJY+GEbyoZ7E9vapbzqgYdwsAcEIbKuVtb5sjxuQVcy4Cwa9ireWALLEuFJyIhTP4zBwAg==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr16776207wrq.374.1590427971404; 
 Mon, 25 May 2020 10:32:51 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g1sm5754842wrb.46.2020.05.25.10.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 10:32:50 -0700 (PDT)
Subject: Re: [RFC v3 1/4] softmmu: move softmmu only files from root
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-2-cfontana@suse.de>
 <871bcac5-ee79-d9cd-817a-98666849e8a6@redhat.com>
 <f886b539-6dcf-80b3-6cbc-8b6e7ed26109@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <cce25784-949f-38eb-e380-fdbe5d7d8c53@redhat.com>
Date: Mon, 25 May 2020 19:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f886b539-6dcf-80b3-6cbc-8b6e7ed26109@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:37 PM, Claudio Fontana wrote:
> On 5/25/20 5:12 PM, Philippe Mathieu-Daudé wrote:
>> On 5/25/20 4:54 PM, Claudio Fontana wrote:
>>> move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.
>>>
>>> They are all specific to CONFIG_SOFTMMU.
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>>  MAINTAINERS                                  | 12 ++++++------
>>>  Makefile.target                              |  7 ++-----
>>>  softmmu/Makefile.objs                        | 10 ++++++++++
>>>  arch_init.c => softmmu/arch_init.c           |  0
>>
>> OK.
>>
>>>  balloon.c => softmmu/balloon.c               |  0
>>
>> OK
>>
>>>  cpus.c => softmmu/cpus.c                     |  0
>>
>> I'm still not 100% convinced.
> 
> Hi Philippe, do you see a reason to keep cpus.c in the top_srcdir?
> 
> The way I see it, it belongs in softmmu/,
> 
> we have a separate cpu-common.c that is target-indep and in common between user and softmmu,
> while cpus.c is softmmu-only right?

Sorry, I meant to say I need to look more in details at this file uses
and will do a second review pass on your series.

> 
> 
>>
>>>  ioport.c => softmmu/ioport.c                 |  0
>>
>> OK
>>
>>>  memory.c => softmmu/memory.c                 |  0
>>
>> OK
>>
>>>  memory_mapping.c => softmmu/memory_mapping.c |  0
>>
>> I am not sure (yet).
> 
> headers are already in sysemu (sysemu/memory_mapping.h)
> 
>>
>>>  qtest.c => softmmu/qtest.c                   |  0
>>
>> This one seems to belong to accel/
> 
> We already have accel/qtest.c , that is the qtest AccelClass.
> 
> Here we are talking about qtest.c from the top_srcdir, which it the
> qtest server and is built with softmmu code, with header in sysemu/qtest.h

I haven't looked at it in detail but will.

> 
> Thomas?
> 
>>>  10 files changed, 18 insertions(+), 11 deletions(-)
>>>  rename arch_init.c => softmmu/arch_init.c (100%)
>>>  rename balloon.c => softmmu/balloon.c (100%)
>>>  rename cpus.c => softmmu/cpus.c (100%)
>>>  rename ioport.c => softmmu/ioport.c (100%)
>>>  rename memory.c => softmmu/memory.c (100%)
>>>  rename memory_mapping.c => softmmu/memory_mapping.c (100%)
>>>  rename qtest.c => softmmu/qtest.c (100%)
>>
>> What about the corresponding headers?
> 
> headers already in sysemu/ :
> 
> sysemu/arch_init.h
> sysemu/balloon.h
> sysemu/cpus.h
> sysemu/qtest.h - (again, for the qtest server)
> sysemu/memory_mapping.h
> 
> headers currently in exec/ :
> 
> exec/memory.h
> exec/ioport.h

Yes, if you want a clean separation, I'd rather restrict
include/softmmu/ to softmmu builds. user-mode and tools builds shouldn't
access these headers.

> 
> Paolo?
> 
>>
>> [...]
>>
> 


