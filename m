Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D756C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C082087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxNhr6LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C082087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGP3g-0001tI-3z
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGP1w-0008D0-KB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:02:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGP1t-0005Ck-Tt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599753752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lco4+RbgnH2rxh2Br19nexisgzNG0rjal9ON0Gwa5fw=;
 b=YxNhr6LOk7/DTQPhUv/UysNhnYAt4Xeygvd1EtQ526qsk2iGS9fOTpLvKN+mwhpwUDxUeg
 c8i5ntxLJSyUFba17xUehymzTQv3JuRqeNUOaB4fHYphRFPqNweAf1Xdt1CBeIAHKXyCnz
 ecljjkjBGd09Yg1UvuH5Q/gXUy/0/jQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-QAxs6BbMOBWVxuxNzl_Rjg-1; Thu, 10 Sep 2020 12:02:27 -0400
X-MC-Unique: QAxs6BbMOBWVxuxNzl_Rjg-1
Received: by mail-wr1-f70.google.com with SMTP id v12so2422038wrm.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lco4+RbgnH2rxh2Br19nexisgzNG0rjal9ON0Gwa5fw=;
 b=bNgj8CZV0w1Yarw4k30am01qllm/Yje65HEW/aE+J/omuQWfFUteDi2kuU/tmcVdOG
 iiXPeytH6al5VP9gUKKquAuEWMjKqV51VrYu37HSeQKeFu5Y006X+bxmoXZuhWISlj80
 QkuPixjdg/cBsD4n46x65nf2Y5DrOKwTyd+AJo7+gKE1HjR45RItGNnr3b8Ngw1asVqQ
 YjY6S6THeVW8k8Obm1sBw4iAuLObY8GVSeQSlUMoWr7H2EfG/WE6IcvAYy1YKZzEhoGI
 WYiBmiWGIgRSv7iCvkGcGMwWs3adzeUXb15dEw2fTSPoPjzGh8udhWbZ92cfN83k5NdL
 +vuA==
X-Gm-Message-State: AOAM533w5sDg4yul0KLl78Le6+6j4wGUBbXtQhIsDdw6QsCvDYspVvjf
 Y4e4kWV9NfL3EjrqTKxbDvIH1dIvHE4pjODc6sP7DqrFkHYOvY6bRvPxp0G8tWdW6O/E0w4wAqT
 kBS02JLt6neQSV8Q=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr660014wma.87.1599753746301;
 Thu, 10 Sep 2020 09:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCcobIwUmZNtQnuTLWuBrCKkAjak1xYEf8eWWeMwmwk312ahwqrQ7K28uYfmsDz5b3bU84Cg==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr659985wma.87.1599753746017;
 Thu, 10 Sep 2020 09:02:26 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f14sm9597517wrv.72.2020.09.10.09.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 09:02:25 -0700 (PDT)
Subject: Re: [PATCH 10/10] tests: acpi: update "virt/SSDT.memhp" for
 edk2-stable202008
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-11-lersek@redhat.com>
 <843298f0-049f-b67d-8497-39bd2f00ab11@redhat.com>
 <7db07be3-23d2-2fb4-e96a-ff60b106e0ae@redhat.com>
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
Message-ID: <3f78e59c-93f2-b642-c338-9bbc6d261ea1@redhat.com>
Date: Thu, 10 Sep 2020 18:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7db07be3-23d2-2fb4-e96a-ff60b106e0ae@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 2:14 PM, Laszlo Ersek wrote:
> On 09/08/20 10:27, Philippe Mathieu-Daudé wrote:
>> On 9/8/20 9:29 AM, Laszlo Ersek wrote:
>>> The NVDIMM_ACPI_MEM_ADDR dword in "virt/SSDT.memhp" needs an update due to
>>> the firmware now allocating NVDIMM_DSM_MEM_FILE at a lower address.
>>>
>>>>          }
>>>>      }
>>>>
>>>> -    Name (MEMA, 0x43DD0000)
>>>> +    Name (MEMA, 0x43D10000)
>>>>  }
>>>>
>>
>> What about also adding (with adapted SHA1):
>>
>> This reverts commit 120219eef8a ('tests: acpi: tolerate
>> "virt/SSDT.memhp" mismatch temporarily').
> 
> It's not a revert. The payload for this commit was generated in
> accordance with the instructions in "tests/qtest/bios-tables-test.c",
> namely:
> 
>>  * 5. From build directory, run:
>>  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
>>  * 6. Now commit any changes to the expected binary, include diff from step 4
>>  *    in commit log.
> 
> In particular, "rebuild-expected-aml.sh" empties
> "bios-tables-test-allowed-diff.h" automatically (I didn't have to modify
> it manually).
> 
> Plus the commit contains the actual binary blob update (which is not a
> revert either).
> 
> See also a similar patch from Igor (please note the
> "bios-tables-test-allowed-diff.h" hunk in it, and the fact that the
> commit message does not mention a "revert"):
> 
>   [PATCH v5 10/10] tests: acpi: update acpi blobs with new AML
>   http://mid.mail-archive.com/20200907112348.530921-11-imammedo@redhat.com

OK!

> 
> Thanks!
> Laszlo
> 
>>
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>>>  tests/data/acpi/virt/SSDT.memhp             | Bin 736 -> 736 bytes
>>>  2 files changed, 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index e569098abddc..dfb8523c8bf4 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1,2 +1 @@
>>>  /* List of comma-separated changed AML files to ignore */
>>> -"tests/data/acpi/virt/SSDT.memhp",
>>> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
>>> index db61d6733284..375d7b6fc85a 100644
>>> Binary files a/tests/data/acpi/virt/SSDT.memhp and b/tests/data/acpi/virt/SSDT.memhp differ
>>>
>>
> 


