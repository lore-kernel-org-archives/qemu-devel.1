Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32083C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071502086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7aCX4Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071502086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31gc-00042j-74
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k31fu-0003Qd-KS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:28:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k31fs-0008Kx-NX
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596565711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QlTz+rvVyLRufVSHUGnFO7Fvaut8/Pk+nZj8NXK2bDc=;
 b=K7aCX4Dr+Cp8wFhcOgkUfpiWVq4KM6ZGWT9XdrBUiQKM14sikDq8xmuchEQ5FqqtM+Inos
 tFSJf6DmOUuKOhcyRMZcRafYLHK6IjPN2IppMU1/wIc9xFqh0VHyQv7fcrawODXYcGgdrL
 4I2EFcncPkscEdosy6oAyxk0XY8uB5o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-UElLmEKdMUCHDDIpL8ZZ6w-1; Tue, 04 Aug 2020 14:28:22 -0400
X-MC-Unique: UElLmEKdMUCHDDIpL8ZZ6w-1
Received: by mail-ej1-f69.google.com with SMTP id l7so10352524ejr.7
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 11:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QlTz+rvVyLRufVSHUGnFO7Fvaut8/Pk+nZj8NXK2bDc=;
 b=dzo+kxEC3Vt0ub3yMoDKnNHOnYClMKeMyGBCcHtRcvn73h2+TQU8E8drBcezxdeXyZ
 vnYHRZEaVy4mwMDmIvYjHmS+WmLdeFf+VdTrYFPPm4WE4OBqyn2Rv9mPIXh+b817uVy3
 KmGY2vsBRmSmptM+Froax80xOYHxyae4Tz6CibHSU2NiO7kDooqlNwkLR5DSlCwXZN9+
 MVNMQHw5Up473vcplwiOLVJIIlkfRwbBvxmgin/H8DS67T6NPSixpUZlPOpSCVtLEpmp
 6FCMltx1VSYEXUWi1PUcJ6GS+OO9R6okVoVjvDovtqkj3QltqaPwJY4oYGu/DlECOurD
 CETA==
X-Gm-Message-State: AOAM531jfPqz8dALt37DwVbcgw7/I1MzEWVRQYnS5SpSF/DPw0Z9eu3+
 w8V+Zw7oHnYMYGi6/iAD7k718KQmU0iYOpgb/EdKoWgzgdQyjPKgKreGPtRchPI6sJJlo2v5NRF
 NVRhLk5xSHJemtiw=
X-Received: by 2002:a17:906:819:: with SMTP id
 e25mr23998882ejd.95.1596565701421; 
 Tue, 04 Aug 2020 11:28:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBuJSWkg2Jl2Kd1Mxrb2ERUnpWJjrH/8binz17GhEWsJvwNSJcYDIaHfnUMN+5NkDvTRXcbA==
X-Received: by 2002:a17:906:819:: with SMTP id
 e25mr23998860ejd.95.1596565701167; 
 Tue, 04 Aug 2020 11:28:21 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id op15sm9492470ejb.42.2020.08.04.11.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 11:28:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: Marcelo Tosatti <mtosatti@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
 <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
 <20200319160800.614de5fb@redhat.com>
 <d6c0dc2f-5b0f-2e34-6c12-e9d9cd7402c6@redhat.com>
 <3f70d63d-e9ae-6676-edd5-20613b4b8856@redhat.com>
 <20200323110452.GA14031@fuller.cnet>
 <f8a17eb5-7c70-4deb-82b3-54bc097dcfd6@redhat.com>
 <20200803173338.GA83945@fuller.cnet>
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
Message-ID: <3d4501c3-3ada-6429-08e6-278c63ae17b4@redhat.com>
Date: Tue, 4 Aug 2020 20:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200803173338.GA83945@fuller.cnet>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 7:33 PM, Marcelo Tosatti wrote:
> On Mon, Aug 03, 2020 at 07:10:11PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> Hi Igor, Paolo.
>>
>> On 3/23/20 12:04 PM, Marcelo Tosatti wrote:
>>> On Mon, Mar 23, 2020 at 09:05:06AM +0100, Paolo Bonzini wrote:
>>>> On 22/03/20 17:27, Philippe Mathieu-DaudÃ© wrote:
>>>>>>>
>>>>>> That 'ugly' is typically used within QEMU to deal with such things
>>>>>> probably due to its low complexity.
>>>>>
>>>>> OK. Can you point me to the documentation for this feature? I can find
>>>>> reference of GPE in the ICH9, but I can't find where this IO address on
>>>>> the PIIX4 comes from:
>>>>>
>>>>> #define GPE_BASE 0xafe0
>>>>
>>>> It's made up.  The implementation is placed in PIIX4_PM because it is
>>>> referenced by the ACPI tables.  Real hardware would probably place this
>>>> in the ACPI embedded controller or in the BMC.
>>>>
>>>> Paolo
>>>
>>> Yes, there was nothing at 0xafe0 at the time ACPI support was written.
>>>
>>
>> Igor earlier said:
>> "it's already pretty twisted code and adding one more knob
>> to workaround other compat knobs makes it worse."
>>
>> Is that OK to rename this file "hw/acpi/piix4_twisted.c" and
>> copy/paste the same content to "hw/acpi/piix4.c" but remove the
>> non-PIIX4 code (GPE from ICH9)?
>>
>> This seems counterproductive from a maintenance PoV, but the PIIX4 bug
>> (https://bugs.launchpad.net/qemu/+bug/1835865) is more than 1 year old
>> now...
>>
>> If someone has a clever idea, I'm open to listen and implement it, but
>> keeping ignoring this issue is not good.
>>
>> Note there is a similar issue with the LPC bus not existing on the
>> PIIX, so maybe renaming this to something like "piix_virt.c" and having
>> someone writing the specs (or differences with the physical datasheet)
>> is not a such bad idea.
>>
>> Thanks,
>>
>> Phil.
> 
> Make the port address architecture specific ? 

I find it worse than using a property set on the PC machine only
(that would make the piix4 compiled for each target instead on only
once in common-obj as now). But if Igor is OK with that, I don't
mind much, let's move forward.

Thanks,

Phil.


