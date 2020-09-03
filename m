Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02291C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 00:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3A0204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 00:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGbTI2ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDdb4-0001Ny-Ts
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 20:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kDdaX-0000sO-7F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 20:58:53 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kDdaV-00079S-DH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 20:58:52 -0400
Received: by mail-il1-x142.google.com with SMTP id y2so941522ilp.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hN7aGBq86ycig/3UxHah0Gg2hr9eKDbP0NvSWMHHig8=;
 b=EGbTI2ngA/aC2rozMvsppCNoObESUbzCo2lvui1XjEFzMulLmhPzQBz7W/jCGz17BY
 +44AO4j8cqeOXiH2VJgjWWFm+txkQj6ELt6U+KtZkTMPD774u8qmVmK1TUzRd+HgxeWi
 XOuDFDPw+GjlkL04b96yGU4jL0rT4Gce9h0k212Cc4qungCbO43lRe6PHECT3jh0fZXz
 FAAcXaXcy8+ODFYtN8GsGWL5B/YHA0mTdiPo09cZyqyEBnWKYN0RhpnCCTddhXSwH+8r
 l5HKdOlFY+9kVdN9o7Hfkn3cOywcBC2PJv8sDkwPqkJ8uOR1Efk6Ul8sUu4jWg/RxPUu
 dUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hN7aGBq86ycig/3UxHah0Gg2hr9eKDbP0NvSWMHHig8=;
 b=gAksOxy2jef4geDa1F+44FhKVlXCX4dWQ5LORdW6qb62up9NONACEtQa0IUc/r+jLo
 7qNBlrFKKr4jR2FOpUIrz2ujzY6DGV7ZZoekLuJREOE7tdYcwxsqJEUYNk2VnpdOYg0n
 f8jiGFsR3Y/svcrbYhkwmXqvprZa6B8HfjEBAydH4EyBc+Z+FndACkiVOFJ6HL+5hN0o
 /fRqvcCAYbwUu3O9nx9oGw59LVxNiT0cLpaQQ3ekYWWTyvVjQDunQG8ZgRy03/IjZB5h
 u3msNoVaS9WKuoeaXNKxDLrw3KTaSGK4B9paN5fBR5DarNnz8X1ehzPlZeXKeSZ5U5gs
 EuOg==
X-Gm-Message-State: AOAM5315UhqCIf1ScyKYtJ+KprTd0dYP8SJh16W952T+sGfUJYJtfhoA
 gPwemnjP3PSFgRis4uMysmqfiV/zQDR4arQLxDs=
X-Google-Smtp-Source: ABdhPJyxPKswadvrad1LfcZk/0CqcN+AAVIXVYmf6rsVLZtEegWomF1GZd2gNZJp2gJDfik6wdSWV4x0Rg0ee6Mr5HQ=
X-Received: by 2002:a05:6e02:d8f:: with SMTP id
 i15mr815241ilj.147.1599094729745; 
 Wed, 02 Sep 2020 17:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <d594ed8e-1cb5-f9ac-09d3-7da28f5a95d3@amsat.org>
In-Reply-To: <d594ed8e-1cb5-f9ac-09d3-7da28f5a95d3@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 3 Sep 2020 08:58:38 +0800
Message-ID: <CAAhV-H4hRT+7KNCDX7bWwxK_mgYRSkWh+9rh1o6LLfD8zmGdqg@mail.gmail.com>
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Sep 2, 2020 at 9:55 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Huacai,
>
> On 8/24/20 10:11 AM, Huacai Chen wrote:
> > MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> > libvirt uses a null-machine to detect the kvm capability. In the MIPS
> > case, it will return "KVM not supported" on a VZ platform by default.
> > So, add the kvm_type() hook to the null-machine.
> >
> > This seems not a very good solution, but I cannot do it better now.
> >
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  hw/core/meson.build    | 2 +-
> >  hw/core/null-machine.c | 6 ++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > index fc91f98..b6591b9 100644
> > --- a/hw/core/meson.build
> > +++ b/hw/core/meson.build
> > @@ -35,7 +35,6 @@ softmmu_ss.add(files(
> >    'machine-hmp-cmds.c',
> >    'machine.c',
> >    'nmi.c',
> > -  'null-machine.c',
> >    'qdev-fw.c',
> >    'qdev-properties-system.c',
> >    'sysbus.c',
> > @@ -45,5 +44,6 @@ softmmu_ss.add(files(
> >
> >  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
> >    'machine-qmp-cmds.c',
> > +  'null-machine.c',
> >    'numa.c',
> >  ))
> > diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > index 7e69352..4b4ab76 100644
> > --- a/hw/core/null-machine.c
> > +++ b/hw/core/null-machine.c
> > @@ -17,6 +17,9 @@
> >  #include "sysemu/sysemu.h"
> >  #include "exec/address-spaces.h"
> >  #include "hw/core/cpu.h"
> > +#ifdef TARGET_MIPS
> > +#include "kvm_mips.h"
> > +#endif
> >
> >  static void machine_none_init(MachineState *mch)
> >  {
> > @@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *m=
c)
> >      mc->no_floppy =3D 1;
> >      mc->no_cdrom =3D 1;
> >      mc->no_sdcard =3D 1;
> > +#ifdef TARGET_MIPS
> > +    mc->kvm_type =3D mips_kvm_type;
> > +#endif
>
> I'm a bit confused here, you are taking the same path from your v4...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712550.html
>
> Did you rebase the correct version?
The old patch has split to two parts, the first part is used by MIPS
machine and already merged. This is the second part used by the
null-machine (and libvirt use null-machine to detect kvm
capabilities).

Huacai
>
> >  }
> >
> >  DEFINE_MACHINE("none", machine_none_machine_init)
> >

