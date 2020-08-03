Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7840E20775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USScWP9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7840E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Y4p-0001Vj-I7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2Y4G-000169-0y
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:51:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2Y4E-0001M9-4M
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596451900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4r2ClAOisEd6BtNzwI7xm7F+w3V27i0c2JSqzRGpz74=;
 b=USScWP9trT0Y6tOV4irkSuD8at9BZiWdPtEmfgHoVAGmWgI7PREnx+841mplf0HnO7oGuh
 0A9PtNQahi2DAGysQn6/cTDyisM63sLW43c/BUG+fQLKU5QI1skdb2S93NZET1ZpRae4wB
 7dTx1CqZfBG5CpGG12sh8v7d1mCTlFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-UQfYjzsfPT-CS3uIwT2apQ-1; Mon, 03 Aug 2020 06:51:39 -0400
X-MC-Unique: UQfYjzsfPT-CS3uIwT2apQ-1
Received: by mail-wm1-f72.google.com with SMTP id i15so3158754wmb.5
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 03:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4r2ClAOisEd6BtNzwI7xm7F+w3V27i0c2JSqzRGpz74=;
 b=AePXz5bs1YYIO5UQ5V5iYxZ+aE2a52gtDERcmHKkpjEo+NC+6QkYIdSWxdPmZ5Ff01
 nH4mNlr1ecORe8OmTGh7BIvZyWFHHPd7k1/kQp4NE1vZKhgCIUcpaw59FTCet2TSTJcc
 vTcCnuOjIkqbRGsFJMqfZpnot91J+SkJCcQRycFFdNCwTKEfdfWMYZyklPuk+jkd0ZKT
 Huvpk29KT7fxWULZVXPF+ohpJqmQIrgRfg00IfSleaOJWVn7BdMPikMJY9Zd57HqJ5mQ
 /hh5bSOkgxm5qWhYbZHDyW0ETGGUEIoI0sXO+4somguDIvK5I311oOqTrx3q/dhoNFxV
 h7pw==
X-Gm-Message-State: AOAM530gtz+PR/p7Ja4NDiSOdoXjpz3tiw9h5IA0dDcd8rAwrnLs412t
 Ca/gRuLqJaxazysLWjvjWlGisg1RCJjDIcozxtQ9HQnb//7110eUKpk1VA5mqTA41TO454RF7it
 FeBLbDmhfqWEGJw4=
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr15734262wru.201.1596451898196; 
 Mon, 03 Aug 2020 03:51:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww+o6n3a8NiDnhs/mZZY98Lm2TawsRbVzmQhHCYyMqrKMupU2wxmL9jkZ/saVDG9wSWfuFFQ==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr15734234wru.201.1596451897973; 
 Mon, 03 Aug 2020 03:51:37 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 32sm25126489wrn.86.2020.08.03.03.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 03:51:37 -0700 (PDT)
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
 <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
 <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
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
Message-ID: <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
Date: Mon, 3 Aug 2020 12:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sunil,

On 8/1/20 1:31 AM, Sunil Muthuswamy wrote:
>> Hi Justin, Sunil,
> 
> Justin has moved to a different team is no longer working with WHPX. Moving him
> to bcc.

OK. Does that mean you are the new responsible of updating the ticket
regarding the WHPX headers and their license?

> 
>>
>> On 5/20/20 12:26 PM, Philippe Mathieu-Daudé wrote:
>>> +launchpad ticket
>>>
>>> On 9/20/19 6:53 PM, Justin Terry (VM) wrote:
>>>> Hey Phil,
>>>>
>>>> I have contacted our legal department for guidance on this specific
>>>> use case and will update you when I hear back. Thank you for your
>>>> patience.
>>
>> I recently understood legal changes can be very complex, thus it is
>> implicit it can take years before getting updates.
>>
>> Since the project is still actively developed, maybe you could provide
>> a Azure CI job to build a WHPX binary. We don't need to have access to
>> the binary, just to the exit status (success/fail) and build logs.
>>
>> Do you think it is doable?
>>
>> Thanks,
>>
>> Phil.
>>
> The ask generally sounds reasonable. But, can you help me understand the full
> scope of the ask. Few questions:
> 1. Stefan has a CI pipeline to build WHPX.

Great! I didn't know Stefan already did it :)
Can you share the URL please, so we can integrate it with mainstream CI?

> What's the benefit of having another CI
> job, that doesn't export the binary, but, just the status?

As usual, we do not want to circumvent the license. IANAL but IIUC we
can not force a CI job to accept the EULA when installing it, even to
test it. So the best we can do is check if the build succeeded (exit
status).

> 2. Which branch is the CI pipeline expected to build?

'master', to be sure no regressions are introduced.

> 3. Is the expectation also that it will build WHPX patches that are submitted to the
> WHPX branch?

You describe a "downstream CI" testing, which is out of scope of the
community public CI.

Regards,

Phil.


