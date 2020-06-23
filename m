Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E1A2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsJfEz6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E1A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndbS-0007S6-B5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jndar-00073A-UP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:43:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jndap-0005Rh-9w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592898221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0tMI25T49bVHmHeltgixu6lqvAtENH2wQaZXQarA7Y=;
 b=GsJfEz6/pnR6jdukbdTPi3Hzsq2Qi+TlL9hgFa3AZPEREead2Iyz4jvaWvHWhJc9k8uPth
 Rcz00AWhHBbwJ2noKmHXQAoi3pAzNPXqDgT/1ooO2Sh4kMKNeprCDv23Q3OHJQuqoRB1lx
 R6a4PnmwGHFE6ksJ+LprS2fjG4Gez/w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-sVamamC4PRamCdL6PEh-Mw-1; Tue, 23 Jun 2020 03:43:40 -0400
X-MC-Unique: sVamamC4PRamCdL6PEh-Mw-1
Received: by mail-wr1-f70.google.com with SMTP id o25so12567760wro.16
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 00:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K0tMI25T49bVHmHeltgixu6lqvAtENH2wQaZXQarA7Y=;
 b=coY8pgu58vqmMMVNRYQQErZJTAbzmiDWesgPpXhurQVWGwfXSxw6lI0ijNd3fCage0
 xJPDwkU1+iSalxBm7orETvxDfXsvWAxR97wnfiJY5jeZyfol7rvXojbGzc4xBUduK7mG
 5NBAtyIHnZ9tWf/YTSKCoGmI02xWsCGfD5ykMPq7YhyEMlUFGnOT92+R0d1E9QlfxTQS
 3fBiHIeuuDMHPsZTOGfV1WU9meW5pRuqvD+LY0BNvR+cW7Y3r++XAG+96l/PEz2NN+Vf
 F2cJsdJN1ngx9T8RjcH0xuAjlnwyAYdJJtG6gXRPKXz3M0Bd+d1qi169J1Sqx29Ly0+X
 ztaw==
X-Gm-Message-State: AOAM533H4+jXgyY1RsXWEHM6Wbc4U6nct76D+l39/nirjr3fus29hm2/
 YLs/bxw9ME59v+PDayr5E6mpXjTk83aR5pU8jYIAG3sobZnuNKwKxxZI7NyjoLSyyuTeAegQJBv
 P12o2rjvokH8a+6A=
X-Received: by 2002:a5d:664e:: with SMTP id f14mr23692015wrw.6.1592898219127; 
 Tue, 23 Jun 2020 00:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9NNWLuPRQxMi9n2Bg1zweVz/6kYeb5EMO14rbn7KDyHy+ePQTx0d3r0E9z8q10ay4B9fJMw==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr23691990wrw.6.1592898218832; 
 Tue, 23 Jun 2020 00:43:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id m10sm3108972wru.4.2020.06.23.00.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 00:43:38 -0700 (PDT)
Subject: Re: [PATCH v4] target/i386: Add notes for versioned CPU models
To: Tao Xu <tao3.xu@intel.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>
References: <20200324051034.30541-1-tao3.xu@intel.com>
 <cf93e187-9ee0-d1a9-be81-1afba87c1420@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bfdd16c-ec47-2d3a-8309-b32c1f6f9ec2@redhat.com>
Date: Tue, 23 Jun 2020 09:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cf93e187-9ee0-d1a9-be81-1afba87c1420@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/20 08:37, Tao Xu wrote:
> Hi Eduardo
> 
> Could you review this patch?
> 
> Tao Xu
> 
> On 3/24/2020 1:10 PM, Xu, Tao3 wrote:
>> Add which features are added or removed in this version.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> The output is as follows:
>> qemu-system-x86_64 -cpu help | grep "\["
>> x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake)
>> [ARCH_CAPABILITIES]
>> x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake)
>> [ARCH_CAPABILITIES, no TSX]
>> x86 Denverton-v2          Intel Atom Processor (Denverton) [no MPX, no
>> MONITOR]
>> x86 Icelake-Client-v2     Intel Core Processor (Icelake) [no TSX]
>> x86 Icelake-Server-v2     Intel Xeon Processor (Icelake) [no TSX]
>>
>> Changes in v3:
>>      - Keep the existing custom model-id (Eduardo)
>>
>> Changes in v2:
>>      - correct the note of Cascadelake v3 (Xiaoyao)
>> ---
>>   target/i386/cpu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 34b511f078..1c7690baa0 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3192,6 +3192,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>           .versions = (X86CPUVersionDefinition[]) {
>>               { .version = 1 },
>>               { .version = 2,
>> +              .note = "ARCH_CAPABILITIES",
>>                 .props = (PropValue[]) {
>>                     { "arch-capabilities", "on" },
>>                     { "rdctl-no", "on" },
>> @@ -3203,6 +3204,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               },
>>               { .version = 3,
>>                 .alias = "Cascadelake-Server-noTSX",
>> +              .note = "ARCH_CAPABILITIES, no TSX",
>>                 .props = (PropValue[]) {
>>                     { "hle", "off" },
>>                     { "rtm", "off" },
>> @@ -3424,6 +3426,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               { .version = 1 },
>>               {
>>                   .version = 2,
>> +                .note = "no TSX",
>>                   .alias = "Icelake-Client-noTSX",
>>                   .props = (PropValue[]) {
>>                       { "hle", "off" },
>> @@ -3541,6 +3544,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               { .version = 1 },
>>               {
>>                   .version = 2,
>> +                .note = "no TSX",
>>                   .alias = "Icelake-Server-noTSX",
>>                   .props = (PropValue[]) {
>>                       { "hle", "off" },
>> @@ -3648,6 +3652,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               { .version = 1 },
>>               {
>>                   .version = 2,
>> +                .note = "no MPX, no MONITOR",
>>                   .props = (PropValue[]) {
>>                       { "monitor", "off" },
>>                       { "mpx", "off" },
>>
> 

Queued, thanks.

Paolo


