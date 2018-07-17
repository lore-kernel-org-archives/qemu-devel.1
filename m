Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX7f-0000VB-TY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX7e-00022J-UT
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:03 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:36515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ffX7e-00021w-Lv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:02 -0400
Received: by mail-oi0-x233.google.com with SMTP id r16-v6so4705059oie.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:03:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7b4596fd90e5576e7caafc0f34ecb06c786c4a7c.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<7b4596fd90e5576e7caafc0f34ecb06c786c4a7c.1531859179.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 18 Jul 2018 09:03:01 +1200
Message-ID: <CAHNT7NsWqB11DzW_smQn_3F1mPvuT+rLwpDwDPRriaY=B19XCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/5] sifive_e: Fix crash when
 introspecting the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Wed, Jul 18, 2018 at 8:27 AM, Alistair Francis <alistair.francis@wdc.com>
wrote:

> Use the new object_initialize_child() and sysbus_init_child_obj() to
> fix the issue.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/sifive_e.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 8a8dbe1c00..4577d72037 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -105,9 +105,9 @@ static void riscv_sifive_e_init(MachineState *machine)
>      int i;
>
>      /* Initialize SoC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            sizeof(s->soc), TYPE_RISCV_E_SOC,
> +                            &error_abort, NULL);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                              &error_abort);
>
> @@ -139,9 +139,9 @@ static void riscv_sifive_e_soc_init(Object *obj)
>  {
>      SiFiveESoCState *s = RISCV_E_SOC(obj);
>
> -    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
> -    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
> -                              &error_abort);
> +    object_initialize_child(obj, "cpus", &s->cpus,
> +                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
> +                            &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
> --
> 2.17.1
>
>
