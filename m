Received: from eggs.gnu.org ([2001:4830:134:3::10]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8c-000149-FJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8b-0002Xp-Fp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:02 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:37119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ffX8b-0002Xd-7u
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:01 -0400
Received: by mail-oi0-x22f.google.com with SMTP id k81-v6so4700829oib.4
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:04:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c60f18b1b26088dbbb54538caeaa0121e94a52d.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<6c60f18b1b26088dbbb54538caeaa0121e94a52d.1531859179.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 18 Jul 2018 09:04:00 +1200
Message-ID: <CAHNT7Ns_z5KGMgRCKf8__NXo3UAWAKQRFuW8q9i8_UE3McL9nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 4/5] riscv_hart: Fix crash when
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

On Wed, Jul 18, 2018 at 8:28 AM, Alistair Francis <alistair.francis@wdc.com>
wrote:

> Use the new object_initialize_child() and sysbus_init_child_obj() to
> fix the issue.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/riscv_hart.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 75ba7ed579..e34a26a0ef 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -45,11 +45,10 @@ static void riscv_harts_realize(DeviceState *dev,
> Error **errp)
>      s->harts = g_new0(RISCVCPU, s->num_harts);
>
>      for (n = 0; n < s->num_harts; n++) {
> -
> -        object_initialize(&s->harts[n], sizeof(RISCVCPU), s->cpu_type);
> +        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
> +                                sizeof(RISCVCPU), s->cpu_type,
> +                                &error_abort, NULL);
>          s->harts[n].env.mhartid = n;
> -        object_property_add_child(OBJECT(s), "harts[*]",
> OBJECT(&s->harts[n]),
> -                                  &error_abort);
>          qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
>          object_property_set_bool(OBJECT(&s->harts[n]), true,
>                                   "realized", &err);
> --
> 2.17.1
>
>
