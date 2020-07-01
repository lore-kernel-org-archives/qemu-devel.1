Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72581206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OndfuD5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72581206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeLe-00008I-Kd
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jqeDc-0005z7-7A
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:00:13 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jqeDa-00087Z-1f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:00:11 -0400
Received: by mail-lj1-x244.google.com with SMTP id f8so15136208ljc.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yc+eL/IAj3nyAMuFv8crrvZ6GHVlDHU/rqByUyGib/E=;
 b=OndfuD5dzixU+MzAMVK8Yj8EEwL2yPyBwDT+uPo/gRYAU2InINZMBbtCuYDiGk3rWB
 pxLCtBiGJ+Vb+/9+gkKx4T8xRkLcggmR96lmJsS/azur8SXDNSyC5ly1X+HuLk5hTzaE
 XYt04Pz1g+WwshfUyDiRsEfLTLp3U7ZoM9t/ZJnD4nt19UYMzUFjvYgH4x918UbrysWt
 AfGVnDJMcwUvOCclU+8s/VK5ssj/iPgGDQtT1HjM4jyPE1TGUHOOmHM2S5gW7go5xVYb
 ZsBuDmT5n9h6RPSZcGAVR8TQsrlBUWj6Ui37KflR6diWlc1G7Th/v7t4Wf0+nQIkjJpc
 XWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yc+eL/IAj3nyAMuFv8crrvZ6GHVlDHU/rqByUyGib/E=;
 b=h2LYJmEel9KbB3zyc/3Wl+JO6v9CvwWjjeAhAIZjMm7mn8N4MlG8RwbgT0oAuiTP3B
 63BtmSw2j4lfot4XuZBeSbanFliweNVLNXgIgFYHVJdWgkfPQakqqVHPMywkeCDwHC4y
 ggRM7uM3Idf89Vc6n3S4lN7rvw+jCdIeLV/DqzNQdORZh6jT2nLERb6vdCAwiPF2uGb1
 8weJb5QvokjEUlDfSIll6DdH9vIW0NQaYQlxRnCOOWvDYFr0rLhq8GKIm8fGuWH3XnXd
 6E0KnXuNPluiDkznlcjS4Q/7B5Hrwtq53ipAHTFTD7rsUjtSLTrMOudWvq6HDj+8+ybm
 9CCg==
X-Gm-Message-State: AOAM530rZLkAof7zc9NdfRg5VxcVC2E0JLU1cPRkT0Hx840aa6XXUn+w
 7RNJJoqzzj9aiWxGV3f+OQGAN0eprHUqY4EOz0c=
X-Google-Smtp-Source: ABdhPJzcrloggdF14PhUb1enOgtTkLl6rNS/f0POjqGOcm0QyU99xMr65irW/PqhXVMC+WtSHbmRzyrHzmFUtxdLZXA=
X-Received: by 2002:a2e:978b:: with SMTP id y11mr12896639lji.399.1593615608018; 
 Wed, 01 Jul 2020 08:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
 <000801d64f75$c604f570$520ee050$@xen.org>
 <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
 <07cc67e9-aeaa-1947-43db-c00716bead01@redhat.com>
 <5c00f6a5-3f86-258e-999f-956eef825d14@redhat.com>
In-Reply-To: <5c00f6a5-3f86-258e-999f-956eef825d14@redhat.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 1 Jul 2020 10:59:56 -0400
Message-ID: <CAKf6xpuiQBhvChwfikaLd4tvKVUn3oo88wbsMVw7P11ehV-EYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x244.google.com
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
 Paul Durrant <paul@xen.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 8:55 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 7/1/20 2:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/1/20 2:25 PM, Jason Andryuk wrote:
> >> On Wed, Jul 1, 2020 at 3:03 AM Paul Durrant <xadimgnik@gmail.com> wrot=
e:
> >>>
> >>>> -----Original Message-----
> >>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>> Sent: 30 June 2020 18:27
> >>>> To: paul@xen.org; xen-devel@lists.xenproject.org; qemu-devel@nongnu.=
org
> >>>> Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' <m=
st@redhat.com>; 'Paul Durrant'
> >>>> <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo =
Bonzini' <pbonzini@redhat.com>;
> >>>> 'Richard Henderson' <rth@twiddle.net>
> >>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> >>>>
> >>>> On 6/30/20 5:44 PM, Paul Durrant wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>>>> Sent: 30 June 2020 16:26
> >>>>>> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; q=
emu-devel@nongnu.org
> >>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst=
@redhat.com>; Paul Durrant
> >>>>>> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo B=
onzini <pbonzini@redhat.com>;
> >>>>>> Richard Henderson <rth@twiddle.net>
> >>>>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> >>>>>>
> >>>>>> On 6/24/20 2:18 PM, Paul Durrant wrote:
> >>>>>>> From: Paul Durrant <pdurrant@amazon.com>
> >>>>>>>
> >>>>>>> The generic pc_machine_initfn() calls pc_system_flash_create() wh=
ich creates
> >>>>>>> 'system.flash0' and 'system.flash1' devices. These devices are th=
en realized
> >>>>>>> by pc_system_flash_map() which is called from pc_system_firmware_=
init() which
> >>>>>>> itself is called via pc_memory_init(). The latter however is not =
called when
> >>>>>>> xen_enable() is true and hence the following assertion fails:
> >>>>>>>
> >>>>>>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_proper=
ly:
> >>>>>>> Assertion `dev->realized' failed
> >>>>>>>
> >>>>>>> These flash devices are unneeded when using Xen so this patch avo=
ids the
> >>>>>>> assertion by simply removing them using pc_system_flash_cleanup_u=
nused().
> >>>>>>>
> >>>>>>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> >>>>>>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -bl=
ockdev")
> >>>>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> >>>>>>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> >>>>>>> ---
> >>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>>>>>> Cc: Richard Henderson <rth@twiddle.net>
> >>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >>>>>>> ---
> >>>>>>>  hw/i386/pc_piix.c    | 9 ++++++---
> >>>>>>>  hw/i386/pc_sysfw.c   | 2 +-
> >>>>>>>  include/hw/i386/pc.h | 1 +
> >>>>>>>  3 files changed, 8 insertions(+), 4 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >>>>>>> index 1497d0e4ae..977d40afb8 100644
> >>>>>>> --- a/hw/i386/pc_piix.c
> >>>>>>> +++ b/hw/i386/pc_piix.c
> >>>>>>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
> >>>>>>>      if (!xen_enabled()) {
> >>>>>>>          pc_memory_init(pcms, system_memory,
> >>>>>>>                         rom_memory, &ram_memory);
> >>>>>>> -    } else if (machine->kernel_filename !=3D NULL) {
> >>>>>>> -        /* For xen HVM direct kernel boot, load linux here */
> >>>>>>> -        xen_load_linux(pcms);
> >>>>>>> +    } else {
> >>>>>>> +        pc_system_flash_cleanup_unused(pcms);
> >>>>>>
> >>>>>> TIL pc_system_flash_cleanup_unused().
> >>>>>>
> >>>>>> What about restricting at the source?
> >>>>>>
> >>>>>
> >>>>> And leave the devices in place? They are not relevant for Xen, so w=
hy not clean up?
> >>>>
> >>>> No, I meant to not create them in the first place, instead of
> >>>> create+destroy.
> >>>>
> >>>> Anyway what you did works, so I don't have any problem.
> >>>
> >>> IIUC Jason originally tried restricting creation but encountered a pr=
oblem because xen_enabled() would always return false at that point, becaus=
e machine creation occurs before accelerators are initialized.
> >>
> >> Correct.  Quoting my previous email:
> >> """
> >> Removing the call to pc_system_flash_create() from pc_machine_initfn()
> >> lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
> >> there since accelerators have not been initialized yes, I guess?
> >
> > Ah, I missed that. You pointed at the bug here :)
> >
> > I think pc_system_flash_create() shouldn't be called in init() but
> > realize().
>
> Hmm this is a MachineClass, not qdev, so no realize().
>
> In softmmu/vl.c we have:
>
> 4152     configure_accelerators(argv[0]);
> ....
> 4327     if (!xen_enabled()) { // so xen_enable() is working
> 4328         /* On 32-bit hosts, QEMU is limited by virtual address space=
 */
> 4329         if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> 4330             error_report("at most 2047 MB RAM can be simulated");
> 4331             exit(1);
> 4332         }
> 4333     }
> ....
> 4348     machine_run_board_init(current_machine);
>
> which calls in hw/core/machine.c:
>
> 1089 void machine_run_board_init(MachineState *machine)
> 1090 {
> 1091     MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
> ....
> 1138     machine_class->init(machine);
> 1139 }
>
>          -> pc_machine_class_init()
>
> This should come after:
>
>          -> pc_machine_initfn()
>
>             -> pc_system_flash_create(pcms)

Sorry, I'm not following the flow you want.

The xen_enabled() call in vl.c may always fail.  Or at least in most
common Xen usage.  Xen HVMs are started with machine xenfv and don't
specify an accelerator.  You need to process the xenfv default machine
opts to process "accel=3Dxen".  Actually, I don't know how the
accelerator initialization works, but xen_accel_class_init() needs to
be called to set `ac->allowed =3D &xen_allowed`.  xen_allowed is the
return value of xen_enabled() and the accelerator initialization must
toggle it.

Regards,
Jason

