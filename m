Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00539C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6382074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahlpz3QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6382074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl4qL-0003qG-2m
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jl4pR-0003KV-Ec
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:12:14 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jl4pN-0000GP-O0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:12:13 -0400
Received: by mail-il1-x141.google.com with SMTP id l6so1564152ilo.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bJaVPXa2JspO8MCyA23EijJzTW0l3/Y4SWfus3OxT/U=;
 b=ahlpz3QBG3lE0TjkWyequRB/UfypHO0HYK1nJ52cQ2DqXqT4Z8Vcm9u/CZzGGG20hn
 ibBw9RUm9Ux2bIeh0Lq9VXfr3OYR7bwBsbpci+g8kPSFHRSqo6h9YolmvDjgslj05Q4m
 JcIDa6UPYTcTeHXvkdT+cL6QXRNZKeoNca52gj58hAkmwGvzGgfbL2MTaj70i2fO1imO
 uZeY48NgVaPk+nJ2tIXg1ZcJYYcAWFz5XYsigbSoa3s0OCJERk8aJJnkkNmwSh4yFIiB
 CoGTszMcSueu9I3PElwGj2SMKlYn4LezOE4EojedxrqmX0aQjO1k6i4tXJJp2SFSLf+y
 srQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bJaVPXa2JspO8MCyA23EijJzTW0l3/Y4SWfus3OxT/U=;
 b=WkHpFDbPjzs/XpfQXHT4AW2EmwMyOMXPUW+A2GEPMZ4uNZRV0C8Kcwk7WC1YCfH+Nw
 n01C+FLoXQAiEpVcraVDFQmuz7NceulFfDkIJV1sFLFNCYvJl2YXROMsDRJqKwJp5Y8v
 YifiZo63JrBMlgEJ3thIzFUVk/eLBfcnfM794D6UPGFekJ1keLWahOcFnuxbGlk1Aaaz
 Xi1KySHrmY0TYs+bHOKqluUKsiLZ6t221jCLLuR63M5MhpXhUJw4+ya6bsPT0vy7bTNu
 TuTdxTN5W7xSgjPHgJ+m5gKPCXImBheBZ0wiiIljw/Nfk49S67Wi0CnX3nwi3f5bIo3t
 mWog==
X-Gm-Message-State: AOAM533a9wkwTXe+QWPp20sbkthaulRIO7sgDSlZg6GT7cXCN38IJQGs
 ZKRS6AqUVwIk3EfgjLbwS+qKF0q4Pqx5x3gQWwE=
X-Google-Smtp-Source: ABdhPJwJY5QmBAQMxzGzBcP/IgSsWZmnmEymGxPkJJE7WTvF16qO0EsxYQTb/PcakbC/LP+Z14yrir8Yeny7JjYRYzk=
X-Received: by 2002:a92:cf48:: with SMTP id c8mr1547478ilr.147.1592287928429; 
 Mon, 15 Jun 2020 23:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5o3GdzEeCm5KGM0kDJcGXbJ=syd9sFEg1AqLOirFNg-Q@mail.gmail.com>
 <CAAhV-H6KHOLDstUQvOV+8T872R_mLH-ZYHG1YaA6FSqd5meovw@mail.gmail.com>
 <653db100-34fb-6cbd-215b-e4d931cc5e07@redhat.com>
 <CAL1e-=iuAbE+TF1kCZokX75uALZDTndugZVq-mGebJ0F10TLsA@mail.gmail.com>
In-Reply-To: <CAL1e-=iuAbE+TF1kCZokX75uALZDTndugZVq-mGebJ0F10TLsA@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 16 Jun 2020 14:11:57 +0800
Message-ID: <CAAhV-H4oTR=LATQmZ0xNmnu+_O4XXa84SGzHSZ83HWq9VhKKDA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Thomas and Aleksandar,

On Tue, Jun 16, 2020 at 3:45 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Mon, Jun 15, 2020 at 10:55 AM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 15/06/2020 02.52, Huacai Chen wrote:
> > > Hi, Aleksandar,
> > >
> > > On Sun, Jun 14, 2020 at 4:07 PM Aleksandar Markovic
> > > <aleksandar.qemu.devel@gmail.com> wrote:
> > >>
> > >>
> > >>
> > >> =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
> > >>>
> > >>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now=
 we
> > >>> can't create a VZ guest in QEMU because it lacks the kvm_type() hoo=
k in
> > >>> MachineClass. Besides, libvirt uses a null-machine to detect the kv=
m
> > >>> capability, so by default it will return "KVM not supported" on a V=
Z
> > >>> platform. Thus, null-machine also need the kvm_type() hook.
> > >>>
> > >>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > >>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >>> ---
> > >>
> > >> Huacai,
> > >>
> > >> Please take a look at Peter's remarks at:
> > >>
> > >> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01878.html
> > >>
> > >> ...and refactor this patch for v5. My general advice: The simpler, t=
he batter.
> > >>
> > > OK, I will rework this patch.
> >
> >  Hi,
> >
> > is there maybe also a way to do this without moving null-machine.o from
> > common-obj-y to obj-y, and to avoid the target-specific hacks in this
> > file ? We just moved the null-machine from obj-y to common-obj-y two
> > years ago (see commit 3858ff763985fb9e), since it's more desirable to
> > have as much code in common-obj to save compilation time and maybe to b=
e
> > able to link a qemu with more than one target CPU in one binary one day=
...
> >
> > ppc64 has also more than one kvm_type (kvm-hv and kvm-pr), and
> > apparently it also works without hacks to the null-machine code there
> > ... so maybe you can peek into the ppc64 code to see how it is solved t=
here?
> >
>
> Hi, Huacai,
>
> I think the optimal outcome for this release of QEMU would be if you
> drop support for VZ. I think your scenario could work without VZ,
> couldn't it?
>
> This is a fairly complex thing, and, as you see, it is a little
> intrusive, it could negatively impact other targets. With enough
> development time, you can easily provide that support in 5.2. - but
> now we are close to 5.1 softfreeze.
>
> Even without VZ support, I would consider your contribution the most
> significant for MIPS target in last two years, at least - a giant step
> ahead!
There are two problems: 1, qemu need kvm_type() to create a normal KVM
guest. 2, libvirt use the null-machine to detect the KVM capability.
For the first problem, just provide a kvm_type() hook for MIPS is
enough, which is similar to ppc64. For the second problem, I think
libvirt is also unable to detect the KVM capabilty on ppc64, unless
ppc64 do the same hack on null-machine.

V5 of this patch will only provide kvm_type() for MIPS (not hack
null-machine.c), but all of us should think how to solve the second
problem.

Huacai
>
> Best Regards,
> Aleksandar
>
> >  Thomas
> >
> >
> > >>>  hw/core/Makefile.objs  |  2 +-
> > >>>  hw/core/null-machine.c |  4 ++++
> > >>>  hw/mips/Makefile.objs  |  2 +-
> > >>>  hw/mips/common.c       | 42 ++++++++++++++++++++++++++++++++++++++=
++++
> > >>>  include/hw/mips/mips.h |  3 +++
> > >>>  5 files changed, 51 insertions(+), 2 deletions(-)
> > >>>  create mode 100644 hw/mips/common.c
> > >>>
> > >>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > >>> index 1d540ed..b5672f4 100644
> > >>> --- a/hw/core/Makefile.objs
> > >>> +++ b/hw/core/Makefile.objs
> > >>> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-sta=
te-handler.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> > >>> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
> > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
> > >>> +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> > >>>  obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
> > >>>
> > >>>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
> > >>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > >>> index cb47d9d..94a36f9 100644
> > >>> --- a/hw/core/null-machine.c
> > >>> +++ b/hw/core/null-machine.c
> > >>> @@ -17,6 +17,7 @@
> > >>>  #include "sysemu/sysemu.h"
> > >>>  #include "exec/address-spaces.h"
> > >>>  #include "hw/core/cpu.h"
> > >>> +#include "hw/mips/mips.h"
> > >>>
> > >>>  static void machine_none_init(MachineState *mch)
> > >>>  {
> > >>> @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClas=
s *mc)
> > >>>      mc->max_cpus =3D 1;
> > >>>      mc->default_ram_size =3D 0;
> > >>>      mc->default_ram_id =3D "ram";
> > >>> +#ifdef TARGET_MIPS
> > >>> +    mc->kvm_type =3D mips_kvm_type;
> > >>> +#endif
> > >>>  }
> > >>>
> > >>>  DEFINE_MACHINE("none", machine_none_machine_init)
> > >>> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> > >>> index 739e2b7..3b3e6ea 100644
> > >>> --- a/hw/mips/Makefile.objs
> > >>> +++ b/hw/mips/Makefile.objs
> > >>> @@ -1,4 +1,4 @@
> > >>> -obj-y +=3D addr.o mips_int.o
> > >>> +obj-y +=3D addr.o common.o mips_int.o
> > >>>  obj-$(CONFIG_R4K) +=3D r4k.o
> > >>>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
> > >>>  obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
> > >>> diff --git a/hw/mips/common.c b/hw/mips/common.c
> > >>> new file mode 100644
> > >>> index 0000000..4d8e141
> > >>> --- /dev/null
> > >>> +++ b/hw/mips/common.c
> > >>> @@ -0,0 +1,42 @@
> > >>> +/*
> > >>> + * Common MIPS routines
> > >>> + *
> > >>> + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
> > >>> + * This code is licensed under the GNU GPL v2.
> > >>> + */
> > >>> +
> > >>> +#include <linux/kvm.h>
> > >>> +#include "qemu/osdep.h"
> > >>> +#include "qemu-common.h"
> > >>> +#include "hw/boards.h"
> > >>> +#include "hw/mips/mips.h"
> > >>> +#include "sysemu/kvm_int.h"
> > >>> +
> > >>> +#ifndef CONFIG_KVM
> > >>> +
> > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > >>> +{
> > >>> +    return 0;
> > >>> +}
> > >>> +
> > >>> +#else
> > >>> +
> > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > >>> +{
> > >>> +    int r;
> > >>> +    KVMState *s =3D KVM_STATE(machine->accelerator);
> > >>> +
> > >>> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> > >>> +    if (r > 0) {
> > >>> +        return KVM_VM_MIPS_VZ;
> > >>> +    }
> > >>> +
> > >>> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
> > >>> +    if (r > 0) {
> > >>> +        return KVM_VM_MIPS_TE;
> > >>> +    }
> > >>> +
> > >>> +    return -1;
> > >>> +}
> > >>> +
> > >>> +#endif
> > >>> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> > >>> index 0af4c3d..2ac0580 100644
> > >>> --- a/include/hw/mips/mips.h
> > >>> +++ b/include/hw/mips/mips.h
> > >>> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, in=
t len);
> > >>>
> > >>>  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dm=
a_mr);
> > >>>
> > >>> +/* common.c */
> > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type);
> > >>> +
> > >>>  #endif
> > >>> --
> > >>> 2.7.0
> > >>>
> > >
> >
> >

