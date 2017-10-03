Received: from eggs.gnu.org ([2001:4830:134:3::10]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVKD-0004jH-OV
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVKA-0004E6-I5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:06:01 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVKA-0004Dm-Ez
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:05:58 -0400
Received: by mail-qk0-x241.google.com with SMTP id a12so4136933qka.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 15:05:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b98b949b-8497-1ea2-82ba-78e2a26b45de@amsat.org>
Date: Tue, 3 Oct 2017 19:05:52 -0300
MIME-Version: 1.0
In-Reply-To: <ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, marcel@redhat.com, alistair23@gmail.com

On 10/03/2017 05:05 PM, Alistair Francis wrote:
> List all possible valid CPU options.
> 
> Although the board only ever has a Cortex-M3 we mark the Cortex-M4 as
> supported because the Netduino2 Plus supports the Cortex-M4 and the
> Netduino2 Plus is similar to the Netduino2.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
