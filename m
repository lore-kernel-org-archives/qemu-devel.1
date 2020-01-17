Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB41C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D282082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUXaI9rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D282082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPit-00044p-3G
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isPi8-0003Es-5m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isPi7-00064w-1B
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:22:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isPi6-00064g-UL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579260162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmThgViCQ+XIJ18tN8Ie/gC+jlmG51PP0/YIsm26cFQ=;
 b=IUXaI9rSdfXlrM/CUrZG+jelfeO6bB90I8dL3HHZ27KNhNGEBurBD4P6kNaaBiJt1QA817
 C+3yQ9oooO+1rrflKrBOTTyiqUErYvwV1TwjX4J/v3ZzJNJtEF6LtW0Ejx+GRf2DOfLz7D
 AGde5RNetmndi5bk7juXOPbyvFwTwwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-p75q2yB9ND2VE7jwpVfU8w-1; Fri, 17 Jan 2020 06:22:38 -0500
Received: by mail-wm1-f69.google.com with SMTP id q26so1109592wmq.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 03:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1KvxUNp1KgYZrP3PTc7X6mLhbjCUmF5jCMS907NMjFw=;
 b=Ia6NY0l1RR+ArCLGK+WR1DIdbCsHqBUNVy74uHyolw7hoD+NxUmQlVyoUBO19UTSAB
 AfaZ/6czvcyv/XpYeQZjPCUSep7fuBpXGX2G960G1k5OJL3OwM6EUtSDfP6fZANl++iP
 T/wG0RNlCJFqD1s/NowwgxUrSK2Orucb3qGKlmdiNScBFInm+yjKAezC3TeR46RYuT3R
 xiWWrVySbZtvB+eGgdZk/HrVcS/aMHuGY6KFMyTD3FreL++4J0pTdpQvrg9Ac3ly0LJp
 d+fcFtXkprfqNrHjr1AlC47fE/PzNqEKOvznh39pHsG2Q+9zFWb2PQLoPxY+Q3jxEvgN
 PZfw==
X-Gm-Message-State: APjAAAUtSk0CEXH9Vv2Ni36Izaz69UfqDcMcTRgKOK5C4FJDLjbSw4y5
 NzqUs8mZ/AEe1bknU0x4OYIFz4FjnA8BjBXK5zc76NM9KGM7cBbppYimuYLox/ijOtPJ2Nv6+P7
 FLnR87U5qchxc70M=
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr4010645wmc.111.1579260157432; 
 Fri, 17 Jan 2020 03:22:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxw6jG4sunKX8VtAdOpeF6yPeSU9Bg8VWVUzEvV9nwY1wrfKbeKrRfkjUOqNnf61HZxoUkhkw==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr4010613wmc.111.1579260157141; 
 Fri, 17 Jan 2020 03:22:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 5sm33742050wrh.5.2020.01.17.03.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 03:22:36 -0800 (PST)
Subject: Re: [PATCH v22 9/9] MAINTAINERS: Add ACPI/HEST/GHES entries
To: Peter Maydell <peter.maydell@linaro.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-10-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
 <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
 <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <724fbf58-19df-593c-b665-2c2e9fe71189@redhat.com>
Date: Fri, 17 Jan 2020 12:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: p75q2yB9ND2VE7jwpVfU8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 12:09 PM, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 07:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Hi Peter,
>>
>> On 1/16/20 5:46 PM, Peter Maydell wrote:
>>> On Wed, 8 Jan 2020 at 11:32, Dongjiu Geng <gengdongjiu@huawei.com> wrot=
e:
>>>>
>>>> I and Xiang are willing to review the APEI-related patches and
>>>> volunteer as the reviewers for the HEST/GHES part.
>>>>
>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>>>> ---
>>>>    MAINTAINERS | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 387879a..5af70a5 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1423,6 +1423,15 @@ F: tests/bios-tables-test.c
>>>>    F: tests/acpi-utils.[hc]
>>>>    F: tests/data/acpi/
>>>>
>>>> +ACPI/HEST/GHES
>>>> +R: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> +R: Xiang Zheng <zhengxiang9@huawei.com>
>>>> +L: qemu-arm@nongnu.org
>>>> +S: Maintained
>>>> +F: hw/acpi/ghes.c
>>>> +F: include/hw/acpi/ghes.h
>>>> +F: docs/specs/acpi_hest_ghes.rst
>>>> +
>>>>    ppc4xx
>>>>    M: David Gibson <david@gibson.dropbear.id.au>
>>>>    L: qemu-ppc@nongnu.org
>>>> --
>>>
>>> Michael, Igor: since this new MAINTAINERS section is
>>> moving files out of the 'ACPI/SMBIOS' section that you're
>>> currently responsible for, do you want to provide an
>>> acked-by: that you think this division of files makes sense?
>>
>> The files are not 'moved out', Michael and Igor are still the
>> maintainers of the supported ACPI/SMBIOS subsystem:
>=20
> Does get_maintainer.pl print the answers for all matching
> sections, rather than just the most specific, then?

Yes:

$ ./scripts/get_maintainer.pl -f hw/acpi/ghes.c
Dongjiu Geng <gengdongjiu@huawei.com> (reviewer:ACPI/HEST/GHES)
Xiang Zheng <zhengxiang9@huawei.com> (reviewer:ACPI/HEST/GHES)
"Michael S. Tsirkin" <mst@redhat.com> (supporter:ACPI/SMBIOS)
Igor Mammedov <imammedo@redhat.com> (supporter:ACPI/SMBIOS)
qemu-arm@nongnu.org (open list:ACPI/HEST/GHES)
qemu-devel@nongnu.org (open list:All patches CC here)

> In any case, I'd still like an acked-by from them.

Sure :)


