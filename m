Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkHsM-0006eM-Ln
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkHsL-0004DM-F8
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:42:22 -0400
Date: Wed, 23 Aug 2017 01:42:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170823014025-mutt-send-email-mst@kernel.org>
References: <20170822214343.31385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170822214343.31385-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10-rc4?] acpi: pcihp: fix
 use-after-free for machines previous pc-1.7 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daud=E9 wrote:
> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new pro=
perty
> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API" adde=
d the
> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hotplug=
'
> property.
>=20
> Check for use_acpi_pci_hotplug before calling acpi_pcihp_device_[un]plu=
g_cb().
>=20
> If Xen is enabled, piix4_pm_init() disables use_acpi_pci_hotplug.
>=20
> The following valgrind Trace equivs:
>=20
>   qdev_device_add( "ich9-ahci" )
>    -> device_set_realized()
>     -> hotplug_handler_plug()
>      -> piix4_device_plug_cb()
>       -> acpi_pcihp_device_plug_cb()
>        -> acpi_pcihp_get_bsel() "Property ACPI_PCIHP_PROP_BSEL not foun=
d"
>    -> object_unparent()
>      <- "Bus doesn't have property ACPI_PCIHP_PROP_BSEL set"
>=20
> $ valgrind x86_64-softmmu/qemu-system-x86_64 -M pc-1.2 -nographic -S
> (qemu) device_add ich9-ahci,id=3Dich9-ahci
> =3D=3D6604=3D=3D Invalid read of size 8
> =3D=3D6604=3D=3D    at 0x609AB0: object_unparent (object.c:445)
> =3D=3D6604=3D=3D    by 0x4C4478: device_unparent (qdev.c:1095)
> =3D=3D6604=3D=3D    by 0x60A364: object_finalize_child_property (object=
.c:1396)
> =3D=3D6604=3D=3D    by 0x6092A6: object_property_del_child.isra.7 (obje=
ct.c:427)
> =3D=3D6604=3D=3D    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> =3D=3D6604=3D=3D    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> =3D=3D6604=3D=3D    by 0x46B689: hmp_device_add (hmp.c:1925)
> =3D=3D6604=3D=3D    by 0x364083: handle_hmp_command (monitor.c:3119)
> =3D=3D6604=3D=3D    by 0x365439: monitor_command_cb (monitor.c:3922)
> =3D=3D6604=3D=3D    by 0x6E5D27: readline_handle_byte (readline.c:393)
> =3D=3D6604=3D=3D    by 0x364311: monitor_read (monitor.c:3905)
> =3D=3D6604=3D=3D    by 0x67C573: mux_chr_read (char-mux.c:216)
> =3D=3D6604=3D=3D  Address 0x15fc5448 is 30,328 bytes inside a block of =
size 36,288 free'd
> =3D=3D6604=3D=3D    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> =3D=3D6604=3D=3D    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.=
0.5000.3)
> =3D=3D6604=3D=3D    by 0x50100E: pci_ich9_uninit (ich.c:161)
> =3D=3D6604=3D=3D    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> =3D=3D6604=3D=3D    by 0x4C5EE9: device_set_realized (qdev.c:988)
> =3D=3D6604=3D=3D    by 0x608DCD: property_set_bool (object.c:1886)
> =3D=3D6604=3D=3D    by 0x60CEBE: object_property_set_qobject (qom-qobje=
ct.c:27)
> =3D=3D6604=3D=3D    by 0x60AB6F: object_property_set_bool (object.c:116=
2)
> =3D=3D6604=3D=3D    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> =3D=3D6604=3D=3D    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> =3D=3D6604=3D=3D    by 0x46B689: hmp_device_add (hmp.c:1925)
> =3D=3D6604=3D=3D    by 0x364083: handle_hmp_command (monitor.c:3119)
> =3D=3D6604=3D=3D  Block was alloc'd at
> =3D=3D6604=3D=3D    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> =3D=3D6604=3D=3D    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.=
so.0.5000.3)
> =3D=3D6604=3D=3D    by 0x50094F: ahci_realize (ahci.c:1468)
> =3D=3D6604=3D=3D    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> =3D=3D6604=3D=3D    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> =3D=3D6604=3D=3D    by 0x4C5E69: device_set_realized (qdev.c:914)
> =3D=3D6604=3D=3D    by 0x608DCD: property_set_bool (object.c:1886)
> =3D=3D6604=3D=3D    by 0x60CEBE: object_property_set_qobject (qom-qobje=
ct.c:27)
> =3D=3D6604=3D=3D    by 0x60AB6F: object_property_set_bool (object.c:116=
2)
> =3D=3D6604=3D=3D    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> =3D=3D6604=3D=3D    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> =3D=3D6604=3D=3D    by 0x46B689: hmp_device_add (hmp.c:1925)
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Looks like this is a very old bug, isn't it?
Objections to merging this after the release?

> ---
>  hw/acpi/piix4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index f276967365..d4df209a2e 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -385,7 +385,7 @@ static void piix4_device_plug_cb(HotplugHandler *ho=
tplug_dev,
>                                  dev, errp);
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        if (!xen_enabled()) {
> +        if (s->use_acpi_pci_hotplug) {
>              acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplu=
g, dev,
>                                        errp);
>          }
> @@ -411,7 +411,7 @@ static void piix4_device_unplug_request_cb(HotplugH=
andler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hot=
plug,
>                                        dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        if (!xen_enabled()) {
> +        if (s->use_acpi_pci_hotplug) {
>              acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotp=
lug, dev,
>                                          errp);
>          }
> --=20
> 2.14.1
