Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Ky-0004jL-9r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Ku-000619-5K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:29:12 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Ku-00060s-0q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:29:08 -0400
Received: by mail-qk0-x244.google.com with SMTP id a12so1943913qka.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:29:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-9-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b2fe79b8-65ab-0aeb-f579-a54d0df54c12@amsat.org>
Date: Mon, 2 Oct 2017 17:29:04 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/38] lm32: lm32_boards: use generic
 cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, michael@walle.cc
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: michael@walle.cc
> ---
>   hw/lm32/lm32_boards.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index b0bb3ef..002d638 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -75,7 +75,6 @@ static void main_cpu_reset(void *opaque)
>   
>   static void lm32_evr_init(MachineState *machine)
>   {
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       LM32CPU *cpu;
>       CPULM32State *env;
> @@ -101,10 +100,7 @@ static void lm32_evr_init(MachineState *machine)
>   
>       reset_info = g_malloc0(sizeof(ResetInfo));
>   
> -    if (cpu_model == NULL) {
> -        cpu_model = "lm32-full";
> -    }
> -    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> +    cpu = LM32_CPU(cpu_create(machine->cpu_type));
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> @@ -163,7 +159,6 @@ static void lm32_evr_init(MachineState *machine)
>   
>   static void lm32_uclinux_init(MachineState *machine)
>   {
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -198,10 +193,7 @@ static void lm32_uclinux_init(MachineState *machine)
>   
>       reset_info = g_malloc0(sizeof(ResetInfo));
>   
> -    if (cpu_model == NULL) {
> -        cpu_model = "lm32-full";
> -    }
> -    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> +    cpu = LM32_CPU(cpu_create(machine->cpu_type));
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> @@ -295,6 +287,7 @@ static void lm32_evr_class_init(ObjectClass *oc, void *data)
>       mc->desc = "LatticeMico32 EVR32 eval system";
>       mc->init = lm32_evr_init;
>       mc->is_default = 1;
> +    mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>   }
>   
>   static const TypeInfo lm32_evr_type = {
> @@ -310,6 +303,7 @@ static void lm32_uclinux_class_init(ObjectClass *oc, void *data)
>       mc->desc = "lm32 platform for uClinux and u-boot by Theobroma Systems";
>       mc->init = lm32_uclinux_init;
>       mc->is_default = 0;
> +    mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>   }
>   
>   static const TypeInfo lm32_uclinux_type = {
> 
