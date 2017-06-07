Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIVT6-0003Nt-Vk
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIVT3-00008e-Ql
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:33:28 -0400
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
Date: Wed, 7 Jun 2017 09:33:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170607070732.23312-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pseries: Correct panic behaviour for
 pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, lvivier@redhat.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07.06.2017 09:07, David Gibson wrote:
> The pseries machine type doesn't usually use the 'pvpanic' device as such,
> because it has a firmware/hypervisor facility with roughly the same
> purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that the
> guest has crashed.
> 
> Our implementation of this call was sending a GUEST_PANICKED qmp event;
> however, it was not doing the other usual panic actions, making its
> behaviour different from pvpanic for no good reason.
> 
> To correct this, we should call qemu_system_guest_panicked() rather than
> directly sending the panic event.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_rtas.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 707c4d4..94a2799 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                              target_ulong args,
>                              uint32_t nret, target_ulong rets)
>  {
> -    target_ulong ret = 0;
> +    qemu_system_guest_panicked(NULL);
>  
> -    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false, NULL,
> -                                   &error_abort);
> -
> -    rtas_st(rets, 0, ret);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>  
>  static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> 

If I get that qemu_system_guest_panicked() function right, it will stop
the VM, won't it? That contradicts the LoPAPR spec that says that the
RTAS call returns if the "ibm,extended-os-term" property is available in
the device tree. And we currently present this property in the device
tree. So either the guest should not be stopped here, or we've got to
remove the property from the device tree again.

 Thomas
