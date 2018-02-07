Received: from eggs.gnu.org ([2001:4830:134:3::10]:35921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNXg-0004uP-PC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNXa-0003nV-UH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:05:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNXa-0003n9-Ln
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:05:26 -0500
Received: by mail-wr0-f195.google.com with SMTP id y3so554342wrh.3
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:05:26 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-23-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90a77ba5-1a16-a05e-f7b8-b409500dcc30@redhat.com>
Date: Wed, 7 Feb 2018 12:05:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-23-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 22/34] i386: Hyper-V VMBus ACPI DSDT
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> From: Andrey Smetanin <asmetanin@virtuozzo.com>
> 
> Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
> entry to DSDT in case vmbus has been enabled.
> 
> Experimentally Windows guests were found to require this entry to
> include two IRQ resources, so this patch adds two semi-arbitrarily
> chosen ones (7 and 13).  This results, in particular, in parallel port
> conflicting with vmbus.
> 
> TODO: discover and use spare IRQs to avoid conflicts.

Could they be level-triggered IRQs?  If so you could reuse 10 and 11
which are used by PCI INTx.  Otherwise, the parallel port conflict is
not a huge deal.

> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>

Somewhat messy SoB chain. :)

Paolo

> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  hw/i386/acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ed78c4ed9f..6f8cd3eb41 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -46,6 +46,7 @@
>  #include "sysemu/tpm_backend.h"
>  #include "hw/timer/mc146818rtc_regs.h"
>  #include "sysemu/numa.h"
> +#include "hw/vmbus/vmbus.h"
>  
>  /* Supported chipsets: */
>  #include "hw/acpi/piix4.h"
> @@ -1317,6 +1318,43 @@ static Aml *build_com_device_aml(uint8_t uid)
>      return dev;
>  }
>  
> +static Aml *build_vmbus_device_aml(void)
> +{
> +    Aml *dev;
> +    Aml *method;
> +    Aml *crs;
> +
> +    dev = aml_device("VMBS");
> +    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
> +
> +    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_name("STA"), aml_local(0)));
> +    aml_append(method, aml_return(aml_local(0)));
> +    aml_append(dev, method);
> +
> +    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(7));
> +    aml_append(crs, aml_irq_no_flags(13));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    return dev;
> +}
> +
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> @@ -1343,6 +1381,10 @@ static void build_isa_devices_aml(Aml *table)
>          build_acpi_ipmi_devices(scope, BUS(obj));
>      }
>  
> +    if (vmbus_exists()) {
> +        aml_append(scope, build_vmbus_device_aml());
> +    }
> +
>      aml_append(table, scope);
>  }
>  
> 
