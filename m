Received: from eggs.gnu.org ([2001:4830:134:3::10]:40418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUeZO-0007Wy-Fn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUeZL-0002Px-5W
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:18:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUeZK-0002PA-Tv
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:18:55 -0500
References: <5C07EB0A.0934FA.23346@m12-11.163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf0be83a-2df7-7ed1-04d3-f457ce97de53@redhat.com>
Date: Wed, 5 Dec 2018 22:18:50 +0100
MIME-Version: 1.0
In-Reply-To: <5C07EB0A.0934FA.23346@m12-11.163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question about piix3's PIRQC register set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, Alex Williamson <alex.l.williamson@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 05/12/18 16:13, Li Qiang wrote:
> Here my question when the piix3=E2=80=99s PIRQx route control registers=
 is set
> and by who?
>=20
> I mean when this =E2=80=98=E2=80=98piix3->dev.config[PIIX_PIRQC + pin];=
=E2=80=99=E2=80=99 is set?
> =C2=A0
> Once I think this is set by seabios.

Hi,

it's set by the operating system via ACPI.  Search for define_link in
SeaBIOS's src/fw/acpi-dsdt.dsl, it refers to fields called PRQ0-PRQ3
which in turn are defined like this:

            /* PIIX PCI to ISA irq remapping */
            OperationRegion(P40C, PCI_Config, 0x60, 0x04)

	...
        Field(PCI0.ISA.P40C, ByteAcc, NoLock, Preserve) {
            PRQ0,   8,
            PRQ1,   8,
            PRQ2,   8,
            PRQ3,   8
        }

Current QEMU doesn't use anymore the SeaBIOS copy of the DSDT, but the
same thing can be found in build_piix4_isa_bridge and
build_piix4_pci0_int, in hw/i386/acpi-build.c.

> But seems it is not as this function is called in vfio_realize, the
> guest dones=E2=80=99t begin.

vfio also calls it (from vfio_intx_update) every time the routing
registers are updated.  The ISA bridge calls
pci_bus_fire_intx_routing_notifier, and then that function calls
vfio_intx_update, because it was registered with
pci_device_set_intx_routing_notifier.

Thanks,

Paolo
