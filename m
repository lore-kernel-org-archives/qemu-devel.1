Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393AC3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 04:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A8221743
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Gbh6XY8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A8221743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i10ui-0005up-PZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 00:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i10td-0005Ho-9s
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 00:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i10tb-00041g-O2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 00:09:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i10tb-00041D-E8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 00:09:51 -0400
Received: by mail-pg1-x543.google.com with SMTP id d1so5003062pgp.4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P8AN6RZN/hzrVtGW7J6TDlgeWmQBScmewEQyJNGg2CY=;
 b=Gbh6XY8h5O78NMkXcq7atJvCTEnrE5iK+V0p2ueRN6tad5Nb+129ogosvGDZ5Hce65
 GKPkb4QA1xhdo0ZXfTo54McMyY4r4EHwDRttdTaGld5pK7YK9r9WyLfVPY1qcJQgoJRH
 Isq1iWhMWU8A3NHzjEYFfaGUNqnnEug2NgyRrjvJ1DigUkwbOwjrj5EYhX05WjQZQPDR
 UVlyo895UNcBYAkwi2JsnbIHo6OZy/F4NsJrm85/1bNI5qX46a3H2u/IzxTObFjyOVwq
 EjXPo1hC07iuETavC7Tu/CRAEq1QQMvOVvts0B+aBJJfhxuysCNNvkIwyXlSoWZ37iJ2
 bM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P8AN6RZN/hzrVtGW7J6TDlgeWmQBScmewEQyJNGg2CY=;
 b=sfWuwSDqpEutTmUbSnO25z6JhSPz2ZAZagug+qdUsx34jrCA4PrzAaK1jrqO/3/SvB
 bTEY5pkJgzMjr7dTSE45MKGwv/7Z597PG85GQXz475iMv+Tv/AlCciqAT5Otzqu197wG
 YtxpyHG7sS5qB4yGYgyxXlLYx1tOJ0BeXKPfFMGHMAOjmRlcjMeHY2/glruYanluBWcA
 GGJB5u4HKIHPz0vi2Ap4qaTtNG5KT0gtbIoOlDKm4LN2y/oc2YD50CWY6OVeG5lrUCk6
 hG5XNCs07FCdyZKxK63CmZbxEc7DZwFHmVVKYPAECamV9VnJITeuM2+wiY3rFHISpNKd
 UedA==
X-Gm-Message-State: APjAAAVQKPJXItWGt+gw3yHPM+pu7CNjZRKCm66Ac/7ZAAziTM9z/lIm
 gyFO8QmExdmuBLiqrY0XWJ9Zr1njl9w=
X-Google-Smtp-Source: APXvYqynIX+PiMprYAvGzRsfGK24PaYuMvxBx4XQVQKb1uAPsgphD0Sb8OwH0KeVsbvsUkC1vwThWg==
X-Received: by 2002:a17:90b:14c:: with SMTP id
 em12mr3265838pjb.28.1566533388906; 
 Thu, 22 Aug 2019 21:09:48 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 10sm1033003pfv.63.2019.08.22.21.09.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Aug 2019 21:09:48 -0700 (PDT)
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190719024555.18845-1-aik@ozlabs.ru>
 <ae3e5bd1-c7dd-d893-5c0e-803f4e4f2325@linux.vnet.ibm.com>
 <20190812100849.GF3947@umbus.fritz.box>
 <3722a768-c8bb-ed04-e450-b18cba8e6296@linux.vnet.ibm.com>
 <20190813141755.GN3947@umbus.fritz.box>
 <a2edbfa3-85fe-6998-ce0c-b97898081822@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9639fb3c-1b26-925d-903e-961fc306674c@ozlabs.ru>
Date: Fri, 23 Aug 2019 14:09:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a2edbfa3-85fe-6998-ce0c-b97898081822@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries REPOST]
 pseries: Update SLOF firmware image
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 14/08/2019 14:33, Aravinda Prasad wrote:
> 
> 
> On Tuesday 13 August 2019 07:47 PM, David Gibson wrote:
>> On Tue, Aug 13, 2019 at 01:00:24PM +0530, Aravinda Prasad wrote:
>>>
>>>
>>> On Monday 12 August 2019 03:38 PM, David Gibson wrote:
>>>> On Mon, Aug 05, 2019 at 02:14:39PM +0530, Aravinda Prasad wrote:
>>>>> Alexey/David,
>>>>>
>>>>> With the SLOF changes, QEMU cannot resize the RTAS blob. Resizing is
>>>>> required for FWNMI support which extends the RTAS blob to include an
>>>>> error log upon a machine check.
>>>>>
>>>>> The check to valid RTAS buffer fails in the guest because the rtas-size
>>>>> updated in QEMU is not reflecting in the guest.
>>>>>
>>>>> Any workaround for this?
>>>>
>>>> Well, we should still be able to do it, it just means fwnmi would need
>>>> a SLOF change.  It's an inconvenience, but not really a big deal.
>>>
>>> Yes. Alexey and I were discussing about the following changes to SLOf:
>>>
>>> diff --git a/lib/libhvcall/hvcall.S b/lib/libhvcall/hvcall.S
>>> index b19f6dbeff2c..880d29a29122 100644
>>> --- a/lib/libhvcall/hvcall.S
>>> +++ b/lib/libhvcall/hvcall.S
>>> @@ -134,6 +134,7 @@ ENTRY(hv_rtas)
>>>          ori     r3,r3,KVMPPC_H_RTAS@l
>>>          HVCALL
>>>          blr
>>> +    .space 2048
>>>          .globl hv_rtas_size
>>>   hv_rtas_size:
>>>          .long . - hv_rtas;
>>>
>>>
>>> But this will statically reserve space for RTAS even when
>>> SPAPR_CAP_FWNMI_MCE is OFF.
>>
>> Sure.  We could flag that in the DT somehow, and have SLOF reserve the
>> space conditionally.
>>
>> Or we could just ignore it. 2 kiB is miniscule compared to our minimum
>> guest size, and our current RTAS is microscopic compared to PowerVM.
> 
> I also think so, 2kiB is miniscule so we can allocate it statically.
> 
> Alexey,
> 
> Can you please include the above one line fix to SLOF?


I am thinking of:
===
@@ -132,20 +132,22 @@ ENTRY(hv_rtas)
  	mr	r4,r3
  	lis	r3,KVMPPC_H_RTAS@h
  	ori	r3,r3,KVMPPC_H_RTAS@l
  	HVCALL
  	blr
+	.space 2048 - (. - hv_rtas)
  	.globl hv_rtas_size
  hv_rtas_size:
  	.long . - hv_rtas;

  ENTRY(hv_rtas_broken_sc1)
  	mr	r4,r3
  	lis	r3,KVMPPC_H_RTAS@h
  	ori	r3,r3,KVMPPC_H_RTAS@l
  	.long	0x7c000268
  	blr
+	.space 2048 - (. - hv_rtas_broken_sc1)
  	.globl hv_rtas_broken_sc1_size
  hv_rtas_broken_sc1_size:
  	.long . - hv_rtas_broken_sc1;
===

to align the rtas blob to 2k precisely. But QEMU hardcoded 
RTAS_ERROR_LOG_OFFSET bothers me a bit, I should probably put some sort 
of a magic marker at which RTAS log can start.

David, any thoughts? The marker could be as simple as a zero, for example.


-- 
Alexey

