Received: from eggs.gnu.org ([2001:4830:134:3::10]:52897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnB8-0004jr-IR
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnB5-0003L7-C9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:11:42 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:46803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnB5-0003Kr-5C
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:11:39 -0400
Received: by mail-ua0-x243.google.com with SMTP id r18-v6so3000209ual.13
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:11:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<0f2b0a7a0b3565525a8683ac8fe65f44f734ab19.1531859179.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <060ee023-8a95-86c4-f5d1-b269ccce046a@amsat.org>
Date: Wed, 18 Jul 2018 11:11:33 -0300
MIME-Version: 1.0
In-Reply-To: <0f2b0a7a0b3565525a8683ac8fe65f44f734ab19.1531859179.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] sifive_u: Fix crash when
 introspecting the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, mjc@sifive.com

On 07/17/2018 05:28 PM, Alistair Francis wrote:
> Use the new object_initialize_child() and sysbus_init_child_obj() to
> fix the issue.
> 

Suggested-by: Thomas Huth <thuth@redhat.com>

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/sifive_u.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 3a6ffeb437..59ae1ce24a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -244,9 +244,9 @@ static void riscv_sifive_u_init(MachineState *machine)
>      int i;
>  
>      /* Initialize SoC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_U_SOC);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            sizeof(s->soc), TYPE_RISCV_U_SOC,
> +                            &error_abort, NULL);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                              &error_abort);
>  
> @@ -303,16 +303,15 @@ static void riscv_sifive_u_soc_init(Object *obj)
>  {
>      SiFiveUSoCState *s = RISCV_U_SOC(obj);
>  
> -    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
> -    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
> -                              &error_abort);
> +    object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
> +                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
>                              &error_abort);
>  
> -    object_initialize(&s->gem, sizeof(s->gem), TYPE_CADENCE_GEM);
> -    qdev_set_parent_bus(DEVICE(&s->gem), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> +                          TYPE_CADENCE_GEM);
>  }
>  
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> 
