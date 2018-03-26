Received: from eggs.gnu.org ([2001:4830:134:3::10]:38223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f0UHp-0002xR-3n
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f0UHl-0006rO-6q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:43:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1f0UHl-0006nX-0y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:43:49 -0400
References: <20180326153441.32641-1-f4bug@amsat.org>
	<20180326153441.32641-6-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3a91b73a-5484-bb57-00f4-dfeab1387ea9@redhat.com>
Date: Mon, 26 Mar 2018 18:43:28 +0300
MIME-Version: 1.0
In-Reply-To: <20180326153441.32641-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13 5/5] hw/dma/i8257: Rename
 i8257_dma_init(false) -> i8257_dma_init_pc_at()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Nageswara Sastry <nasastry@in.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 26/03/2018 18:34, Philippe Mathieu-Daud=C3=A9 wrote:
> Reflect that the PC/AT implementation is used.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/dma/i8257.h  | 17 +++++++++++++++--
>  hw/i386/pc.c            |  2 +-
>  hw/mips/mips_fulong2e.c |  2 +-
>  hw/mips/mips_jazz.c     |  2 +-
>  hw/mips/mips_malta.c    |  2 +-
>  5 files changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
> index 986319e4e3..15db8b4d29 100644
> --- a/include/hw/dma/i8257.h
> +++ b/include/hw/dma/i8257.h
> @@ -47,9 +47,22 @@ typedef struct I8257State {
>  } I8257State;
> =20
>  void i8257_dma_init_cascaded(ISABus *bus, bool high_page_enable);
> -static inline void i8257_dma_init(ISABus *bus, bool high_page_enable)
> +
> +/**
> + * i8257_dma_init_pc_at: Install 8 DMA channels on the ISA bus.
> + *
> + * This is the PC/AT DMA implementation:
> + *
> + * Two i8257 controllers are created.
> + * The primary controller register channels [0..3] on the bus,
> + * the secondary controller (slave) is cascaded on the primary (master=
),
> + * registering channels [4..7].
> + *
> + * @bus: the #ISABus against which these are created.
> + */
> +static inline void i8257_dma_init_pc_at(ISABus *bus)
>  {
> -    i8257_dma_init_cascaded(bus, high_page_enable);
> +    i8257_dma_init_cascaded(bus, false);
>  }
> =20
>  #endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d36bac8c89..baba079d7f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1624,7 +1624,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_i=
rq *gsi,
>          pcspk_init(isa_bus, pit);
>      }
> =20
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init_pc_at(isa_bus);
> =20
>      /* Super I/O */
>      pc_superio_init(isa_bus, create_fdctrl, no_vmport);
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 02fb2fdcc4..8168e6cf16 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -243,7 +243,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_=
bus, int slot, qemu_irq intc,
>      isa_bus_irqs(isa_bus, i8259);
>      /* init other devices */
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init_pc_at(isa_bus);
>      /* Super I/O */
>      isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
> =20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 7223085547..2577e8383d 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -222,7 +222,7 @@ static void mips_jazz_init(MachineState *machine,
>      /* ISA devices */
>      i8259 =3D i8259_init(isa_bus, env->irq[4]);
>      isa_bus_irqs(isa_bus, i8259);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init_pc_at(isa_bus);
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      pcspk_init(isa_bus, pit);
> =20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index f6513a4fd5..9d0409bc36 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1198,7 +1198,7 @@ void mips_malta_init(MachineState *machine)
>      smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>                            isa_get_irq(NULL, 9), NULL, 0, NULL);
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init_pc_at(isa_bus);
>      mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
>      /* generate SPD EEPROM data */
>=20

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
