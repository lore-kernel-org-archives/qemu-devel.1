Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DA320EDD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crOWA+S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DA320EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqJr-0003Gk-Hv
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kFqJ8-0002UZ-3u
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:58:02 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kFqJ4-0008F6-Rf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:58:01 -0400
Received: by mail-lj1-x242.google.com with SMTP id v23so1573020ljd.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 19:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6q0qO8r2NTq7pnimF+Mx4S7abiDBU3hJeehOWWdY3q4=;
 b=crOWA+S5VTDvdiVRFf+KeFYdAS34fLf/DHVCrqu/IXVMiwq5eLu41kNz0lP9ZpWYjl
 ukvGuQqgEDtT1RvdN4VJNw0qitFKHgdZ0GvK/PJAOPn+ZjIqE+2N/qBCJEUM6hjhygAV
 eOqQg+VevkfP3fwJpi3uDI7An65ruiKyVepwQhWOaXeH9KgCg1Zmnh+S20ztrbYKaRHV
 ScoTWP4bZsliCPiasWCsgQIC6QlJ9M1m7jtV4hc9Of+lQAJG/4HGwPkvI7Go2GxMpDc5
 6tDiwXmx8JfivVS/yyVjQ0ApWXZAIB2p4/d2XSwkW7n+u6nhknu/HZMBtU9dck/B3EJJ
 o7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6q0qO8r2NTq7pnimF+Mx4S7abiDBU3hJeehOWWdY3q4=;
 b=cHI1Lh24NJslSJGU9cQkFIZayvwEexxwcfM4pyLPzQyz0vLjeB8z1tedxRPG8Ebu42
 zXhwQSd8kMeuBL5BWt3hsWTSaveIqDEvh/tC+F0JRcGwxW+mvhfajPGBEqMZ497Tj/P9
 0Pks1HmD6M52XztYMAEwr2l2gopvyt9+l+7WhQgCICEgT5F+SqpSUyXL+KUkhVUlk/Ky
 aCBw1gVKZyk0Wjk+p5svD/OzqO9MtBSsE1GU+YQxX1Uom/S/KrwdyeWL5Lllr7ReknFf
 8TJ6KQsMqrV0RpWH595vXQvoqEnFOzEQj13dPSSEG3M0kNF7kE43cwfvHA0b2h4qkfJs
 ugtg==
X-Gm-Message-State: AOAM5302Pxkl3gNHUyxOEEjz1B2AY+Zye4PuE/WP/9LBMxy4IyXewVBD
 WMn0Ht26UNLKdJxaYdZA4puRtJ3LeVYJoR/Duks=
X-Google-Smtp-Source: ABdhPJwCOwqCJ+1yUIeb78ZktoCyQNGbP7vZcQLSEfvo7ODxEQME1hGXUAOpTftRtUBgEFRmCDEKddc/B8qn+jKYvU8=
X-Received: by 2002:a2e:8215:: with SMTP id w21mr720559ljg.43.1599620276033;
 Tue, 08 Sep 2020 19:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
In-Reply-To: <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Wed, 9 Sep 2020 10:57:44 +0800
Message-ID: <CABDp7VoRCMsW6b17XEek3-EJLHgY=bCXnx5B1ZWCOkHq0aasxw@mail.gmail.com>
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, all,

On Wed, Sep 9, 2020 at 1:25 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 24/08/2020 10.11, Huacai Chen wrote:
> > MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> > libvirt uses a null-machine to detect the kvm capability. In the MIPS
> > case, it will return "KVM not supported" on a VZ platform by default.
> > So, add the kvm_type() hook to the null-machine.
> >
> > This seems not a very good solution, but I cannot do it better now.
>
> This is still ugly. Why do the other architectures do not have the
> same problem? Let's see... in kvm-all.c, we have:
>
>     int type = 0;
>     [...]
>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>     if (mc->kvm_type) {
>         type = mc->kvm_type(ms, kvm_type);
>     } else if (kvm_type) {
>         ret = -EINVAL;
>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
>         goto err;
>     }
>
>     do {
>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
>     } while (ret == -EINTR);
>
> Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
> case (i.e. when libvirt probes with the "null"-machine).
>
> Now let's have a look at the kernel. The "type" parameter is passed
> there to the architecture specific function kvm_arch_init_vm().
> For powerpc, this looks like:
>
>         if (type == 0) {
>                 if (kvmppc_hv_ops)
>                         kvm_ops = kvmppc_hv_ops;
>                 else
>                         kvm_ops = kvmppc_pr_ops;
>                 if (!kvm_ops)
>                         goto err_out;
>         } else  if (type == KVM_VM_PPC_HV) {
>                 if (!kvmppc_hv_ops)
>                         goto err_out;
>                 kvm_ops = kvmppc_hv_ops;
>         } else if (type == KVM_VM_PPC_PR) {
>                 if (!kvmppc_pr_ops)
>                         goto err_out;
>                 kvm_ops = kvmppc_pr_ops;
>         } else
>                 goto err_out;
>
> That means for type == 0, it automatically detects the best
> kvm-type.
>
> For mips, this function looks like this:
>
>         switch (type) {
> #ifdef CONFIG_KVM_MIPS_VZ
>         case KVM_VM_MIPS_VZ:
> #else
>         case KVM_VM_MIPS_TE:
> #endif
>                 break;
>         default:
>                 /* Unsupported KVM type */
>                 return -EINVAL;
>         };
>
> That means, for type == 0, it returns -EINVAL here!
>
> Looking at the API docu in Documentation/virt/kvm/api.rst
> the description of the type parameter is quite sparse, but it
> says:
>
>  "You probably want to use 0 as machine type."
>
> So I think this is a bug in the implementation of KVM in the
> mips kernel code. The kvm_arch_init_vm() in the mips code should
> do the same as on powerpc, and use the best available KVM type
> there instead of returning EINVAL. Once that is fixed there,
> you don't need this patch here for QEMU anymore.
Yes, PPC use a good method, because it can use 0 as "automatic"
#define KVM_VM_PPC_HV 1
#define KVM_VM_PPC_PR 2

Unfortunately, MIPS cannot do like this because it define 0 as "TE":
#define KVM_VM_MIPS_TE          0
#define KVM_VM_MIPS_VZ          1

So, it cannot be solved in kernel side, unless changing the definition
of TE/VZ, but I think changing their definition is also unacceptable.

Huacai

>
>  HTH,
>   Thomas
>
>
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
> > @@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *mc)
> >      mc->no_floppy = 1;
> >      mc->no_cdrom = 1;
> >      mc->no_sdcard = 1;
> > +#ifdef TARGET_MIPS
> > +    mc->kvm_type = mips_kvm_type;
> > +#endif
> >  }
> >
> >  DEFINE_MACHINE("none", machine_none_machine_init)
> >
>


-- 
Huacai Chen

