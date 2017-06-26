Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLlo-0002gD-L1
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLln-00041o-N2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:37:04 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170623220926.11479-2-jsnow@redhat.com>
References: <20170623220926.11479-1-jsnow@redhat.com>
	<20170623220926.11479-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:37:00 -0300
Message-ID: <CAAdtpL5PrQY5iqej0uFyebBdX2PMk=JPjA5ESfXiv2B+-joY2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] ahci: add ahci_get_num_ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jun 23, 2017 at 7:09 PM, John Snow <jsnow@redhat.com> wrote:
> Instead of reaching into the PCI state, allow the AHCIDevice to
> respond with how many ports it has.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/i386/pc_q35.c      | 4 ++--
>  hw/ide/ahci.c         | 8 ++++++++
>  hw/mips/boston.c      | 4 ++--
>  include/hw/ide/ahci.h | 1 +
>  4 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 1523ef3..8715514 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -241,8 +241,8 @@ static void pc_q35_init(MachineState *machine)
>                                                 true, "ich9-ahci");
>          idebus[0] =3D qdev_get_child_bus(&ahci->qdev, "ide.0");
>          idebus[1] =3D qdev_get_child_bus(&ahci->qdev, "ide.1");
> -        g_assert(MAX_SATA_PORTS =3D=3D ICH_AHCI(ahci)->ahci.ports);
> -        ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
> +        g_assert(MAX_SATA_PORTS =3D=3D ahci_get_num_ports(ahci));
> +        ide_drive_get(hd, ahci_get_num_ports(ahci));
>          ahci_ide_create_devs(ahci, hd);
>      } else {
>          idebus[0] =3D idebus[1] =3D NULL;
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index f60826d..1ab3245 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1833,6 +1833,14 @@ static void sysbus_ahci_register_types(void)
>
>  type_init(sysbus_ahci_register_types)
>
> +int32_t ahci_get_num_ports(PCIDevice *dev)
> +{
> +    AHCIPCIState *d =3D ICH_AHCI(dev);
> +    AHCIState *ahci =3D &d->ahci;
> +
> +    return ahci->ports;
> +}
> +
>  void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
>  {
>      AHCIPCIState *d =3D ICH_AHCI(dev);
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index a4677f7..ad59404 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -538,8 +538,8 @@ static void boston_mach_init(MachineState *machine)
>      ahci =3D pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->=
sec_bus,
>                                             PCI_DEVFN(0, 0),
>                                             true, TYPE_ICH9_AHCI);
> -    g_assert(ARRAY_SIZE(hd) =3D=3D ICH_AHCI(ahci)->ahci.ports);
> -    ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
> +    g_assert(ARRAY_SIZE(hd) =3D=3D ahci_get_num_ports(ahci));
> +    ide_drive_get(hd, ahci_get_num_ports(ahci));
>      ahci_ide_create_devs(ahci, hd);
>
>      if (machine->firmware) {
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index 0ca7c65..f866bbf 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -372,6 +372,7 @@ void ahci_uninit(AHCIState *s);
>
>  void ahci_reset(AHCIState *s);
>
> +int32_t ahci_get_num_ports(PCIDevice *dev);
>  void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
>
>  #define TYPE_SYSBUS_AHCI "sysbus-ahci"
> --
> 2.9.4
>
