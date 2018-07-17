Received: from eggs.gnu.org ([2001:4830:134:3::10]:49221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRaT-0006AH-TD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRaQ-00083e-Mg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:08:25 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:41623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRaQ-00082z-Er
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:08:22 -0400
Received: by mail-ua0-x242.google.com with SMTP id t14-v6so884722uao.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:08:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1531839759-14090-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b221436-d992-f147-0fc7-487c2ff2a969@amsat.org>
Date: Tue, 17 Jul 2018 12:08:17 -0300
MIME-Version: 1.0
In-Reply-To: <1531839759-14090-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/sifive_u: Fix introspection
 problem in the "riscv.sifive.u.soc" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 07/17/2018 12:02 PM, Thomas Huth wrote:
> Valgrind complains:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'riscv.sifive.u.soc'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q riscv32-softmmu/qemu-system-riscv32 -M none,accel=qtest -qmp stdio
> [...]
> ==28083== Invalid read of size 8
> ==28083==    at 0x2E036A: qdev_print (qdev-monitor.c:686)
> ==28083==    by 0x2E036A: qbus_print (qdev-monitor.c:719)
> ==28083==    by 0x268938: handle_hmp_command (monitor.c:3446)
> [...]
> 
> Use the new object_initialize_child() and sysbus_init_child_obj() functions
> to fix the problem.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/sifive_u.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 3a6ffeb..459ec90 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
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
