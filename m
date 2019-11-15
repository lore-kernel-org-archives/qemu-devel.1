Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A1C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C805E20732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdvhuD5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C805E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iViJm-0005Ac-Uo
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iViI7-0004Jp-8L
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iViI4-0006yQ-LA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:34:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iViI4-0006yE-9z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573850039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/xNcdTmkcJPeynSqMWfjWiq5ARQaZ+ZdcyZVrWm5hM=;
 b=YdvhuD5jUrccYDPm8bkIwG1F5g4EYJTpmFtCBh3RSD1xWWouY6mDMAgL/664Zf9yLNqlpv
 Q32A32bh1A/cs3OtofDwCvIuv5+F1/bprwfHeEjFzkOA9psUH7SgAWdXb74X5EJwzcAx9g
 G7soFWNmC7sT3PM0hE6TW6s6Hw0YXMc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-P5PdOaP7PmKrlLfTipgaGA-1; Fri, 15 Nov 2019 15:33:56 -0500
Received: by mail-wr1-f72.google.com with SMTP id g17so8718438wru.4
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 12:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LVd/0L7Kkg11GT11i+kP3yo0t5j6ifayUNh5lfAITqo=;
 b=ND6f7D9FjzG2UjZRQlAa6EaC+JMM9cgGLXKvIaeUAfRBUs+FRrhdvDjtqe5N78EaAw
 S04k+jR7dLZ+aDUm2yxydEhUWbO8fpXcutoPR4zF7rhft882sAra8fW4xGCM7xFWK2XT
 nNq5zd7oW6q9TU1Ux4rt881Yxs9yLwxWB8smdxhI/0WxX0flNNODwepjIWxYs3cKOIWZ
 DO66+SjJM3cu/djU/x0t8E/ka3AlTQvoOl6NVI6ActVm+0KoQaDa0YS2UYoRkiJ3X6PU
 U4ky/dqSjxFDsktEr2gSKHdcVQCngJzVTIW8cZw0OESmWWs5X/QhaInmVTIoy8/LrGpq
 JtOA==
X-Gm-Message-State: APjAAAWztjmG//MI/Ua9V1EFBCRTqz2O+vKfjhDoqi9AxR7cUW6ajmF4
 JqOQM2HMvWS/yO5SHvuGo5G+BL9o39uavE8spvCQNY8wyClHULlyTJQd/YPkecy6SXTSYIf+P2Y
 /11/zDNG63FotBsc=
X-Received: by 2002:adf:f44a:: with SMTP id f10mr17547531wrp.63.1573850035593; 
 Fri, 15 Nov 2019 12:33:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpsxL7j/q/JtFqkuyG464ZN2FB57L9GJpO1g6b2uC8nNHoJkV3QxyzbmbPvv1wmF1HS5aK1A==
X-Received: by 2002:adf:f44a:: with SMTP id f10mr17547512wrp.63.1573850035411; 
 Fri, 15 Nov 2019 12:33:55 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id n17sm12205585wrp.40.2019.11.15.12.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 12:33:54 -0800 (PST)
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191115145049.26868-1-thuth@redhat.com>
 <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
 <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
 <c7c45aed-76c0-9c17-72fb-6abceb9e5ff4@redhat.com>
 <be453a76-d5fe-62c3-6954-447be7fe646a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2795653-8726-6bce-7183-2da59d70808e@redhat.com>
Date: Fri, 15 Nov 2019 21:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <be453a76-d5fe-62c3-6954-447be7fe646a@redhat.com>
Content-Language: en-US
X-MC-Unique: P5PdOaP7PmKrlLfTipgaGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 5:13 PM, Thomas Huth wrote:
> On 15/11/2019 17.13, Paolo Bonzini wrote:
>> On 15/11/19 16:54, Thomas Huth wrote:
>>> On 15/11/2019 16.54, Peter Maydell wrote:
>>>> On Fri, 15 Nov 2019 at 15:10, Thomas Huth <thuth@redhat.com> wrote:
>>>>>
>>>>> When CONFIG_IDE_ISA is disabled, compilation currently fails:
>>>>>
>>>>>   hw/i386/pc_piix.c: In function =E2=80=98pc_init1=E2=80=99:
>>>>>   hw/i386/pc_piix.c:81:9: error: unused variable =E2=80=98i=E2=80=99 =
[-Werror=3Dunused-variable]
>>>>>
>>>>> Move the variable declaration to the right code block to avoid
>>>>> this problem.
>>>>>
>>>>> Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   hw/i386/pc_piix.c | 3 +--
>>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>> index 2aefa3b8df..d187db761c 100644
>>>>> --- a/hw/i386/pc_piix.c
>>>>> +++ b/hw/i386/pc_piix.c
>>>>> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
>>>>>       X86MachineState *x86ms =3D X86_MACHINE(machine);
>>>>>       MemoryRegion *system_memory =3D get_system_memory();
>>>>>       MemoryRegion *system_io =3D get_system_io();
>>>>> -    int i;
>>>>>       PCIBus *pci_bus;
>>>>>       ISABus *isa_bus;
>>>>>       PCII440FXState *i440fx_state;
>>>>> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
>>>>>       }
>>>>>   #ifdef CONFIG_IDE_ISA
>>>>>   else {
>>>>> -        for(i =3D 0; i < MAX_IDE_BUS; i++) {
>>>>> +        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>>>>>               ISADevice *dev;
>>>>>               char busname[] =3D "ide.0";
>>>>>               dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase=
2[i],
>>>>
>>>> Don't put variable declarations inside 'for' statements,
>>>> please. They should go at the start of a {} block.
>>>
>>> Why? We're using -std=3Dgnu99 now, so this should not be an issue anymo=
re.
>>
>> For now I can squash the following while we discuss coding standards. :)

Thanks.

>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index fa62244f4d..0130b8fb4e 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -244,7 +244,8 @@ static void pc_init1(MachineState *machine,
>>       }
>>   #ifdef CONFIG_IDE_ISA
>>   else {
>> -        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>> +        int i;
>> +        for (i =3D 0; i < MAX_IDE_BUS; i++) {
>>               ISADevice *dev;
>>               char busname[] =3D "ide.0";
>>               dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i=
],
>=20
> Yes, please do. I guess we won't update CODING_STYLE.rst during the hard
> freeze anymore ;-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


