Received: from eggs.gnu.org ([209.51.188.92]:57768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2drA-0002xN-3F
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 10:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2dr9-0007iK-Df
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 10:25:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-8-philmd@redhat.com>
Date: Sat, 09 Mar 2019 15:47:36 +0100
In-Reply-To: <20190308013222.12524-8-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Mar 2019 02:32:11
	+0100")
Message-ID: <87imws3y0n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/18] hw/nvram/fw_cfg: Add
 fw_cfg_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Back in abe147e0ce4 when fw_cfg_add_file() was introduced, there
> was no QOM design, object where not created and released at runtime.
> Later 38f3adc34d finished the QOM conversion of the fw_cfg device,
> adding the fw_cfg_common_realize() method.
> The time has come to add the equivalent destructor and release the
> memory allocated for 'files'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index b2dc0a80cb..0fb020edce 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -959,6 +959,13 @@ static void fw_cfg_common_realize(DeviceState *dev, =
Error **errp)
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
>  }
>=20=20
> +static void fw_cfg_common_unrealize(DeviceState *dev, Error **errp)
> +{
> +    FWCfgState *s =3D FW_CFG(dev);
> +
> +    g_free(s->files);
> +}
> +

Still leaks at least s->entries[0], s->entries[1], s->entry_order,
doesn't it?

>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as)
>  {
> @@ -1127,6 +1134,7 @@ static void fw_cfg_io_class_init(ObjectClass *klass=
, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20=20
>      dc->realize =3D fw_cfg_io_realize;
> +    dc->unrealize =3D fw_cfg_common_unrealize;
>      dc->props =3D fw_cfg_io_properties;
>  }
>=20=20
> @@ -1190,6 +1198,7 @@ static void fw_cfg_mem_class_init(ObjectClass *klas=
s, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20=20
>      dc->realize =3D fw_cfg_mem_realize;
> +    dc->unrealize =3D fw_cfg_common_unrealize;
>      dc->props =3D fw_cfg_mem_properties;
>  }
