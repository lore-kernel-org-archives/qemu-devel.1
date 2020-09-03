Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A748C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABAC206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHQe/frC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABAC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDusy-0003Qo-HS
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDusM-0002zl-Kf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:26:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDusJ-0001Gb-36
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599161181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bG1swpi7B2K5rxSbe9syH9K9grNCjzGmO3ji7bFwhZg=;
 b=SHQe/frCLZwgc+//Ab41U1CLh5kKzMW/p9H/GmrqAzVCAwXbbSvDmuF13ac0EIC5iTeggR
 3L5tRhw/zqniGWQGnMN+nWsZxEbjgab8Ssl0BvDp//7lO5OV96DCXYQb1Imz8FtVq9/5Ql
 M8h8zVFO2fD/BD25jgbW1bXk8dQ5Wtc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-NVBZn2JEPRW1kXHr13WmxA-1; Thu, 03 Sep 2020 15:26:19 -0400
X-MC-Unique: NVBZn2JEPRW1kXHr13WmxA-1
Received: by mail-wr1-f72.google.com with SMTP id s8so1421172wrb.15
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 12:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bG1swpi7B2K5rxSbe9syH9K9grNCjzGmO3ji7bFwhZg=;
 b=NvJtIF9y/uoAuErcq49BdMdG6CRjFZXVQgmYhBuQVMyTI+T8NMLG+bGKKNA8r+88ts
 JGaOUFhe2cGj5Z/5Js3vIIe9poYEklaneCOfECfmhNbtUBeFmVjabsJtGpgptrOCAcnc
 2dhynbb3NkmunA/99wdq2hb6pm3RKM0YaWB4Xmv4UYWJFqIOY8TE1UlOt/ov7XFYpPp7
 riv3ogAPlNWR0HQ8B6KC8+6e57Qk64ZHN/S3JpCdbRP+nlUy1Sib4hXCSLBjOG7M3DmS
 qvqFG0UlhA6pdcp5nsH5nannArDa5vg8j3vHQUmymxoDAWgb/YN7kYY+KfisSXRS6V2/
 puCQ==
X-Gm-Message-State: AOAM532MNOsesfcwZ6g/S8/k9hPHoP2YnpraT48ahCCxBq1ZVOxh3+l3
 hnOXNZPnQwMOBu8xCbD171bTxCv2h1Ek4+ZI+11Rcz7IVQR4r7TpVHwXxEPMJ4K9SaCv2uzOyA2
 N5mBvlZQMvi0TfkQ=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr3873060wro.86.1599161178666; 
 Thu, 03 Sep 2020 12:26:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK3uE0P0BfbBW0kCb5i46BNykXgzvAQuM9O1LEh59ZJvcFlvUcU0DWP/koGKPOBkJA2IGdZg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr3873044wro.86.1599161178473; 
 Thu, 03 Sep 2020 12:26:18 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id j7sm6455923wrw.35.2020.09.03.12.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:26:17 -0700 (PDT)
Subject: Re: [PATCH 14/63] i8254: Rename TYPE_I8254 to TYPE_PIT
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-15-ehabkost@redhat.com>
 <9a2be0a5-1d7f-1813-5bdb-2c741f07c593@redhat.com>
 <20200903161809.GH4940@habkost.net> <20200903164429.GD441291@redhat.com>
 <20200903165511.GP4940@habkost.net>
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
Message-ID: <47698a43-6b72-1b97-7e6f-da7ba952847f@redhat.com>
Date: Thu, 3 Sep 2020 21:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903165511.GP4940@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 6:55 PM, Eduardo Habkost wrote:
> On Thu, Sep 03, 2020 at 05:44:29PM +0100, Daniel P. BerrangÃ© wrote:
>> On Thu, Sep 03, 2020 at 12:18:09PM -0400, Eduardo Habkost wrote:
>>> On Thu, Sep 03, 2020 at 02:47:03PM +0200, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>>>> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
>>>>> This will make the type name constant consistent with the name of
>>>>> the type checking macro.
>>>>>
>>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> ---
>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: qemu-devel@nongnu.org
>>>>> ---
>>>>>  include/hw/timer/i8254.h | 4 ++--
>>>>>  hw/timer/i8254.c         | 4 ++--
>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
>>>>> index 1a522a2457..ddd925074f 100644
>>>>> --- a/include/hw/timer/i8254.h
>>>>> +++ b/include/hw/timer/i8254.h
>>>>> @@ -45,7 +45,7 @@ typedef struct PITCommonClass PITCommonClass;
>>>>>  DECLARE_OBJ_CHECKERS(PITCommonState, PITCommonClass,
>>>>>                       PIT_COMMON, TYPE_PIT_COMMON)
>>>>>  
>>>>> -#define TYPE_I8254 "isa-pit"
>>>>> +#define TYPE_PIT "isa-pit"
>>>>
>>>> I disagree with this patch, as we have various PIT and only one I8254.
>>>
>>> I was unsure about this, and I agree with your point.  I will
>>> suggest renaming the PIT macro to I8254 instead.
>>
>> IMHO the macro name should be directly related to the object name
>> string with non-alnum characters replaced by underscore.
>>
>> ie since the object type is "isa-pit", then the macro should be
>> TYPE_ISA_PIT
> 
> I think that's a good idea in this specific case because it's a
> short name (I will do it).  But I don't think we'll be able to
> always follow that rule, as the QOM type name is user-visible.

Only user-visible if user-creatable, right?


