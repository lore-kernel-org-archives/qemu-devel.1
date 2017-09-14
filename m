Received: from eggs.gnu.org ([2001:4830:134:3::10]:40267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsYjY-0000Pa-CU
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsYjV-0003tK-62
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:19:28 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsYjU-0003si-VJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:19:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id c69so92340qke.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:19:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
	<1505318697-77161-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4cb8e4a1-ea7f-bcdd-f50e-3467c6a2ac36@amsat.org>
Date: Thu, 14 Sep 2017 15:19:21 -0300
MIME-Version: 1.0
In-Reply-To: <1505318697-77161-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vl.c: convert cpu_model to cpu type
 and set of global properties before machine_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 09/13/2017 01:04 PM, Igor Mammedov wrote:
> All machines that support user specified cpu_model either call
> cpu_generic_init() or cpu_class_by_name()/CPUClass::parse_features
> to parse feature string and to get CPU type to create.
> 
> Which leads to code duplication and hard-codding default CPU model
> within machine_foo_init() code. Which makes it impossible to
> get CPU type before machine_init() is run.
> 
> So instead of setting default CPUs models and doing parsing in
> target specific machine_foo_init() in various ways, provide
> a generic data driven cpu_model parsing before machine_init()
> is called.
> 
> in follow up per target patches, it will allow to:
>    * define default CPU type in consistent/generic manner
>      per machine type and drop custom code that fallbacks
>      to default if cpu_model is NULL
>    * drop custom features parsing in targets and do it
>      in centralized way.
>    * for cases of
>        cpu_generic_init(TYPE_BASE/DEFAULT_CPU, "some_cpu")
>      replace it with
>        cpu_create(machine->cpu_type) || cpu_create(TYPE_FOO)
>      depending if CPU type is user settable or not.
>      not doing useless parsing and clearly documenting where
>      CPU model is user settable or fixed one.
> 
> Patch allows machine subclasses to define default CPU type
> per machine class at class_init() time and if that is set
> generic code will parse cpu_model into a MachineState::cpu_type
> which will be used to create CPUs for that machine instance
> and allows gradual per board conversion.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Target specific changes will split into separate per target/machine
> patches to make changes reviewable.
> ---
>   include/hw/boards.h |  6 ++++++
>   vl.c                | 10 ++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 7f044d1..6b67ada 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -125,6 +125,10 @@ typedef struct {
>    *    Caller is responsible for freeing returned list.
>    * @has_hotpluggable_cpus:
>    *    If true, board supports CPUs creation with -device/device_add.
> + * @default_cpu_type:
> + *    specifies default CPU_TYPE, which will be used for parsing target
> + *    specific features and for creating CPUs if CPU name wasn't provided
> + *    explicitly at CLI
>    * @minimum_page_bits:
>    *    If non-zero, the board promises never to create a CPU with a page size
>    *    smaller than this, so QEMU can use a more efficient larger page
> @@ -177,6 +181,7 @@ struct MachineClass {
>       GArray *compat_props;
>       const char *hw_version;
>       ram_addr_t default_ram_size;
> +    const char *default_cpu_type;
>       bool option_rom_has_mr;
>       bool rom_file_has_mr;
>       int minimum_page_bits;
> @@ -231,6 +236,7 @@ struct MachineState {
>       char *kernel_cmdline;
>       char *initrd_filename;
>       const char *cpu_model;
> +    const char *cpu_type;
>       AccelState *accelerator;
>       CPUArchIdList *possible_cpus;
>   };
> diff --git a/vl.c b/vl.c
> index fb1f05b..034180f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4636,6 +4636,16 @@ int main(int argc, char **argv, char **envp)
>       current_machine->boot_order = boot_order;
>       current_machine->cpu_model = cpu_model;
>   
> +
> +    /* parse features once if machine provides default cpu_type */
> +    if (machine_class->default_cpu_type) {
> +        current_machine->cpu_type = machine_class->default_cpu_type;
> +        if (cpu_model) {
> +            current_machine->cpu_type =
> +                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
> +        }
> +    }
> +
>       machine_run_board_init(current_machine);
>   
>       realtime_init();
> 
