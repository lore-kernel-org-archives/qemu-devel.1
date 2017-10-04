Received: from eggs.gnu.org ([2001:4830:134:3::10]:60236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzhSJ-0001tH-HW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzhSE-0000wN-LX
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzhSE-0000vc-FG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:03:06 -0400
Date: Wed, 4 Oct 2017 13:02:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171004130258.0a977151@nial.brq.redhat.com>
In-Reply-To: <ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Tue, 3 Oct 2017 13:05:11 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> List all possible valid CPU options.
> 
> Although the board only ever has a Cortex-M3 we mark the Cortex-M4 as
> supported because the Netduino2 Plus supports the Cortex-M4 and the
> Netduino2 Plus is similar to the Netduino2.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
> RFC v2:
>  - Use a NULL terminated list
>  - Add the Cortex-M4 for testing
> 
> 
>  hw/arm/netduino2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index f936017d4a..b68ecf2c08 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -34,18 +34,25 @@ static void netduino2_init(MachineState *machine)
>      DeviceState *dev;
>  
>      dev = qdev_create(NULL, TYPE_STM32F205_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
> +    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
>      object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
>  
>      armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>                         FLASH_SIZE);
>  }
>  
> +const char *netduino_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-m3"),
style nit,                               ^^^ put entries on new line with typical 4 space alignment
> +                                      ARM_CPU_TYPE_NAME("cortex-m4"),
> +                                      NULL
> +                                    };

> +
>  static void netduino2_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Netduino 2 Machine";
>      mc->init = netduino2_init;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
> +    mc->valid_cpu_types = netduino_valid_cpus;
>  }
>  
>  DEFINE_MACHINE("netduino2", netduino2_machine_init)
