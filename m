Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F6C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85AA2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF04OPfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85AA2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLyl-0002hd-VG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isLy2-0002Ar-S8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isLy0-0007Xr-LJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:22:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isLy0-0007XI-Em
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579245771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SX85ocYe6qBHhEmGwRnMOgwhJq0ZCFu5QUJbBLBiCA=;
 b=aF04OPfvXC1FVhKr1SK6v9H7dunkCy47tdjBXk5S6oCHMm8dipieThPL33ohoXr9EXenQv
 cTnmd5gm+ch4QfxVhyQ3fI9xMKzWt7UL5+QGHxU/AiL3lcjmvo6F0ggdYVcepkIGaaMAng
 vzkgfgYW8RWZjEfh1z+DKfd60cXmvPw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-BTdI-xjQPhiPwK9ghE7jXg-1; Fri, 17 Jan 2020 02:22:48 -0500
Received: by mail-wm1-f70.google.com with SMTP id 18so1930819wmp.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 23:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y3RcHw06IWFshCmwxf/kgJpylqKRRJYyaQ6ieJjtjws=;
 b=EeTgA/Jiyfh8I73Cmh7GfdFbnDQda06vuy08lOX0lnW9+MhsdiUGJbM/yAl9YIXgWM
 b4Ce7Vl+6fohgJDy/lr2CHjZrBHmNxLaBlCefek/lkDUlH/+U9PfAwAPDKrXYgG5Jhx+
 mvNfUgwTNzIHbYY0LHL1JO/Vo+d9B0+dLyoPJJcZPktipvW4DVlWVJdFc4/ArjOhyDcC
 5mB5OAGWwPMeefUqMU+WX3tTI0ml2suKx7BBkH9eT2uJTCyU8iS4j3GzRu59EhlnUMnj
 +V8tF+UVYIbCfAt1sPeDKsdyij8yRoDgUqYqLP3S6AZDd7wmWjSYthRC19hdPx/7UUyE
 a3zw==
X-Gm-Message-State: APjAAAVZih0RxpAHhESpiuf+1wyuHhA0/6TjWQBy3TQUhaJSowShHpZS
 2LInStskPJ7krRDAlXw4/3+gnA0P7588kVqEhjz/svU1dDSGH+LtKGduMpCQwzyoLNF01XN4Igw
 deYxQkDrN2B1Xg9s=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr1505123wrj.361.1579245767252; 
 Thu, 16 Jan 2020 23:22:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhVu92f0rPbMXkhVzlAmmh1h6VA7J+gWqDV5WIKA8NY6FR45MKwm6SeR4kPdGNcBnws6v4QA==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr1505101wrj.361.1579245766968; 
 Thu, 16 Jan 2020 23:22:46 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x7sm31918244wrq.41.2020.01.16.23.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 23:22:46 -0800 (PST)
Subject: Re: [PATCH v22 9/9] MAINTAINERS: Add ACPI/HEST/GHES entries
To: Peter Maydell <peter.maydell@linaro.org>,
 Dongjiu Geng <gengdongjiu@huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-10-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
Date: Fri, 17 Jan 2020 08:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BTdI-xjQPhiPwK9ghE7jXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 1/16/20 5:46 PM, Peter Maydell wrote:
> On Wed, 8 Jan 2020 at 11:32, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>
>> I and Xiang are willing to review the APEI-related patches and
>> volunteer as the reviewers for the HEST/GHES part.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 387879a..5af70a5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1423,6 +1423,15 @@ F: tests/bios-tables-test.c
>>   F: tests/acpi-utils.[hc]
>>   F: tests/data/acpi/
>>
>> +ACPI/HEST/GHES
>> +R: Dongjiu Geng <gengdongjiu@huawei.com>
>> +R: Xiang Zheng <zhengxiang9@huawei.com>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/acpi/ghes.c
>> +F: include/hw/acpi/ghes.h
>> +F: docs/specs/acpi_hest_ghes.rst
>> +
>>   ppc4xx
>>   M: David Gibson <david@gibson.dropbear.id.au>
>>   L: qemu-ppc@nongnu.org
>> --
>=20
> Michael, Igor: since this new MAINTAINERS section is
> moving files out of the 'ACPI/SMBIOS' section that you're
> currently responsible for, do you want to provide an
> acked-by: that you think this division of files makes sense?

The files are not 'moved out', Michael and Igor are still the=20
maintainers of the supported ACPI/SMBIOS subsystem:

ACPI/SMBIOS
M: Michael S. Tsirkin <mst@redhat.com>
M: Igor Mammedov <imammedo@redhat.com>
S: Supported
F: include/hw/acpi/*
F: hw/acpi/*

Dongjiu and Xiang only add themselves as reviewers to get notified on=20
changes on these specific files. The more eyes the better :)

The docs/specs/acpi_hest_ghes.rst document has no maintainer, as these=20
others too:

- docs/specs/acpi_cpu_hotplug.txt
- docs/specs/acpi_hw_reduced_hotplug.rst
- docs/specs/acpi_mem_hotplug.txt
- docs/specs/acpi_nvdimm.txt

The only ACPI file reported as maintained in docs/specs/ is=20
acpi_pci_hotplug.txt, from this entry:

PCI
M: Michael S. Tsirkin <mst@redhat.com>
M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
S: Supported
F: docs/specs/*pci*

FWIW:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


