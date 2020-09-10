Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3E02065E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbNBbNtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3E02065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIZp-0008V4-KF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIYr-0007Ta-3l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:08:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIYp-0002Dy-79
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599728886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPFIhvjjZZMrZtxtj2VIAvzFKsc4panpciSld1za2uc=;
 b=PbNBbNtzypN38UrlgI3Al1yihPnpqqVg3617doEpaUR7vlQ5x6B3oZ2XRyIEhMH1Z5DE6e
 RIRB+mS4DyQ4z2nC+b1+1kjHlADfBRIq1FNchk6pi+o5KvenLwbvGynA7h/HrBoFbOs25u
 XQ2jQF7Y9oqyw6Oxhp+hjbEXnuYgmRY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-ESMqgR9ZONiSeqcVR1BJ1w-1; Thu, 10 Sep 2020 05:08:02 -0400
X-MC-Unique: ESMqgR9ZONiSeqcVR1BJ1w-1
Received: by mail-ed1-f72.google.com with SMTP id n25so2167852edr.13
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MPFIhvjjZZMrZtxtj2VIAvzFKsc4panpciSld1za2uc=;
 b=exkiwQCjgLMWGt9axwE1U1vo+BEb/qUsNGlce5EMsw48sPM+aSGNJldpaso32mb2+p
 p+KG/1bRmssSEKUhutp8HWUSuu9GiGjvFX9qhel3DQM85ckvrNhNbaETHmOKSNAe7yfV
 FVbSkMeu7XoDlo+qv/x5lky+6EeYGwwpCUI8aH/qf3wZV0ooV7P4QCOhkSW+++Psi1ps
 bDTdfJynwKc9qamWIb9RHqt1/24L4Qq9oN9AEtzvb8UsBd+rgRsO9u1FT5LRozlGw8dD
 YjQOM2t2PYIOefafzlChCZ3gO1AREu6UwYJSK84tc2Y4x0gSYkQsvWArtD61l4DLSzRo
 Wozg==
X-Gm-Message-State: AOAM531Mxl7fSfyi3Y/ZRg+8GzGtcEs8qVCc7rrdL5nfN945wuWFo/C1
 LdGin2frxsAVH6kCKa79Z9JUn+1OL7OKuwjvHYM7Bmu/iAaf+Ct2d/Q3+yJxnZUMekO53M+RqS4
 69+n501Q3RIKIdQk=
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr8264335edo.181.1599728881628; 
 Thu, 10 Sep 2020 02:08:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQY7ESTIgaZMy+kHSdTrJ7jizxujH24NZ0PRXz6BdORgw8v3h7QKACcLPwL7zPscN03XKOCg==
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr8264297edo.181.1599728881331; 
 Thu, 10 Sep 2020 02:08:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2744:1c91:fa55:fa01?
 ([2001:b07:6468:f312:2744:1c91:fa55:fa01])
 by smtp.gmail.com with ESMTPSA id lr14sm6284398ejb.0.2020.09.10.02.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 02:08:00 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/i386/kvm: Rename host_tsx_blacklisted() as
 host_tsx_broken()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-7-philmd@redhat.com>
 <118a4cae-f220-8224-52ac-26a1795ac071@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfc1c6be-8569-4150-6deb-136f930285ee@redhat.com>
Date: Thu, 10 Sep 2020 11:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <118a4cae-f220-8224-52ac-26a1795ac071@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 09:08, Thomas Huth wrote:
> On 10/09/2020 09.01, Philippe Mathieu-Daudé wrote:
>> In order to use inclusive terminology, rename host_tsx_blacklisted()
>> as host_tsx_broken().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  target/i386/kvm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 205b68bc0ce..3d640a8decf 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -302,7 +302,7 @@ static int get_para_features(KVMState *s)
>>      return features;
>>  }
>>  
>> -static bool host_tsx_blacklisted(void)
>> +static bool host_tsx_broken(void)
>>  {
>>      int family, model, stepping;\
>>      char vendor[CPUID_VENDOR_SZ + 1];
>> @@ -408,7 +408,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>>      } else if (function == 6 && reg == R_EAX) {
>>          ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
>>      } else if (function == 7 && index == 0 && reg == R_EBX) {
>> -        if (host_tsx_blacklisted()) {
>> +        if (host_tsx_broken()) {
>>              ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>>          }
>>      } else if (function == 7 && index == 0 && reg == R_EDX) {
>>
> 
> Looking at commit 40e80ee4113, the term "broken" seems to be a good
> replacement here.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


