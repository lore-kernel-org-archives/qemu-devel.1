Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPY5V-0002lv-IC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPY5U-0007dy-QJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:13:57 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPY5U-0007dc-Mp
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:13:56 -0500
Received: by mail-ua0-x22e.google.com with SMTP id i68so307246648uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 09:13:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102200153.28864-17-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
	<20170102200153.28864-17-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 17:13:35 +0000
Message-ID: <CAFEAcA-Wen-TR4NwCgo-xYEka4wu+K9g5vr+ZA3440pkzanWrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 16/16] hw/arm/virt-acpi-build: madt: add
 vgic maint irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhao@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 2 January 2017 at 20:01, Andrew Jones <drjones@redhat.com> wrote:
> When virtualization is enabled and we have a v3 gic, then we add
> the vgic maintenance interrupt to the DT. This patch is the ACPI
> equivalent.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7c00ee683f44..971ee4885c43 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -607,6 +607,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
>          }
> +        if (vms->virt && vms->gic_version == 3) {
> +            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
> +        }
>      }
>
>      if (vms->gic_version == 3) {

I'm going to squash this change into my "target-arm: Enable EL2 feature bit
on A53 and A57" patch, since it's a trivial diff and that's the patch
which has the "put this into the DTB" change in it.

thanks
-- PMM
