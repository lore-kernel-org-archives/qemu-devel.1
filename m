Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE1C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D04206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHxnGuTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D04206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEszL-0000SG-Nj
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEsyP-00086q-Ro
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEsyM-0002MM-Fl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:04:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEsyM-0002Jq-BY
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584615861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjwr2XVd0bXJqGU+98/wcllT+vG59QhOEWgnuJtWYS8=;
 b=BHxnGuTM+u2SKlK07k54wbZM9o18NF5409KqsLEyXczYHsup3vghluNlUBx947KozbAKhe
 z0fsyo+98j973bcqm4g+0BCzJL/FqvU+MaHJseMuTMQG91S3l9n68csbWS0xX72Xe6z5Ld
 zAmOmMvNXdrDBl+RLC1+IgvC0cHv2cc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-25X1nxaqPZ-YJs8rgP_sQA-1; Thu, 19 Mar 2020 07:04:15 -0400
X-MC-Unique: 25X1nxaqPZ-YJs8rgP_sQA-1
Received: by mail-ed1-f71.google.com with SMTP id i25so1589746edx.12
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 04:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=en1lem5CyI1N0qK751qnOKydFd+dGDJDI/z6tDdUOVs=;
 b=pyOpOl73gNQV5jTdWuYPrgDUb+CI5d52zrS5rUx1ePY9qtEMBwzfQpV6tbCef6knQ5
 U4IcBHvIxR7OrT9qV7OPHAP5F+zGWcp6Ef+n0u0l/fJIpUY9MEDnmpCdhIhwiEjtoJBn
 +cDZfWPtJJujpl/WeQCcG4CU0UGWnbCoT26TvFlbr4HsIm8Ui8BX4iTvV7FcNmFXm7Uk
 UXada6WHf5YvME3vsZz1ZnKeFwCqWTHV+20AaPN+IGr78ncKYI4d0H+r2HeKlx70DSzh
 EKCYRyFXNjjvA7c9sdPKp+49VnRkxgcr8I2BOUEdCHiQ8npt/uRv71fVzuRN35f3p3fn
 9bKw==
X-Gm-Message-State: ANhLgQ12Mspxh1jq5wxzvZT0loetxrCjncZunBUIbFFaQO9Oml+X3Oxl
 QyOMg97AtbsiTTzSQ4OOhXNLJ3s7aSOR5KIl5WhSPwyq0rbH9VxgE7mZEFQIdOa6zpZjJxZkHiv
 6AcuPwpvUfT0DPVk=
X-Received: by 2002:a17:906:2347:: with SMTP id
 m7mr2595085eja.224.1584615854407; 
 Thu, 19 Mar 2020 04:04:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvbtX4mzPuK5/eMtT6aZVUWTKMUk5GjNIAco1i+qRuFSOggXzrXVg6IWU225aykK15oKvH9aQ==
X-Received: by 2002:a17:906:2347:: with SMTP id
 m7mr2595036eja.224.1584615854124; 
 Thu, 19 Mar 2020 04:04:14 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id h24sm90613eja.38.2020.03.19.04.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 04:04:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
Date: Thu, 19 Mar 2020 12:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319114424.5723e777@office.mammed.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 11:44 AM, Igor Mammedov wrote:
> On Wed, 18 Mar 2020 23:15:30 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
>> function are not documented in the PIIX4 datasheet.
>> This appears to be a PC-only feature added in commit 5e3cb5347e
>> ("initialize hot add system / acpi gpe") which was then moved
>> to the PIIX4 device model in commit 9d5e77a22f ("make
>> qemu_system_device_hot_add piix independent")
>> Add a property (default enabled, to not modify the current
>> behavior) to allow machines wanting to model a simple PIIX4
>> to disable this feature.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> it's already pretty twisted code and adding one more knob
> to workaround other compat knobs makes it worse.
>=20
> Even though it's not really welcomed approach,
> we can ifdef all hotplug parts and compile them out for mips
> dropping along the way linking with not needed dependencies

We can't use use target-specific poisoned definitions to ifdef out in=20
generic hw/ code.

> or
> more often used, make stubs from hotplug parts for mips
> and link with them.

So the problem is this device doesn't match the hardware datasheet, has=20
extra features helping virtualization, and now we can not simplify it=20
due to backward compat.

Once Michael said he doesn't care about the PIIX4, only the PIIX3=20
southbridge [1] [2], but then the i440fx pc machine uses a PIIX3 with a=20
pci PM function from PIIX4, and made that PII4_PM Frankenstein.

You are asking me to choose between worse versus ugly?

The saner outcome I see is make the current PIIX4_PM x86-specific, not=20
modifying the code, and start a fresh new copy respecting the datasheet.

Note I'm not particularly interested in MIPS here, but having model=20
respecting the hardware.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504270.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg601512.html

>=20
>> ---
>> Should I squash this with the next patch and start with
>> default=3Dfalse, which is closer to the hardware model?
>> ---
>>   hw/acpi/piix4.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index 964d6f5990..9c970336ac 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>>  =20
>>       AcpiPciHpState acpi_pci_hotplug;
>>       bool use_acpi_pci_hotplug;
>> +    bool use_acpi_system_hotplug;
>>  =20
>>       uint8_t disable_s3;
>>       uint8_t disable_s4;
>> @@ -503,8 +504,10 @@ static void piix4_pm_realize(PCIDevice *dev, Error =
**errp)
>>       s->machine_ready.notify =3D piix4_pm_machine_ready;
>>       qemu_add_machine_init_done_notifier(&s->machine_ready);
>>  =20
>> -    piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>> -                                   pci_get_bus(dev), s);
>> +    if (s->use_acpi_system_hotplug) {
>> +        piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>> +                                       pci_get_bus(dev), s);
>> +    }
>>       qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_=
abort);
>>  =20
>>       piix4_pm_add_propeties(s);
>> @@ -635,6 +638,8 @@ static Property piix4_pm_properties[] =3D {
>>                        use_acpi_pci_hotplug, true),
>>       DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>>                        acpi_memory_hotplug.is_enabled, true),
>> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
>> +                     use_acpi_system_hotplug, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>  =20
>=20


