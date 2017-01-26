Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWoVo-0008Qk-8g
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWoVk-0006Di-45
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:11:08 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-6-git-send-email-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9af8649f-d27f-7033-7e1d-6b67d3e9c8d9@redhat.com>
Date: Thu, 26 Jan 2017 19:10:44 +0100
MIME-Version: 1.0
In-Reply-To: <1485443388-27253-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] hw/arm/highbank: Default -drive to
 if=ide instead of if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, mreitz@redhat.com, qemu-arm@nongnu.org

On 26.01.2017 16:09, Markus Armbruster wrote:
> These machines have no onboard SCSI HBA, and no way to plug one.
> -drive if=scsi therefore cannot work.  They do have an onboard IDE
> controller (sysbus-ahci), but fail to honor if=ide.
> 
> Change their default to if=ide, and add a TODO comment on what needs
> to be done to actually honor -drive if=ide.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/highbank.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 80e5fd4..0a4508c 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -363,6 +363,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[82]);
>      }
>  
> +    /* TODO create and connect IDE devices for ide_drive_get() */
> +
>      highbank_binfo.ram_size = ram_size;
>      highbank_binfo.kernel_filename = kernel_filename;
>      highbank_binfo.kernel_cmdline = kernel_cmdline;
> @@ -405,7 +407,8 @@ static void highbank_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "Calxeda Highbank (ECX-1000)";
>      mc->init = highbank_init;
> -    mc->block_default_type = IF_SCSI;
> +    mc->block_default_type = IF_IDE;
> +    mc->units_per_default_bus = 1;
>      mc->max_cpus = 4;
>  }
>  
> @@ -421,7 +424,8 @@ static void midway_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "Calxeda Midway (ECX-2000)";
>      mc->init = midway_init;
> -    mc->block_default_type = IF_SCSI;
> +    mc->block_default_type = IF_IDE;
> +    mc->units_per_default_bus = 1;
>      mc->max_cpus = 4;
>  }
>  
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
