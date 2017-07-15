Received: from eggs.gnu.org ([2001:4830:134:3::10]:55715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUyB-0006P5-Mw
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUyA-0007nY-Rv
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:51:23 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUyA-0007mo-NZ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:51:22 -0400
Received: by mail-qt0-x241.google.com with SMTP id j25so483824qtf.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 14:51:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-16-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <450f03dc-cf45-db4f-b404-e92e2ad29440@amsat.org>
Date: Sat, 15 Jul 2017 18:51:18 -0300
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-16-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/28] microblaze: replace cpu_mb_init()
 with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 07/14/2017 10:52 AM, Igor Mammedov wrote:
> cpu_mb_init() always falls back to TYPE_MICROBLAZE_CPU object
> regardless of cpu_model. Put fallback logic into
> mb_cpu_class_by_name() which would translate any cpu_model
> into TYPE_MICROBLAZE_CPU class and replace cpu_mb_init()
> with cpu_generic_init().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> ---
>   target/microblaze/cpu.h       |  3 +--
>   target/microblaze/cpu.c       |  6 ++++++
>   target/microblaze/translate.c | 11 -----------
>   3 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 5ce4c82..52b6b6a 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -331,7 +331,6 @@ int mb_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>   int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   
>   void mb_tcg_init(void);
> -MicroBlazeCPU *cpu_mb_init(const char *cpu_model);
>   /* you can call this signal handler from your SIGBUS and SIGSEGV
>      signal handlers to inform the virtual CPU of exceptions. non zero
>      is returned if the signal was handled by the virtual CPU.  */
> @@ -344,7 +343,7 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
>   #define TARGET_PHYS_ADDR_SPACE_BITS 32
>   #define TARGET_VIRT_ADDR_SPACE_BITS 32
>   
> -#define cpu_init(cpu_model) CPU(cpu_mb_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
>   
>   #define cpu_signal_handler cpu_mb_signal_handler
>   
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index f85ff01..ddffe86 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -253,6 +253,11 @@ static Property mb_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
> +{
> +    return object_class_by_name(TYPE_MICROBLAZE_CPU);
> +}
> +
>   static void mb_cpu_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -265,6 +270,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
>       mcc->parent_reset = cc->reset;
>       cc->reset = mb_cpu_reset;
>   
> +    cc->class_by_name = mb_cpu_class_by_name;
>       cc->has_work = mb_cpu_has_work;
>       cc->do_interrupt = mb_cpu_do_interrupt;
>       cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index cb65d1e..c97c9d8 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1845,17 +1845,6 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>       cpu_fprintf(f, "\n\n");
>   }
>   
> -MicroBlazeCPU *cpu_mb_init(const char *cpu_model)
> -{
> -    MicroBlazeCPU *cpu;
> -
> -    cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> -
> -    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> -
> -    return cpu;
> -}
> -
>   void mb_tcg_init(void)
>   {
>       int i;
> 
