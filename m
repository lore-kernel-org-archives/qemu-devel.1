Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC75020674
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPmi8IyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKDP-0001p4-4o
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixKCZ-0001Dr-Q7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixKCY-0003YU-BH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:30:27 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixKCY-0003Xk-63
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:30:26 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so5597340oic.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7JXvGiTHKSnnK6E/QhWXVRTMPaI7iorbwSxiicTmTBE=;
 b=QPmi8IyMsaSkxqW0PrwebTPa2RZIHHacpcsK6vfCfN1CP+q4tO5vk42zSNvzWDqyKV
 mxWFCgXARzwzjnO5xwjcPJqoccoIb0LAms0pvIiVA8I39pHivbR4c57qWtq4zXhVCmXt
 Xbli0lZY0BOuwyOPfFtJjUrhQK6Vz/eVUx4rZqWgvueJQbglg2VBrDOLwfmSYNDK/8qz
 jWSFzgXtPFBASjA9eBeDaKa+MAuo2vgoKGeJt+rbWA6M9jFDaXF6oKDYvs3sPzlCTzRO
 qLigmKfuNoDMmTMxZPHHs7SnosWzluEXDAigwSzLX7wpe0hflKk2powKvSPyPyu07ov0
 DkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7JXvGiTHKSnnK6E/QhWXVRTMPaI7iorbwSxiicTmTBE=;
 b=iiyJ4ih8vnTpPK3YCbQnNLnemrrCAP5Tcn0xaGASoDW+I3dkPKA6KEx6QuWdOhQWc1
 +zQ+N4+DGGz431y6oFOYmPF9/DFDpMbRs2x9uKlrlQcQkshUcxOV/mdSYXMCgEP3Sf60
 RhnMCUvRfISjwju98nY+/+a8orgIrqmQdGqijFT6VmRmVc5dP4lKpk4h4j41O92fuxeb
 aRJVfeE7rIdDJ4MW2CfhOjLNHUMnxf+uCyxtfp+NNmyDDEdk1lbo1sYHoHzJJ9K5EOYZ
 z2KcGmSTiLN+CqR0qRf+7OBCKIdyhZtzQh9Mr3aAEmZZdn5TdKLPl5EjsiUPJZWUHr3l
 x2qg==
X-Gm-Message-State: APjAAAUbEAvm7lqe4BN0fmfypeWEnT7FPpcBI5A0QaI0O/bzYXgAP/Si
 KvqP0d8m+RhNRE62WEe5CGBRwRslWs73QryBdcM=
X-Google-Smtp-Source: APXvYqwfwfYYa46SCxKtuplqOatfEGQ46P+XJEaFKnfyDB0PIEl0HgChsY9bCqqIHuTQsSg5JZAY01D/urpybQnECpU=
X-Received: by 2002:aca:4ece:: with SMTP id c197mr4750846oib.53.1580430625249; 
 Thu, 30 Jan 2020 16:30:25 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <7b46b2c2-b6b0-3252-fe18-c9b803823506@redhat.com>
 <CAL1e-=gToiXtXAVxwn-Tf6ON8_87GLw=QTe8HCRhwCSMfmkVLg@mail.gmail.com>
 <0b3665a2-5ef7-ac2d-ff00-60396ff53f73@redhat.com>
In-Reply-To: <0b3665a2-5ef7-ac2d-ff00-60396ff53f73@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 01:30:14 +0100
Message-ID: <CAL1e-=iChNme9Za=qyBfnZJRRS3Xs4QeZOVjH-mzR37690SQWA@mail.gmail.com>
Subject: Re: [PATCH rc4 23/29] hw/avr: Add helper to load raw/ELF firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 1:28 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/31/20 1:26 AM, Aleksandar Markovic wrote:
> > On Fri, Jan 31, 2020 at 1:20 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> On 1/31/20 1:03 AM, Aleksandar Markovic wrote:
> >>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>
> >>> Add avr_load_firmware() function to load firmware in ELF or
> >>> raw binary format.
> >>>
> >>> [AM: Corrected the type of the variable containing e_flags]
> >>>
> >>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >>> ---
> >>>    hw/avr/Makefile.objs |  1 +
> >>>    hw/avr/boot.c        | 74 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>    hw/avr/boot.h        | 33 +++++++++++++++++++++++
> >>>    include/elf.h        |  2 ++
> >>>    4 files changed, 110 insertions(+)
> >>>    create mode 100644 hw/avr/Makefile.objs
> >>>    create mode 100644 hw/avr/boot.c
> >>>    create mode 100644 hw/avr/boot.h
> >>>
> >>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> >>> new file mode 100644
> >>> index 0000000..123f174
> >>> --- /dev/null
> >>> +++ b/hw/avr/Makefile.objs
> >>> @@ -0,0 +1 @@
> >>> +obj-y +=3D boot.o
> >>> diff --git a/hw/avr/boot.c b/hw/avr/boot.c
> >>> new file mode 100644
> >>> index 0000000..9ac2c88
> >>> --- /dev/null
> >>> +++ b/hw/avr/boot.c
> >>> @@ -0,0 +1,74 @@
> >>> +/*
> >>> + * AVR loader helpers
> >>> + *
> >>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPLv2 or later.
> >>> + * See the COPYING file in the top-level directory.
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu-common.h"
> >>> +#include "hw/loader.h"
> >>> +#include "elf.h"
> >>> +#include "boot.h"
> >>> +#include "qemu/error-report.h"
> >>> +
> >>> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> >>> +                       MemoryRegion *mr, const char *firmware)
> >>> +{
> >>> +    const char *filename;
> >>> +    int bytes_loaded;
> >>> +    uint64_t entry;
> >>> +    uint32_t e_flags;
> >>> +
> >>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> >>> +    if (filename =3D=3D NULL) {
> >>> +        error_report("Unable to find %s", firmware);
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    bytes_loaded =3D load_elf_ram_sym(filename,
> >>> +                                    NULL, NULL, NULL,
> >>> +                                    &entry, NULL, NULL,
> >>> +                                    &e_flags, 0, EM_AVR, 0, 0,
> >>> +                                    NULL, true, NULL);
> >>> +    if (bytes_loaded >=3D 0) {
> >>> +        /* If ELF file is provided, determine CPU type reading ELF e=
_flags. */
> >>> +        const char *elf_cpu =3D avr_flags_to_cpu_type(e_flags, NULL)=
;
> >>> +        const char *mcu_cpu_type =3D object_get_typename(OBJECT(cpu)=
);
> >>> +        int cpu_len =3D strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_S=
UFFIX);
> >>> +
> >>> +        if (entry) {
> >>> +            error_report("BIOS entry_point must be 0x0000 "
> >>> +                         "(ELF image '%s' has entry_point 0x%04" PRI=
x64 ")",
> >>> +                         firmware, entry);
> >>> +            return false;
> >>> +        }
> >>> +        if (!elf_cpu) {
> >>> +            warn_report("Could not determine CPU type for ELF image =
'%s', "
> >>> +                        "assuming '%.*s' CPU",
> >>> +                         firmware, cpu_len, mcu_cpu_type);
> >>> +            return true;
> >>> +        }
> >>> +        if (strcmp(elf_cpu, mcu_cpu_type)) {
> >>> +            error_report("Current machine: %s with '%.*s' CPU",
> >>> +                         MACHINE_GET_CLASS(ms)->desc, cpu_len, mcu_c=
pu_type);
> >>> +            error_report("ELF image '%s' is for '%.*s' CPU",
> >>> +                         firmware,
> >>> +                         (int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE=
_SUFFIX)),
> >>> +                         elf_cpu);
> >>> +            return false;
> >>> +        }
> >>> +    } else {
> >>> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE,
> >>> +                                           memory_region_size(mr));
> >>> +    }
> >>> +    if (bytes_loaded < 0) {
> >>> +        error_report("Unable to load firmware image %s as ELF or raw=
 binary",
> >>> +                     firmware);
> >>> +        return false;
> >>> +    }
> >>> +    return true;
> >>> +}
> >>> diff --git a/hw/avr/boot.h b/hw/avr/boot.h
> >>> new file mode 100644
> >>> index 0000000..62bc10c
> >>> --- /dev/null
> >>> +++ b/hw/avr/boot.h
> >>> @@ -0,0 +1,33 @@
> >>> +/*
> >>> + * AVR loader helpers
> >>> + *
> >>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPLv2 or later.
> >>> + * See the COPYING file in the top-level directory.
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + */
> >>> +
> >>> +#ifndef HW_AVR_BOOT_H
> >>> +#define HW_AVR_BOOT_H
> >>> +
> >>> +#include "hw/boards.h"
> >>> +#include "cpu.h"
> >>> +
> >>> +/**
> >>> + * avr_load_firmware:   load an image into a memory region
> >>> + *
> >>> + * @cpu:        Handle a AVR CPU object
> >>> + * @ms:         A MachineState
> >>> + * @mr:         Memory Region to load into
> >>> + * @firmware:   Path to the firmware file (raw binary or ELF format)
> >>> + *
> >>> + * Load a firmware supplied by the machine or by the user  with the
> >>> + * '-bios' command line option, and put it in target memory.
> >>> + *
> >>> + * Returns: true on success, false on error.
> >>> + */
> >>> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> >>> +                       MemoryRegion *mr, const char *firmware);
> >>> +
> >>> +#endif
> >>> diff --git a/include/elf.h b/include/elf.h
> >>> index 8fbfe60..3f08f68 100644
> >>> --- a/include/elf.h
> >>> +++ b/include/elf.h
> >>> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
> >>>    #define EM_MOXIE           223     /* Moxie processor family */
> >>>    #define EM_MOXIE_OLD       0xFEED
> >>>
> >>> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> >>
> >> IIRC from previous version you suggested to move this, I suppose betwe=
en:
> >>
> >> #define EM_CRIS         76
> >>
> >> #define EM_V850         87
> >>
> >
> > I forgot about that, thinking about other larger changes.
>
> Anyway looking closer, the definitions are not ordered correctly, so I
> think we don't care much. Your call :)
>

Let's not add more mess to the mess. :)

> >
> >>> +
> >>>    /* This is the info that is needed to parse the dynamic section of=
 the file */
> >>>    #define DT_NULL             0
> >>>    #define DT_NEEDED   1
> >>>
> >>
> >
>

