Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A4E20709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4PV0TMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A4E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joR36-0002wQ-Dx
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joR2J-0002V4-WF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:31:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joR2C-0001M4-LN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:31:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id t194so5736425wmt.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vLx/rVdcsTPPzKn/NJD9+nWah4SnC8Q984keWnHlvGE=;
 b=D4PV0TMkf/QMGZeRhokHT0nGoR4QuCo1jF4o42YuXw9Nfk0x6SKPqVxZg4Veeht4aF
 XZru2HZ8aY0KhkU5ApxbIvmRs2PNI1eo5BHDZHQjw8/YgS4E1IVojpDRr0je+9pfeR7T
 6C2KvofLqrT/o1Zbh7FIe0388sdzk8YoTA7aLYPDJziCltXNmsfJx/2S9cryR2AYZBwN
 VA2jJ6giBHEoW5lP/fcwRq0rMZPRtGZV9MFw+qp1Jw2PgruZdF0oc6qHEwmWzOLfPGHn
 P1Y00+uRr8mdoMA4cG6sUVemPRHmRz8ie3A1eZo8OXedZYQ+FzbkXFuy2gtWxxUY317K
 VFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vLx/rVdcsTPPzKn/NJD9+nWah4SnC8Q984keWnHlvGE=;
 b=eg80xQZ7PKx33HZf/e3+0XMRUJjUggM5Zkxp9DWHikO1aV4dQ/l+jH2GLCdzlZneli
 vTCXe3g9N0NQo5Y8AZO+LTpQ5OQhKyEt+HRRCADiuQDEY6ccCZgUj1CgXDd9KZGhDSMX
 7c7hsB0xyTO8awVR+bqerBKkYkVRDpEESqjSwxm6DMhY3xbVQCBuQ2TQFUUEGwXfa1N8
 BXt79O8lgkOhZZTrml+e9/QPW6AZHlkfKBCWNb4zaAD7D/UPngepcH6xQizpbVbfdvjB
 vSMQcK1FPam0uWHuPTU7pwPaMpPUVTI2ddISqXeB2e6Z8SLk0Cu6dLezW7kBiN0FqYOG
 o7lA==
X-Gm-Message-State: AOAM533HBa/De0lnAtXOhvM78u/+AVU4JBgwdOB1DgYXfSIOQbaxoNz5
 EJBpEVl21Mh2jFJa69xBQFHNEOvL2iaaImd+aSM=
X-Google-Smtp-Source: ABdhPJwK5Fv3m7r98HVBR989A/LsUkzRvmG/hf0/cJq8ZHSoclzmWIh7UN32RF+x9gM4NEWnlFHR0npXTZFT3jUmtfo=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr3016633wme.159.1593088274184; 
 Thu, 25 Jun 2020 05:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
 <1592995531-32600-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1592995531-32600-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 14:31:01 +0200
Message-ID: <CAHiYmc5ZbZSyMxevp-Ta1fWsY67yt6S_bhoHr5CGYPWN=KTLbQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 24. =D1=98=D1=83=D0=BD 2020. =D1=83 12:44 Huacai Chen <=
zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
> MachineClass. This patch add the the kvm_type() hook to support both of
> the two types.
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  target/mips/kvm.c      | 20 ++++++++++++++++++++
>  target/mips/kvm_mips.h | 11 +++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 96cfa10..373f582 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -21,10 +21,12 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/timer.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/kvm_int.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/cpus.h"
>  #include "kvm_mips.h"
>  #include "exec/memattrs.h"
> +#include "hw/boards.h"
>
>  #define DEBUG_KVM 0
>
> @@ -1270,3 +1272,21 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>  {
>      abort();
>  }
> +
> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> +{
> +    int r;
> +    KVMState *s =3D KVM_STATE(machine->accelerator);
> +
> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);

This will not work for build systems with kernel < 4.12. You need to
provide fallback solution for that case.

> +    if (r > 0) {
> +        return KVM_VM_MIPS_VZ;
> +    }
> +
> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
> +    if (r > 0) {
> +        return KVM_VM_MIPS_TE;
> +    }
> +
> +    return -1;
> +}
> diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
> index 1e40147..171d53d 100644
> --- a/target/mips/kvm_mips.h
> +++ b/target/mips/kvm_mips.h
> @@ -12,6 +12,8 @@
>  #ifndef KVM_MIPS_H
>  #define KVM_MIPS_H
>
> +#include "cpu.h"
> +
>  /**
>   * kvm_mips_reset_vcpu:
>   * @cpu: MIPSCPU
> @@ -23,4 +25,13 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu);
>  int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
>  int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
>
> +#ifdef CONFIG_KVM
> +int mips_kvm_type(MachineState *machine, const char *vm_type);
> +#else
> +static inline int mips_kvm_type(MachineState *machine, const char *vm_ty=
pe)
> +{
> +    return 0;
> +}
> +#endif
> +
>  #endif /* KVM_MIPS_H */
> --
> 2.7.0
>

