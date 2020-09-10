Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CA52078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyylzW2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CA52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKsj-0000MK-HC
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGKs8-00089y-8j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGKs5-0002vj-JL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599737768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g68Ln2Ykm0AsGzDT36RNb3rZ1ltN22ArPGT5SDWCbBk=;
 b=FyylzW2a/0FEqR8XPPuTFe8qeFouGuOmfnOnN3t8EXZcLU+DaTGW5+7JY1J08QaVAGIesF
 qcgU7NkYZcnr1PLGh08YAiAkP/4S4m3p5b7i5otJeA/9kXtDCshou1gNqSId1rHgGJhvc7
 4JTuS+6BX96oODOImJB7WxXd5vXBcUc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-kfjTWmUkPLGxBiEoYzf5mg-1; Thu, 10 Sep 2020 07:36:06 -0400
X-MC-Unique: kfjTWmUkPLGxBiEoYzf5mg-1
Received: by mail-ej1-f72.google.com with SMTP id md9so2581792ejb.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 04:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g68Ln2Ykm0AsGzDT36RNb3rZ1ltN22ArPGT5SDWCbBk=;
 b=dcp/GKpkLyFwSCSjEq2o1M2zuk2KdBj1tadn63Q3BGJWBGr2X5Cb1VJBmLkPH5yAGr
 X8bYnrUcIphv0F9kFrofHqdZ8hzrNIg7/CcoKahyz1Mg2AoWVV3DuimslRlryk/OkkAf
 GdXd328DEd9Wj4KwBka7M9jPwjkHqnZ14hFq1SJ1GXzloRUqwPrj0HBnpSv20s1aIn60
 Gh2M+8biQIXsVCQdTwQxHLzSw902t0PokdDm6OWvGY6Jhp5IatpRSYY5pBjGs5QUqfUr
 QLuT9KTEQx9dyUuKMZ8T5QDdZ5Knmu37k+yv9SjX2h1z3oTjbHDvCxmWzGl2YuxytBXF
 W8bQ==
X-Gm-Message-State: AOAM530sj0BAXik8MJTLk88RyfPPD1a0xrJuA3H4iZbiWfG1MedPMpr7
 FtPOo86fCmJCccFT1wMlA8sdq+DcBl75/rIRZPZqe4247hrXqapzLU1mcfc6gpi6pRgmnHo5mVs
 HMewBiroib+k967o=
X-Received: by 2002:a05:6402:70f:: with SMTP id
 w15mr9029434edx.202.1599737765683; 
 Thu, 10 Sep 2020 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9MRcEWHvXnnWCE/19WdyGtANc2GFua6jmtkInHUN59/gDC3dQTZo6HFVJY56Lsok1NEcSrw==
X-Received: by 2002:a05:6402:70f:: with SMTP id
 w15mr9029399edx.202.1599737765385; 
 Thu, 10 Sep 2020 04:36:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:68f6:5b4d:4ee8:10c7?
 ([2001:b07:6468:f312:68f6:5b4d:4ee8:10c7])
 by smtp.gmail.com with ESMTPSA id m6sm6450319ejb.85.2020.09.10.04.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 04:36:04 -0700 (PDT)
Subject: Re: [PATCH 5/6] hw/pci-host/q35: Rename PCI 'black hole as '(memory)
 hole'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-6-philmd@redhat.com>
 <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
 <20200910091454.GE1083348@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6af444a-fb0b-ed98-60df-28ea67d6abe4@redhat.com>
Date: Thu, 10 Sep 2020 13:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910091454.GE1083348@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 11:14, Daniel P. Berrangé wrote:
> On Thu, Sep 10, 2020 at 09:15:02AM +0200, Thomas Huth wrote:
>> On 10/09/2020 09.01, Philippe Mathieu-Daudé wrote:
>>> In order to use inclusive terminology, rename "blackhole"
>>> as "(memory)hole".
>>
>> A black hole is a well-known astronomical term, which is simply named
>> that way since it absorbes all light. I doubt that anybody could get
>> upset by this term?
> 
> In this particular case I think the change is the right thing to do
> simply because the astronomical analogy is not adding any value in
> understanding. Calling it a "memoryhole" is more descriptive in what
> is actually is.

Absolutely not.  A memory hole ("memoryhole" is not an English word)
would be easily confused with a hole in the memory map, which this is
not.  For example on x86 systems the "PCI hole" is a hole between the
end of low RAM and the bottom of the ROM that is reserved for memory
mapped devices.  The "PCI hole" is explicitly left free by board code so
that the OS can put PCI BARs in there.

These black hole MemoryRegions, instead, are present in the memory map
and their purpose is to absorbs all writes and only sends back zeros,
hiding the contents of SMRAM and TSEG from the guest.  Just like a black
hole they are "something that exists".

Therefore, both "memory hole" and "hole" as in Philippe's patch are
worse than the astronomical metaphor.

Paolo

>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  include/hw/pci-host/q35.h |  4 ++--
>>>  hw/pci-host/q35.c         | 38 +++++++++++++++++++-------------------
>>>  tests/qtest/q35-test.c    |  2 +-
>>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
>>> index 070305f83df..0fb90aca18b 100644
>>> --- a/include/hw/pci-host/q35.h
>>> +++ b/include/hw/pci-host/q35.h
>>> @@ -48,8 +48,8 @@ typedef struct MCHPCIState {
>>>      PAMMemoryRegion pam_regions[13];
>>>      MemoryRegion smram_region, open_high_smram;
>>>      MemoryRegion smram, low_smram, high_smram;
>>> -    MemoryRegion tseg_blackhole, tseg_window;
>>> -    MemoryRegion smbase_blackhole, smbase_window;
>>> +    MemoryRegion tseg_hole, tseg_window;
>>> +    MemoryRegion smbase_hole, smbase_window;
>>
>> Maybe rather use smbase_memhole and tseg_memhole?
>>
>>  Thomas
>>
>>
> 
> Regards,
> Daniel
> 


