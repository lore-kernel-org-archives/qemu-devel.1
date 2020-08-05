Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC922173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evtTUYSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC922173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Gwd-0006fc-6E
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Gvn-0005ot-51
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:45:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Gvk-0006ju-5f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596624354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VmRAHV8TKXw0lFDNsRqmHS7aLv6XanjsoR81sIXjNUg=;
 b=evtTUYSrJ9Ojet2z/kM6S/g5CsLz4yW/vNL/gBFD0qw8jy87ZV3MykHqnyIbyiybSXj7ws
 Rv121mudsOx0xy2rmHWeotzCbnhlwVA83vIipjhwn8/2qJfnIzNGGw5m4Tlvg2WLGOAMzb
 CBgE2R6wS6lgoV3+OkkwL+z9Tr8SfJ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Sj_QtCwKMf6DNr9iDbkI6g-1; Wed, 05 Aug 2020 06:45:51 -0400
X-MC-Unique: Sj_QtCwKMf6DNr9iDbkI6g-1
Received: by mail-wm1-f69.google.com with SMTP id a207so2299667wme.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VmRAHV8TKXw0lFDNsRqmHS7aLv6XanjsoR81sIXjNUg=;
 b=FzhSKqfMctkDUiCDYcuntlfxM1BJbjhRexvHS2bJ1C5oNp/iudK/sFuq+HCToBBTc9
 L2TnSlzvPRK1cMz6h33+vWRTFPhmvxYp0tElxvQwjtndxL/rSmxGjCi/60dN21pAX6YH
 voE6h/+DfLenHVZ437Hi/P3ssoZpvmQk6PQEiVZBmsy9Es92J4oYpOMLe2TKI+JcY6zk
 GzlEJuhgHRs0ORoryQfW8YPuUnyAll7Yz81q2y7Q0wnV8X30n7ZGJ+9q3hP/GIg7G0/j
 FROPuVfrAGHrWB6RTWMkNWRnOqBVgYuTCslkKbobs45wBaWUczP5NKjDCh/v3f0mFA1B
 OSPw==
X-Gm-Message-State: AOAM532DOH/pok3ZlDym3FkWs2XTDgAYKwjnzXDKi/WQsxLup7kikaeC
 4cOMUBn2HtXW2PMWAQYKfECwSN4/gzxr7vlVGLX9ZJygRBiqY2oly2EnC686EqLqCJvjSPBQ1u+
 Ndr5uE64rBB50ers=
X-Received: by 2002:adf:fe12:: with SMTP id n18mr2224514wrr.295.1596624349728; 
 Wed, 05 Aug 2020 03:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQuxN3Ofa6GYCVwPtnoVNYHPMn5S2k8X2TcciSPTBNk8tkadxz8JKme1b4kyurP9WjiTb4eg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr2224496wrr.295.1596624349425; 
 Wed, 05 Aug 2020 03:45:49 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id j5sm2329928wmb.15.2020.08.05.03.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 03:45:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v3 1/2] exec: Restrict icount to softmmu
To: Claudio Fontana <cfontana@suse.de>
References: <20200805100126.25583-1-philmd@redhat.com>
 <20200805100126.25583-2-philmd@redhat.com>
 <f29544ab-d583-d6ed-48da-aa49c05ab966@suse.de>
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
Message-ID: <47f3773f-93b8-51a5-7927-9830d60c3ee1@redhat.com>
Date: Wed, 5 Aug 2020 12:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f29544ab-d583-d6ed-48da-aa49c05ab966@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 12:12 PM, Claudio Fontana wrote:
> Hi Philippe,
> 
> could you take a look if this series already addresses the issue?
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00067.html

I had tagged this series as "after-release" review and hadn't looked
at it yet :)

> 
> Everything icount related is already moved to softmmu and made TCG only.

Good. I was looking for a surgical change for 5.1, but I think it is too
late to have the WHPX CI running now (Thomas?). So we'll probably ignore
my surgical series and proceed with yours when 5.2 development window
opens.

> 
> I will post a new version of the series today with a couple changes;
> 
> the series could then be ready if HVF is already ready with its synchronize_state implementation? Otherwise we'd have to hold back the HVF patch.
> 
> Thanks!
> 
> Claudio
> 
> 
> On 8/5/20 12:01 PM, Philippe Mathieu-Daudé wrote:
>> 'icount' feature is only meaningful when using softmmu.
>> Move it out of the globally used exec.c, and define it as
>> 'false' in user-mode emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/sysemu/cpus.h | 4 ++++
>>  exec.c                | 4 ----
>>  softmmu/cpus.c        | 7 +++++++
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
>> index 3c1da6a018..d8442aa9f0 100644
>> --- a/include/sysemu/cpus.h
>> +++ b/include/sysemu/cpus.h
>> @@ -11,9 +11,13 @@ void pause_all_vcpus(void);
>>  void cpu_stop_current(void);
>>  void cpu_ticks_init(void);
>>  
>> +#if !defined(CONFIG_USER_ONLY)
>>  void configure_icount(QemuOpts *opts, Error **errp);
>>  extern int use_icount;
>>  extern int icount_align_option;
>> +#else
>> +#define use_icount false
>> +#endif
>>  
>>  /* drift information for info jit command */
>>  extern int64_t max_delay;
>> diff --git a/exec.c b/exec.c
>> index 6f381f98e2..a89ffa93c1 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -102,10 +102,6 @@ uintptr_t qemu_host_page_size;
>>  intptr_t qemu_host_page_mask;
>>  
>>  #if !defined(CONFIG_USER_ONLY)
>> -/* 0 = Do not count executed instructions.
>> -   1 = Precise instruction counting.
>> -   2 = Adaptive rate instruction counting.  */
>> -int use_icount;
>>  
>>  typedef struct PhysPageEntry PhysPageEntry;
>>  
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index a802e899ab..a4772034c0 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -81,6 +81,13 @@
>>  
>>  #endif /* CONFIG_LINUX */
>>  
>> +/*
>> + * 0 = Do not count executed instructions.
>> + * 1 = Precise instruction counting.
>> + * 2 = Adaptive rate instruction counting.
>> + */
>> +int use_icount;
>> +
>>  static QemuMutex qemu_global_mutex;
>>  
>>  int64_t max_delay;
>>
> 


