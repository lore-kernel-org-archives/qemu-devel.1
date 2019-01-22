Received: from eggs.gnu.org ([209.51.188.92]:34601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gm1Qq-0006dK-72
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gm1Qo-0001dH-B4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gm1Qo-0000Qv-0N
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:54 -0500
References: <20190122121048.76469-1-sgarzare@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <0e6e97a2-c029-bbbe-7a9d-009e1f8f20cc@oracle.com>
Date: Tue, 22 Jan 2019 12:19:57 +0000
MIME-Version: 1.0
In-Reply-To: <20190122121048.76469-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: enable PVH only for machine
 type >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 22/01/2019 12:10, Stefano Garzarella wrote:
> In order to avoid migration issues, we enable PVH only for
> machine type >= 4.0
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>



> ---
> Based-on: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
> 
>   hw/i386/pc.c         | 4 +++-
>   hw/i386/pc_piix.c    | 3 +++
>   hw/i386/pc_q35.c     | 3 +++
>   include/hw/i386/pc.h | 3 +++
>   4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2833b130ba..3be4a06c4f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1211,7 +1211,8 @@ static void load_linux(PCMachineState *pcms,
>            * saving the PVH entry point used by the x86/HVM direct boot ABI.
>            * If load_elfboot() is successful, populate the fw_cfg info.
>            */
> -        if (load_elfboot(kernel_filename, kernel_size,
> +        if (pcmc->pvh_enabled &&
> +            load_elfboot(kernel_filename, kernel_size,
>                            header, pvh_start_addr, fw_cfg)) {
>               fclose(f);
>   
> @@ -2774,6 +2775,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       pcmc->acpi_data_size = 0x20000 + 0x8000;
>       pcmc->save_tsc_khz = true;
>       pcmc->linuxboot_dma_enabled = true;
> +    pcmc->pvh_enabled = true;
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = pc_get_hotpug_handler;
>       mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 5088e2f492..a51b83e50e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -440,9 +440,12 @@ DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
>   
>   static void pc_i440fx_3_1_machine_options(MachineClass *m)
>   {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>       pc_i440fx_4_0_machine_options(m);
>       m->is_default = 0;
>       m->alias = NULL;
> +    pcmc->pvh_enabled = false;
>       compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>       compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
>   }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index b7b7959934..4a175ea50e 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -376,9 +376,12 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
>   
>   static void pc_q35_3_1_machine_options(MachineClass *m)
>   {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>       pc_q35_4_0_machine_options(m);
>       m->default_kernel_irqchip_split = false;
>       m->alias = NULL;
> +    pcmc->pvh_enabled = false;
>       compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>       compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
>   }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 0abbe45637..e4e2c1352d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -133,6 +133,9 @@ struct PCMachineClass {
>   
>       /* use DMA capable linuxboot option rom */
>       bool linuxboot_dma_enabled;
> +
> +    /* use PVH to load kernels that support this feature */
> +    bool pvh_enabled;
>   };
>   
>   #define TYPE_PC_MACHINE "generic-pc-machine"
> 
