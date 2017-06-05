Received: from eggs.gnu.org ([2001:4830:134:3::10]:44158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHt58-0007Tb-4s
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHt56-0003P1-UZ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:34:10 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHt56-0003Ol-Mn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:34:08 -0400
Received: by mail-wm0-x233.google.com with SMTP id x70so14302673wme.0
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 07:34:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424015927.8933-42-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<20170424015927.8933-42-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 15:33:46 +0100
Message-ID: <CAFEAcA8FvmfwwhbNEz4qvGCjoPEQn6bJh-WiwRM7Ot0uEV8ACg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 41/47] ppc/pnv: populate device tree for
 IPMI BT devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 24 April 2017 at 02:59, David Gibson <david@gibson.dropbear.id.au> wrote=
:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> When an ipmi-bt device [1] is defined on the ISA bus, we need to
> populate the device tree with the object properties. Such devices are
> created with the command line options :
>
>    -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg03168.html
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index dfa21e4..977e126 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -354,6 +354,39 @@ static void powernv_populate_serial(ISADevice *d, vo=
id *fdt, int lpc_off)
>      _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
>  }
>
> +static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
> +{
> +    const char compatible[] =3D "bt\0ipmi-bt";
> +    uint32_t io_base;
> +    uint32_t io_regs[] =3D {
> +        cpu_to_be32(1),
> +        0, /* 'io_base' retrieved from the 'ioport' property of 'isa-ipm=
i-bt' */
> +        cpu_to_be32(3)
> +    };
> +    uint32_t irq;
> +    char *name;
> +    int node;
> +
> +    io_base =3D object_property_get_int(OBJECT(d), "ioport", &error_fata=
l);
> +    io_regs[1] =3D cpu_to_be32(io_base);
> +
> +    irq =3D object_property_get_int(OBJECT(d), "irq", &error_fatal);
> +
> +    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_base)=
;
> +    node =3D fdt_add_subnode(fdt, lpc_off, name);
> +    _FDT(node);
> +    g_free(name);
> +
> +    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
> +    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatible))=
;
> +
> +    /* Mark it as reserved to avoid Linux trying to claim it */
> +    _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupts", irq)));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
> +                           fdt_get_phandle(fdt, lpc_off))));
> +}

Hi -- Coverity points out (CID 1374832) that the fdt_setprop() calls
in this function to set "reg" and "compatible" don't check whether the
function returns an error. Is there any reason why these calls
haven't been wrapped with the barf-on-errors _FDT() macro like the
other fdt_setprop* calls in the function?

thanks
-- PMM
