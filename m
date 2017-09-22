Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxg-0002Wx-BF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxc-00022I-QF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:32 -0400
Received: from ozlabs.org ([103.22.144.67]:56203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dvKxc-00020G-5N
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:28 -0400
Date: Fri, 22 Sep 2017 20:13:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922101312.GH4998@umbus.fritz.box>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <1506071794-4373-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 11:16:34AM +0200, Thomas Huth wrote:
> Historically we've marked all devices as hotpluggable by default. However,
> most devices are not hotpluggable, and you also need a HotplugHandler to
> support these devices. So if the user tries to "device_add" or "device_de=
l"
> such a non-hotpluggable device during runtime, either nothing really usab=
le
> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> So let's change this dangerous default behaviour and mark the devices as
> non-hotpluggable by default. Certain parent devices classes which are kno=
wn
> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable =3D t=
rue",
> so that devices that are derived from these classes continue to work as
> expected.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Seems reasonable to me.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  v2: Add missing devices and dropped "RFC" status. See Eduardo's reply on
>  the previous version of this patch for the rationale which devices need
>  to be hotpluggable:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06128.html
>=20
>  hw/char/virtio-serial-bus.c   |  1 +
>  hw/core/qdev.c                | 10 ++++------
>  hw/mem/nvdimm.c               |  3 +++
>  hw/mem/pc-dimm.c              |  1 +
>  hw/pci/pci.c                  |  1 +
>  hw/ppc/spapr_cpu_core.c       |  1 +
>  hw/s390x/ccw-device.c         |  1 +
>  hw/scsi/scsi-bus.c            |  1 +
>  hw/usb/bus.c                  |  1 +
>  hw/usb/dev-smartcard-reader.c |  1 +
>  hw/xen/xen_backend.c          |  1 +
>  target/i386/cpu.c             |  4 ++--
>  target/s390x/cpu.c            |  1 +
>  13 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 17a1bb0..da26fc2 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1097,6 +1097,7 @@ static void virtio_serial_port_class_init(ObjectCla=
ss *klass, void *data)
>      k->realize =3D virtser_port_device_realize;
>      k->unrealize =3D virtser_port_device_unrealize;
>      k->props =3D virtser_props;
> +    k->hotpluggable =3D true;
>  }
> =20
>  static const TypeInfo virtio_serial_port_type_info =3D {
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index d9ccce6..28fd92f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1125,13 +1125,11 @@ static void device_class_init(ObjectClass *class,=
 void *data)
>      dc->realize =3D device_realize;
>      dc->unrealize =3D device_unrealize;
> =20
> -    /* by default all devices were considered as hotpluggable,
> -     * so with intent to check it in generic qdev_unplug() /
> -     * device_set_realized() functions make every device
> -     * hotpluggable. Devices that shouldn't be hotpluggable,
> -     * should override it in their class_init()
> +    /*
> +     * All devices are considered as cold-pluggable by default. The devi=
ces
> +     * that are hotpluggable should override it in their class_init().
>       */
> -    dc->hotpluggable =3D true;
> +    dc->hotpluggable =3D false;
>      dc->user_creatable =3D true;
>  }
> =20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 952fce5..02be9f3 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -148,9 +148,12 @@ static MemoryRegion *nvdimm_get_vmstate_memory_regio=
n(PCDIMMDevice *dimm)
> =20
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_CLASS(oc);
>      NVDIMMClass *nvc =3D NVDIMM_CLASS(oc);
> =20
> +    dc->hotpluggable =3D true;
> +
>      ddc->realize =3D nvdimm_realize;
>      ddc->get_memory_region =3D nvdimm_get_memory_region;
>      ddc->get_vmstate_memory_region =3D nvdimm_get_vmstate_memory_region;
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 66eace5..1f78567 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -443,6 +443,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void =
*data)
>      dc->unrealize =3D pc_dimm_unrealize;
>      dc->props =3D pc_dimm_properties;
>      dc->desc =3D "DIMM memory module";
> +    dc->hotpluggable =3D true;
> =20
>      ddc->get_memory_region =3D pc_dimm_get_memory_region;
>      ddc->get_vmstate_memory_region =3D pc_dimm_get_vmstate_memory_region;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88..8db380d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2534,6 +2534,7 @@ static void pci_device_class_init(ObjectClass *klas=
s, void *data)
>      k->unrealize =3D pci_qdev_unrealize;
>      k->bus_type =3D TYPE_PCI_BUS;
>      k->props =3D pci_props;
> +    k->hotpluggable =3D true;
>      pc->realize =3D pci_default_realize;
>  }
> =20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee75..720284e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -325,6 +325,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void =
*data)
>      dc->realize =3D spapr_cpu_core_realize;
>      dc->unrealize =3D spapr_cpu_core_unrealizefn;
>      dc->props =3D spapr_cpu_core_properties;
> +    dc->hotpluggable =3D true;
>      scc->cpu_class =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
>      g_assert(scc->cpu_class);
>  }
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa15..d1b6e6f 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, v=
oid *data)
>      k->realize =3D ccw_device_realize;
>      k->refill_ids =3D ccw_device_refill_ids;
>      dc->props =3D ccw_device_properties;
> +    dc->hotpluggable =3D true;
>  }
> =20
>  const VMStateDescription vmstate_ccw_dev =3D {
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 977f7bc..6703b2a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1741,6 +1741,7 @@ static void scsi_device_class_init(ObjectClass *kla=
ss, void *data)
>      k->realize   =3D scsi_qdev_realize;
>      k->unrealize =3D scsi_qdev_unrealize;
>      k->props     =3D scsi_props;
> +    k->hotpluggable =3D true;
>  }
> =20
>  static void scsi_dev_instance_init(Object *obj)
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index d910f84..16701aa 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -793,6 +793,7 @@ static void usb_device_class_init(ObjectClass *klass,=
 void *data)
>      k->realize  =3D usb_qdev_realize;
>      k->unrealize =3D usb_qdev_unrealize;
>      k->props    =3D usb_props;
> +    k->hotpluggable =3D true;
>  }
> =20
>  static const TypeInfo usb_device_type_info =3D {
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index bef1f03..e28d1ba 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1499,6 +1499,7 @@ static void ccid_card_class_init(ObjectClass *klass=
, void *data)
>      k->init =3D ccid_card_init;
>      k->exit =3D ccid_card_exit;
>      k->props =3D ccid_props;
> +    k->hotpluggable =3D true;
>  }
> =20
>  static const TypeInfo ccid_card_type_info =3D {
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index c46cbb0..96621fe 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -620,6 +620,7 @@ static void xendev_class_init(ObjectClass *klass, voi=
d *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* xen-backend devices can be plugged/unplugged dynamically */
>      dc->user_creatable =3D true;
> +    dc->hotpluggable =3D true;
>  }
> =20
>  static const TypeInfo xendev_type_info =3D {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0aa28fc..122623b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4170,6 +4170,8 @@ static void x86_cpu_common_class_init(ObjectClass *=
oc, void *data)
>      dc->realize =3D x86_cpu_realizefn;
>      dc->unrealize =3D x86_cpu_unrealizefn;
>      dc->props =3D x86_cpu_properties;
> +    dc->user_creatable =3D true;
> +    dc->hotpluggable =3D true;
> =20
>      xcc->parent_reset =3D cc->reset;
>      cc->reset =3D x86_cpu_reset;
> @@ -4215,8 +4217,6 @@ static void x86_cpu_common_class_init(ObjectClass *=
oc, void *data)
>  #endif
>      cc->cpu_exec_enter =3D x86_cpu_exec_enter;
>      cc->cpu_exec_exit =3D x86_cpu_exec_exit;
> -
> -    dc->user_creatable =3D true;
>  }
> =20
>  static const TypeInfo x86_cpu_type_info =3D {
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 34538c3..ef61d19 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -462,6 +462,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>      dc->realize =3D s390_cpu_realizefn;
>      dc->props =3D s390x_cpu_properties;
>      dc->user_creatable =3D true;
> +    dc->hotpluggable =3D true;
> =20
>      scc->parent_reset =3D cc->reset;
>  #if !defined(CONFIG_USER_ONLY)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE4jgACgkQbDjKyiDZ
s5J21xAAhlFoTQSILgcqVpTX/bd46ItuLOZAZMcP2SjZ5nuP0kB9qtdkQYjEkP7B
vmv09iASsmVn72m3Rr5U8xRfNCexEv18npdJXR+nfJx51eVmC0vJRKEjaHb0oIaC
0ynNirnlg8sm9w50Qp5QDqBbBlGwINxwk4BJlqTAznVNkrmxL2zT5FGAYTIb5fW2
TbJQe49ElG91NirFYNPruD/9SGXa6ef0hlzVP/DcpxcgnKiNIav/C3EHWLvEdCmS
ed16jPrpDYarohT0xFZFbQ5UFric39IsYybW7egtiGs4zfRYfu1jk2lzCPbZkhnu
GQqPPl4lRSbJyZiUJzTha3otSLFTkzE9YzM5HDhkIeuHwvxR3nbbMuRH3fR+Z4eI
4Bg9ES+Xu2+s4ivpHrFJpnqsr2tofSRHGXkP8gAI5e8LmR+EufeoM5+37ufHeBBo
7fTWjh564ItKXMd4JK9p2/KcC/QlxY+PMjvJVA0gSXc28Mxi3Z9X1CV43uztUbgy
pP5YFA+I66Gymd7qgiAkCsRQ5P9yFLRf1C3MSUGh9YQtxYBSib8WXI+LaIuIzANU
ykQ3rQIs6oYPt6F6BhSh3tQ0StpCmxu9xj/qzh1prTUUagFmmPS/x6ftUQfiD2PC
oMYQw952FKvJnwvrlbPuyEu7Gn1diQOzSYWw67YDNUfAjYjzEY4=
=suBz
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
