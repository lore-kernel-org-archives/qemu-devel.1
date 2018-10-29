Received: from eggs.gnu.org ([2001:4830:134:3::10]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDHq-0002Qd-AT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDHl-0000XC-NN
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:33:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHDHl-0000Wq-Gl
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:33:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so10004710wrs.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:33:13 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-12-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4bc8b6c-cab3-0481-74cc-d37a499da2fa@redhat.com>
Date: Mon, 29 Oct 2018 20:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-12-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/19] hw: acpi: Do not create hotplug
 method when handler is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 29/10/18 18:01, Samuel Ortiz wrote:
> CPU and memory ACPI hotplug are not necessarily handled through SCI
> events. For example, with Hardware-reduced ACPI, the GED device will
> manage ACPI hotplug entirely.
> As a consequence, we make the CPU and memory specific events AML
> generation optional. The code will only be added when the method name is
> not NULL.

It makes sens.

> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/acpi/cpu.c            |  8 +++++---
>   hw/acpi/memory_hotplug.c | 11 +++++++----
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index f10b190019..cd41377b5a 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -569,9 +569,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>       aml_append(sb_scope, cpus_dev);
>       aml_append(table, sb_scope);
>   
> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
>   
>       g_free(cphp_res_path);
>   }
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 8c7c1013f3..db2c4df961 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -715,10 +715,13 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>       }
>       aml_append(table, dev_container);
>   
> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method,
> -        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> +        aml_append(method,
> +                   aml_call0(MEMORY_DEVICES_CONTAINER "."
> +                             MEMORY_SLOT_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
>   
>       g_free(mhp_res_path);
>   }
> 
