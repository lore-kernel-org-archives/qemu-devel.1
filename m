Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGnJn-0002qU-QI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGnJk-0002ld-LI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:45:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eGnJk-0002kx-F3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:45:00 -0500
Date: Mon, 20 Nov 2017 12:44:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171120144454.GK3037@localhost.localdomain>
References: <1511188453-248734-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511188453-248734-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] pc: fix crash on attempted cpu
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Mon, Nov 20, 2017 at 03:34:13PM +0100, Igor Mammedov wrote:
> when qemu is started with '-no-acpi' CLI option, an attempt
> to unplug a CPU using device_del results in null pointer
> dereference at:
> 
>   #0 object_get_class
>   #1 pc_machine_device_unplug_request_cb
>   #2 qmp_marshal_device_del
> 
> which is caused by pcms->acpi_dev == NULL due to ACPI support
> being disabled.
> 
> Considering that ACPI support is necessary for unplug to work,
> check that it's enabled and fail unplug request gracefully
> if no acpi device were found.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

But I have one small suggestion:

> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c3afe5b..d80cec3 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1842,6 +1842,11 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
>      X86CPU *cpu = X86_CPU(dev);
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>  
> +    if (!pcms->acpi_dev) {
> +        error_setg(&local_err, "not supported without acpi");

I suggest "CPU hot unplug not supported without ACPI" instead.

> +        goto out;
> +    }
> +
>      pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      assert(idx != -1);
>      if (idx == 0) {
> -- 
> 2.7.4
> 

-- 
Eduardo
