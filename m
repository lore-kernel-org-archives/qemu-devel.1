Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EBC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A6520882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7QiniTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A6520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTEI-00044q-A8
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iCTCQ-0002nt-SU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iCTCO-0002xJ-CE
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:36:38 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iCTCO-0002wp-6s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:36:36 -0400
Received: by mail-qt1-x841.google.com with SMTP id n7so18385048qtb.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YabcjeTFAAe5ZMdv64YzXMDO2i14GHKKmFFTyjQnKMA=;
 b=X7QiniTcJBk0fRmbeQkNylmFzYAw5Kc2QhnJf8bnNv1S0+mnP3sreyhHsjF2G2D1/o
 cWux4wEU5yZGEU9z7iDp0jzXnarBK+0l5AJhE9r2aG378Gq6/RzW/sm6uaKiSG+H7TFE
 wpv9m4E6pS0/i8F5o6l4tpAAlbWAm6V1YIRhmq5032hcEWdbopA/b4QzFmeivm/fZA7B
 UqhHvFBl1UVJxXwdtaN4oaGRg3nqONIQZHTGONuDDKGzFKvMh2n2RyosmsE+vyhAmUop
 0Ew9zYBVM6pWlT7ZeJD0KzD0iHUchtcFfga140cV/hfb5SttclrWyErFVM+JZXc+93jF
 ZC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YabcjeTFAAe5ZMdv64YzXMDO2i14GHKKmFFTyjQnKMA=;
 b=sYEROq6g9Z2efNl8Sm87OUHqniY02d2ERy5F+peYdDFdRS3TyIocq4CvbfmBaWBcFo
 5Y0vbtELmJW5K6bJVBXoUppTGalvgPe3Ei9U8uNF38hHnEDUWK7LrEy+7xCGle7J5QAS
 r8PyPx/vEd/2IASPSlhx9LoFtjIom91gKpbJuGcBVO9MairobOWkVU/pyYuwIVmFnnqk
 fMKf2fCAutFaEf1G87VcLeRR/HdWFu33rl+gUXQNpcIGwg4rHC2KlTFWdYZu9mmf9lFq
 yPevp/V1lMNNIC3QV57Y96GjDloPkebH3zie6rPkZWL3bSDoHFANLTItuIKmk9LBi2YJ
 CLXQ==
X-Gm-Message-State: APjAAAWZQDh8jwbGayv+Ad5o5hT6eTAbgmGaUqE6j+PI7V8eg05EQhs2
 WH9Io5aD/NWaPxu74VfF9d6tMMY=
X-Google-Smtp-Source: APXvYqy2fdEcXIWBoYXcRLxg+LPDS82nD9cShWd1OI3O5iWFeP629CE1bNoD9ZFsdCpJHcyEa9v21g==
X-Received: by 2002:ac8:1c54:: with SMTP id j20mr1516904qtk.302.1569263795365; 
 Mon, 23 Sep 2019 11:36:35 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id 22sm5126837qkj.0.2019.09.23.11.36.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Sep 2019 11:36:34 -0700 (PDT)
Date: Mon, 23 Sep 2019 14:36:29 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: [Qemu-devel] [RFC QEMU v2 1/2] arm/virt: Initialize generic
 timer scale factor dynamically
Message-ID: <20190923183628.4jj5yougeksylqrt@gabell>
References: <1543352837-21529-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1543352837-21529-2-git-send-email-bijan.mottahedeh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543352837-21529-2-git-send-email-bijan.mottahedeh@oracle.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This issue remains on the latest qemu, right?
Let me add some comments for the patch.

On Tue, Nov 27, 2018 at 01:07:16PM -0800, Bijan Mottahedeh wrote:
> Initialize the generic timer scale factor based on the counter frequency
> register cntfrq_el0, and default to the current static value if necessary.
> Always use the default value for TCG.
> 
> Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> ---
>  hw/arm/virt.c          | 17 +++++++++++++++++
>  target/arm/helper.c    | 19 ++++++++++++++++---
>  target/arm/internals.h |  8 ++++++--
>  target/arm/kvm64.c     |  1 +
>  4 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcd..792d223 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "target/arm/internals.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1710,6 +1711,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>  
> +static void set_system_clock_scale(void)
> +{
> +    unsigned long cntfrq_el0 = 0;
> +
> +#ifdef  CONFIG_KVM
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(cntfrq_el0));
> +#endif
> +
> +    if (cntfrq_el0 == 0) {
> +        cntfrq_el0 = GTIMER_SCALE_DEF;
> +    }
> +
> +    system_clock_scale = NANOSECONDS_PER_SECOND / (int)cntfrq_el0;
> +}
> +
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1736,6 +1752,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>      hc->plug = virt_machine_device_plug_cb;
> +    set_system_clock_scale();
>  }
>  
>  static const TypeInfo virt_machine_info = {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 66afb08..6330586 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/kvm.h"
>  #include "fpu/softfloat.h"
>  #include "qemu/range.h"
> +#include "hw/arm/arm.h"

arm.h is renamed to boot.h, so:

#include "hw/arm/boot.h"

>  
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
>  
> @@ -1614,6 +1615,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>  
> +static void gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    assert(GTIMER_SCALE);
> +    assert(ri->fieldoffset);
> +
> +    if (cpreg_field_is_64bit(ri)) {
> +        CPREG_FIELD64(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> +    } else {
> +        CPREG_FIELD32(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> +    }
> +}
> +
>  static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
>                                          bool isread)
>  {
> @@ -1709,7 +1722,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>      }
>  }
>  
> -static uint64_t gt_get_countervalue(CPUARMState *env)
> +uint64_t gt_get_countervalue(CPUARMState *env)
>  {
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
>  }
> @@ -1996,7 +2009,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
> +      .resetfn = gt_cntfrq_reset,

Build error is here on the target aarch64-linux-user, like as:

/home/foo/qemu/target/arm/helper.c:2901:18: error: 'gt_cntfrq_reset' undeclared here (not in a function); did you mean 'g_timer_reset'?
       .resetfn = gt_cntfrq_reset,
                  ^~~~~~~~~~~~~~~

The issue doesn't affect to aarch64-linux-user, right?
If so:

#ifdef CONFIG_LINUX_USER
      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
#else
      .resetfn = gt_cntfrq_reset,
#endif

>      },
>      /* overall control: mostly access permissions */
>      { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
> @@ -2187,7 +2200,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
> +      .resetfn = gt_cntfrq_reset,

Same as above.

>      },
>      { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index dc93577..b66a1fa 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -52,9 +52,13 @@ static inline bool excp_is_internal(int excp)
>  }
>  
>  /* Scale factor for generic timers, ie number of ns per tick.
> - * This gives a 62.5MHz timer.
> + * Calculated dynamically based on CNTFRQ with a default value
> + * that gives a 62.5MHZ timer.
>   */
> -#define GTIMER_SCALE 16
> +#define GTIMER_SCALE        system_clock_scale
> +#define GTIMER_SCALE_DEF    16

I think extern for system_clock_scale should be added here,
otherwise the build error happens.
If the issue doesn't affect to aarch64-linux-user, how about the following?

#ifndef CONFIG_LINUX_USER
extern int system_clock_scale;
#define GTIMER_SCALE        system_clock_scale
#define GTIMER_SCALE_DEF    16
#else
#define GTIMER_SCALE        16
#endif

> +
> +uint64_t gt_get_countervalue(CPUARMState *);
>  
>  /* Bit definitions for the v7M CONTROL register */
>  FIELD(V7M_CONTROL, NPRIV, 0, 1)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e0b8246..5d1c394 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -485,6 +485,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      set_feature(&features, ARM_FEATURE_NEON);
>      set_feature(&features, ARM_FEATURE_AARCH64);
>      set_feature(&features, ARM_FEATURE_PMU);
> +    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
>  
>      ahcf->features = features;

Thanks,
Masa

