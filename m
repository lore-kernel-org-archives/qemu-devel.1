Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB99C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA932076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIdRFB/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA932076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETeC-0007Tx-HA
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jETcV-0006XC-Ub
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jETcQ-0006xM-OT
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:00:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jETcQ-0006wz-G0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584518402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opZalyoMUrKKL1iXiWGjlWhPOq8s/+RqABQ/vz6N2jE=;
 b=JIdRFB/3L/3e70n/HXtxKYPp04k0EghWo2/CHJ+ZsGOuP3/Ug6Ggb3d6P8oPjX0zbNrKWJ
 9OrQjVnecj3JEFIv/KeiNsuYNN/EKJpb59kvw/HTW1RlzEvL0toMazQo+da7IzSdwA7Y4C
 mojwwdisCpjDoids4XOOmzde1woMyZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-cXh5HakcM5W1ktINnR3rpA-1; Wed, 18 Mar 2020 03:59:56 -0400
X-MC-Unique: cXh5HakcM5W1ktINnR3rpA-1
Received: by mail-wr1-f71.google.com with SMTP id t10so5630317wrp.15
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 00:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9RRu+qpAqdEbVazuvoocRQdXfeB53GPFe8cPHXgKdmo=;
 b=d+cPrcZjtl4/NI+1guxuEd5Tsks/Pq4zrdIwToQhrvzznxabSLRar9Ps01MZVNMKaC
 HovujfJ049kp46rLnf1z7Kj9bQUaLdlRecQS0W6f5cnTkUql6g+oa6hVw9vvt3ctPIla
 vIyQOjaK4VSvBhlWSddqXrUyByEOimLNzlCs1JdiYVk2S9yNqdUCUMJfxnPiPbBk7yUH
 Z60wMnlf+QJN0cAK6rOWKUWObLYXgBCt29AU48mQANwvcz21A4nWwCBj2zpDb2I54yx6
 2MdB/0OeevjkXhXOLtXzWI4e7KyXraZH+x9sElYksezmc4xG0uX2tnSV70+8+2Koobz0
 k1dw==
X-Gm-Message-State: ANhLgQ0shVoc7neicBjwG+6kmExyvLJZOTIQVntu3zZZuaWQ8frU8cAS
 6Gp/qw4KTvgcLjnWHBAYBfo1AEIJReb0uX4V85OCeg8KflGzrreioy28DcZMKVSuSmPkNOxaxEQ
 IWbrnj6q2ZfOEvUk=
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr562671wrw.170.1584518394166;
 Wed, 18 Mar 2020 00:59:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFNosL/Fv9cbzX9141TmyD2E4KaSGu5O7a4fgmq0lBsjnieZadlUNNTkegM4sYYY3RFIQzcA==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr562602wrw.170.1584518393446;
 Wed, 18 Mar 2020 00:59:53 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id q4sm28381wmj.1.2020.03.18.00.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 00:59:52 -0700 (PDT)
Subject: Re: [PULL 07/13] cpu: Use DeviceClass reset instead of a special
 CPUClass reset
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
 <20200318011748.2104336-8-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0ec4123-93ed-95ad-3f6b-61d6495983f0@redhat.com>
Date: Wed, 18 Mar 2020 08:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318011748.2104336-8-ehabkost@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 2:17 AM, Eduardo Habkost wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>=20
> The CPUClass has a 'reset' method.  This is a legacy from when
> TYPE_CPU used not to inherit from TYPE_DEVICE.  We don't need it any
> more, as we can simply use the TYPE_DEVICE reset.  The 'cpu_reset()'
> function is kept as the API which most places use to reset a CPU; it
> is now a wrapper which calls device_cold_reset() and then the
> tracepoint function.
>=20
> This change should not cause CPU objects to be reset more often
> than they are at the moment, because:
>   * nobody is directly calling device_cold_reset() or
>     qdev_reset_all() on CPU objects
>   * no CPU object is on a qbus, so they will not be reset either
>     by somebody calling qbus_reset_all()/bus_cold_reset(), or
>     by the main "reset sysbus and everything in the qbus tree"
>     reset that most devices are reset by
>=20
> Note that this does not change the need for each machine or whatever
> to use qemu_register_reset() to arrange to call cpu_reset() -- that
> is necessary because CPU objects are not on any qbus, so they don't
> get reset when the qbus tree rooted at the sysbus bus is reset, and
> this isn't being changed here.
>=20
> All the changes to the files under target/ were made using the
> included Coccinelle script, except:
>=20
> (1) the deletion of the now-inaccurate and not terribly useful
> "CPUClass::reset" comments was done with a perl one-liner afterwards:
>    perl -n -i -e '/ CPUClass::reset/ or print' target/*/*.c
>=20
> (2) this bit of the s390 change was done by hand, because the
> Coccinelle script is not sophisticated enough to handle the
> parent_reset call being inside another function:
>=20
> | @@ -96,8 +96,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_typ=
e type)
> |     S390CPU *cpu =3D S390_CPU(s);
> |     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
> |     CPUS390XState *env =3D &cpu->env;
> |+    DeviceState *dev =3D DEVICE(s);
> |
> |-    scc->parent_reset(s);
> |+    scc->parent_reset(dev);
> |     cpu->env.sigp_order =3D 0;
> |     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-Id: <20200303100511.5498-1-peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   hw/core/cpu.c                      | 19 +++---------
>   include/hw/core/cpu.h              |  6 ----
>   scripts/coccinelle/cpu-reset.cocci | 47 ++++++++++++++++++++++++++++++
>   target/alpha/cpu-qom.h             |  2 +-
>   target/arm/cpu-qom.h               |  2 +-
>   target/arm/cpu.c                   |  8 ++---
>   target/cris/cpu-qom.h              |  2 +-
>   target/cris/cpu.c                  |  8 ++---
>   target/hppa/cpu-qom.h              |  2 +-
>   target/i386/cpu-qom.h              |  2 +-
>   target/i386/cpu.c                  |  8 ++---
>   target/lm32/cpu-qom.h              |  2 +-
>   target/lm32/cpu.c                  |  8 ++---
>   target/m68k/cpu-qom.h              |  2 +-
>   target/m68k/cpu.c                  |  8 ++---
>   target/microblaze/cpu-qom.h        |  2 +-
>   target/microblaze/cpu.c            |  8 ++---
>   target/mips/cpu-qom.h              |  2 +-
>   target/mips/cpu.c                  |  8 ++---
>   target/moxie/cpu.c                 |  7 +++--
>   target/moxie/cpu.h                 |  2 +-
>   target/nios2/cpu.c                 |  8 ++---
>   target/nios2/cpu.h                 |  2 +-
>   target/openrisc/cpu.c              |  8 ++---
>   target/openrisc/cpu.h              |  2 +-
>   target/ppc/cpu-qom.h               |  2 +-
>   target/ppc/translate_init.inc.c    |  8 ++---
>   target/riscv/cpu.c                 |  7 +++--
>   target/riscv/cpu.h                 |  2 +-
>   target/s390x/cpu-qom.h             |  2 +-
>   target/s390x/cpu.c                 |  8 +++--
>   target/sh4/cpu-qom.h               |  2 +-
>   target/sh4/cpu.c                   |  8 ++---
>   target/sparc/cpu-qom.h             |  2 +-
>   target/sparc/cpu.c                 |  8 ++---
>   target/tilegx/cpu.c                |  7 +++--
>   target/tilegx/cpu.h                |  2 +-
>   target/tricore/cpu-qom.h           |  2 +-
>   target/tricore/cpu.c               |  7 +++--
>   target/xtensa/cpu-qom.h            |  2 +-
>   target/xtensa/cpu.c                |  8 ++---
>   41 files changed, 144 insertions(+), 108 deletions(-)
>   create mode 100644 scripts/coccinelle/cpu-reset.cocci
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index fe65ca62ac..b889878f3c 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -239,27 +239,16 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
>       }
>   }
>  =20
> -void cpu_class_set_parent_reset(CPUClass *cc,
> -                                void (*child_reset)(CPUState *cpu),
> -                                void (**parent_reset)(CPUState *cpu))
> -{
> -    *parent_reset =3D cc->reset;
> -    cc->reset =3D child_reset;
> -}
> -
>   void cpu_reset(CPUState *cpu)
>   {
> -    CPUClass *klass =3D CPU_GET_CLASS(cpu);
> -
> -    if (klass->reset !=3D NULL) {
> -        (*klass->reset)(cpu);
> -    }
> +    device_cold_reset(DEVICE(cpu));
>  =20
>       trace_guest_cpu_reset(cpu);
>   }
>  =20
> -static void cpu_common_reset(CPUState *cpu)
> +static void cpu_common_reset(DeviceState *dev)
>   {
> +    CPUState *cpu =3D CPU(dev);
>       CPUClass *cc =3D CPU_GET_CLASS(cpu);
>  =20
>       if (qemu_loglevel_mask(CPU_LOG_RESET)) {
> @@ -419,7 +408,6 @@ static void cpu_class_init(ObjectClass *klass, void *=
data)
>       CPUClass *k =3D CPU_CLASS(klass);
>  =20
>       k->parse_features =3D cpu_common_parse_features;
> -    k->reset =3D cpu_common_reset;
>       k->get_arch_id =3D cpu_common_get_arch_id;
>       k->has_work =3D cpu_common_has_work;
>       k->get_paging_enabled =3D cpu_common_get_paging_enabled;
> @@ -440,6 +428,7 @@ static void cpu_class_init(ObjectClass *klass, void *=
data)
>       set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>       dc->realize =3D cpu_common_realizefn;
>       dc->unrealize =3D cpu_common_unrealizefn;
> +    dc->reset =3D cpu_common_reset;
>       device_class_set_props(dc, cpu_common_props);
>       /*
>        * Reason: CPUs still need special care by board code: wiring up
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 73e9a869a4..88ee543722 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -79,7 +79,6 @@ struct TranslationBlock;
>    * @class_by_name: Callback to map -cpu command line model name to an
>    * instantiatable CPU type.
>    * @parse_features: Callback to parse command line arguments.
> - * @reset: Callback to reset the #CPUState to its initial state.
>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>    * @has_work: Callback for checking if there is work to do.
>    * @do_interrupt: Callback for interrupt handling.
> @@ -165,7 +164,6 @@ typedef struct CPUClass {
>       ObjectClass *(*class_by_name)(const char *cpu_model);
>       void (*parse_features)(const char *typename, char *str, Error **err=
p);
>  =20
> -    void (*reset)(CPUState *cpu);

Unfortunately this is going to clash with the "Add the Renesas RX=20
architecture" series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689956.html

Peter, due to the different set of testing and the timezone lag with=20
Eduardo, I suggest you skip the RX pull request and I repost the pull=20
request once this patch is merged.

>       int reset_dump_flags;
>       bool (*has_work)(CPUState *cpu);
>       void (*do_interrupt)(CPUState *cpu);
> @@ -1135,10 +1133,6 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>    */
>   bool target_words_bigendian(void);
>  =20
> -void cpu_class_set_parent_reset(CPUClass *cc,
> -                                void (*child_reset)(CPUState *cpu),
> -                                void (**parent_reset)(CPUState *cpu));
> -
>   #ifdef NEED_CPU_H
>  =20
>   #ifdef CONFIG_SOFTMMU
> diff --git a/scripts/coccinelle/cpu-reset.cocci b/scripts/coccinelle/cpu-=
reset.cocci
> new file mode 100644
> index 0000000000..396a724e51
> --- /dev/null
> +++ b/scripts/coccinelle/cpu-reset.cocci
> @@ -0,0 +1,47 @@
> +// Convert targets using the old CPUState reset to DeviceState reset
> +//
> +// Copyright Linaro Ltd 2020
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch --macro-file scripts/cocci-macro-file.h \
> +//        --sp-file scripts/coccinelle/cpu-reset.cocci \
> +//        --keep-comments --smpl-spacing --in-place --include-headers --=
dir target
> +//
> +// For simplicity we assume some things about the code we're modifying
> +// that happen to be true for all our targets:
> +//  * all cpu_class_set_parent_reset() callsites have a 'DeviceClass *dc=
' local
> +//  * the parent reset field in the target CPU class is 'parent_reset'
> +//  * no reset function already has a 'dev' local
> +
> +@@
> +identifier cpu, x;
> +typedef CPUState;
> +@@
> +struct x {
> +...
> +- void (*parent_reset)(CPUState *cpu);
> ++ DeviceReset parent_reset;
> +...
> +};
> +@ rule1 @
> +identifier resetfn;
> +expression resetfield;
> +identifier cc;
> +@@
> +- cpu_class_set_parent_reset(cc, resetfn, resetfield)
> ++ device_class_set_parent_reset(dc, resetfn, resetfield)
> +@@
> +identifier rule1.resetfn;
> +identifier cpu, cc;
> +typedef CPUState, DeviceState;
> +@@
> +-resetfn(CPUState *cpu)
> +-{
> ++resetfn(DeviceState *dev)
> ++{
> ++    CPUState *cpu =3D CPU(dev);
> +<...
> +-    cc->parent_reset(cpu);
> ++    cc->parent_reset(dev);
> +...>
> +}
> diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
> index 6f0a0adb9e..08832fa767 100644
> --- a/target/alpha/cpu-qom.h
> +++ b/target/alpha/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct AlphaCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } AlphaCPUClass;
>  =20
>   typedef struct AlphaCPU AlphaCPU;
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 3a9d31ea9d..d95568bf05 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct ARMCPUClass {
>  =20
>       const ARMCPUInfo *info;
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } ARMCPUClass;
>  =20
>   typedef struct ARMCPU ARMCPU;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7fe367078c..8e5ba619a0 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -155,14 +155,14 @@ static void cp_reg_check_reset(gpointer key, gpoint=
er value,  gpointer opaque)
>       assert(oldvalue =3D=3D newvalue);
>   }
>  =20
> -/* CPUClass::reset() */
> -static void arm_cpu_reset(CPUState *s)
> +static void arm_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       ARMCPU *cpu =3D ARM_CPU(s);
>       ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(cpu);
>       CPUARMState *env =3D &cpu->env;
>  =20
> -    acc->parent_reset(s);
> +    acc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUARMState, end_reset_fields));
>  =20
> @@ -2785,7 +2785,7 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
>                                       &acc->parent_realize);
>  =20
>       device_class_set_props(dc, arm_cpu_properties);
> -    cpu_class_set_parent_reset(cc, arm_cpu_reset, &acc->parent_reset);
> +    device_class_set_parent_reset(dc, arm_cpu_reset, &acc->parent_reset)=
;
>  =20
>       cc->class_by_name =3D arm_cpu_class_by_name;
>       cc->has_work =3D arm_cpu_has_work;
> diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
> index 308c1f95bd..f1de6041dc 100644
> --- a/target/cris/cpu-qom.h
> +++ b/target/cris/cpu-qom.h
> @@ -45,7 +45,7 @@ typedef struct CRISCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>  =20
>       uint32_t vr;
>   } CRISCPUClass;
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 17c6712e29..cff6b9eabf 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -40,15 +40,15 @@ static bool cris_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_=
NMI);
>   }
>  =20
> -/* CPUClass::reset() */
> -static void cris_cpu_reset(CPUState *s)
> +static void cris_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       CRISCPU *cpu =3D CRIS_CPU(s);
>       CRISCPUClass *ccc =3D CRIS_CPU_GET_CLASS(cpu);
>       CPUCRISState *env =3D &cpu->env;
>       uint32_t vr;
>  =20
> -    ccc->parent_reset(s);
> +    ccc->parent_reset(dev);
>  =20
>       vr =3D env->pregs[PR_VR];
>       memset(env, 0, offsetof(CPUCRISState, end_reset_fields));
> @@ -264,7 +264,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void=
 *data)
>       device_class_set_parent_realize(dc, cris_cpu_realizefn,
>                                       &ccc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, cris_cpu_reset, &ccc->parent_reset);
> +    device_class_set_parent_reset(dc, cris_cpu_reset, &ccc->parent_reset=
);
>  =20
>       cc->class_by_name =3D cris_cpu_class_by_name;
>       cc->has_work =3D cris_cpu_has_work;
> diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
> index 6367dc4793..b1f6045495 100644
> --- a/target/hppa/cpu-qom.h
> +++ b/target/hppa/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct HPPACPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } HPPACPUClass;
>  =20
>   typedef struct HPPACPU HPPACPU;
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 0efab2fc67..3e96f8d668 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -71,7 +71,7 @@ typedef struct X86CPUClass {
>  =20
>       DeviceRealize parent_realize;
>       DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } X86CPUClass;
>  =20
>   typedef struct X86CPU X86CPU;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 350b51b346..fb3f3c54bb 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5983,9 +5983,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>       }
>   }
>  =20
> -/* CPUClass::reset() */
> -static void x86_cpu_reset(CPUState *s)
> +static void x86_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       X86CPU *cpu =3D X86_CPU(s);
>       X86CPUClass *xcc =3D X86_CPU_GET_CLASS(cpu);
>       CPUX86State *env =3D &cpu->env;
> @@ -5993,7 +5993,7 @@ static void x86_cpu_reset(CPUState *s)
>       uint64_t xcr0;
>       int i;
>  =20
> -    xcc->parent_reset(s);
> +    xcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUX86State, end_reset_fields));
>  =20
> @@ -7297,7 +7297,7 @@ static void x86_cpu_common_class_init(ObjectClass *=
oc, void *data)
>                                         &xcc->parent_unrealize);
>       device_class_set_props(dc, x86_cpu_properties);
>  =20
> -    cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
> +    device_class_set_parent_reset(dc, x86_cpu_reset, &xcc->parent_reset)=
;
>       cc->reset_dump_flags =3D CPU_DUMP_FPU | CPU_DUMP_CCOP;
>  =20
>       cc->class_by_name =3D x86_cpu_class_by_name;
> diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
> index dc9ac9ac9f..bdedb3759a 100644
> --- a/target/lm32/cpu-qom.h
> +++ b/target/lm32/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct LM32CPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } LM32CPUClass;
>  =20
>   typedef struct LM32CPU LM32CPU;
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 687bf35e65..c50ad5fa15 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -99,14 +99,14 @@ static bool lm32_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & CPU_INTERRUPT_HARD;
>   }
>  =20
> -/* CPUClass::reset() */
> -static void lm32_cpu_reset(CPUState *s)
> +static void lm32_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       LM32CPU *cpu =3D LM32_CPU(s);
>       LM32CPUClass *lcc =3D LM32_CPU_GET_CLASS(cpu);
>       CPULM32State *env =3D &cpu->env;
>  =20
> -    lcc->parent_reset(s);
> +    lcc->parent_reset(dev);
>  =20
>       /* reset cpu state */
>       memset(env, 0, offsetof(CPULM32State, end_reset_fields));
> @@ -218,7 +218,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void=
 *data)
>  =20
>       device_class_set_parent_realize(dc, lm32_cpu_realizefn,
>                                       &lcc->parent_realize);
> -    cpu_class_set_parent_reset(cc, lm32_cpu_reset, &lcc->parent_reset);
> +    device_class_set_parent_reset(dc, lm32_cpu_reset, &lcc->parent_reset=
);
>  =20
>       cc->class_by_name =3D lm32_cpu_class_by_name;
>       cc->has_work =3D lm32_cpu_has_work;
> diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
> index b56da8a213..88b11b60f1 100644
> --- a/target/m68k/cpu-qom.h
> +++ b/target/m68k/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct M68kCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } M68kCPUClass;
>  =20
>   typedef struct M68kCPU M68kCPU;
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f0653cda2f..9445fcd6df 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -41,16 +41,16 @@ static void m68k_set_feature(CPUM68KState *env, int f=
eature)
>       env->features |=3D (1u << feature);
>   }
>  =20
> -/* CPUClass::reset() */
> -static void m68k_cpu_reset(CPUState *s)
> +static void m68k_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       M68kCPU *cpu =3D M68K_CPU(s);
>       M68kCPUClass *mcc =3D M68K_CPU_GET_CLASS(cpu);
>       CPUM68KState *env =3D &cpu->env;
>       floatx80 nan =3D floatx80_default_nan(NULL);
>       int i;
>  =20
> -    mcc->parent_reset(s);
> +    mcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUM68KState, end_reset_fields));
>   #ifdef CONFIG_SOFTMMU
> @@ -273,7 +273,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void =
*data)
>  =20
>       device_class_set_parent_realize(dc, m68k_cpu_realizefn,
>                                       &mcc->parent_realize);
> -    cpu_class_set_parent_reset(cc, m68k_cpu_reset, &mcc->parent_reset);
> +    device_class_set_parent_reset(dc, m68k_cpu_reset, &mcc->parent_reset=
);
>  =20
>       cc->class_by_name =3D m68k_cpu_class_by_name;
>       cc->has_work =3D m68k_cpu_has_work;
> diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
> index 49b07cc697..053ba44ee8 100644
> --- a/target/microblaze/cpu-qom.h
> +++ b/target/microblaze/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct MicroBlazeCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } MicroBlazeCPUClass;
>  =20
>   typedef struct MicroBlazeCPU MicroBlazeCPU;
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 8c90110e52..a2c2f271df 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -102,14 +102,14 @@ static void microblaze_cpu_set_irq(void *opaque, in=
t irq, int level)
>   }
>   #endif
>  =20
> -/* CPUClass::reset() */
> -static void mb_cpu_reset(CPUState *s)
> +static void mb_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(s);
>       MicroBlazeCPUClass *mcc =3D MICROBLAZE_CPU_GET_CLASS(cpu);
>       CPUMBState *env =3D &cpu->env;
>  =20
> -    mcc->parent_reset(s);
> +    mcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUMBState, end_reset_fields));
>       env->res_addr =3D RES_ADDR_NONE;
> @@ -292,7 +292,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *=
data)
>  =20
>       device_class_set_parent_realize(dc, mb_cpu_realizefn,
>                                       &mcc->parent_realize);
> -    cpu_class_set_parent_reset(cc, mb_cpu_reset, &mcc->parent_reset);
> +    device_class_set_parent_reset(dc, mb_cpu_reset, &mcc->parent_reset);
>  =20
>       cc->class_by_name =3D mb_cpu_class_by_name;
>       cc->has_work =3D mb_cpu_has_work;
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index a430c0fe4b..9d0df6c034 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -48,7 +48,7 @@ typedef struct MIPSCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>       const struct mips_def_t *cpu_def;
>   } MIPSCPUClass;
>  =20
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 6cd6b9650b..e86cd06548 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -96,14 +96,14 @@ static bool mips_cpu_has_work(CPUState *cs)
>       return has_work;
>   }
>  =20
> -/* CPUClass::reset() */
> -static void mips_cpu_reset(CPUState *s)
> +static void mips_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       MIPSCPU *cpu =3D MIPS_CPU(s);
>       MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(cpu);
>       CPUMIPSState *env =3D &cpu->env;
>  =20
> -    mcc->parent_reset(s);
> +    mcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
>  =20
> @@ -189,7 +189,7 @@ static void mips_cpu_class_init(ObjectClass *c, void =
*data)
>  =20
>       device_class_set_parent_realize(dc, mips_cpu_realizefn,
>                                       &mcc->parent_realize);
> -    cpu_class_set_parent_reset(cc, mips_cpu_reset, &mcc->parent_reset);
> +    device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset=
);
>  =20
>       cc->class_by_name =3D mips_cpu_class_by_name;
>       cc->has_work =3D mips_cpu_has_work;
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index cf47bc709b..6e0443ccb7 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -35,13 +35,14 @@ static bool moxie_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & CPU_INTERRUPT_HARD;
>   }
>  =20
> -static void moxie_cpu_reset(CPUState *s)
> +static void moxie_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       MoxieCPU *cpu =3D MOXIE_CPU(s);
>       MoxieCPUClass *mcc =3D MOXIE_CPU_GET_CLASS(cpu);
>       CPUMoxieState *env =3D &cpu->env;
>  =20
> -    mcc->parent_reset(s);
> +    mcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUMoxieState, end_reset_fields));
>       env->pc =3D 0x1000;
> @@ -101,7 +102,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, voi=
d *data)
>  =20
>       device_class_set_parent_realize(dc, moxie_cpu_realizefn,
>                                       &mcc->parent_realize);
> -    cpu_class_set_parent_reset(cc, moxie_cpu_reset, &mcc->parent_reset);
> +    device_class_set_parent_reset(dc, moxie_cpu_reset, &mcc->parent_rese=
t);
>  =20
>       cc->class_by_name =3D moxie_cpu_class_by_name;
>  =20
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 01dca548e5..455553b794 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -69,7 +69,7 @@ typedef struct MoxieCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } MoxieCPUClass;
>  =20
>   /**
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> index 1c0c855a6f..0a4075949e 100644
> --- a/target/nios2/cpu.c
> +++ b/target/nios2/cpu.c
> @@ -39,9 +39,9 @@ static bool nios2_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_=
NMI);
>   }
>  =20
> -/* CPUClass::reset() */
> -static void nios2_cpu_reset(CPUState *cs)
> +static void nios2_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *cs =3D CPU(dev);
>       Nios2CPU *cpu =3D NIOS2_CPU(cs);
>       Nios2CPUClass *ncc =3D NIOS2_CPU_GET_CLASS(cpu);
>       CPUNios2State *env =3D &cpu->env;
> @@ -51,7 +51,7 @@ static void nios2_cpu_reset(CPUState *cs)
>           log_cpu_state(cs, 0);
>       }
>  =20
> -    ncc->parent_reset(cs);
> +    ncc->parent_reset(dev);
>  =20
>       memset(env->regs, 0, sizeof(uint32_t) * NUM_CORE_REGS);
>       env->regs[R_PC] =3D cpu->reset_addr;
> @@ -188,7 +188,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, voi=
d *data)
>       device_class_set_parent_realize(dc, nios2_cpu_realizefn,
>                                       &ncc->parent_realize);
>       device_class_set_props(dc, nios2_properties);
> -    cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
> +    device_class_set_parent_reset(dc, nios2_cpu_reset, &ncc->parent_rese=
t);
>  =20
>       cc->class_by_name =3D nios2_cpu_class_by_name;
>       cc->has_work =3D nios2_cpu_has_work;
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 78f633f970..4dddf9c3a1 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -50,7 +50,7 @@ typedef struct Nios2CPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } Nios2CPUClass;
>  =20
>   #define TARGET_HAS_ICE 1
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index 5cd04dafab..5528c0918f 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -41,13 +41,13 @@ static void openrisc_disas_set_info(CPUState *cpu, di=
sassemble_info *info)
>       info->print_insn =3D print_insn_or1k;
>   }
>  =20
> -/* CPUClass::reset() */
> -static void openrisc_cpu_reset(CPUState *s)
> +static void openrisc_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       OpenRISCCPU *cpu =3D OPENRISC_CPU(s);
>       OpenRISCCPUClass *occ =3D OPENRISC_CPU_GET_CLASS(cpu);
>  =20
> -    occ->parent_reset(s);
> +    occ->parent_reset(dev);
>  =20
>       memset(&cpu->env, 0, offsetof(CPUOpenRISCState, end_reset_fields));
>  =20
> @@ -150,7 +150,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, =
void *data)
>  =20
>       device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
>                                       &occ->parent_realize);
> -    cpu_class_set_parent_reset(cc, openrisc_cpu_reset, &occ->parent_rese=
t);
> +    device_class_set_parent_reset(dc, openrisc_cpu_reset, &occ->parent_r=
eset);
>  =20
>       cc->class_by_name =3D openrisc_cpu_class_by_name;
>       cc->has_work =3D openrisc_cpu_has_work;
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 0ad02eab79..e7fb06445e 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -48,7 +48,7 @@ typedef struct OpenRISCCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } OpenRISCCPUClass;
>  =20
>   #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index e499575dc8..b528131761 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -166,7 +166,7 @@ typedef struct PowerPCCPUClass {
>  =20
>       DeviceRealize parent_realize;
>       DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>       void (*parent_parse_features)(const char *type, char *str, Error **=
errp);
>  =20
>       uint32_t pvr;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 53995f62ea..7e9780e875 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10669,16 +10669,16 @@ static bool ppc_cpu_has_work(CPUState *cs)
>       return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
>   }
>  =20
> -/* CPUClass::reset() */
> -static void ppc_cpu_reset(CPUState *s)
> +static void ppc_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       PowerPCCPU *cpu =3D POWERPC_CPU(s);
>       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>       CPUPPCState *env =3D &cpu->env;
>       target_ulong msr;
>       int i;
>  =20
> -    pcc->parent_reset(s);
> +    pcc->parent_reset(dev);
>  =20
>       msr =3D (target_ulong)0;
>       msr |=3D (target_ulong)MSR_HVB;
> @@ -10885,7 +10885,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_always=
;
>       device_class_set_props(dc, ppc_cpu_properties);
>  =20
> -    cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
> +    device_class_set_parent_reset(dc, ppc_cpu_reset, &pcc->parent_reset)=
;
>  =20
>       cc->class_by_name =3D ppc_cpu_class_by_name;
>       pcc->parent_parse_features =3D cc->parse_features;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c0b7023100..4e578239d3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -330,13 +330,14 @@ void restore_state_to_opc(CPURISCVState *env, Trans=
lationBlock *tb,
>       env->pc =3D data[0];
>   }
>  =20
> -static void riscv_cpu_reset(CPUState *cs)
> +static void riscv_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *cs =3D CPU(dev);
>       RISCVCPU *cpu =3D RISCV_CPU(cs);
>       RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
>       CPURISCVState *env =3D &cpu->env;
>  =20
> -    mcc->parent_reset(cs);
> +    mcc->parent_reset(dev);
>   #ifndef CONFIG_USER_ONLY
>       env->priv =3D PRV_M;
>       env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
> @@ -511,7 +512,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
>       device_class_set_parent_realize(dc, riscv_cpu_realize,
>                                       &mcc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, riscv_cpu_reset, &mcc->parent_reset);
> +    device_class_set_parent_reset(dc, riscv_cpu_reset, &mcc->parent_rese=
t);
>  =20
>       cc->class_by_name =3D riscv_cpu_class_by_name;
>       cc->has_work =3D riscv_cpu_has_work;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3dcdf92227..078fc83959 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -234,7 +234,7 @@ typedef struct RISCVCPUClass {
>       CPUClass parent_class;
>       /*< public >*/
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } RISCVCPUClass;
>  =20
>   /**
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index dbe5346ec9..1630818c28 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -61,7 +61,7 @@ typedef struct S390CPUClass {
>       const char *desc;
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>       void (*load_normal)(CPUState *cpu);
>       void (*reset)(CPUState *cpu, cpu_reset_type type);
>   } S390CPUClass;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3dd396e870..427a46e3e1 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -96,8 +96,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type =
type)
>       S390CPU *cpu =3D S390_CPU(s);
>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>       CPUS390XState *env =3D &cpu->env;
> +    DeviceState *dev =3D DEVICE(s);
>  =20
> -    scc->parent_reset(s);
> +    scc->parent_reset(dev);
>       cpu->env.sigp_order =3D 0;
>       s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>  =20
> @@ -450,8 +451,9 @@ static Property s390x_cpu_properties[] =3D {
>       DEFINE_PROP_END_OF_LIST()
>   };
>  =20
> -static void s390_cpu_reset_full(CPUState *s)
> +static void s390_cpu_reset_full(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
>   }
>  =20
> @@ -466,7 +468,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>       device_class_set_props(dc, s390x_cpu_properties);
>       dc->user_creatable =3D true;
>  =20
> -    cpu_class_set_parent_reset(cc, s390_cpu_reset_full, &scc->parent_res=
et);
> +    device_class_set_parent_reset(dc, s390_cpu_reset_full, &scc->parent_=
reset);
>   #if !defined(CONFIG_USER_ONLY)
>       scc->load_normal =3D s390_cpu_load_normal;
>   #endif
> diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
> index 0c56d055ba..72a63f3fd3 100644
> --- a/target/sh4/cpu-qom.h
> +++ b/target/sh4/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct SuperHCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>  =20
>       uint32_t pvr;
>       uint32_t prr;
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 70c8d8170f..3c68021c56 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -47,14 +47,14 @@ static bool superh_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & CPU_INTERRUPT_HARD;
>   }
>  =20
> -/* CPUClass::reset() */
> -static void superh_cpu_reset(CPUState *s)
> +static void superh_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       SuperHCPU *cpu =3D SUPERH_CPU(s);
>       SuperHCPUClass *scc =3D SUPERH_CPU_GET_CLASS(cpu);
>       CPUSH4State *env =3D &cpu->env;
>  =20
> -    scc->parent_reset(s);
> +    scc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUSH4State, end_reset_fields));
>  =20
> @@ -214,7 +214,7 @@ static void superh_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       device_class_set_parent_realize(dc, superh_cpu_realizefn,
>                                       &scc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, superh_cpu_reset, &scc->parent_reset)=
;
> +    device_class_set_parent_reset(dc, superh_cpu_reset, &scc->parent_res=
et);
>  =20
>       cc->class_by_name =3D superh_cpu_class_by_name;
>       cc->has_work =3D superh_cpu_has_work;
> diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
> index 7442e2768e..8b4d33c21e 100644
> --- a/target/sparc/cpu-qom.h
> +++ b/target/sparc/cpu-qom.h
> @@ -49,7 +49,7 @@ typedef struct SPARCCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>       sparc_def_t *cpu_def;
>   } SPARCCPUClass;
>  =20
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index eeaecbd8d6..3f05aba9d6 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -28,14 +28,14 @@
>  =20
>   //#define DEBUG_FEATURES
>  =20
> -/* CPUClass::reset() */
> -static void sparc_cpu_reset(CPUState *s)
> +static void sparc_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       SPARCCPU *cpu =3D SPARC_CPU(s);
>       SPARCCPUClass *scc =3D SPARC_CPU_GET_CLASS(cpu);
>       CPUSPARCState *env =3D &cpu->env;
>  =20
> -    scc->parent_reset(s);
> +    scc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUSPARCState, end_reset_fields));
>       env->cwp =3D 0;
> @@ -859,7 +859,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, voi=
d *data)
>                                       &scc->parent_realize);
>       device_class_set_props(dc, sparc_cpu_properties);
>  =20
> -    cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
> +    device_class_set_parent_reset(dc, sparc_cpu_reset, &scc->parent_rese=
t);
>  =20
>       cc->class_by_name =3D sparc_cpu_class_by_name;
>       cc->parse_features =3D sparc_cpu_parse_features;
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index cd422a0467..1fee87c094 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -68,13 +68,14 @@ static bool tilegx_cpu_has_work(CPUState *cs)
>       return true;
>   }
>  =20
> -static void tilegx_cpu_reset(CPUState *s)
> +static void tilegx_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       TileGXCPU *cpu =3D TILEGX_CPU(s);
>       TileGXCPUClass *tcc =3D TILEGX_CPU_GET_CLASS(cpu);
>       CPUTLGState *env =3D &cpu->env;
>  =20
> -    tcc->parent_reset(s);
> +    tcc->parent_reset(dev);
>  =20
>       memset(env, 0, offsetof(CPUTLGState, end_reset_fields));
>   }
> @@ -142,7 +143,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
>                                       &tcc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, tilegx_cpu_reset, &tcc->parent_reset)=
;
> +    device_class_set_parent_reset(dc, tilegx_cpu_reset, &tcc->parent_res=
et);
>  =20
>       cc->class_by_name =3D tilegx_cpu_class_by_name;
>       cc->has_work =3D tilegx_cpu_has_work;
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index 9cbec247d2..193b6bbccb 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -118,7 +118,7 @@ typedef struct TileGXCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } TileGXCPUClass;
>  =20
>   /**
> diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
> index 7c1e130b4e..cd819e6f24 100644
> --- a/target/tricore/cpu-qom.h
> +++ b/target/tricore/cpu-qom.h
> @@ -36,7 +36,7 @@ typedef struct TriCoreCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>   } TriCoreCPUClass;
>  =20
>   typedef struct TriCoreCPU TriCoreCPU;
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 85bc9f03a1..743b404a95 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -53,13 +53,14 @@ static void tricore_cpu_synchronize_from_tb(CPUState =
*cs,
>       env->PC =3D tb->pc;
>   }
>  =20
> -static void tricore_cpu_reset(CPUState *s)
> +static void tricore_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       TriCoreCPU *cpu =3D TRICORE_CPU(s);
>       TriCoreCPUClass *tcc =3D TRICORE_CPU_GET_CLASS(cpu);
>       CPUTriCoreState *env =3D &cpu->env;
>  =20
> -    tcc->parent_reset(s);
> +    tcc->parent_reset(dev);
>  =20
>       cpu_state_reset(env);
>   }
> @@ -153,7 +154,7 @@ static void tricore_cpu_class_init(ObjectClass *c, vo=
id *data)
>       device_class_set_parent_realize(dc, tricore_cpu_realizefn,
>                                       &mcc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, tricore_cpu_reset, &mcc->parent_reset=
);
> +    device_class_set_parent_reset(dc, tricore_cpu_reset, &mcc->parent_re=
set);
>       cc->class_by_name =3D tricore_cpu_class_by_name;
>       cc->has_work =3D tricore_cpu_has_work;
>  =20
> diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
> index 9ac54241bd..3ea93ce1f9 100644
> --- a/target/xtensa/cpu-qom.h
> +++ b/target/xtensa/cpu-qom.h
> @@ -56,7 +56,7 @@ typedef struct XtensaCPUClass {
>       /*< public >*/
>  =20
>       DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    DeviceReset parent_reset;
>  =20
>       const XtensaConfig *config;
>   } XtensaCPUClass;
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 4856aee8ec..82c2ee0679 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -67,14 +67,14 @@ bool xtensa_abi_call0(void)
>   }
>   #endif
>  =20
> -/* CPUClass::reset() */
> -static void xtensa_cpu_reset(CPUState *s)
> +static void xtensa_cpu_reset(DeviceState *dev)
>   {
> +    CPUState *s =3D CPU(dev);
>       XtensaCPU *cpu =3D XTENSA_CPU(s);
>       XtensaCPUClass *xcc =3D XTENSA_CPU_GET_CLASS(cpu);
>       CPUXtensaState *env =3D &cpu->env;
>  =20
> -    xcc->parent_reset(s);
> +    xcc->parent_reset(dev);
>  =20
>       env->exception_taken =3D 0;
>       env->pc =3D env->config->exception_vector[EXC_RESET0 + env->static_=
vectors];
> @@ -184,7 +184,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
>                                       &xcc->parent_realize);
>  =20
> -    cpu_class_set_parent_reset(cc, xtensa_cpu_reset, &xcc->parent_reset)=
;
> +    device_class_set_parent_reset(dc, xtensa_cpu_reset, &xcc->parent_res=
et);
>  =20
>       cc->class_by_name =3D xtensa_cpu_class_by_name;
>       cc->has_work =3D xtensa_cpu_has_work;
>=20


