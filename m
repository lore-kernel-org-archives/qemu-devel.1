Received: from eggs.gnu.org ([2001:4830:134:3::10]:42649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gD2t6-0007eq-Dl
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gD2t0-0004EL-F6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:38:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gD2sp-0003X9-6r
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:38:17 -0400
Date: Thu, 18 Oct 2018 03:38:12 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1012699093.34889598.1539848292497.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181017143604.5194-3-lhrazky@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-3-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu v2 2/2] spice: set device address
 and device display ID in QXL interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org, kraxel@redhat.com

>=20
> Calls new SPICE QXL interface functions to set:
>=20
> * The hardware address of the graphics device represented by the QXL
>   interface (e.g. a PCI path):
>   spice_qxl_set_device_address(...)
>=20
> * The device display IDs (the IDs of the device's monitors that belong
>   to this QXL interface):
>   spice_qxl_monitor_set_device_display_id(...)
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
> ---
>  hw/display/qxl.c   |  8 ++++++++
>  ui/spice-core.c    | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  ui/spice-display.c |  5 +++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index f608abc769..63144f42b4 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2184,6 +2184,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> Error **errp)
>                     SPICE_INTERFACE_QXL_MAJOR, SPICE_INTERFACE_QXL_MINOR)=
;
>          return;
>      }
> +
> +#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
> +    // register all possible device display IDs to SPICE server
> +    for (int i =3D 0; i < qxl->max_outputs; ++i) {
> +        spice_qxl_monitor_set_device_display_id(&qxl->ssd.qxl, i, i);
> +    }
> +#endif
> +

I think would be better if this were the default in spice-server.

>      qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
> =20
>      qxl->update_irq =3D qemu_bh_new(qxl_update_irq_bh, qxl);
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index a4fbbc3898..2e01beea03 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -35,6 +35,8 @@
>  #include "qemu/option.h"
>  #include "migration/misc.h"
>  #include "hw/hw.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_bus.h"
>  #include "ui/spice-display.h"
> =20
>  /* core bits */
> @@ -871,6 +873,26 @@ bool qemu_spice_have_display_interface(QemuConsole *=
con)
>      return false;
>  }
> =20
> +/*
> + * Recursively (in reverse order) appends addresses of PCI devices as it
> moves
> + * up in the PCI hierarchy.
> + *
> + * @returns true on success, false when the buffer wasn't large enough
> + */
> +static bool append_pci_address_recursive(char *buf, size_t buf_size, con=
st
> PCIDevice *pci)

I won't use the "_recursive" in the name, looks like more an implementation
detail.

> +{
> +    PCIBus *bus =3D pci_get_bus(pci);
> +    if (!pci_bus_is_root(bus)) {
> +        append_pci_address_recursive(buf, buf_size, bus->parent_dev);
> +    }
> +
> +    size_t len =3D strlen(buf);
> +    size_t written =3D snprintf(buf + len, buf_size - len, "/%02x.%x",
> +        PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn));
> +
> +    return written > 0 && written < buf_size - len;

written is always > 0, unless there's a bug in snprintf. Note that Qemu use=
s
MingW snprintf on Windows so even on Windows this returns always > 0 (note
that snprintf returns an int which is signed while size_t is unsigned and
some implementation could return < 0, but not in Qemu).

> +}
> +
>  int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *co=
n)
>  {
>      if (g_slist_find(spice_consoles, con)) {
> @@ -878,7 +900,28 @@ int qemu_spice_add_display_interface(QXLInstance *qx=
lin,
> QemuConsole *con)
>      }
>      qxlin->id =3D qemu_console_get_index(con);
>      spice_consoles =3D g_slist_append(spice_consoles, con);
> -    return qemu_spice_add_interface(&qxlin->base);
> +    int res =3D qemu_spice_add_interface(&qxlin->base);
> +
> +#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
> +    DeviceState *dev =3D DEVICE(object_property_get_link(OBJECT(con),
> "device", &error_abort));
> +    PCIDevice *pci =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev),
> TYPE_PCI_DEVICE);
> +
> +    if (pci =3D=3D NULL) {
> +        warn_report("Setting PCI path of a display device to SPICE: Not =
a
> PCI device.");
> +        return res;
> +    }
> +
> +    char device_path[128] =3D "pci/0000";  // hardcoded PCI domain 0000
> +    if (!append_pci_address_recursive(device_path, sizeof(device_path),
> pci)) {
> +        warn_report("Setting PCI path of a display device to SPICE: "
> +            "Too many PCI devices in the chain.");
> +        return res;
> +    }
> +
> +    spice_qxl_set_device_address(qxlin, device_path);
> +#endif
> +
> +    return res;
>  }
> =20
>  static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_c=
onn)
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 2f8adb6b9f..f620750803 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1129,6 +1129,11 @@ static void qemu_spice_display_init_one(QemuConsol=
e
> *con)
> =20
>      ssd->qxl.base.sif =3D &dpy_interface.base;
>      qemu_spice_add_display_interface(&ssd->qxl, con);
> +
> +#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */

Surely OT: won't be better to have something like

#if SPICE_SERVER_VERSION >=3D SPICE_SERVER_VERSION_NUMBER(0,14,2)

> +    spice_qxl_monitor_set_device_display_id(&ssd->qxl, 0,
> qemu_console_get_head(con));
> +#endif
> +
>      qemu_spice_create_host_memslot(ssd);
> =20
>      register_displaychangelistener(&ssd->dcl);

Frediano
