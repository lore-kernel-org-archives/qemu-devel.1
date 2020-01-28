Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B15C206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPjfVufm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWt3-0003Uv-83
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwWV1-0000hM-Qp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwWUs-0001dy-TB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:26:11 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwWUs-0001cl-DZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:26:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id 66so13141109otd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ae3YKpdS7iQ6pdBaiGhfIpz7PUE0r0PbtgypyH0nUc4=;
 b=JPjfVufmEqF7waXkwgLcE7J2LJ739lO6Q/WBPUknX8C0JGEU7ADhrbMxhiS4BzNJ1d
 HtUvtA9bfJTQJTNRgT0hFD1aGFSBWV4H4Osfydio8tqsPpqDhlHFdlzDIVlorf7ZRGVn
 WEVgMiZnu9XfKxtF3skZimqmrIvgnSPP3oYWtxytCdztnYqovtE5R/PfNX+jiNKCL6Vs
 yK04Mqtm+E3WCj3JQZLuMq103UXiYc7nGzze9d3g9P6DoAlCYUNVFgXeS+IMNEQM5PN2
 B7hmwfXnvEcYvqiOttekSFeGL48z1uBpSuBbHqT8oDiD4tCRao0CUPoAkRYAqoIc/ezW
 k5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ae3YKpdS7iQ6pdBaiGhfIpz7PUE0r0PbtgypyH0nUc4=;
 b=jWX3Jn4uzfOW0pO9WjRQKj3IMbhJRZHohOhBJ9Zn47DBN7dLfs9IDKkDtfNVpFlleq
 FdyEpb/S7JrdsDwuRZgu7mzKvEx97hUm02Y745FiSoNHiowSIk8kAWB+yekdkkPGcODG
 ENdGqTVgUsJ2o3pad/E9g9Iv3jDoe7vV5wqN1er3sYmGy8ACntdtlvaklpK0n+BCLIXV
 N7ixmw2+uDAQme3WUUN7rk+zOi9OdBSq4QWrJm+1y1F5lxoFO2aZTY0XfI5FaHk4gkSl
 eLb+7ip6HSLpQh1GdsRWuPf//bBhnLLqft69DkFcb1pQrZBqvSvJLJCUH7tUVKaGldY1
 B/pA==
X-Gm-Message-State: APjAAAXHS0T+ZIW7A4S3X4UWG5VKQI9XjVIykbSrleBgCmbzIVz/8X1V
 sV1BDR3ZBxIUxrpuGzIXC1aVAfPtjNL1vTXiVH2/BqT4
X-Google-Smtp-Source: APXvYqwr8hJXA/BdnT2RNxhNl5hSdbd0W4RS8/S9/hFMo7VTz7djKtCF742BlvLUlyVsCZii5Li1GRN8+UuPTy51okw=
X-Received: by 2002:a9d:6505:: with SMTP id i5mr16719239otl.121.1580239561105; 
 Tue, 28 Jan 2020 11:26:01 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
 <alpine.BSF.2.22.395.2001281334310.9839@zero.eik.bme.hu>
 <CAL1e-=iNBvd0eBHig==3V6Hw6tjf-A3+-QRukXeqATyvJufz8A@mail.gmail.com>
In-Reply-To: <CAL1e-=iNBvd0eBHig==3V6Hw6tjf-A3+-QRukXeqATyvJufz8A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 Jan 2020 20:25:50 +0100
Message-ID: <CAL1e-=i_NPErr=9Bag_6Ps1+5=0xAC0NKxpTnyCJVpvZ_a5veQ@mail.gmail.com>
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000b3275d059d38310c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <huth@tuxfamily.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 Michael Rolnik <mrolnik@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b3275d059d38310c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 2:27 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Tuesday, January 28, 2020, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> On Tue, 28 Jan 2020, Aleksandar Markovic wrote:
>>
>>> On Sunday, January 26, 2020, Aleksandar Markovic <
>>> aleksandar.markovic@rt-rk.com> wrote:
>>>
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>
>>>> Some platforms (like AVR) need to determine cpu type by reading
>>>> the ELF flags (field e_flags oin ELF header).
>>>>
>>>> This patch enables discovery of the content of that flag while
>>>> using following functions:
>>>>
>>>>   - load_elf()
>>>>   - load_elf_as()
>>>>   - load_elf_ram()
>>>>   - load_elf_ram_sym()
>>>>
>>>> The added argument of these functions is of type uint32_t*. It is
>>>> allowed to pass NULL as that argument, and in such case no lookup
>>>> to the field e_flags will happen, and of course, no information
>>>> will be returned to the caller.
>>>>
>>>>
Applied to MIPS queue, with some commit message corrections and fixes.


>
>>>> We plan to use this new functionality for MIPS Malta board, for
>>> detection
>>> of incompatible cpu/kernel combinations, and graceful exit (right now
>>> these
>>> combinations result in hang or crash). I would say other boards could
>>> make
>>> use of it too.
>>>
>>> For that reason, if there is no objection, I plan to select this patch
>>> for
>>> next MIPS queue.
>>>
>>
>> No objection but kind of d=C3=A9j=C3=A0 vu:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427.html
>>
>> I still think the interface of load_elf may need to be rethinked but I
>> don't know a good way.
>
>
>>
> Perhaps having only two, "in" and "out", arguments that are pointers to
> structures?
>
> Another thing that I noticed is "endian argument" that it seems everyone
> uses in a different way: 0, 1, true, false, bigendian, etc. Would c
> enumeration help? This looks to me like a time ticking bomb.
>
> Just to add that some platforms like MIPS and SPARC must load elfs of mor=
e
> than one value of EM_MACHINE (in MIPS case, EM_MIPS and EM_NANOMIPS) and
> current load_elf() interface offers only clumsy solutions/workarounds in
> these cases.
>
> Let's think about everything later on.
>
>
>>  This could be fixed in a later patch causing more code churn again
>> though, so if there's a way to fix this it might be a good opportunity n=
ow.
>> But I don't want to hold your patch series back so unless someone has a
>> good idea to avoid this situation then we have to live with it.
>>
>>
> Thank you. I will do some minor corrections for obvious unclarities and
> typos in the commit message while applying to my qieue.
>
>
>> Regards,
>> BALATON Zoltan
>>
>>
>>> Regards,
>>> Aleksandar
>>>
>>>
>>>
>>>
>>> CC: Richard Henderson <rth@twiddle.net>
>>>> CC: Peter Maydell <peter.maydell@linaro.org>
>>>> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>>>> CC: Michael Walle <michael@walle.cc>
>>>> CC: Thomas Huth <huth@tuxfamily.org>
>>>> CC: Laurent Vivier <laurent@vivier.eu>
>>>> CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>>> CC: Aurelien Jarno <aurelien@aurel32.net>
>>>> CC: Jia Liu <proljc@gmail.com>
>>>> CC: David Gibson <david@gibson.dropbear.id.au>
>>>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> CC: BALATON Zoltan <balaton@eik.bme.hu>
>>>> CC: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> CC: Thomas Huth <thuth@redhat.com>
>>>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>>>> CC: Fabien Chouteau <chouteau@adacore.com>
>>>> CC: KONRAD Frederic <frederic.konrad@adacore.com>
>>>> CC: Max Filippov <jcmvbkbc@gmail.com>
>>>>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> [PMD: Extracted from bigger patch,
>>>>       Replaced 'uint32_t *pe_flags' by 'int proc_flags']
>>>> [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
>>>>      replaced one instance of 'elf_sword' to 'elf_word',
>>>>      extended functionality to load_elf()]
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>> ---
>>>>  hw/alpha/dp264.c               |  4 ++--
>>>>  hw/arm/armv7m.c                |  2 +-
>>>>  hw/arm/boot.c                  |  2 +-
>>>>  hw/core/generic-loader.c       |  2 +-
>>>>  hw/core/loader.c               | 37
>>>> +++++++++++++++++++------------------
>>>>  hw/cris/boot.c                 |  2 +-
>>>>  hw/hppa/machine.c              |  4 ++--
>>>>  hw/i386/multiboot.c            |  2 +-
>>>>  hw/i386/x86.c                  |  2 +-
>>>>  hw/lm32/lm32_boards.c          |  4 ++--
>>>>  hw/lm32/milkymist.c            |  2 +-
>>>>  hw/m68k/an5206.c               |  2 +-
>>>>  hw/m68k/mcf5208.c              |  2 +-
>>>>  hw/m68k/q800.c                 |  2 +-
>>>>  hw/microblaze/boot.c           |  4 ++--
>>>>  hw/mips/mips_fulong2e.c        |  2 +-
>>>>  hw/mips/mips_malta.c           |  3 ++-
>>>>  hw/mips/mips_mipssim.c         |  2 +-
>>>>  hw/mips/mips_r4k.c             |  2 +-
>>>>  hw/moxie/moxiesim.c            |  2 +-
>>>>  hw/nios2/boot.c                |  4 ++--
>>>>  hw/openrisc/openrisc_sim.c     |  2 +-
>>>>  hw/pci-host/prep.c             |  3 ++-
>>>>  hw/ppc/e500.c                  |  2 +-
>>>>  hw/ppc/mac_newworld.c          |  4 ++--
>>>>  hw/ppc/mac_oldworld.c          |  4 ++--
>>>>  hw/ppc/ppc440_bamboo.c         |  2 +-
>>>>  hw/ppc/sam460ex.c              |  3 ++-
>>>>  hw/ppc/spapr.c                 |  6 +++---
>>>>  hw/ppc/virtex_ml507.c          |  2 +-
>>>>  hw/riscv/boot.c                |  4 ++--
>>>>  hw/s390x/ipl.c                 |  7 ++++---
>>>>  hw/sparc/leon3.c               |  2 +-
>>>>  hw/sparc/sun4m.c               |  4 ++--
>>>>  hw/sparc64/sun4u.c             |  5 +++--
>>>>  hw/tricore/tricore_testboard.c |  2 +-
>>>>  hw/xtensa/sim.c                |  2 +-
>>>>  hw/xtensa/xtfpga.c             |  2 +-
>>>>  include/hw/elf_ops.h           |  6 +++++-
>>>>  include/hw/loader.h            | 21 ++++++++++++---------
>>>>  40 files changed, 92 insertions(+), 79 deletions(-)
>>>>
>>>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>>>> index f2026fd..a8f9a89 100644
>>>> --- a/hw/alpha/dp264.c
>>>> +++ b/hw/alpha/dp264.c
>>>> @@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)
>>>>          exit(1);
>>>>      }
>>>>      size =3D load_elf(palcode_filename, NULL,
>>>> cpu_alpha_superpage_to_phys,
>>>> -                    NULL, &palcode_entry, &palcode_low, &palcode_high=
,
>>>> +                    NULL, &palcode_entry, &palcode_low, &palcode_high=
,
>>>> NULL,
>>>>                      0, EM_ALPHA, 0, 0);
>>>>      if (size < 0) {
>>>>          error_report("could not load palcode '%s'", palcode_filename)=
;
>>>> @@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)
>>>>          uint64_t param_offset;
>>>>
>>>>          size =3D load_elf(kernel_filename, NULL,
>>>> cpu_alpha_superpage_to_phys,
>>>> -                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>>>> +                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>>>> NULL,
>>>>                          0, EM_ALPHA, 0, 0);
>>>>          if (size < 0) {
>>>>              error_report("could not load kernel '%s'",
>>>> kernel_filename);
>>>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>>>> index 7a3c48f..e4fc9a8 100644
>>>> --- a/hw/arm/armv7m.c
>>>> +++ b/hw/arm/armv7m.c
>>>> @@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char
>>>> *kernel_filename, int mem_size)
>>>>
>>>>      if (kernel_filename) {
>>>>          image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
>>>> -                                 &entry, &lowaddr,
>>>> +                                 &entry, &lowaddr, NULL,
>>>>                                   NULL, big_endian, EM_ARM, 1, 0, as);
>>>>          if (image_size < 0) {
>>>>              image_size =3D load_image_targphys_as(kernel_filename, 0,
>>>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>>>> index 8fb4a63..0c213ca 100644
>>>> --- a/hw/arm/boot.c
>>>> +++ b/hw/arm/boot.c
>>>> @@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info
>>>> *info, uint64_t *pentry,
>>>>      }
>>>>
>>>>      ret =3D load_elf_as(info->kernel_filename, NULL, NULL, NULL,
>>>> -                      pentry, lowaddr, highaddr, big_endian,
>>>> elf_machine,
>>>> +                      pentry, lowaddr, highaddr, NULL, big_endian,
>>>> elf_machine,
>>>>                        1, data_swab, as);
>>>>      if (ret <=3D 0) {
>>>>          /* The header loaded but the image didn't */
>>>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>>>> index 4b1fc86..1e5ccb7 100644
>>>> --- a/hw/core/generic-loader.c
>>>> +++ b/hw/core/generic-loader.c
>>>> @@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *de=
v,
>>>> Error **errp)
>>>>
>>>>          if (!s->force_raw) {
>>>>              size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, N=
ULL,
>>>> NULL,
>>>> -                               big_endian, 0, 0, 0, as);
>>>> +                               NULL, big_endian, 0, 0, 0, as);
>>>>
>>>>              if (size < 0) {
>>>>                  size =3D load_uimage_as(s->file, &entry, NULL, NULL,
>>>> NULL,
>>>> NULL,
>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>> index 5099f27..d1b78f6 100644
>>>> --- a/hw/core/loader.c
>>>> +++ b/hw/core/loader.c
>>>> @@ -406,12 +406,12 @@ int load_elf(const char *filename,
>>>>               uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>               uint64_t (*translate_fn)(void *, uint64_t),
>>>>               void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -             uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -             int clear_lsb, int data_swab)
>>>> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
>>>> +             int elf_machine, int clear_lsb, int data_swab)
>>>>  {
>>>>      return load_elf_as(filename, elf_note_fn, translate_fn,
>>>> translate_opaque,
>>>> -                       pentry, lowaddr, highaddr, big_endian,
>>>> elf_machine,
>>>> -                       clear_lsb, data_swab, NULL);
>>>> +                       pentry, lowaddr, highaddr, pflags, big_endian,
>>>> +                       elf_machine, clear_lsb, data_swab, NULL);
>>>>  }
>>>>
>>>>  /* return < 0 if error, otherwise the number of bytes loaded in memor=
y
>>>> */
>>>> @@ -419,12 +419,12 @@ int load_elf_as(const char *filename,
>>>>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                  uint64_t (*translate_fn)(void *, uint64_t),
>>>>                  void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -                uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -                int clear_lsb, int data_swab, AddressSpace *as)
>>>> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
>>>> +                int elf_machine, int clear_lsb, int data_swab,
>>>> AddressSpace *as)
>>>>  {
>>>>      return load_elf_ram(filename, elf_note_fn, translate_fn,
>>>> translate_opaque,
>>>> -                        pentry, lowaddr, highaddr, big_endian,
>>>> elf_machine,
>>>> -                        clear_lsb, data_swab, as, true);
>>>> +                        pentry, lowaddr, highaddr, pflags, big_endian=
,
>>>> +                        elf_machine, clear_lsb, data_swab, as, true);
>>>>  }
>>>>
>>>>  /* return < 0 if error, otherwise the number of bytes loaded in memor=
y
>>>> */
>>>> @@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,
>>>>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                   uint64_t (*translate_fn)(void *, uint64_t),
>>>>                   void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -                 uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -                 int clear_lsb, int data_swab, AddressSpace *as,
>>>> -                 bool load_rom)
>>>> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian=
,
>>>> +                 int elf_machine, int clear_lsb, int data_swab,
>>>> +                 AddressSpace *as, bool load_rom)
>>>>  {
>>>>      return load_elf_ram_sym(filename, elf_note_fn,
>>>>                              translate_fn, translate_opaque,
>>>> -                            pentry, lowaddr, highaddr, big_endian,
>>>> +                            pentry, lowaddr, highaddr, pflags,
>>>> big_endian,
>>>>                              elf_machine, clear_lsb, data_swab, as,
>>>>                              load_rom, NULL);
>>>>  }
>>>> @@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
>>>>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>>>                       void *translate_opaque, uint64_t *pentry,
>>>> -                     uint64_t *lowaddr, uint64_t *highaddr, int
>>>> big_endian,
>>>> -                     int elf_machine, int clear_lsb, int data_swab,
>>>> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
>>>> *pflags,
>>>> +                     int big_endian, int elf_machine,
>>>> +                     int clear_lsb, int data_swab,
>>>>                       AddressSpace *as, bool load_rom, symbol_fn_t
>>>> sym_cb)
>>>>  {
>>>>      int fd, data_order, target_data_order, must_swab, ret =3D
>>>> ELF_LOAD_FAILED;
>>>> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>>>>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>>>>          ret =3D load_elf64(filename, fd, elf_note_fn,
>>>>                           translate_fn, translate_opaque, must_swab,
>>>> -                         pentry, lowaddr, highaddr, elf_machine,
>>>> clear_lsb,
>>>> -                         data_swab, as, load_rom, sym_cb);
>>>> +                         pentry, lowaddr, highaddr, pflags,
>>>> elf_machine,
>>>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>>>      } else {
>>>>          ret =3D load_elf32(filename, fd, elf_note_fn,
>>>>                           translate_fn, translate_opaque, must_swab,
>>>> -                         pentry, lowaddr, highaddr, elf_machine,
>>>> clear_lsb,
>>>> -                         data_swab, as, load_rom, sym_cb);
>>>> +                         pentry, lowaddr, highaddr, pflags,
>>>> elf_machine,
>>>> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>>>>      }
>>>>
>>>>   fail:
>>>> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
>>>> index 2d2cc0c..b8947bc 100644
>>>> --- a/hw/cris/boot.c
>>>> +++ b/hw/cris/boot.c
>>>> @@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct
>>>> cris_load_info
>>>> *li)
>>>>         devboard SDK.  */
>>>>      image_size =3D load_elf(li->image_filename, NULL,
>>>>                            translate_kernel_address, NULL,
>>>> -                          &entry, NULL, &high, 0, EM_CRIS, 0, 0);
>>>> +                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0=
);
>>>>      li->entry =3D entry;
>>>>      if (image_size < 0) {
>>>>          /* Takes a kimage from the axis devboard SDK.  */
>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>> index 5d0de26..0ab36cf 100644
>>>> --- a/hw/hppa/machine.c
>>>> +++ b/hw/hppa/machine.c
>>>> @@ -140,7 +140,7 @@ static void machine_hppa_init(MachineState *machin=
e)
>>>>      }
>>>>
>>>>      size =3D load_elf(firmware_filename, NULL, NULL, NULL,
>>>> -                    &firmware_entry, &firmware_low, &firmware_high,
>>>> +                    &firmware_entry, &firmware_low, &firmware_high,
>>>> NULL,
>>>>                      true, EM_PARISC, 0, 0);
>>>>
>>>>      /* Unfortunately, load_elf sign-extends reading elf32.  */
>>>> @@ -169,7 +169,7 @@ static void machine_hppa_init(MachineState *machin=
e)
>>>>      /* Load kernel */
>>>>      if (kernel_filename) {
>>>>          size =3D load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
>>>> -                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>>>> +                        NULL, &kernel_entry, &kernel_low, &kernel_hig=
h,
>>>> NULL,
>>>>                          true, EM_PARISC, 0, 0);
>>>>
>>>>          /* Unfortunately, load_elf sign-extends reading elf32.  */
>>>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>>>> index 9a59f95..9e7d69d 100644
>>>> --- a/hw/i386/multiboot.c
>>>> +++ b/hw/i386/multiboot.c
>>>> @@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>>>>          }
>>>>
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> &elf_entry,
>>>> -                               &elf_low, &elf_high, 0,
>>>> I386_ELF_MACHINE,
>>>> +                               &elf_low, &elf_high, NULL, 0,
>>>> I386_ELF_MACHINE,
>>>>                                 0, 0);
>>>>          if (kernel_size < 0) {
>>>>              error_report("Error while loading elf kernel");
>>>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>>>> index 9b9a4d5..7f38e6b 100644
>>>> --- a/hw/i386/x86.c
>>>> +++ b/hw/i386/x86.c
>>>> @@ -413,7 +413,7 @@ static bool load_elfboot(const char
>>>> *kernel_filename,
>>>>      uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
>>>>      kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
>>>>                             NULL, &elf_note_type, &elf_entry,
>>>> -                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
>>>> +                           &elf_low, &elf_high, NULL, 0,
>>>> I386_ELF_MACHINE,
>>>>                             0, 0);
>>>>
>>>>      if (kernel_size < 0) {
>>>> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
>>>> index 5ae308b..d1894ad 100644
>>>> --- a/hw/lm32/lm32_boards.c
>>>> +++ b/hw/lm32/lm32_boards.c
>>>> @@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)
>>>>          int kernel_size;
>>>>
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, NULL, NULL,
>>>> +                               &entry, NULL, NULL, NULL,
>>>>                                 1, EM_LATTICEMICO32, 0, 0);
>>>>          reset_info->bootstrap_pc =3D entry;
>>>>
>>>> @@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machin=
e)
>>>>          int kernel_size;
>>>>
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, NULL, NULL,
>>>> +                               &entry, NULL, NULL, NULL,
>>>>                                 1, EM_LATTICEMICO32, 0, 0);
>>>>          reset_info->bootstrap_pc =3D entry;
>>>>
>>>> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
>>>> index 460d322..6d46134 100644
>>>> --- a/hw/lm32/milkymist.c
>>>> +++ b/hw/lm32/milkymist.c
>>>> @@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)
>>>>
>>>>          /* Boots a kernel elf binary.  */
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, NULL, NULL,
>>>> +                               &entry, NULL, NULL, NULL,
>>>>                                 1, EM_LATTICEMICO32, 0, 0);
>>>>          reset_info->bootstrap_pc =3D entry;
>>>>
>>>> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
>>>> index 54ccbe1..bed43a9 100644
>>>> --- a/hw/m68k/an5206.c
>>>> +++ b/hw/m68k/an5206.c
>>>> @@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)
>>>>      }
>>>>
>>>>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> &elf_entry,
>>>> -                           NULL, NULL, 1, EM_68K, 0, 0);
>>>> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>>>>      entry =3D elf_entry;
>>>>      if (kernel_size < 0) {
>>>>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NU=
LL,
>>>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>>>> index 158c5e4..a999c21 100644
>>>> --- a/hw/m68k/mcf5208.c
>>>> +++ b/hw/m68k/mcf5208.c
>>>> @@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)
>>>>      }
>>>>
>>>>      kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> &elf_entry,
>>>> -                           NULL, NULL, 1, EM_68K, 0, 0);
>>>> +                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
>>>>      entry =3D elf_entry;
>>>>      if (kernel_size < 0) {
>>>>          kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NU=
LL,
>>>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>>>> index 12491ec..1e32363 100644
>>>> --- a/hw/m68k/q800.c
>>>> +++ b/hw/m68k/q800.c
>>>> @@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)
>>>>      if (linux_boot) {
>>>>          uint64_t high;
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &elf_entry, NULL, &high, 1,
>>>> +                               &elf_entry, NULL, &high, NULL, 1,
>>>>                                 EM_68K, 0, 0);
>>>>          if (kernel_size < 0) {
>>>>              error_report("could not load kernel '%s'",
>>>> kernel_filename);
>>>> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
>>>> index d1d7dfb..925e3f7 100644
>>>> --- a/hw/microblaze/boot.c
>>>> +++ b/hw/microblaze/boot.c
>>>> @@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu,
>>>> hwaddr ddr_base,
>>>>
>>>>          /* Boots a kernel elf binary.  */
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, &low, &high,
>>>> +                               &entry, &low, &high, NULL,
>>>>                                 big_endian, EM_MICROBLAZE, 0, 0);
>>>>          base32 =3D entry;
>>>>          if (base32 =3D=3D 0xc0000000) {
>>>>              kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                     translate_kernel_address, NULL,
>>>> -                                   &entry, NULL, NULL,
>>>> +                                   &entry, NULL, NULL, NULL,
>>>>                                     big_endian, EM_MICROBLAZE, 0, 0);
>>>>          }
>>>>          /* Always boot into physical ram.  */
>>>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>>>> index 9eaa6e2..2e043cb 100644
>>>> --- a/hw/mips/mips_fulong2e.c
>>>> +++ b/hw/mips/mips_fulong2e.c
>>>> @@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)
>>>>                             cpu_mips_kseg0_to_phys, NULL,
>>>>                             (uint64_t *)&kernel_entry,
>>>>                             (uint64_t *)&kernel_low, (uint64_t
>>>> *)&kernel_high,
>>>> -                           0, EM_MIPS, 1, 0);
>>>> +                           NULL, 0, EM_MIPS, 1, 0);
>>>>      if (kernel_size < 0) {
>>>>          error_report("could not load kernel '%s': %s",
>>>>                       loaderparams.kernel_filename,
>>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>>> index 5aaeaa8..34b76bb 100644
>>>> --- a/hw/mips/mips_malta.c
>>>> +++ b/hw/mips/mips_malta.c
>>>> @@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)
>>>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>>>                             cpu_mips_kseg0_to_phys, NULL,
>>>>                             (uint64_t *)&kernel_entry, NULL,
>>>> -                           (uint64_t *)&kernel_high, big_endian,
>>>> EM_MIPS,
>>>> 1, 0);
>>>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>>>> EM_MIPS,
>>>> +                           1, 0);
>>>>      if (kernel_size < 0) {
>>>>          error_report("could not load kernel '%s': %s",
>>>>                       loaderparams.kernel_filename,
>>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>>>> index 84c03dd..b934ca9 100644
>>>> --- a/hw/mips/mips_mipssim.c
>>>> +++ b/hw/mips/mips_mipssim.c
>>>> @@ -74,7 +74,7 @@ static int64_t load_kernel(void)
>>>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>>>                             cpu_mips_kseg0_to_phys, NULL,
>>>>                             (uint64_t *)&entry, NULL,
>>>> -                           (uint64_t *)&kernel_high, big_endian,
>>>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>>>>                             EM_MIPS, 1, 0);
>>>>      if (kernel_size >=3D 0) {
>>>>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
>>>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>>>> index fd926a3..b2aec43 100644
>>>> --- a/hw/mips/mips_r4k.c
>>>> +++ b/hw/mips/mips_r4k.c
>>>> @@ -98,7 +98,7 @@ static int64_t load_kernel(void)
>>>>      kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
>>>>                             cpu_mips_kseg0_to_phys, NULL,
>>>>                             (uint64_t *)&entry, NULL,
>>>> -                           (uint64_t *)&kernel_high, big_endian,
>>>> +                           (uint64_t *)&kernel_high, NULL, big_endian=
,
>>>>                             EM_MIPS, 1, 0);
>>>>      if (kernel_size >=3D 0) {
>>>>          if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
>>>> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
>>>> index 57af1b4..1d06e39 100644
>>>> --- a/hw/moxie/moxiesim.c
>>>> +++ b/hw/moxie/moxiesim.c
>>>> @@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams
>>>> *loader_params)
>>>>      ram_addr_t initrd_offset;
>>>>
>>>>      kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, N=
ULL,
>>>> NULL,
>>>> -                           &entry, &kernel_low, &kernel_high, 1,
>>>> EM_MOXIE,
>>>> +                           &entry, &kernel_low, &kernel_high, NULL, 1=
,
>>>> EM_MOXIE,
>>>>                             0, 0);
>>>>
>>>>      if (kernel_size <=3D 0) {
>>>> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
>>>> index d78bc9e..46b8349 100644
>>>> --- a/hw/nios2/boot.c
>>>> +++ b/hw/nios2/boot.c
>>>> @@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr
>>>> ddr_base,
>>>>
>>>>          /* Boots a kernel elf binary. */
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, &low, &high,
>>>> +                               &entry, &low, &high, NULL,
>>>>                                 big_endian, EM_ALTERA_NIOS2, 0, 0);
>>>>          if ((uint32_t)entry =3D=3D 0xc0000000) {
>>>>              /*
>>>> @@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr
>>>> ddr_base,
>>>>               */
>>>>              kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                     translate_kernel_address, NULL,
>>>> -                                   &entry, NULL, NULL,
>>>> +                                   &entry, NULL, NULL, NULL,
>>>>                                     big_endian, EM_ALTERA_NIOS2, 0, 0)=
;
>>>>              boot_info.bootstrap_pc =3D ddr_base + 0xc0000000 +
>>>>                  (entry & 0x07ffffff);
>>>> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
>>>> index 79e7049..ad53712 100644
>>>> --- a/hw/openrisc/openrisc_sim.c
>>>> +++ b/hw/openrisc/openrisc_sim.c
>>>> @@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size=
,
>>>>
>>>>      if (kernel_filename && !qtest_enabled()) {
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &elf_entry, NULL, NULL, 1, EM_OPENRISC=
,
>>>> +                               &elf_entry, NULL, NULL, NULL, 1,
>>>> EM_OPENRISC,
>>>>                                 1, 0);
>>>>          entry =3D elf_entry;
>>>>          if (kernel_size < 0) {
>>>> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
>>>> index afa136d..fcf6235 100644
>>>> --- a/hw/pci-host/prep.c
>>>> +++ b/hw/pci-host/prep.c
>>>> @@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error
>>>> **errp)
>>>>          if (filename) {
>>>>              if (s->elf_machine !=3D EM_NONE) {
>>>>                  bios_size =3D load_elf(filename, NULL, NULL, NULL, NU=
LL,
>>>> -                                     NULL, NULL, 1, s->elf_machine, 0=
,
>>>> 0);
>>>> +                                     NULL, NULL, NULL, 1,
>>>> s->elf_machine,
>>>> +                                     0, 0);
>>>>              }
>>>>              if (bios_size < 0) {
>>>>                  bios_size =3D get_image_size(filename);
>>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>>> index 12b6a5b..886442e 100644
>>>> --- a/hw/ppc/e500.c
>>>> +++ b/hw/ppc/e500.c
>>>> @@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)
>>>>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
>>>>
>>>>      payload_size =3D load_elf(filename, NULL, NULL, NULL,
>>>> -                            &bios_entry, &loadaddr, NULL,
>>>> +                            &bios_entry, &loadaddr, NULL, NULL,
>>>>                              1, PPC_ELF_MACHINE, 0, 0);
>>>>      if (payload_size < 0) {
>>>>          /*
>>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>>> index 3594517..464d012 100644
>>>> --- a/hw/ppc/mac_newworld.c
>>>> +++ b/hw/ppc/mac_newworld.c
>>>> @@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)
>>>>      /* Load OpenBIOS (ELF) */
>>>>      if (filename) {
>>>>          bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
>>>> -                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>>>> +                             NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0,
>>>> 0);
>>>>
>>>>          g_free(filename);
>>>>      } else {
>>>> @@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)
>>>>
>>>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                 translate_kernel_address, NULL,
>>>> -                               NULL, &lowaddr, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>> +                               NULL, &lowaddr, NULL, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>>                                 0, 0);
>>>>          if (kernel_size < 0)
>>>>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>>>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>>>> index 0fa680b..7318d7e 100644
>>>> --- a/hw/ppc/mac_oldworld.c
>>>> +++ b/hw/ppc/mac_oldworld.c
>>>> @@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
>>>>
>>>>      /* Load OpenBIOS (ELF) */
>>>>      if (filename) {
>>>> -        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, N=
ULL,
>>>> +        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, N=
ULL,
>>>> NULL,
>>>>                               1, PPC_ELF_MACHINE, 0, 0);
>>>>          g_free(filename);
>>>>      } else {
>>>> @@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
>>>>          kernel_base =3D KERNEL_LOAD_ADDR;
>>>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                 translate_kernel_address, NULL,
>>>> -                               NULL, &lowaddr, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>> +                               NULL, &lowaddr, NULL, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>>                                 0, 0);
>>>>          if (kernel_size < 0)
>>>>              kernel_size =3D load_aout(kernel_filename, kernel_base,
>>>> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
>>>> index b782641..da777ef 100644
>>>> --- a/hw/ppc/ppc440_bamboo.c
>>>> +++ b/hw/ppc/ppc440_bamboo.c
>>>> @@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)
>>>>                                NULL, NULL);
>>>>          if (success < 0) {
>>>>              success =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> &elf_entry,
>>>> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE=
,
>>>> +                               &elf_lowaddr, NULL, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>>                                 0, 0);
>>>>              entry =3D elf_entry;
>>>>              loadaddr =3D elf_lowaddr;
>>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>>> index 437e214..89bc70e 100644
>>>> --- a/hw/ppc/sam460ex.c
>>>> +++ b/hw/ppc/sam460ex.c
>>>> @@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)
>>>>
>>>>              success =3D load_elf(machine->kernel_filename, NULL,
>>>>                                 NULL, NULL, &elf_entry,
>>>> -                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE=
,
>>>> 0,
>>>> 0);
>>>> +                               &elf_lowaddr, NULL, NULL, 1,
>>>> PPC_ELF_MACHINE, 0,
>>>> +                               0);
>>>>              entry =3D elf_entry;
>>>>              loadaddr =3D elf_lowaddr;
>>>>          }
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 02cf53f..a0076e5 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState
>>>> *machine)
>>>>
>>>>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                        translate_kernel_address, NULL,
>>>> -                                      NULL, &lowaddr, NULL, 1,
>>>> +                                      NULL, &lowaddr, NULL, NULL, 1,
>>>>                                        PPC_ELF_MACHINE, 0, 0);
>>>>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>>>>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                            translate_kernel_address,
>>>> NULL,
>>>> NULL,
>>>> -                                          &lowaddr, NULL, 0,
>>>> PPC_ELF_MACHINE,
>>>> -                                          0, 0);
>>>> +                                          &lowaddr, NULL, NULL, 0,
>>>> +                                          PPC_ELF_MACHINE, 0, 0);
>>>>              spapr->kernel_le =3D spapr->kernel_size > 0;
>>>>          }
>>>>          if (spapr->kernel_size < 0) {
>>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>>> index 6862552..7526947 100644
>>>> --- a/hw/ppc/virtex_ml507.c
>>>> +++ b/hw/ppc/virtex_ml507.c
>>>> @@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)
>>>>
>>>>          /* Boots a kernel elf binary.  */
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, &low, &high, 1, PPC_ELF_MACHIN=
E,
>>>> +                               &entry, &low, &high, NULL, 1,
>>>> PPC_ELF_MACHINE,
>>>>                                 0, 0);
>>>>          boot_info.bootstrap_pc =3D entry & 0x00ffffff;
>>>>
>>>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>>>> index 027303d..b8e7652 100644
>>>> --- a/hw/riscv/boot.c
>>>> +++ b/hw/riscv/boot.c
>>>> @@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char
>>>> *firmware_filename,
>>>>      uint64_t firmware_entry, firmware_start, firmware_end;
>>>>
>>>>      if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry=
,
>>>> -                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) >
>>>> 0) {
>>>> +                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1=
,
>>>> 0)
>>>>
>>>>> 0) {
>>>>>
>>>>          return firmware_entry;
>>>>      }
>>>>
>>>> @@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char
>>>> *kernel_filename, symbol_fn_t sym_cb)
>>>>      uint64_t kernel_entry, kernel_high;
>>>>
>>>>      if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
>>>> -                         &kernel_entry, NULL, &kernel_high, 0,
>>>> +                         &kernel_entry, NULL, &kernel_high, NULL, 0,
>>>>                           EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>>>>          return kernel_entry;
>>>>      }
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index ca544d6..49506e4 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or
>>>> **errp)
>>>>
>>>>          bios_size =3D load_elf(bios_filename, NULL,
>>>>                               bios_translate_addr, &fwbase,
>>>> -                             &ipl->bios_start_addr, NULL, NULL, 1,
>>>> +                             &ipl->bios_start_addr, NULL, NULL, NULL,
>>>> 1,
>>>>                               EM_S390, 0, 0);
>>>>          if (bios_size > 0) {
>>>>              /* Adjust ELF start address to final location */
>>>> @@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or
>>>> **errp)
>>>>      if (ipl->kernel) {
>>>>          kernel_size =3D load_elf(ipl->kernel, NULL, NULL, NULL,
>>>>                                 &pentry, NULL,
>>>> -                               NULL, 1, EM_S390, 0, 0);
>>>> +                               NULL, NULL, 1, EM_S390, 0, 0);
>>>>          if (kernel_size < 0) {
>>>>              kernel_size =3D load_image_targphys(ipl->kernel, 0,
>>>> ram_size);
>>>>              if (kernel_size < 0) {
>>>> @@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)
>>>>
>>>>      img_size =3D load_elf_ram(netboot_filename, NULL, NULL, NULL,
>>>>                              &ipl->start_addr,
>>>> -                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false=
);
>>>> +                            NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,
>>>> +                            false);
>>>>
>>>>      if (img_size < 0) {
>>>>          img_size =3D load_image_size(netboot_filename, ram_ptr,
>>>> ram_size);
>>>> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
>>>> index 8038887..f5a087d 100644
>>>> --- a/hw/sparc/leon3.c
>>>> +++ b/hw/sparc/leon3.c
>>>> @@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState
>>>> *machine)
>>>>          uint64_t entry;
>>>>
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> -                               &entry, NULL, NULL,
>>>> +                               &entry, NULL, NULL, NULL,
>>>>                                 1 /* big endian */, EM_SPARC, 0, 0);
>>>>          if (kernel_size < 0) {
>>>>              kernel_size =3D load_uimage(kernel_filename, NULL, &entry=
,
>>>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>>>> index 2aaa5bf..d404353 100644
>>>> --- a/hw/sparc/sun4m.c
>>>> +++ b/hw/sparc/sun4m.c
>>>> @@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char
>>>> *kernel_filename,
>>>>  #endif
>>>>          kernel_size =3D load_elf(kernel_filename, NULL,
>>>>                                 translate_kernel_address, NULL,
>>>> -                               NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>>>> +                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0=
,
>>>> 0);
>>>>          if (kernel_size < 0)
>>>>              kernel_size =3D load_aout(kernel_filename, KERNEL_LOAD_AD=
DR,
>>>>                                      RAM_size - KERNEL_LOAD_ADDR,
>>>> bswap_needed,
>>>> @@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char
>>>> *bios_name)
>>>>      if (filename) {
>>>>          ret =3D load_elf(filename, NULL,
>>>>                         translate_prom_address, &addr, NULL,
>>>> -                       NULL, NULL, 1, EM_SPARC, 0, 0);
>>>> +                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
>>>>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>>>>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX=
);
>>>>          }
>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>> index 9550827..c746040 100644
>>>> --- a/hw/sparc64/sun4u.c
>>>> +++ b/hw/sparc64/sun4u.c
>>>> @@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char
>>>> *kernel_filename,
>>>>          bswap_needed =3D 0;
>>>>  #endif
>>>>          kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
>>>> kernel_entry,
>>>> -                               kernel_addr, &kernel_top, 1, EM_SPARCV=
9,
>>>> 0, 0);
>>>> +                               kernel_addr, &kernel_top, NULL, 1,
>>>> EM_SPARCV9, 0,
>>>> +                               0);
>>>>          if (kernel_size < 0) {
>>>>              *kernel_addr =3D KERNEL_LOAD_ADDR;
>>>>              *kernel_entry =3D KERNEL_LOAD_ADDR;
>>>> @@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char
>>>> *bios_name)
>>>>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>>>      if (filename) {
>>>>          ret =3D load_elf(filename, NULL, translate_prom_address, &add=
r,
>>>> -                       NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>>>> +                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
>>>>          if (ret < 0 || ret > PROM_SIZE_MAX) {
>>>>              ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX=
);
>>>>          }
>>>> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_
>>>> testboard.c
>>>> index aef3289..20c9ccb 100644
>>>> --- a/hw/tricore/tricore_testboard.c
>>>> +++ b/hw/tricore/tricore_testboard.c
>>>> @@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env=
)
>>>>
>>>>      kernel_size =3D load_elf(tricoretb_binfo.kernel_filename, NULL,
>>>>                             NULL, NULL, &entry, NULL,
>>>> -                           NULL, 0,
>>>> +                           NULL, NULL, 0,
>>>>                             EM_TRICORE, 1, 0);
>>>>      if (kernel_size <=3D 0) {
>>>>          error_report("no kernel file '%s'",
>>>> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
>>>> index a22743a..aeb46d8 100644
>>>> --- a/hw/xtensa/sim.c
>>>> +++ b/hw/xtensa/sim.c
>>>> @@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu,
>>>> MachineState *machine)
>>>>          uint64_t elf_entry;
>>>>          uint64_t elf_lowaddr;
>>>>          int success =3D load_elf(kernel_filename, NULL,
>>>> translate_phys_addr, cpu,
>>>> -                               &elf_entry, &elf_lowaddr, NULL,
>>>> big_endian,
>>>> +                               &elf_entry, &elf_lowaddr, NULL, NULL,
>>>> big_endian,
>>>>                                 EM_XTENSA, 0, 0);
>>>>
>>>>          if (success > 0) {
>>>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>>>> index 8220c7a..8e2dd13 100644
>>>> --- a/hw/xtensa/xtfpga.c
>>>> +++ b/hw/xtensa/xtfpga.c
>>>> @@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc
>>>> *board,
>>>> MachineState *machine)
>>>>          uint64_t elf_entry;
>>>>          uint64_t elf_lowaddr;
>>>>          int success =3D load_elf(kernel_filename, NULL,
>>>> translate_phys_addr, cpu,
>>>> -                &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
>>>> +                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, =
0,
>>>> 0);
>>>>          if (success > 0) {
>>>>              entry_point =3D elf_entry;
>>>>          } else {
>>>> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>>>> index e07d276..a1411bf 100644
>>>> --- a/include/hw/elf_ops.h
>>>> +++ b/include/hw/elf_ops.h
>>>> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, in=
t
>>>> fd,
>>>>                                void *translate_opaque,
>>>>                                int must_swab, uint64_t *pentry,
>>>>                                uint64_t *lowaddr, uint64_t *highaddr,
>>>> -                              int elf_machine, int clear_lsb, int
>>>> data_swab,
>>>> +                              uint32_t *pflags, int elf_machine,
>>>> +                              int clear_lsb, int data_swab,
>>>>                                AddressSpace *as, bool load_rom,
>>>>                                symbol_fn_t sym_cb)
>>>>  {
>>>> @@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, in=
t
>>>> fd,
>>>>              }
>>>>      }
>>>>
>>>> +    if (pflags) {
>>>> +        *pflags =3D (elf_word)ehdr.e_flags;
>>>> +    }
>>>>      if (pentry)
>>>>          *pentry =3D (uint64_t)(elf_sword)ehdr.e_entry;
>>>>
>>>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>>>> index 48a96cd..a9eeea3 100644
>>>> --- a/include/hw/loader.h
>>>> +++ b/include/hw/loader.h
>>>> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>>>>   * @pentry: Populated with program entry point. Ignored if NULL.
>>>>   * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>>>>   * @highaddr: Populated with highest loaded address. Ignored if NULL.
>>>> + * @pflags: Populated with ELF processor-specific flags. Ignore if
>>>> NULL.
>>>>   * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>>>>   * @elf_machine: Expected ELF machine type
>>>>   * @clear_lsb: Set to mask off LSB of addresses (Some architectures u=
se
>>>> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>>>>                       uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                       uint64_t (*translate_fn)(void *, uint64_t),
>>>>                       void *translate_opaque, uint64_t *pentry,
>>>> -                     uint64_t *lowaddr, uint64_t *highaddr, int
>>>> big_endian,
>>>> -                     int elf_machine, int clear_lsb, int data_swab,
>>>> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t
>>>> *pflags,
>>>> +                     int big_endian, int elf_machine,
>>>> +                     int clear_lsb, int data_swab,
>>>>                       AddressSpace *as, bool load_rom, symbol_fn_t
>>>> sym_cb);
>>>>
>>>>  /** load_elf_ram:
>>>> @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
>>>>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                   uint64_t (*translate_fn)(void *, uint64_t),
>>>>                   void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -                 uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -                 int clear_lsb, int data_swab, AddressSpace *as,
>>>> -                 bool load_rom);
>>>> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian=
,
>>>> +                 int elf_machine, int clear_lsb, int data_swab,
>>>> +                 AddressSpace *as, bool load_rom);
>>>>
>>>>  /** load_elf_as:
>>>>   * Same as load_elf_ram(), but always loads the elf as ROM
>>>> @@ -154,8 +156,9 @@ int load_elf_as(const char *filename,
>>>>                  uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>                  uint64_t (*translate_fn)(void *, uint64_t),
>>>>                  void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -                uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -                int clear_lsb, int data_swab, AddressSpace *as);
>>>> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
>>>> +                int elf_machine, int clear_lsb, int data_swab,
>>>> +                AddressSpace *as);
>>>>
>>>>  /** load_elf:
>>>>   * Same as load_elf_as(), but doesn't allow the caller to specify an
>>>> @@ -165,8 +168,8 @@ int load_elf(const char *filename,
>>>>               uint64_t (*elf_note_fn)(void *, void *, bool),
>>>>               uint64_t (*translate_fn)(void *, uint64_t),
>>>>               void *translate_opaque, uint64_t *pentry, uint64_t
>>>> *lowaddr,
>>>> -             uint64_t *highaddr, int big_endian, int elf_machine,
>>>> -             int clear_lsb, int data_swab);
>>>> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
>>>> +             int elf_machine, int clear_lsb, int data_swab);
>>>>
>>>>  /** load_elf_hdr:
>>>>   * @filename: Path of ELF file
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>>
>>>>

--000000000000b3275d059d38310c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 28, 2020 at 2:27 PM Aleks=
andar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksanda=
r.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br><br>On Tuesday, January 28, 2020, BALATON Zoltan &lt;=
<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu<=
/a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue,=
 28 Jan 2020, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On Sunday, January 26, 2020, Aleksandar Markovic &lt;<br>
<a href=3D"mailto:aleksandar.markovic@rt-rk.com" target=3D"_blank">aleksand=
ar.markovic@rt-rk.com</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" ta=
rget=3D"_blank">f4bug@amsat.org</a>&gt;<br>
<br>
Some platforms (like AVR) need to determine cpu type by reading<br>
the ELF flags (field e_flags oin ELF header).<br>
<br>
This patch enables discovery of the content of that flag while<br>
using following functions:<br>
<br>
=C2=A0 - load_elf()<br>
=C2=A0 - load_elf_as()<br>
=C2=A0 - load_elf_ram()<br>
=C2=A0 - load_elf_ram_sym()<br>
<br>
The added argument of these functions is of type uint32_t*. It is<br>
allowed to pass NULL as that argument, and in such case no lookup<br>
to the field e_flags will happen, and of course, no information<br>
will be returned to the caller.<br>
<br></blockquote></blockquote></blockquote></blockquote><div><br></div><div=
>Applied to MIPS queue, with some commit message corrections and fixes.<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote>
We plan to use this new functionality for MIPS Malta board, for detection<b=
r>
of incompatible cpu/kernel combinations, and graceful exit (right now these=
<br>
combinations result in hang or crash). I would say other boards could make<=
br>
use of it too.<br>
<br>
For that reason, if there is no objection, I plan to select this patch for<=
br>
next MIPS queue.<br>
</blockquote>
<br>
No objection but kind of d=C3=A9j=C3=A0 vu:<br>
<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg0342=
7.html" target=3D"_blank">https://lists.nongnu.org/archive/html/qemu-devel/=
2019-01/msg03427.html</a><br>
<br>
I still think the interface of load_elf may need to be rethinked but I don&=
#39;t know a good way.</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br></blockquote><div><br></div><div>Perhaps having only two, &q=
uot;in&quot; and &quot;out&quot;, arguments that are pointers to structures=
?</div><div><br></div><div>Another thing that I noticed is &quot;endian arg=
ument&quot; that it seems everyone uses in a different way: 0, 1, true, fal=
se, bigendian, etc. Would c enumeration help? This looks to me like a time =
ticking bomb.</div><div><br></div><div>Just to add that some platforms like=
 MIPS and SPARC must load elfs of more than one value of EM_MACHINE (in MIP=
S case, EM_MIPS and EM_NANOMIPS) and current load_elf() interface offers on=
ly clumsy solutions/workarounds in these cases.</div><div><br></div><div>Le=
t&#39;s think about everything later on.</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br></blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">=C2=A0This could be fixed in a later patch caus=
ing more code churn again though, so if there&#39;s a way to fix this it mi=
ght be a good opportunity now. But I don&#39;t want to hold your patch seri=
es back so unless someone has a good idea to avoid this situation then we h=
ave to live with it.<br>
<br></blockquote><div><br></div><div>Thank you. I will do some minor correc=
tions for obvious unclarities and typos in the commit message while applyin=
g to my qieue.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
Regards,<br>
BALATON Zoltan<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Aleksandar<br>
<br>
<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
CC: Richard Henderson &lt;<a href=3D"mailto:rth@twiddle.net" target=3D"_bla=
nk">rth@twiddle.net</a>&gt;<br>
CC: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank">peter.maydell@linaro.org</a>&gt;<br>
CC: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" targe=
t=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
CC: Michael Walle &lt;michael@walle.cc&gt;<br>
CC: Thomas Huth &lt;<a href=3D"mailto:huth@tuxfamily.org" target=3D"_blank"=
>huth@tuxfamily.org</a>&gt;<br>
CC: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blan=
k">laurent@vivier.eu</a>&gt;<br>
CC: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" targ=
et=3D"_blank">f4bug@amsat.org</a>&gt;<br>
CC: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com" ta=
rget=3D"_blank">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
CC: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" target=3D"_b=
lank">aurelien@aurel32.net</a>&gt;<br>
CC: Jia Liu &lt;<a href=3D"mailto:proljc@gmail.com" target=3D"_blank">prolj=
c@gmail.com</a>&gt;<br>
CC: David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au" target=
=3D"_blank">david@gibson.dropbear.id.au</a>&gt;<br>
CC: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" t=
arget=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
CC: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_bla=
nk">balaton@eik.bme.hu</a>&gt;<br>
CC: Christian Borntraeger &lt;<a href=3D"mailto:borntraeger@de.ibm.com" tar=
get=3D"_blank">borntraeger@de.ibm.com</a>&gt;<br>
CC: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">t=
huth@redhat.com</a>&gt;<br>
CC: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_=
blank">atar4qemu@gmail.com</a>&gt;<br>
CC: Fabien Chouteau &lt;<a href=3D"mailto:chouteau@adacore.com" target=3D"_=
blank">chouteau@adacore.com</a>&gt;<br>
CC: KONRAD Frederic &lt;<a href=3D"mailto:frederic.konrad@adacore.com" targ=
et=3D"_blank">frederic.konrad@adacore.com</a>&gt;<br>
CC: Max Filippov &lt;<a href=3D"mailto:jcmvbkbc@gmail.com" target=3D"_blank=
">jcmvbkbc@gmail.com</a>&gt;<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
[PMD: Extracted from bigger patch,<br>
=C2=A0 =C2=A0 =C2=A0 Replaced &#39;uint32_t *pe_flags&#39; by &#39;int proc=
_flags&#39;]<br>
[AM: Replaced &#39;int proc_flags&#39; with &#39;uint32_t *pflags&#39;,<br>
=C2=A0 =C2=A0 =C2=A0replaced one instance of &#39;elf_sword&#39; to &#39;el=
f_word&#39;,<br>
=C2=A0 =C2=A0 =C2=A0extended functionality to load_elf()]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/alpha/dp264.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++--<br>
=C2=A0hw/arm/armv7m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0hw/arm/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/core/generic-loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 37 +++++++++++++++++++------------------<br>
=C2=A0hw/cris/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/hppa/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 ++--<br>
=C2=A0hw/i386/multiboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A0hw/i386/x86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/lm32/lm32_boards.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++-=
-<br>
=C2=A0hw/lm32/milkymist.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A0hw/m68k/an5206.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
=C2=A0hw/m68k/mcf5208.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A0hw/m68k/q800.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/microblaze/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
4 ++--<br>
=C2=A0hw/mips/mips_fulong2e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 ++-<br>
=C2=A0hw/mips/mips_mipssim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0hw/moxie/moxiesim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A0hw/nios2/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 ++--<br>
=C2=A0hw/openrisc/openrisc_sim.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/pci-host/prep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 3 ++-<br>
=C2=A0hw/ppc/e500.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/ppc/mac_newworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++-=
-<br>
=C2=A0hw/ppc/mac_oldworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++-=
-<br>
=C2=A0hw/ppc/ppc440_bamboo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0hw/ppc/sam460ex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 ++-<br>
=C2=A0hw/ppc/spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0hw/ppc/virtex_ml507.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<=
br>
=C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 ++--<br>
=C2=A0hw/s390x/ipl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 7 ++++---<br>
=C2=A0hw/sparc/leon3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
=C2=A0hw/sparc/sun4m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++--<br>
=C2=A0hw/sparc64/sun4u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 5 +++--<br>
=C2=A0hw/tricore/tricore_testboard.c |=C2=A0 2 +-<br>
=C2=A0hw/xtensa/sim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0hw/xtensa/xtfpga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
6 +++++-<br>
=C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 21 +++=
+++++++++---------<br>
=C2=A040 files changed, 92 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c<br>
index f2026fd..a8f9a89 100644<br>
--- a/hw/alpha/dp264.c<br>
+++ b/hw/alpha/dp264.c<br>
@@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0size =3D load_elf(palcode_filename, NULL, cpu_alpha_sup=
erpage_to_phys,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL=
, &amp;palcode_entry, &amp;palcode_low, &amp;palcode_high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL=
, &amp;palcode_entry, &amp;palcode_low, &amp;palcode_high,<br>
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00, EM_ALPHA, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load palcode=
 &#39;%s&#39;&quot;, palcode_filename);<br>
@@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t param_offset;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf(kernel_filename, NULL,<=
br>
cpu_alpha_superpage_to_phys,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<br>
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00, EM_ALPHA, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could no=
t load kernel &#39;%s&#39;&quot;, kernel_filename);<br>
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c<br>
index 7a3c48f..e4fc9a8 100644<br>
--- a/hw/arm/armv7m.c<br>
+++ b/hw/arm/armv7m.c<br>
@@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char<br>
*kernel_filename, int mem_size)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_size =3D load_elf_as(kernel_filenam=
e, NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;lowaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;lowaddr, NULL=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, big_endian, EM_ARM, 1, =
0, as);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (image_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_size =3D load_image_t=
argphys_as(kernel_filename, 0,<br>
diff --git a/hw/arm/boot.c b/hw/arm/boot.c<br>
index 8fb4a63..0c213ca 100644<br>
--- a/hw/arm/boot.c<br>
+++ b/hw/arm/boot.c<br>
@@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info<br>
*info, uint64_t *pentry,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D load_elf_as(info-&gt;kernel_filename, NULL, NUL=
L, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pentry, lowaddr, highaddr, big_endian, elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pentry, lowaddr, highaddr, NULL, big_endian,<br>
elf_machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01, data_swab, as);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The header loaded but the image didn&#=
39;t */<br>
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c<br>
index 4b1fc86..1e5ccb7 100644<br>
--- a/hw/core/generic-loader.c<br>
+++ b/hw/core/generic-loader.c<br>
@@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *dev,<br=
>
Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;force_raw) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf_as(s-&gt;=
file, NULL, NULL, NULL, &amp;entry, NULL,<br>
NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0big_endian, 0, 0, 0, as);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, big_endian, 0, 0, 0, as);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load=
_uimage_as(s-&gt;file, &amp;entry, NULL, NULL, NULL,<br>
NULL,<br>
diff --git a/hw/core/loader.c b/hw/core/loader.c<br>
index 5099f27..d1b78f6 100644<br>
--- a/hw/core/loader.c<br>
+++ b/hw/core/loader.c<br>
@@ -406,12 +406,12 @@ int load_elf(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*elf_note_fn)(vo=
id *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*translate_fn)(v=
oid *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *translate_opaque, ui=
nt64_t *pentry, uint64_t *lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, int bi=
g_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_lsb, int data_sw=
ab)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, uint32=
_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_machine, int clear=
_lsb, int data_swab)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return load_elf_as(filename, elf_note_fn, translate_fn,=
<br>
translate_opaque,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pentry, lowaddr, highaddr, big_endian, elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0clear_lsb, data_swab, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pentry, lowaddr, highaddr, pflags, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0elf_machine, clear_lsb, data_swab, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0/* return &lt; 0 if error, otherwise the number of bytes loaded in me=
mory */<br>
@@ -419,12 +419,12 @@ int load_elf_as(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t (*el=
f_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t (*tr=
anslate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *transla=
te_opaque, uint64_t *pentry, uint64_t<br>
*lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *highaddr=
, int big_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int=
 data_swab, AddressSpace *as)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *highaddr=
, uint32_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, i=
nt clear_lsb, int data_swab,<br>
AddressSpace *as)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return load_elf_ram(filename, elf_note_fn, translate_fn=
,<br>
translate_opaque,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pentry, lowaddr, highaddr, big_endian,<br>
elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 clear_lsb, data_swab, as, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pentry, lowaddr, highaddr, pflags, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 elf_machine, clear_lsb, data_swab, as, true);<br>
=C2=A0}<br>
<br>
=C2=A0/* return &lt; 0 if error, otherwise the number of bytes loaded in me=
mory */<br>
@@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*e=
lf_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*t=
ranslate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *transl=
ate_opaque, uint64_t *pentry, uint64_t<br>
*lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *hi=
ghaddr, int big_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_ls=
b, int data_swab, AddressSpace *as,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool load_ro=
m)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *hi=
ghaddr, uint32_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_mach=
ine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace=
 *as, bool load_rom)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return load_elf_ram_sym(filename, elf_note_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0translate_fn, translate_opaque,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 pentry, lowaddr, highaddr, pflags, big_endian,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elf_machine, clear_lsb, data_swab, as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_rom, NULL);<br>
=C2=A0}<br>
@@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*elf_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void *translate_opaque, uint64_t *pentry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t *lowaddr, uint64_t *highaddr, int<br>
big_endian,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t<br>
*pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int big_endian, int elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int fd, data_order, target_data_order, must_swab, ret =
=3D<br>
ELF_LOAD_FAILED;<br>
@@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf64(filename, fd, elf_note=
_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine,<br>
clear_lsb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pflags, elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf32(filename, fd, elf_note=
_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine,<br>
clear_lsb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, pflags, elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 fail:<br>
diff --git a/hw/cris/boot.c b/hw/cris/boot.c<br>
index 2d2cc0c..b8947bc 100644<br>
--- a/hw/cris/boot.c<br>
+++ b/hw/cris/boot.c<br>
@@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info<=
br>
*li)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devboard SDK.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0image_size =3D load_elf(li-&gt;image_filename, NULL,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0translate_kernel_address, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;entry, NULL, &amp;high, 0, EM_CRIS, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;entry, NULL, &amp;high, NULL, 0, EM_CRIS, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0li-&gt;entry =3D entry;<br>
=C2=A0 =C2=A0 =C2=A0if (image_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Takes a kimage from the axis devboard =
SDK.=C2=A0 */<br>
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c<br>
index 5d0de26..0ab36cf 100644<br>
--- a/hw/hppa/machine.c<br>
+++ b/hw/hppa/machine.c<br>
@@ -140,7 +140,7 @@ static void machine_hppa_init(MachineState *machine)<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0size =3D load_elf(firmware_filename, NULL, NULL, NULL,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;firmware_entry, &amp;firmware_low, &amp;firmware_high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;firmware_entry, &amp;firmware_low, &amp;firmware_high, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0true, EM_PARISC, 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Unfortunately, load_elf sign-extends reading elf32.=
=C2=A0 */<br>
@@ -169,7 +169,7 @@ static void machine_hppa_init(MachineState *machine)<br=
>
=C2=A0 =C2=A0 =C2=A0/* Load kernel */<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D load_elf(kernel_filename, NULL, =
&amp;cpu_hppa_to_phys,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, &amp;kernel_entry, &amp;kernel_low, &amp;kernel_high,<br>
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0true, EM_PARISC, 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unfortunately, load_elf sign-extends r=
eading elf32.=C2=A0 */<br>
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c<br>
index 9a59f95..9e7d69d 100644<br>
--- a/hw/i386/multiboot.c<br>
+++ b/hw/i386/multiboot.c<br>
@@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
&amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, 0, I386_=
ELF_MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, NULL, 0,=
<br>
I386_ELF_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Error wh=
ile loading elf kernel&quot;);<br>
diff --git a/hw/i386/x86.c b/hw/i386/x86.c<br>
index 9b9a4d5..7f38e6b 100644<br>
--- a/hw/i386/x86.c<br>
+++ b/hw/i386/x86.c<br>
@@ -413,7 +413,7 @@ static bool load_elfboot(const char *kernel_filename,<b=
r>
=C2=A0 =C2=A0 =C2=A0uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;<br=
>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, read_pvh_star=
t_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;elf_note_type, &amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, 0, I386_ELF_MACHINE,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, NULL, 0, I386_ELF_MACH=
INE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c<br>
index 5ae308b..d1894ad 100644<br>
--- a/hw/lm32/lm32_boards.c<br>
+++ b/hw/lm32/lm32_boards.c<br>
@@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int kernel_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entry;<br=
>
<br>
@@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machine)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int kernel_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entry;<br=
>
<br>
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c<br>
index 460d322..6d46134 100644<br>
--- a/hw/lm32/milkymist.c<br>
+++ b/hw/lm32/milkymist.c<br>
@@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, EM_LATTICEMICO32, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reset_info-&gt;bootstrap_pc =3D entry;<br=
>
<br>
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c<br>
index 54ccbe1..bed43a9 100644<br>
--- a/hw/m68k/an5206.c<br>
+++ b/hw/m68k/an5206.c<br>
@@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, NULL, NULL, N=
ULL, &amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_68K, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_68K, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_uimage(kernel_filena=
me, &amp;entry, NULL, NULL,<br>
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c<br>
index 158c5e4..a999c21 100644<br>
--- a/hw/m68k/mcf5208.c<br>
+++ b/hw/m68k/mcf5208.c<br>
@@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename, NULL, NULL, N=
ULL, &amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_68K, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_68K, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_uimage(kernel_filena=
me, &amp;entry, NULL, NULL,<br>
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c<br>
index 12491ec..1e32363 100644<br>
--- a/hw/m68k/q800.c<br>
+++ b/hw/m68k/q800.c<br>
@@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0if (linux_boot) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t high;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, &amp;high, 1,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, &amp;high, NULL=
, 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_68K, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could no=
t load kernel &#39;%s&#39;&quot;, kernel_filename);<br>
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c<br>
index d1d7dfb..925e3f7 100644<br>
--- a/hw/microblaze/boot.c<br>
+++ b/hw/microblaze/boot.c<br>
@@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu,<br>
hwaddr ddr_base,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, NULL=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_MICROBLAZE, 0, 0);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base32 =3D entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (base32 =3D=3D 0xc0000000) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(ke=
rnel_filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_addre=
ss, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_MICROBL=
AZE, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always boot into physical ram.=C2=A0 *=
/<br>
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c<br>
index 9eaa6e2..2e043cb 100644<br>
--- a/hw/mips/mips_fulong2e.c<br>
+++ b/hw/mips/mips_fulong2e.c<br>
@@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_entry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_low, (uint64_t<br>
*)&amp;kernel_high,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00, EM_MIPS, 1, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0, EM_MIPS, 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load kernel =
&#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 loaderparams.kernel_filename,<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 5aaeaa8..34b76bb 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filename, =
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_entry, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian, EM_MIPS,<=
br>
1, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,<br>
EM_MIPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load kernel =
&#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 loaderparams.kernel_filename,<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 84c03dd..b934ca9 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -74,7 +74,7 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filename, =
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;entry, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 EM_MIPS, 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((entry &amp; ~0x7fffffffULL) =3D=3D 0=
x80000000) {<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index fd926a3..b2aec43 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -98,7 +98,7 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loaderparams.kernel_filename, =
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_kseg0_to_phys, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;entry, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_high, NULL, big_endian,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 EM_MIPS, 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((entry &amp; ~0x7fffffffULL) =3D=3D 0=
x80000000) {<br>
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c<br>
index 57af1b4..1d06e39 100644<br>
--- a/hw/moxie/moxiesim.c<br>
+++ b/hw/moxie/moxiesim.c<br>
@@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams<br>
*loader_params)<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t initrd_offset;<br>
<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(loader_params-&gt;kernel_filen=
ame,=C2=A0 NULL, NULL,<br>
NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;kernel_low, &amp;kernel_high, 1, E=
M_MOXIE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;kernel_low, &amp;kernel_high, NULL=
, 1,<br>
EM_MOXIE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt;=3D 0) {<br>
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c<br>
index d78bc9e..46b8349 100644<br>
--- a/hw/nios2/boot.c<br>
+++ b/hw/nios2/boot.c<br>
@@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, NULL=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_ALTERA_NIOS2, 0, 0);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((uint32_t)entry =3D=3D 0xc0000000) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
@@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(ke=
rnel_filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_addre=
ss, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 big_endian, EM_ALTERA_=
NIOS2, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boot_info.bootstrap_pc =3D =
ddr_base + 0xc0000000 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(entry &amp; =
0x07ffffff);<br>
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c<br>
index 79e7049..ad53712 100644<br>
--- a/hw/openrisc/openrisc_sim.c<br>
+++ b/hw/openrisc/openrisc_sim.c<br>
@@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_filename &amp;&amp; !qtest_enabled()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, NULL, 1, EM_OPE=
NRISC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, NULL, NULL, NULL, 1,<=
br>
EM_OPENRISC,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c<br>
index afa136d..fcf6235 100644<br>
--- a/hw/pci-host/prep.c<br>
+++ b/hw/pci-host/prep.c<br>
@@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **errp)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;elf_machine !=3D =
EM_NONE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D=
 load_elf(filename, NULL, NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, s=
-&gt;elf_machine, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL=
, 1, s-&gt;elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D=
 get_image_size(filename);<br>
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c<br>
index 12b6a5b..886442e 100644<br>
--- a/hw/ppc/e500.c<br>
+++ b/hw/ppc/e500.c<br>
@@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payloa=
d_name);<br>
<br>
=C2=A0 =C2=A0 =C2=A0payload_size =3D load_elf(filename, NULL, NULL, NULL,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bios_entry, &amp;loadaddr, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bios_entry, &amp;loadaddr, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01, PPC_ELF_MACHINE, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (payload_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c<br>
index 3594517..464d012 100644<br>
--- a/hw/ppc/mac_newworld.c<br>
+++ b/hw/ppc/mac_newworld.c<br>
@@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0/* Load OpenBIOS (ELF) */<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D load_elf(filename, NULL, NU=
LL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(filename);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, 1, PPC_ELF_=
MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, NULL, 1,<br=
>
PPC_ELF_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_aout(k=
ernel_filename, kernel_base,<br>
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c<br>
index 0fa680b..7318d7e 100644<br>
--- a/hw/ppc/mac_oldworld.c<br>
+++ b/hw/ppc/mac_oldworld.c<br>
@@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machine)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load OpenBIOS (ELF) */<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D load_elf(filename, NULL, 0, NULL=
, NULL, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D load_elf(filename, NULL, 0, NULL=
, NULL, NULL, NULL,<br>
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1, PPC_ELF_MACHINE, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(filename);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machine)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_base =3D KERNEL_LOAD_ADDR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, 1, PPC_ELF_=
MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;lowaddr, NULL, NULL, 1,<br=
>
PPC_ELF_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_aout(k=
ernel_filename, kernel_base,<br>
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c<br>
index b782641..da777ef 100644<br>
--- a/hw/ppc/ppc440_bamboo.c<br>
+++ b/hw/ppc/ppc440_bamboo.c<br>
@@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D load_elf(kernel=
_filename, NULL, NULL, NULL,<br>
&amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, 1, PPC_ELF_MA=
CHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, NULL, 1,<br>
PPC_ELF_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadaddr =3D elf_lowaddr;<b=
r>
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c<br>
index 437e214..89bc70e 100644<br>
--- a/hw/ppc/sam460ex.c<br>
+++ b/hw/ppc/sam460ex.c<br>
@@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D load_elf(machin=
e-&gt;kernel_filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &amp;elf_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, 1, PPC_ELF_MA=
CHINE, 0,<br>
0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_lowaddr, NULL, NULL, 1,<br>
PPC_ELF_MACHINE, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadaddr =3D elf_lowaddr;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c<br>
index 02cf53f..a0076e5 100644<br>
--- a/hw/ppc/spapr.c<br>
+++ b/hw/ppc/spapr.c<br>
@@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState<br>
*machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_size =3D load_elf(kernel=
_filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0translate=
_kernel_address, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;lowa=
ddr, NULL, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;lowa=
ddr, NULL, NULL, 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PPC_ELF_M=
ACHINE, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spapr-&gt;kernel_size =3D=3D ELF_LOAD=
_WRONG_ENDIAN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_size =3D l=
oad_elf(kernel_filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0translate_kernel_address, NULL,<br>
NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;lowaddr, NULL, 0,<br>
PPC_ELF_MACHINE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;lowaddr, NULL, NULL, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
PC_ELF_MACHINE, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spapr-&gt;kernel_le =3D spa=
pr-&gt;kernel_size &gt; 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spapr-&gt;kernel_size &lt; 0) {<br>
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c<br>
index 6862552..7526947 100644<br>
--- a/hw/ppc/virtex_ml507.c<br>
+++ b/hw/ppc/virtex_ml507.c<br>
@@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Boots a kernel elf binary.=C2=A0 */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, 1, P=
PC_ELF_MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, &amp;low, &amp;high, NULL=
, 1,<br>
PPC_ELF_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boot_info.bootstrap_pc =3D entry &amp; 0x=
00ffffff;<br>
<br>
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c<br>
index 027303d..b8e7652 100644<br>
--- a/hw/riscv/boot.c<br>
+++ b/hw/riscv/boot.c<br>
@@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char<br>
*firmware_filename,<br>
=C2=A0 =C2=A0 =C2=A0uint64_t firmware_entry, firmware_start, firmware_end;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0if (load_elf(firmware_filename, NULL, NULL, NULL, &amp;=
firmware_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;firmwar=
e_start, &amp;firmware_end, 0, EM_RISCV, 1, 0) &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;firmwar=
e_start, &amp;firmware_end, NULL, 0, EM_RISCV, 1, 0)<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
0) {<br>
</blockquote>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return firmware_entry;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char<br>
*kernel_filename, symbol_fn_t sym_cb)<br>
=C2=A0 =C2=A0 =C2=A0uint64_t kernel_entry, kernel_high;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;kernel_entry, NULL, &amp;kernel_high, NULL, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 EM_RISCV, 1, 0, NULL, true, sym_cb) &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return kernel_entry;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c<br>
index ca544d6..49506e4 100644<br>
--- a/hw/s390x/ipl.c<br>
+++ b/hw/s390x/ipl.c<br>
@@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Error<br=
>
**errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D load_elf(bios_filename, NUL=
L,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_translate_addr, &amp;fwbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;bios_start_addr, NULL, NULL, 1,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;bios_start_addr, NULL, NULL, NU=
LL, 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_S390, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios_size &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Adjust ELF start address=
 to final location */<br>
@@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Error<br=
>
**errp)<br>
=C2=A0 =C2=A0 =C2=A0if (ipl-&gt;kernel) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(ipl-&gt;kernel, =
NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pentry, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 1, EM_S390, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 1, EM_S390, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_image_=
targphys(ipl-&gt;kernel, 0, ram_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<b=
r>
@@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0img_size =3D load_elf_ram(netboot_filename, NULL, NULL,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ipl-&gt;start_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, 1, EM_S390, 0, 0, NULL, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (img_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0img_size =3D load_image_size(netboot_file=
name, ram_ptr, ram_size);<br>
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c<br>
index 8038887..f5a087d 100644<br>
--- a/hw/sparc/leon3.c<br>
+++ b/hw/sparc/leon3.c<br>
@@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState<br>
*machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t entry;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entry, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 /* big endian */, EM_SPARC, 0, 0);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_uimage=
(kernel_filename, NULL, &amp;entry,<br>
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c<br>
index 2aaa5bf..d404353 100644<br>
--- a/hw/sparc/sun4m.c<br>
+++ b/hw/sparc/sun4m.c<br>
@@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char<br>
*kernel_filename,<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 translate_kernel_address, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARC, 0, 0);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL, 1, EM_SPARC, =
0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_aout(k=
ernel_filename, KERNEL_LOAD_ADDR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RAM_size - KERNE=
L_LOAD_ADDR,<br>
bswap_needed,<br>
@@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char<br>
*bios_name)<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf(filename, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 translate_prom_address, &amp;addr, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL, 1, EM_SPARC, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARC, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret &gt; PROM_SIZE_MAX)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_image_targphys=
(filename, addr, PROM_SIZE_MAX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c<br>
index 9550827..c746040 100644<br>
--- a/hw/sparc64/sun4u.c<br>
+++ b/hw/sparc64/sun4u.c<br>
@@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char<br>
*kernel_filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bswap_needed =3D 0;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL,<br>
kernel_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_addr, &amp;kernel_top, 1, EM_S=
PARCV9,<br>
0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_addr, &amp;kernel_top, NULL, 1=
,<br>
EM_SPARCV9, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kernel_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*kernel_addr =3D KERNEL_LOA=
D_ADDR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*kernel_entry =3D KERNEL_LO=
AD_ADDR;<br>
@@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char<br>
*bios_name)<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_n=
ame);<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf(filename, NULL, translat=
e_prom_address, &amp;addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret &gt; PROM_SIZE_MAX)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_image_targphys=
(filename, addr, PROM_SIZE_MAX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_<br>
testboard.c<br>
index aef3289..20c9ccb 100644<br>
--- a/hw/tricore/tricore_testboard.c<br>
+++ b/hw/tricore/tricore_testboard.c<br>
@@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)<br>
<br>
=C2=A0 =C2=A0 =C2=A0kernel_size =3D load_elf(tricoretb_binfo.kernel_filenam=
e, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &amp;entry, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 EM_TRICORE, 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &lt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;no kernel file &#39;%s=
&#39;&quot;,<br>
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c<br>
index a22743a..aeb46d8 100644<br>
--- a/hw/xtensa/sim.c<br>
+++ b/hw/xtensa/sim.c<br>
@@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu,<br>
MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_lowaddr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int success =3D load_elf(kernel_filename,=
 NULL,<br>
translate_phys_addr, cpu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, &amp;elf_lowaddr, NUL=
L, big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_entry, &amp;elf_lowaddr, NUL=
L, NULL,<br>
big_endian,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EM_XTENSA, 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &gt; 0) {<br>
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c<br>
index 8220c7a..8e2dd13 100644<br>
--- a/hw/xtensa/xtfpga.c<br>
+++ b/hw/xtensa/xtfpga.c<br>
@@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,<b=
r>
MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_entry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t elf_lowaddr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int success =3D load_elf(kernel_filename,=
 NULL,<br>
translate_phys_addr, cpu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;elf_entry, &a=
mp;elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;elf_entry, &a=
mp;elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0,<br>
0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (success &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry_point =3D elf_entry;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h<br>
index e07d276..a1411bf 100644<br>
--- a/include/hw/elf_ops.h<br>
+++ b/include/hw/elf_ops.h<br>
@@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *translate_opaque,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int must_swab, uint64_t *pentry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *lowaddr, uint64_t *highaddr=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, int clear_lsb, int<br>
data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *pflags, int elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace *as, bool load_rom,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symbol_fn_t sym_cb)<br>
=C2=A0{<br>
@@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (pflags) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pflags =3D (elf_word)ehdr.e_flags;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (pentry)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pentry =3D (uint64_t)(elf_sword)ehdr.e_e=
ntry;<br>
<br>
diff --git a/include/hw/loader.h b/include/hw/loader.h<br>
index 48a96cd..a9eeea3 100644<br>
--- a/include/hw/loader.h<br>
+++ b/include/hw/loader.h<br>
@@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);<br>
=C2=A0 * @pentry: Populated with program entry point. Ignored if NULL.<br>
=C2=A0 * @lowaddr: Populated with lowest loaded address. Ignored if NULL.<b=
r>
=C2=A0 * @highaddr: Populated with highest loaded address. Ignored if NULL.=
<br>
+ * @pflags: Populated with ELF processor-specific flags. Ignore if NULL.<b=
r>
=C2=A0 * @bigendian: Expected ELF endianness. 0 for LE otherwise BE<br>
=C2=A0 * @elf_machine: Expected ELF machine type<br>
=C2=A0 * @clear_lsb: Set to mask off LSB of addresses (Some architectures u=
se<br>
@@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*elf_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void *translate_opaque, uint64_t *pentry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t *lowaddr, uint64_t *highaddr, int<br>
big_endian,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t *lowaddr, uint64_t *highaddr, uint32_t<br>
*pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int big_endian, int elf_machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);<br>
<br>
=C2=A0/** load_elf_ram:<br>
@@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*e=
lf_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*t=
ranslate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *transl=
ate_opaque, uint64_t *pentry, uint64_t<br>
*lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *hi=
ghaddr, int big_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_ls=
b, int data_swab, AddressSpace *as,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool load_ro=
m);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *hi=
ghaddr, uint32_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_mach=
ine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace=
 *as, bool load_rom);<br>
<br>
=C2=A0/** load_elf_as:<br>
=C2=A0 * Same as load_elf_ram(), but always loads the elf as ROM<br>
@@ -154,8 +156,9 @@ int load_elf_as(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t (*el=
f_note_fn)(void *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t (*tr=
anslate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *transla=
te_opaque, uint64_t *pentry, uint64_t<br>
*lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *highaddr=
, int big_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int=
 data_swab, AddressSpace *as);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *highaddr=
, uint32_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, i=
nt clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AddressSpace *as);=
<br>
<br>
=C2=A0/** load_elf:<br>
=C2=A0 * Same as load_elf_as(), but doesn&#39;t allow the caller to specify=
 an<br>
@@ -165,8 +168,8 @@ int load_elf(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*elf_note_fn)(vo=
id *, void *, bool),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t (*translate_fn)(v=
oid *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *translate_opaque, ui=
nt64_t *pentry, uint64_t *lowaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, int bi=
g_endian, int elf_machine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int clear_lsb, int data_sw=
ab);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *highaddr, uint32=
_t *pflags, int big_endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int elf_machine, int clear=
_lsb, int data_swab);<br>
<br>
=C2=A0/** load_elf_hdr:<br>
=C2=A0 * @filename: Path of ELF file<br>
--<br>
2.7.4<br>
<br>
<br>
<br>
</blockquote>
</blockquote>
</blockquote>
</blockquote></div></div>

--000000000000b3275d059d38310c--

