Received: from eggs.gnu.org ([2001:4830:134:3::10]:45117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ63Z-0006Xp-7x
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ63Y-0001jR-1p
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:05:17 -0500
MIME-Version: 1.0
In-Reply-To: <20161213161152.GN9606@toto>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-23-git-send-email-peter.maydell@linaro.org>
	<20161213161152.GN9606@toto>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Dec 2016 14:04:41 -0800
Message-ID: <CAKmqyKNXugCpkY_oHv=256wP5nve9hcsGep21UQuwyLE_mm99A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 22/23] target-arm: Enable EL2 feature bit
 on A53 and A57
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Tue, Dec 13, 2016 at 8:11 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> On Tue, Dec 13, 2016 at 10:36:23AM +0000, Peter Maydell wrote:
>> Enable the ARM_FEATURE_EL2 bit on Cortex-A52 and
>> Cortex-A57, since this is all now sufficiently implemented
>> to work with the GICv3. We provide the usual CPU property
>> to disable it for backwards compatibility with the older
>> virt boards.
>>
>> In this commit, we disable the EL2 feature on the
>> virt and ZynpMP boards, so there is no overall effect.
>> Another commit will expose a board-level property to
>> allow the user to enable EL2.
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

>
>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target-arm/cpu.h     |  2 ++
>>  hw/arm/virt.c        |  4 ++++
>>  hw/arm/xlnx-zynqmp.c |  2 ++
>>  target-arm/cpu.c     | 12 ++++++++++++
>>  target-arm/cpu64.c   |  2 ++
>>  5 files changed, 22 insertions(+)
>>
>> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
>> index be42ffb..51165fa 100644
>> --- a/target-arm/cpu.h
>> +++ b/target-arm/cpu.h
>> @@ -574,6 +574,8 @@ struct ARMCPU {
>>      bool start_powered_off;
>>      /* CPU currently in PSCI powered-off state */
>>      bool powered_off;
>> +    /* CPU has virtualization extension */
>> +    bool has_el2;
>>      /* CPU has security extension */
>>      bool has_el3;
>>      /* CPU has PMU (Performance Monitor Unit) */
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index cce8d2e..5bde68c 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1368,6 +1368,10 @@ static void machvirt_init(MachineState *machine)
>>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>>          }
>>
>> +        if (object_property_find(cpuobj, "has_el2", NULL)) {
>> +            object_property_set_bool(cpuobj, false, "has_el2", NULL);
>> +        }
>> +
>>          if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
>>              object_property_set_int(cpuobj, vms->psci_conduit,
>>                                      "psci-conduit", NULL);
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index 0d86ba3..bc4e66b 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -258,6 +258,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>
>>          object_property_set_bool(OBJECT(&s->apu_cpu[i]),
>>                                   s->secure, "has_el3", NULL);
>> +        object_property_set_bool(OBJECT(&s->apu_cpu[i]),
>> +                                 false, "has_el2", NULL);

Hey Peter,

We would like this to be settable. I think just copying the s->secure
(same as EL3) should be fine here.

Let me know what is easier for you, if you want to just add an extra
patch to enable it or if you want me to send a patch doing it?

Thanks,

Alistair

>>          object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
>>                                  "reset-cbar", &error_abort);
>>          object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
>> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
>> index 5e0d21d..d721cd4 100644
>> --- a/target-arm/cpu.c
>> +++ b/target-arm/cpu.c
>> @@ -497,6 +497,9 @@ static Property arm_cpu_reset_hivecs_property =
>>  static Property arm_cpu_rvbar_property =
>>              DEFINE_PROP_UINT64("rvbar", ARMCPU, rvbar, 0);
>>
>> +static Property arm_cpu_has_el2_property =
>> +            DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
>> +
>>  static Property arm_cpu_has_el3_property =
>>              DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
>>
>> @@ -547,6 +550,11 @@ static void arm_cpu_post_init(Object *obj)
>>  #endif
>>      }
>>
>> +    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
>> +        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property,
>> +                                 &error_abort);
>> +    }
>> +
>>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>>          qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
>>                                   &error_abort);
>> @@ -690,6 +698,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>          cpu->id_aa64pfr0 &= ~0xf000;
>>      }
>>
>> +    if (!cpu->has_el2) {
>> +        unset_feature(env, ARM_FEATURE_EL2);
>> +    }
>> +
>>      if (!cpu->has_pmu || !kvm_enabled()) {
>>          cpu->has_pmu = false;
>>          unset_feature(env, ARM_FEATURE_PMU);
>> diff --git a/target-arm/cpu64.c b/target-arm/cpu64.c
>> index 73c7f31..670c07a 100644
>> --- a/target-arm/cpu64.c
>> +++ b/target-arm/cpu64.c
>> @@ -110,6 +110,7 @@ static void aarch64_a57_initfn(Object *obj)
>>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
>>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>>      set_feature(&cpu->env, ARM_FEATURE_PMU);
>>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
>> @@ -169,6 +170,7 @@ static void aarch64_a53_initfn(Object *obj)
>>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
>>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>>      set_feature(&cpu->env, ARM_FEATURE_PMU);
>>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
>> --
>> 2.7.4
>>
>
