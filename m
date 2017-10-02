Received: from eggs.gnu.org ([2001:4830:134:3::10]:42372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1PP-0002g1-Sl
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1PK-0000GH-0J
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:09:23 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1PJ-0000G6-Qt
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:09:17 -0400
Received: by mail-qt0-x243.google.com with SMTP id b21so1496104qte.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:09:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-34-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77335363-f322-5813-f204-b81520eda665@amsat.org>
Date: Mon, 2 Oct 2017 11:09:12 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-34-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 33/38] mips: use object_new() instead of
 gnew()+object_initialize()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, aurelien@aurel32.net
Cc: qemu-devel@nongnu.org, paul.burton@imgtec.com, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> object_initialize() is intended for inplace initialization of
> objects, but here it's first allocated with g_new0() and then
> initialized with object_initialize(). QEMU already has API
> to do this (object_new), so do object creation with suitable
> for usecase API.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: paul.burton@imgtec.com
> CC: aurelien@aurel32.net
> CC: yongbok.kim@imgtec.com
> ---
>   hw/mips/boston.c     | 3 +--
>   hw/mips/mips_malta.c | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 776ee28..e815be6 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -460,7 +460,6 @@ static void boston_mach_init(MachineState *machine)
>   
>       s = BOSTON(dev);
>       s->mach = machine;
> -    s->cps = g_new0(MIPSCPSState, 1);
>   
>       if (!cpu_supports_cps_smp(cpu_model)) {
>           error_report("Boston requires CPUs which support CPS");
> @@ -469,7 +468,7 @@ static void boston_mach_init(MachineState *machine)
>   
>       is_64b = cpu_supports_isa(cpu_model, ISA_MIPS64);
>   
> -    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
> +    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
>       qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
>   
>       object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 2adb9bc..b6a58c7 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -949,9 +949,8 @@ static void create_cps(MaltaState *s, const char *cpu_model,
>                          qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>   {
>       Error *err = NULL;
> -    s->cps = g_new0(MIPSCPSState, 1);
>   
> -    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
> +    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
>       qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
>   
>       object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
> 
