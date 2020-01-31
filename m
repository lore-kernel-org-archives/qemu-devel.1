Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776FBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E04D20661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVmTwpvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKBP-0000gg-Dt
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixKAn-0000DS-Im
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixKAm-0000db-34
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:28:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixKAl-0000cX-Ve
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580430515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kx9H5ikLgbp/LUu+5SyU+/dujFkA4fQQIcT1xUdPBo=;
 b=cVmTwpvxAKmu/kTCMBKRMBb0pcus8hvWfiDKaqmelULHtuNKFZ5n65noyAV/YtPk0dE5O0
 SWiEmnsnctnBzClRVnLvfzIRv8FV2NEcinvjLHoSsyc1b4tKfF/rQ1SYfxlvBD6D1Vptx7
 dVXbZtg237Z+vRzjMHpHKShTLa/Bs5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-0PkTPGzPPImeCFDPLrJtbw-1; Thu, 30 Jan 2020 19:28:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id j13so2471516wrr.20
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cElkXJz9CFUEcc+NEP/+U6/pq2JGa/lmwB5jMJAwolg=;
 b=ctd/cbIccpHEwZCk3J1Qy3aPRHMbga8k5rLu+Iv6jeYqiTOxhOP/R5iaHzUoJkcOBD
 ig0tu6lhYsv01uZSZnuDx4hIFnyhCgQOyablAV4zuSM7TyT+hX/OAmku4fg8dsacD7lC
 uT/X9wE1jPnVapU9fr46ZtwAMq8KxDRkIwr8iAKLGiTuneKB33FtXmDWNZlxolsQeGND
 AAlBSEfs4dnZCNRBSTd9GpklF4UvlBbgsINx+DtS5bNiBXK8UUVmWAJabvYm1pA+Kfzg
 Csw7o/bSmKlfwi1/g76F/E2BQLlXZy2/CuZ+8KgkzIAhIHOBUJd4ask5BCdUI9yPbpG/
 mEzA==
X-Gm-Message-State: APjAAAUj9IkJRYf+RlkByuxMc7QHT1bk5j6V8FnsDs1HzPvCYgp/3vFV
 orDLwKQteY79HBxTRRYlT5vrhKcsJFkMwHWGcTHau2tv4I8IdUJcCdPSTSicoTcjKsYAb79/PNG
 TlDFl4iHuW5kPmCA=
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr8761195wmk.128.1580430512627; 
 Thu, 30 Jan 2020 16:28:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2b/HF0TEKd0BZKB1ZQ1eJFqB/bTqnCODqkRYgLjHz+c4a4gMarnmvrz+QTS0a2gBAGGJ9gg==
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr8761174wmk.128.1580430512326; 
 Thu, 30 Jan 2020 16:28:32 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x132sm13869736wmg.0.2020.01.30.16.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 16:28:31 -0800 (PST)
Subject: Re: [PATCH rc4 23/29] hw/avr: Add helper to load raw/ELF firmware
 binaries
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <7b46b2c2-b6b0-3252-fe18-c9b803823506@redhat.com>
 <CAL1e-=gToiXtXAVxwn-Tf6ON8_87GLw=QTe8HCRhwCSMfmkVLg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b3665a2-5ef7-ac2d-ff00-60396ff53f73@redhat.com>
Date: Fri, 31 Jan 2020 01:28:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gToiXtXAVxwn-Tf6ON8_87GLw=QTe8HCRhwCSMfmkVLg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0PkTPGzPPImeCFDPLrJtbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 1:26 AM, Aleksandar Markovic wrote:
> On Fri, Jan 31, 2020 at 1:20 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 1/31/20 1:03 AM, Aleksandar Markovic wrote:
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>> Add avr_load_firmware() function to load firmware in ELF or
>>> raw binary format.
>>>
>>> [AM: Corrected the type of the variable containing e_flags]
>>>
>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>> ---
>>>    hw/avr/Makefile.objs |  1 +
>>>    hw/avr/boot.c        | 74 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>    hw/avr/boot.h        | 33 +++++++++++++++++++++++
>>>    include/elf.h        |  2 ++
>>>    4 files changed, 110 insertions(+)
>>>    create mode 100644 hw/avr/Makefile.objs
>>>    create mode 100644 hw/avr/boot.c
>>>    create mode 100644 hw/avr/boot.h
>>>
>>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
>>> new file mode 100644
>>> index 0000000..123f174
>>> --- /dev/null
>>> +++ b/hw/avr/Makefile.objs
>>> @@ -0,0 +1 @@
>>> +obj-y +=3D boot.o
>>> diff --git a/hw/avr/boot.c b/hw/avr/boot.c
>>> new file mode 100644
>>> index 0000000..9ac2c88
>>> --- /dev/null
>>> +++ b/hw/avr/boot.c
>>> @@ -0,0 +1,74 @@
>>> +/*
>>> + * AVR loader helpers
>>> + *
>>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>>> + *
>>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu-common.h"
>>> +#include "hw/loader.h"
>>> +#include "elf.h"
>>> +#include "boot.h"
>>> +#include "qemu/error-report.h"
>>> +
>>> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
>>> +                       MemoryRegion *mr, const char *firmware)
>>> +{
>>> +    const char *filename;
>>> +    int bytes_loaded;
>>> +    uint64_t entry;
>>> +    uint32_t e_flags;
>>> +
>>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
>>> +    if (filename =3D=3D NULL) {
>>> +        error_report("Unable to find %s", firmware);
>>> +        return false;
>>> +    }
>>> +
>>> +    bytes_loaded =3D load_elf_ram_sym(filename,
>>> +                                    NULL, NULL, NULL,
>>> +                                    &entry, NULL, NULL,
>>> +                                    &e_flags, 0, EM_AVR, 0, 0,
>>> +                                    NULL, true, NULL);
>>> +    if (bytes_loaded >=3D 0) {
>>> +        /* If ELF file is provided, determine CPU type reading ELF e_f=
lags. */
>>> +        const char *elf_cpu =3D avr_flags_to_cpu_type(e_flags, NULL);
>>> +        const char *mcu_cpu_type =3D object_get_typename(OBJECT(cpu));
>>> +        int cpu_len =3D strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_SUF=
FIX);
>>> +
>>> +        if (entry) {
>>> +            error_report("BIOS entry_point must be 0x0000 "
>>> +                         "(ELF image '%s' has entry_point 0x%04" PRIx6=
4 ")",
>>> +                         firmware, entry);
>>> +            return false;
>>> +        }
>>> +        if (!elf_cpu) {
>>> +            warn_report("Could not determine CPU type for ELF image '%=
s', "
>>> +                        "assuming '%.*s' CPU",
>>> +                         firmware, cpu_len, mcu_cpu_type);
>>> +            return true;
>>> +        }
>>> +        if (strcmp(elf_cpu, mcu_cpu_type)) {
>>> +            error_report("Current machine: %s with '%.*s' CPU",
>>> +                         MACHINE_GET_CLASS(ms)->desc, cpu_len, mcu_cpu=
_type);
>>> +            error_report("ELF image '%s' is for '%.*s' CPU",
>>> +                         firmware,
>>> +                         (int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE_S=
UFFIX)),
>>> +                         elf_cpu);
>>> +            return false;
>>> +        }
>>> +    } else {
>>> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE,
>>> +                                           memory_region_size(mr));
>>> +    }
>>> +    if (bytes_loaded < 0) {
>>> +        error_report("Unable to load firmware image %s as ELF or raw b=
inary",
>>> +                     firmware);
>>> +        return false;
>>> +    }
>>> +    return true;
>>> +}
>>> diff --git a/hw/avr/boot.h b/hw/avr/boot.h
>>> new file mode 100644
>>> index 0000000..62bc10c
>>> --- /dev/null
>>> +++ b/hw/avr/boot.h
>>> @@ -0,0 +1,33 @@
>>> +/*
>>> + * AVR loader helpers
>>> + *
>>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
>>> + *
>>> + * This work is licensed under the terms of the GNU GPLv2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_AVR_BOOT_H
>>> +#define HW_AVR_BOOT_H
>>> +
>>> +#include "hw/boards.h"
>>> +#include "cpu.h"
>>> +
>>> +/**
>>> + * avr_load_firmware:   load an image into a memory region
>>> + *
>>> + * @cpu:        Handle a AVR CPU object
>>> + * @ms:         A MachineState
>>> + * @mr:         Memory Region to load into
>>> + * @firmware:   Path to the firmware file (raw binary or ELF format)
>>> + *
>>> + * Load a firmware supplied by the machine or by the user  with the
>>> + * '-bios' command line option, and put it in target memory.
>>> + *
>>> + * Returns: true on success, false on error.
>>> + */
>>> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
>>> +                       MemoryRegion *mr, const char *firmware);
>>> +
>>> +#endif
>>> diff --git a/include/elf.h b/include/elf.h
>>> index 8fbfe60..3f08f68 100644
>>> --- a/include/elf.h
>>> +++ b/include/elf.h
>>> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>>>    #define EM_MOXIE           223     /* Moxie processor family */
>>>    #define EM_MOXIE_OLD       0xFEED
>>>
>>> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
>>
>> IIRC from previous version you suggested to move this, I suppose between=
:
>>
>> #define EM_CRIS         76
>>
>> #define EM_V850         87
>>
>=20
> I forgot about that, thinking about other larger changes.

Anyway looking closer, the definitions are not ordered correctly, so I=20
think we don't care much. Your call :)

>=20
>>> +
>>>    /* This is the info that is needed to parse the dynamic section of t=
he file */
>>>    #define DT_NULL             0
>>>    #define DT_NEEDED   1
>>>
>>
>=20


