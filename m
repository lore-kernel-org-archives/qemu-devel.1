Received: from eggs.gnu.org ([209.51.188.92]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CbB-0001Nm-Ak
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CbA-0004yk-Eh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:19:29 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-9-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <34983af3-cc35-5274-8a56-a8d8531702ed@redhat.com>
Date: Fri, 8 Mar 2019 11:19:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/18] hw/nvram/fw_cfg: Move
 fw_cfg_file_slots_allocate() to common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Each implementation (I/O and MEM) calls fw_cfg_file_slots_allocate()
> then fw_cfg_common_realize().
> Simplify by moving the fw_cfg_file_slots_allocate() call into
> fw_cfg_common_realize() where it belongs.

The patch does more than that, namely:

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 0fb020edce..ca58d279a4 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -929,19 +929,26 @@ static void fw_cfg_machine_ready(struct Notifier =
*n, void *data)
>      qemu_register_reset(fw_cfg_machine_reset, s);
>  }
> =20
> -
> +static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp);
> =20
>  static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
>  {
>      FWCfgState *s =3D FW_CFG(dev);
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      uint32_t version =3D FW_CFG_VERSION;
> +    Error *local_err =3D NULL;
> =20
>      if (!fw_cfg_find()) {
>          error_setg(errp, "at most one %s device is permitted", TYPE_FW=
_CFG);
>          return;
>      }
> =20
> +    fw_cfg_file_slots_allocate(s, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
>      fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
>      fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_gra=
phics);
> @@ -1108,7 +1115,7 @@ static void fw_cfg_io_realize(DeviceState *dev, E=
rror **errp)
>      FWCfgIoState *s =3D FW_CFG_IO(dev);
>      Error *local_err =3D NULL;
> =20
> -    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> +    fw_cfg_common_realize(dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -1125,8 +1132,6 @@ static void fw_cfg_io_realize(DeviceState *dev, E=
rror **errp)
>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.d=
ma",
>                                sizeof(dma_addr_t));
>      }
> -
> -    fw_cfg_common_realize(dev, errp);
>  }

it moves the fw_cfg_common_realize() call from the ends of the IO/MEM
realize functions to their middles; in particular to the point before
memory regions and (when appropriate) MMIO resources are initialized.

In other words, the patch reorders all of the current actions in
fw_cfg_common_realize() against said MemoryRegion & SysBusDevice
resource actions.

Why is this safe? (I'm not claiming it is unsafe, but I'd like to see it
explained in the commit message.)

Note: the fw_cfg_common_realize() you are moving around was introduced
in commit 38f3adc34de8 ("fw_cfg: move qdev_init_nofail() from
fw_cfg_init1() to callers", 2017-07-17), by Mark Cave-Ayland. I see Mark
is CC'd already, so I hope he can comment.

Thanks,
Laszlo

> =20
>  static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
> @@ -1162,7 +1167,7 @@ static void fw_cfg_mem_realize(DeviceState *dev, =
Error **errp)
>      const MemoryRegionOps *data_ops =3D &fw_cfg_data_mem_ops;
>      Error *local_err =3D NULL;
> =20
> -    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> +    fw_cfg_common_realize(dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -1189,8 +1194,6 @@ static void fw_cfg_mem_realize(DeviceState *dev, =
Error **errp)
>                                sizeof(dma_addr_t));
>          sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>      }
> -
> -    fw_cfg_common_realize(dev, errp);
>  }
> =20
>  static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
>=20
