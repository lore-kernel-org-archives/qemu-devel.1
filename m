Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLm-0004zw-1Z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLi-0008S3-0m
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:35:06 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:57134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLh-0008Qw-Tg
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:35:01 -0400
Received: by mail-qt0-x244.google.com with SMTP id e19so9088914qta.13
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:35:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-25-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab192839-6793-d408-124c-a14822f28fbc@amsat.org>
Date: Tue, 3 Oct 2017 10:34:58 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-25-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 24/38] xtensa: lx60/lx200/ml605/kc705: use
 generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: jcmvbkbc@gmail.com
> ---
>  hw/xtensa/xtfpga.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index a19cceb..1971ecf 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -220,19 +220,14 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
>      DriveInfo *dinfo;
>      pflash_t *flash = NULL;
>      QemuOpts *machine_opts = qemu_get_machine_opts();
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
>      const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
>      const char *dtb_filename = qemu_opt_get(machine_opts, "dtb");
>      const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
>      int n;
>  
> -    if (!cpu_model) {
> -        cpu_model = XTENSA_DEFAULT_CPU_MODEL;
> -    }
> -
>      for (n = 0; n < smp_cpus; n++) {
> -        cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
> +        cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
>          env = &cpu->env;
>  
>          env->sregs[PRID] = n;
> @@ -454,6 +449,7 @@ static void xtensa_lx60_class_init(ObjectClass *oc, void *data)
>      mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
>      mc->init = xtensa_lx60_init;
>      mc->max_cpus = 4;
> +    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>  }
>  
>  static const TypeInfo xtensa_lx60_type = {
> @@ -469,6 +465,7 @@ static void xtensa_lx200_class_init(ObjectClass *oc, void *data)
>      mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
>      mc->init = xtensa_lx200_init;
>      mc->max_cpus = 4;
> +    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>  }
>  
>  static const TypeInfo xtensa_lx200_type = {
> @@ -484,6 +481,7 @@ static void xtensa_ml605_class_init(ObjectClass *oc, void *data)
>      mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
>      mc->init = xtensa_ml605_init;
>      mc->max_cpus = 4;
> +    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>  }
>  
>  static const TypeInfo xtensa_ml605_type = {
> @@ -499,6 +497,7 @@ static void xtensa_kc705_class_init(ObjectClass *oc, void *data)
>      mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
>      mc->init = xtensa_kc705_init;
>      mc->max_cpus = 4;
> +    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>  }
>  
>  static const TypeInfo xtensa_kc705_type = {
> 
