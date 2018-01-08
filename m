Received: from eggs.gnu.org ([2001:4830:134:3::10]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eYY0A-0007Bx-Ku
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eYY06-0005XX-HW
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:02:10 -0500
Date: Mon, 8 Jan 2018 15:01:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180108150143.30b5e38b@redhat.com>
In-Reply-To: <aaab7bfd-d3ed-aa50-f09e-89d6ccf556ff@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-5-f4bug@amsat.org>
	<20180108135437.4ab656fb@redhat.com>
	<cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
	<aaab7bfd-d3ed-aa50-f09e-89d6ccf556ff@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] arm/xlnx-zynq: use FDT names for
 the Cadence UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, 8 Jan 2018 10:51:38 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 01/08/2018 10:17 AM, Thomas Huth wrote:
> > On 08.01.2018 13:54, Igor Mammedov wrote: =20
> >> On Thu,  4 Jan 2018 11:40:44 -0300
> >> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >> =20
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> ---
> >>>  hw/arm/xilinx_zynq.c | 1 +
> >>>  hw/arm/xlnx-zynqmp.c | 2 +-
> >>>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> >>> index 1836a4ed45..c45c364583 100644
> >>> --- a/hw/arm/xilinx_zynq.c
> >>> +++ b/hw/arm/xilinx_zynq.c
> >>> @@ -236,6 +236,7 @@ static void zynq_init(MachineState *machine)
> >>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFS=
ET]);
> >>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFS=
ET]);
> >>> =20
> >>> +    /* "xlnx,xuartps" */
> >>>      cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hds=
[0]);
> >>>      cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hds=
[1]);
> >>> =20
> >>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> >>> index 325642058b..38f038786c 100644
> >>> --- a/hw/arm/xlnx-zynqmp.c
> >>> +++ b/hw/arm/xlnx-zynqmp.c
> >>> @@ -155,7 +155,7 @@ static void xlnx_zynqmp_init(Object *obj)
> >>>      }
> >>> =20
> >>>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> >>> -        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADE=
NCE_UART);
> >>> +        object_initialize(&s->uart[i], sizeof(s->uart[i]), "xlnx,zyn=
qmp-uart"); =20
> >>
> >> I don't think that commas are valid symbol in type names
> >> (if I recall correctly it should be letters, numbers and '-') =20
> >=20
> > At least commas are a real PITA when you try to use such devices with
> > the "-device" CLI parameter. We should try to avoid this if possible, I
> > think. =20
>=20
> Ok, good to know.
>=20
> I was following Linux Device Tree names [1] to avoid handling some
> fdt_qemu_to_linux[] & fdt_linux_to_qemu conversion arrays.
>=20
> What about keeping using the QEMU default name for -device CLI param and
> allow aliases for FDT parsing?
> With this series the cadence_uart_info is now:
>=20
> static const TypeInfo cadence_uart_info =3D {
>     .name          =3D TYPE_CADENCE_UART,
>     .aliases       =3D (const char * []) {
>                         "cdns,uart-r1p8",
>                         "xlnx,xuartps",
>                         "cdns,uart-r1p12",
>                         "xlnx,zynqmp-uart",
>                         NULL
>                      },
No need to pollute Object for this,
It might be better if you make it interface and type will implement it.
But honestly putting desired name in place at the place FDT binding is crea=
ted
is much simpler and one can adapt it to a specific board as needed.


>=20
> [1]:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/serial/cdns,uart.txt
>=20
