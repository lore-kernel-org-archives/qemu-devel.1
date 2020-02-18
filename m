Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79953C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470F1208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFi2PNt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470F1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46OV-0001BJ-DA
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46No-0000OW-G3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46Nn-0004WF-0r
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46Nm-0004Vs-Sp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582045802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLOEipOG6BV/mcfTUVfmGcKHAJZ55fXPUK6kib39XtA=;
 b=XFi2PNt98oPjmI3zDRqvMuZOBZafnCWx24VouNuwckbqd5yc2EWfPaHPtTX9OTj0YHSiF+
 RcXi5O/VPNmLY4v8eqj341osnyT6m5zXDkjO7R2N48ZBM/rG75Z0Wg6GtoZK8etwQMRDwD
 e31X6qKYksK+woJJjJxtguxpNWJui8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-EWZPoZ2IMA2iRraHP0GXSQ-1; Tue, 18 Feb 2020 12:09:59 -0500
Received: by mail-wm1-f71.google.com with SMTP id w12so338387wmc.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7RtQCbW0b+aKzndCbvJg3sBSxYHmJ3YBEZv7TOdcoQU=;
 b=bqqvqtFHicZSO1bqN+k5ZaYtZ7nJWK6WW15cKRL8g0mRsmo3args26CN/hZAy+ZaxP
 2gDLVOQFHhKRpng0qSuOpFbNnN1AGAaT+Sc7oJrHnr7CWHYjyHdfbhoY5I9XkIluU+2H
 uGyzqGp46hnJMVZbKojl0s78bpP7YjVAwzl3nxqwyB5IcuRkjTg8vQo9R4GpToleOTSm
 NYFcH/v7nrstNNFXbnQaxtMqo+NVUBNKp3yiD7SLJYpuLQiDDMvYpvoNsQ4FBUN6gnpP
 P7HDqWlWMh494YrdYJT/o41xEhff+199hTZrRgxCvRamUmwfMVAnaVMUumLmmr7j97sa
 Lbbw==
X-Gm-Message-State: APjAAAWYYT1cg5nANnhYoTBlaBhC0idBCeJMXX2pVh6jfkGGKVxmY9w8
 /Zf+Zi7WKU6KeaxuIbwc+q5wOUND+WXXgM4WahDVEjO3VCgQoltsZx7ib5ODttGxVyX+WifI5PR
 26xolqHx8zqilaNo=
X-Received: by 2002:a5d:65c6:: with SMTP id e6mr3496479wrw.45.1582045798463;
 Tue, 18 Feb 2020 09:09:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMCIeux7oS3mBQZkfQudlIZpVQPZGDhS+HMiLUkF6hEhKvmoZU3++Z8bBoNQHLXWfJaQL9RA==
X-Received: by 2002:a5d:65c6:: with SMTP id e6mr3496461wrw.45.1582045798176;
 Tue, 18 Feb 2020 09:09:58 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j15sm7368873wrp.9.2020.02.18.09.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:09:57 -0800 (PST)
Subject: Re: [PATCH v5 17/79] arm/integratorcp: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-18-imammedo@redhat.com>
 <5e21adc1-a197-9d37-133c-ea510b9b9926@redhat.com>
 <20200218174117.1dab2b41@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e61ab250-1aa7-ebd4-18de-5bf8d2ba2971@redhat.com>
Date: Tue, 18 Feb 2020 18:09:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218174117.1dab2b41@redhat.com>
Content-Language: en-US
X-MC-Unique: EWZPoZ2IMA2iRraHP0GXSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 5:41 PM, Igor Mammedov wrote:
> On Tue, 18 Feb 2020 07:55:14 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 2/17/20 6:33 PM, Igor Mammedov wrote:
>>> memory_region_allocate_system_memory() API is going away, so
>>> replace it with memdev allocated MemoryRegion. The later is
>>> initialized by generic code, so board only needs to opt in
>>> to memdev scheme by providing
>>>     MachineClass::default_ram_id
>>> and using MachineState::ram instead of manually initializing
>>> RAM memory region.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>> CC: peter.chubb@nicta.com.au
>>> ---
>>>    hw/arm/integratorcp.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
>>> index 0cd94d9f09..cc845b8534 100644
>>> --- a/hw/arm/integratorcp.c
>>> +++ b/hw/arm/integratorcp.c
>>> @@ -585,7 +585,6 @@ static void integratorcp_init(MachineState *machine=
)
>>>        Object *cpuobj;
>>>        ARMCPU *cpu;
>>>        MemoryRegion *address_space_mem =3D get_system_memory();
>>> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>>>        MemoryRegion *ram_alias =3D g_new(MemoryRegion, 1);
>>>        qemu_irq pic[32];
>>>        DeviceState *dev, *sic, *icp;
>>> @@ -605,14 +604,13 @@ static void integratorcp_init(MachineState *machi=
ne)
>>>   =20
>>>        cpu =3D ARM_CPU(cpuobj);
>>>   =20
>>> -    memory_region_allocate_system_memory(ram, NULL, "integrator.ram",
>>> -                                         ram_size);
>>>        /* ??? On a real system the first 1Mb is mapped as SSRAM or boot=
 flash.  */
>>>        /* ??? RAM should repeat to fill physical memory space.  */
>>>        /* SDRAM at address zero*/
>>> -    memory_region_add_subregion(address_space_mem, 0, ram);
>>> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>>>        /* And again at address 0x80000000 */
>>> -    memory_region_init_alias(ram_alias, NULL, "ram.alias", ram, 0, ram=
_size);
>>> +    memory_region_init_alias(ram_alias, NULL, "ram.alias", machine->ra=
m,
>>> +                             0, ram_size);
>>>        memory_region_add_subregion(address_space_mem, 0x80000000, ram_a=
lias);
>>>   =20
>>>        dev =3D qdev_create(NULL, TYPE_INTEGRATOR_CM);
>>> @@ -660,6 +658,7 @@ static void integratorcp_machine_init(MachineClass =
*mc)
>>>        mc->init =3D integratorcp_init;
>>>        mc->ignore_memory_transaction_failures =3D true;
>>>        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
>>> +    mc->default_ram_id =3D "integrator.ram";
>>>    }
>>>   =20
>>>    DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
>>>   =20
>>
>> Looking at integratorcm_realize() this machine seems to handle at most
>> 512MiB.
>=20
> According to
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0159b/Ce=
geadbj.html
>=20
> it supports "optionally, 16 to 256MB of SDRAM plugged into the DIMM socke=
t"
> so I'm not sure that realize is valid reference here.
> (well I don't know anything about arm boards, but it probably should be
> double checked by maintainer).
>=20
> PS:
> It should not hold this series (as check wasn't there to begin with),
> I'll post a patch on top to add check once we decide to what limit it
> should be set.

This is certainly not a blocking comment (neither am I waiting for you=20
to fix this, I was just making a comment while reviewing the whole).=20
Sorry if this was not clear.


