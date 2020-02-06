Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE08A20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxH17LjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE08A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37561 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfzP-0001rt-Vx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1izfy4-0000Lf-IY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1izfy2-0001WH-18
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:09:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1izfy1-0001V0-T8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580990949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWlfvFY4xRhF+qWxBlsQcKyBZisPGZz72spey4VRmnA=;
 b=JxH17LjXVcW5GdAS2N3H/QOqcPhfvsEJszFk+0spkNcyH8PNIFzEfrP2v93D0nfEWr3RJW
 9LQWpStxz2q4N9W8ghp73rEEyDyKV3HILLQh68ZbqehsRBFq2QXAPoPjQAZ7qKG0Lg6PXA
 vLqTHpdOQ7VaeZakMyKrknkzBa4D1Ls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-jtG5ANmUMnCCP8VTGf7gmQ-1; Thu, 06 Feb 2020 07:09:07 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so3242943wrm.23
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 04:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4R5VEi7Eux/3b8TYzDdRrjrRIoKfwPspvyKCE7QZHEA=;
 b=MloQMA+AyXFAI+/C5q7R5g9dIsNg9+kB4sBN97sLy3fYaIlSVpguqiML8MM3Zm5T3Y
 4ZNuhze5oUprpfvdPIkV+FUhUb/+1ROG+xmmO1/jAAnR/5NjvHfNnxbC4fQ+gHPuVmzK
 cDngH0ishaM/cqLFgKrSFV6eGKXeOpXEZQtF46h9BL4b/pto9O3fVOkcY6q/7L0A4iNE
 2b2636JDtSj/unI+hSILwk5GULXYL1IyMCdMlzr2L3JruAVnry/au9PTqF42c3L7PuiN
 a5RLFd2gD5O9IVE+RbCv/jLNzxagqlkkq3If+eDcAyCkOjEW2QxLFTTGT3Pin9GELrNF
 Y6jg==
X-Gm-Message-State: APjAAAWC3kwVJ8NsA1penByBLOg7g9nGzYqC9I9SdgoBe7eTkfEQ2dbe
 u51tcyWH4VMD4rdlHbeLtP4Gh/oJ/hdKhHPOzEraRYMC1yRykJATGTnmV9xir/vwrERhVOj2iDW
 yE6EM/csfMkvLzfpKg2Q2VLz7kAvQ+58=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr4155205wmi.17.1580990944667; 
 Thu, 06 Feb 2020 04:09:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4VOB5t4XmCnJo+piP9SR/a5pkjBrlxsVDUmscVjNQwqAMN3YoclaKDzjaKz7cNSdGTMumAZh0GH1QbeoBOCU=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr4155179wmi.17.1580990944341; 
 Thu, 06 Feb 2020 04:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-6-drjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 6 Feb 2020 13:08:53 +0100
Message-ID: <CAP+75-Vt3apV8i64oFTC6pAATXkrE1g+tVskr_3ohBHtZ1LNdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
To: Andrew Jones <drjones@redhat.com>
X-MC-Unique: jtG5ANmUMnCCP8VTGf7gmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On Thu, Dec 12, 2019 at 7:27 PM Andrew Jones <drjones@redhat.com> wrote:
> kvm-no-adjvtime is a KVM specific CPU property and a first of its kind.
> To accommodate it we also add kvm_arm_add_vcpu_properties() and a
> KVM specific CPU properties description to the CPU features document.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  docs/arm-cpu-features.rst | 31 ++++++++++++++++++++++++++++++-
>  hw/arm/virt.c             |  8 ++++++++
>  include/hw/arm/virt.h     |  1 +
>  target/arm/cpu.c          |  2 ++
>  target/arm/cpu64.c        |  1 +
>  target/arm/kvm.c          | 28 ++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h      | 11 +++++++++++
>  target/arm/monitor.c      |  1 +
>  tests/arm-cpu-features.c  |  4 ++++
>  9 files changed, 86 insertions(+), 1 deletion(-)
>
[...]
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cb7041e9677a..e9a08eb883bf 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1664,6 +1664,11 @@ static void machvirt_init(MachineState *machine)
>              }
>          }
>
> +        if (vmc->kvm_no_adjvtime &&
> +            object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
> +            object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NU=
LL);
> +        }
> +
>          if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
>              object_property_set_bool(cpuobj, false, "pmu", NULL);
>          }
> @@ -2154,8 +2159,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
>
>  static void virt_machine_4_2_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_5_0_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
> +    vmc->kvm_no_adjvtime =3D true;
>  }
>  DEFINE_VIRT_MACHINE(4, 2)
>
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 0b41083e9d5c..80e00161b8f2 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -109,6 +109,7 @@ typedef struct {
>      bool smbios_old_sys_ver;
>      bool no_highmem_ecam;
>      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device =
*/
> +    bool kvm_no_adjvtime;
>  } VirtMachineClass;
>
>  typedef struct {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339bf9..53c73c25a67f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2482,6 +2482,7 @@ static void arm_max_initfn(Object *obj)
>
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        kvm_arm_add_vcpu_properties(obj);
>      } else {
>          cortex_a15_initfn(obj);
>
> @@ -2673,6 +2674,7 @@ static void arm_host_initfn(Object *obj)
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
>      }
> +    kvm_arm_add_vcpu_properties(obj);
>      arm_cpu_post_init(obj);
>  }
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index a39d6fcea34f..3cd416db8089 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -605,6 +605,7 @@ static void aarch64_max_initfn(Object *obj)
>
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        kvm_arm_add_vcpu_properties(obj);
>      } else {
>          uint64_t t;
>          uint32_t u;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index a55fe7d7aefd..7666b250ab96 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -17,6 +17,8 @@
>  #include "qemu/timer.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "qom/object.h"
> +#include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/kvm_int.h"
> @@ -179,6 +181,32 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      env->features =3D arm_host_cpu_features.features;
>  }
>
> +static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
> +{
> +    return !ARM_CPU(obj)->kvm_adjvtime;
> +}
> +
> +static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
> +{
> +    ARM_CPU(obj)->kvm_adjvtime =3D !value;
> +}
> +
> +/* KVM VCPU properties should be prefixed with "kvm-". */
> +void kvm_arm_add_vcpu_properties(Object *obj)
> +{
> +    if (!kvm_enabled()) {

This can't happen, right? Can we turn that into an assertion, or
remove the check?

> +        return;
> +    }
> +
> +    ARM_CPU(obj)->kvm_adjvtime =3D true;
> +    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get=
,
> +                             kvm_no_adjvtime_set, &error_abort);
> +    object_property_set_description(obj, "kvm-no-adjvtime",
> +                                    "Set on to disable the adjustment of=
 "
> +                                    "the virtual counter. VM stopped tim=
e "
> +                                    "will be counted.", &error_abort);
> +}
> +
>  bool kvm_arm_pmu_supported(CPUState *cpu)
>  {
>      KVMState *s =3D KVM_STATE(current_machine->accelerator);
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 16b53e45377d..7d76f26beaca 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -232,6 +232,15 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long=
 *map);
>   */
>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>
> +/**
> + * void kvm_arm_add_vcpu_properties:
> + * @obj: The CPU object to add the properties to
> + *
> + * Add all KVM specific CPU properties to the CPU object. These
> + * are the CPU properties with "kvm-" prefixed names.
> + */
> +void kvm_arm_add_vcpu_properties(Object *obj);
> +
>  /**
>   * void kvm_arm_get_virtual_time:
>   * @cs: CPUState
> @@ -319,6 +328,8 @@ static inline void kvm_arm_set_cpu_features_from_host=
(ARMCPU *cpu)
>      cpu->host_cpu_probe_failed =3D true;
>  }
>
> +static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
> +
>  static inline bool kvm_arm_aarch32_supported(CPUState *cs)
>  {
>      return false;
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index fa054f8a369c..9725dfff16d4 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -103,6 +103,7 @@ static const char *cpu_model_advertised_features[] =
=3D {
>      "sve128", "sve256", "sve384", "sve512",
>      "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
>      "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
> +    "kvm-no-adjvtime",
>      NULL
>  };
>
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 06ed05e934e6..738e49447377 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -435,6 +435,8 @@ static void test_query_cpu_model_expansion(const void=
 *data)
>      assert_has_feature_enabled(qts, "cortex-a15", "pmu");
>      assert_has_not_feature(qts, "cortex-a15", "aarch64");
>
> +    assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
> +
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature_enabled(qts, "max", "aarch64");
>          assert_has_feature_enabled(qts, "max", "sve");
> @@ -469,6 +471,8 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
>          return;
>      }
>
> +    assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
> +
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          bool kvm_supports_sve;
>          char max_name[8], name[8];
> --
> 2.21.0
>
>


