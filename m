Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A4C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA0220656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wl66kn0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA0220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVi0-0004vl-Mv
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipVh3-0004Jf-BU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipVh1-0003Ch-2o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:09:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipVh0-00034Z-JM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578568173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOQjcCjH+nOhPc2GrfMI+DTaEl55U6SevsG8iMlrPdI=;
 b=Wl66kn0dkuQzFJcp++MyX83SwlsxP+qrwc84WRmF2akO09YQn7RsieBPCQj9I2qrXxXhZ+
 H1HRzCh9KDH4PdOm29JXvqTWIOMgXtmygwxytrbFjTFIYNBJ8p2FAjRwFPKWZy0LuQ6FVX
 lZCRWgjAhL4TmGTtld6FS8xPMOhCjnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-ejOFn-OqMRSMhocpQ2OpOQ-1; Thu, 09 Jan 2020 06:09:29 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so346729wmi.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V8DqqOEfW4Bc3myfDpGKEJX2KCd9lYTEsCiEW9Eu0qA=;
 b=fyTNPG2LJFlMEtlFhcVBtX2VRvZ7zSwZ+TtT4d1jx5ZG6viwYydf6FTiHQrHvh8O0M
 tIZqC2Rz240KKvT1WJpilqyZjAmY9e4oQAcv5+omzOgzb9xfPtpAsxax3Lgv2Llu1QT5
 2ai8oG+wOOrsThWuupQrZPV6ypTIqDCKWcOaUu0cKD9RT206YKL/RgT3Z2Wtvc5H/2UF
 iWQoHn5o4Z0hbUfEFFKUU83EquUqeBFmzTTkAG1HNcPw4SrBtVMkia6HWOtGPJbwOprF
 NNiOsyI/AfHiF7ynDKxlgRSFr9TzLiboCDe6RUJtINVkPqrglKjkCtzMIKyjPs08INVZ
 Ikyw==
X-Gm-Message-State: APjAAAXDIsBpchozmjJh6hvXCR/cebWbdZq0th8wgChobAKabXAgFj4D
 gNBYSO/D528/C1OfYPRsORhVAzpynk1cwmda9gMV1/dLkHFqosh8Wr18UgPhkk+L5x2dcYPddli
 Xdrs5L5RUkvQRe80=
X-Received: by 2002:a7b:c407:: with SMTP id k7mr4313519wmi.46.1578568168681;
 Thu, 09 Jan 2020 03:09:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzolN1GmCrisDYT06Pc89nLdWIJvAwokIioWGlwv1A8m0yxix7Xmak1jgruC3tBJ07AZEmEA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr4313489wmi.46.1578568168462;
 Thu, 09 Jan 2020 03:09:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k8sm7653721wrl.3.2020.01.09.03.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 03:09:27 -0800 (PST)
Subject: Re: [PATCH 2/3] hw/hppa/machine: Do not limit the RAM to 3840MB
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200108181425.21485-1-f4bug@amsat.org>
 <20200108181425.21485-3-f4bug@amsat.org> <20200109111514.3ab4396a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <00d20bb2-cd8c-37fd-0709-9df1ca0d1545@redhat.com>
Date: Thu, 9 Jan 2020 12:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109111514.3ab4396a@redhat.com>
Content-Language: en-US
X-MC-Unique: ejOFn-OqMRSMhocpQ2OpOQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 11:15 AM, Igor Mammedov wrote:
> On Wed,  8 Jan 2020 19:14:24 +0100
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> The hardware expects DIMM slots of 1 or 2 GB, allowing up to
>> 4 GB of memory. Accept the same amount of memory the hardware
>> can deal with.
>>
>> The CPU doesn't have access to the RAM mapped in the
>> [0xf0000000 - 0xf1000000] range because this is the PDC area
>> (Processor Dependent Code) where the firmware is loaded.
>> To keep this region with higher priority than the RAM, lower
>> the RAM priority. The PDC will overlap it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Looks good to me (since board doesn't fix up ram_size and uses
> whatever user specified, proper support for 4Gb could be done on top late=
r).
>=20
>> ---
>>   hw/hppa/machine.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 6775d879f8..d10c967d06 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -90,16 +90,15 @@ static void machine_hppa_init(MachineState *machine)
>>           g_free(name);
>>       }
>>  =20
>> -    /* Limit main memory. */
>> -    if (ram_size > FIRMWARE_START) {
>> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
>> -    }
>> -
>>       /* Main memory region. */
>> +    if (machine->ram_size > 4 * GiB) {
> Could it break a build on 32-bit mingw host?
> (machine->ram_size is 32-bit on that host and condition would be
> always false, tripping -Werror)

By following Helge tip to restrict to 3GB, v2 of this series doesn't=20
have this problem :)

> that's why I've worked around it using local uint64_t in the last version
>   "[PATCH v3 43/86] hppa: allow max ram size upto 4Gb"
> coincidentally that would get rid of global ram_size usage
> and leave only machine->ram_size on this board.

Since I was not sure how you wanted to clean this, I haven't modified=20
it. We can add it on top but I'd rather do a whole codebase cleanup.

Note: you also need to modify hppa_machine_reset() by using ms->ram_size=20
instead.

>> +        error_report("RAM size of 4GB or more is not supported");
>> +        exit(EXIT_FAILURE);
>> +    }
>>       ram_region =3D g_new(MemoryRegion, 1);
>>       memory_region_allocate_system_memory(ram_region, OBJECT(machine),
>>                                            "ram", ram_size);
>> -    memory_region_add_subregion(addr_space, 0, ram_region);
>> +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
>>  =20
>>       /* Init Dino (PCI host bus chip).  */
>>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>=20
>=20


