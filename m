Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB44C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA7E206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjKAczU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA7E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbow-0005m7-8y
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jqboK-0005Fx-9l
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:25:56 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jqboI-00086p-3R
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:25:55 -0400
Received: by mail-lf1-x142.google.com with SMTP id s16so8000040lfp.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0m3xHATUmn66K+zGcSIW2tRSRee6EDqqrd59PD+igzs=;
 b=PjKAczU26QU5qQh8txybYrwbsgNlTcFxXVNvV2s7uVD130rbZTYW8kUMsm3AYPexro
 3NNQxjCo96sHuf3Mm/ni1Qas99BmC0esd4qmZ9gMixJFArpMnL8cmOz8KORq+i5ollhu
 rZ3Q8ho5jXxsM4pTgZOiLTTiC1ZqFgnoPvo0USzkmdawVDsgRF1eSDZzsXm6mbmc6nqM
 5O/1pMB4scjw7EZrwYANpLiH2+9mK0ZaRSbMZBarl/H49l8BrD/rGQdiK34xVI5lltDk
 OVr50Ii5jaFKD+T2vmmaIDY2ZuJUl40XrEeSPAe8RW7aEq1OUW9dIyeSyytCUNfntIWd
 OUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0m3xHATUmn66K+zGcSIW2tRSRee6EDqqrd59PD+igzs=;
 b=LFkpZimZVKYH6A9akIwAtvKFqF+Fp69gUgdpgBUx9KTL/EX+2ZcAVZ1JGTFt1x+KQ7
 79QjXlZoSi3o8xZozvY5uETTfkVuNlNxy8IJHvcKl1WP7hIDXp39+Nh3We6qmEN/MMnY
 jvAWdGHHPWZin0H8pEaHlChtQATsmyu9ubgRhwCRJoKOdKyYKk1p9huWQH9Phhl9wJl3
 T7hLvaCQbf+ktg5ts3jUeAdiM1CmLnGf3th82raXIPlsvAOH5N8GdNfVN5pz9eA4UJm3
 /CvsnB9r3E83WJQ0MENDmw6S5Hn11ZB3o71XZpZX3fEIoKrYFt+466/8Q5AT23rB9zi0
 rjIQ==
X-Gm-Message-State: AOAM530tjwp2mjKb138sPM+mcQZlkAJYExMZ9dpROiU4hqoU/WxvqrTJ
 wbA7hPf0qkI+h++QHD6Ai1hKZljtrYClLJi+M2E=
X-Google-Smtp-Source: ABdhPJwBH7qgS8+hUi+f8eycQWrSoL8wQ6PEdPQEmNHFNy2vttrvb/j/eXLelv3zW3gKBhGI7T9tHpZJvBVEz1XJvJc=
X-Received: by 2002:a05:6512:691:: with SMTP id
 t17mr1091976lfe.44.1593606351678; 
 Wed, 01 Jul 2020 05:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
 <000801d64f75$c604f570$520ee050$@xen.org>
In-Reply-To: <000801d64f75$c604f570$520ee050$@xen.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 1 Jul 2020 08:25:40 -0400
Message-ID: <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
To: Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=jandryuk@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 3:03 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Sent: 30 June 2020 18:27
> > To: paul@xen.org; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> > Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' <mst@=
redhat.com>; 'Paul Durrant'
> > <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo Bon=
zini' <pbonzini@redhat.com>;
> > 'Richard Henderson' <rth@twiddle.net>
> > Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> >
> > On 6/30/20 5:44 PM, Paul Durrant wrote:
> > >> -----Original Message-----
> > >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >> Sent: 30 June 2020 16:26
> > >> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qem=
u-devel@nongnu.org
> > >> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@r=
edhat.com>; Paul Durrant
> > >> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bon=
zini <pbonzini@redhat.com>;
> > >> Richard Henderson <rth@twiddle.net>
> > >> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> > >>
> > >> On 6/24/20 2:18 PM, Paul Durrant wrote:
> > >>> From: Paul Durrant <pdurrant@amazon.com>
> > >>>
> > >>> The generic pc_machine_initfn() calls pc_system_flash_create() whic=
h creates
> > >>> 'system.flash0' and 'system.flash1' devices. These devices are then=
 realized
> > >>> by pc_system_flash_map() which is called from pc_system_firmware_in=
it() which
> > >>> itself is called via pc_memory_init(). The latter however is not ca=
lled when
> > >>> xen_enable() is true and hence the following assertion fails:
> > >>>
> > >>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly=
:
> > >>> Assertion `dev->realized' failed
> > >>>
> > >>> These flash devices are unneeded when using Xen so this patch avoid=
s the
> > >>> assertion by simply removing them using pc_system_flash_cleanup_unu=
sed().
> > >>>
> > >>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > >>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -bloc=
kdev")
> > >>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > >>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> > >>> ---
> > >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> > >>> Cc: Richard Henderson <rth@twiddle.net>
> > >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> > >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > >>> ---
> > >>>  hw/i386/pc_piix.c    | 9 ++++++---
> > >>>  hw/i386/pc_sysfw.c   | 2 +-
> > >>>  include/hw/i386/pc.h | 1 +
> > >>>  3 files changed, 8 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > >>> index 1497d0e4ae..977d40afb8 100644
> > >>> --- a/hw/i386/pc_piix.c
> > >>> +++ b/hw/i386/pc_piix.c
> > >>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
> > >>>      if (!xen_enabled()) {
> > >>>          pc_memory_init(pcms, system_memory,
> > >>>                         rom_memory, &ram_memory);
> > >>> -    } else if (machine->kernel_filename !=3D NULL) {
> > >>> -        /* For xen HVM direct kernel boot, load linux here */
> > >>> -        xen_load_linux(pcms);
> > >>> +    } else {
> > >>> +        pc_system_flash_cleanup_unused(pcms);
> > >>
> > >> TIL pc_system_flash_cleanup_unused().
> > >>
> > >> What about restricting at the source?
> > >>
> > >
> > > And leave the devices in place? They are not relevant for Xen, so why=
 not clean up?
> >
> > No, I meant to not create them in the first place, instead of
> > create+destroy.
> >
> > Anyway what you did works, so I don't have any problem.
>
> IIUC Jason originally tried restricting creation but encountered a proble=
m because xen_enabled() would always return false at that point, because ma=
chine creation occurs before accelerators are initialized.

Correct.  Quoting my previous email:
"""
Removing the call to pc_system_flash_create() from pc_machine_initfn()
lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
there since accelerators have not been initialized yes, I guess?
"""

If you want to remove the creation in the first place, then I have two
questions.  Why does pc_system_flash_create()/pc_pflash_create() get
called so early creating the pflash devices?  Why aren't they just
created as needed in pc_system_flash_map()?

Regards,
Jason

>   Paul
>
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > >
> > >   Paul
> > >
> > >> -- >8 --
> > >> --- a/hw/i386/pc.c
> > >> +++ b/hw/i386/pc.c
> > >> @@ -1004,24 +1004,26 @@ void pc_memory_init(PCMachineState *pcms,
> > >>                                      &machine->device_memory->mr);
> > >>      }
> > >>
> > >> -    /* Initialize PC system firmware */
> > >> -    pc_system_firmware_init(pcms, rom_memory);
> > >> -
> > >> -    option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
> > >> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SI=
ZE,
> > >> -                           &error_fatal);
> > >> -    if (pcmc->pci_enabled) {
> > >> -        memory_region_set_readonly(option_rom_mr, true);
> > >> -    }
> > >> -    memory_region_add_subregion_overlap(rom_memory,
> > >> -                                        PC_ROM_MIN_VGA,
> > >> -                                        option_rom_mr,
> > >> -                                        1);
> > >> -
> > >>      fw_cfg =3D fw_cfg_arch_create(machine,
> > >>                                  x86ms->boot_cpus, x86ms->apic_id_li=
mit);
> > >>
> > >> -    rom_set_fw(fw_cfg);
> > >> +    /* Initialize PC system firmware */
> > >> +    if (!xen_enabled()) {
> > >> +        pc_system_firmware_init(pcms, rom_memory);
> > >> +
> > >> +        option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
> > >> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_RO=
M_SIZE,
> > >> +                               &error_fatal);
> > >> +        if (pcmc->pci_enabled) {
> > >> +            memory_region_set_readonly(option_rom_mr, true);
> > >> +        }
> > >> +        memory_region_add_subregion_overlap(rom_memory,
> > >> +                                            PC_ROM_MIN_VGA,
> > >> +                                            option_rom_mr,
> > >> +                                            1);
> > >> +
> > >> +        rom_set_fw(fw_cfg);
> > >> +    }
> > >>
> > >>      if (pcmc->has_reserved_memory && machine->device_memory->base) =
{
> > >>          uint64_t *val =3D g_malloc(sizeof(*val));
> > >> ---
> > >>
> > >>> +        if (machine->kernel_filename !=3D NULL) {
> > >>> +            /* For xen HVM direct kernel boot, load linux here */
> > >>> +            xen_load_linux(pcms);
> > >>> +        }
> > >>>      }
> > >>>
> > >>>      gsi_state =3D pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
> > >>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > >>> index ec2a3b3e7e..0ff47a4b59 100644
> > >>> --- a/hw/i386/pc_sysfw.c
> > >>> +++ b/hw/i386/pc_sysfw.c
> > >>> @@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState *pcm=
s)
> > >>>      }
> > >>>  }
> > >>>
> > >>> -static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> > >>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> > >>>  {
> > >>>      char *prop_name;
> > >>>      int i;
> > >>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > >>> index e6135c34d6..497f2b7ab7 100644
> > >>> --- a/include/hw/i386/pc.h
> > >>> +++ b/include/hw/i386/pc.h
> > >>> @@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0)=
;
> > >>>
> > >>>  /* pc_sysfw.c */
> > >>>  void pc_system_flash_create(PCMachineState *pcms);
> > >>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms);
> > >>>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *r=
om_memory);
> > >>>
> > >>>  /* acpi-build.c */
> > >>>
> > >
> > >
>
>

