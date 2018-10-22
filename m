Received: from eggs.gnu.org ([2001:4830:134:3::10]:53741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gEYlQ-0000d6-G8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gEYlH-0003yt-7b
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:52:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gEYlE-0003xR-Ky
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:52:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so44221614wrt.1
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 04:52:40 -0700 (PDT)
Message-ID: <1540209157.16655.244.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Mon, 22 Oct 2018 13:52:37 +0200
In-Reply-To: <1012699093.34889598.1539848292497.JavaMail.zimbra@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-3-lhrazky@redhat.com>
	<1012699093.34889598.1539848292497.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org, kraxel@redhat.com

On Thu, 2018-10-18 at 03:38 -0400, Frediano Ziglio wrote:
> > 
> > Calls new SPICE QXL interface functions to set:
> > 
> > * The hardware address of the graphics device represented by the QXL
> >   interface (e.g. a PCI path):
> >   spice_qxl_set_device_address(...)
> > 
> > * The device display IDs (the IDs of the device's monitors that belong
> >   to this QXL interface):
> >   spice_qxl_monitor_set_device_display_id(...)
> > 
> > Signed-off-by: Lukáš Hrázký <lhrazky@redhat.com>
> > ---
> >  hw/display/qxl.c   |  8 ++++++++
> >  ui/spice-core.c    | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> >  ui/spice-display.c |  5 +++++
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> > index f608abc769..63144f42b4 100644
> > --- a/hw/display/qxl.c
> > +++ b/hw/display/qxl.c
> > @@ -2184,6 +2184,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> > Error **errp)
> >                     SPICE_INTERFACE_QXL_MAJOR, SPICE_INTERFACE_QXL_MINOR);
> >          return;
> >      }
> > +
> > +#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
> > +    // register all possible device display IDs to SPICE server
> > +    for (int i = 0; i < qxl->max_outputs; ++i) {
> > +        spice_qxl_monitor_set_device_display_id(&qxl->ssd.qxl, i, i);
> > +    }
> > +#endif
> > +
> 
> I think would be better if this were the default in spice-server.

I don't know what you mean by this...

> >      qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
> >  
> >      qxl->update_irq = qemu_bh_new(qxl_update_irq_bh, qxl);
> > diff --git a/ui/spice-core.c b/ui/spice-core.c
> > index a4fbbc3898..2e01beea03 100644
> > --- a/ui/spice-core.c
> > +++ b/ui/spice-core.c
> > @@ -35,6 +35,8 @@
> >  #include "qemu/option.h"
> >  #include "migration/misc.h"
> >  #include "hw/hw.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/pci/pci_bus.h"
> >  #include "ui/spice-display.h"
> >  
> >  /* core bits */
> > @@ -871,6 +873,26 @@ bool qemu_spice_have_display_interface(QemuConsole *con)
> >      return false;
> >  }
> >  
> > +/*
> > + * Recursively (in reverse order) appends addresses of PCI devices as it
> > moves
> > + * up in the PCI hierarchy.
> > + *
> > + * @returns true on success, false when the buffer wasn't large enough
> > + */
> > +static bool append_pci_address_recursive(char *buf, size_t buf_size, const
> > PCIDevice *pci)
> 
> I won't use the "_recursive" in the name, looks like more an implementation
> detail.

Allright.

> > +{
> > +    PCIBus *bus = pci_get_bus(pci);
> > +    if (!pci_bus_is_root(bus)) {
> > +        append_pci_address_recursive(buf, buf_size, bus->parent_dev);
> > +    }
> > +
> > +    size_t len = strlen(buf);
> > +    size_t written = snprintf(buf + len, buf_size - len, "/%02x.%x",
> > +        PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn));
> > +
> > +    return written > 0 && written < buf_size - len;
> 
> written is always > 0, unless there's a bug in snprintf. Note that Qemu uses
> MingW snprintf on Windows so even on Windows this returns always > 0 (note
> that snprintf returns an int which is signed while size_t is unsigned and
> some implementation could return < 0, but not in Qemu).

Right. The man page says it returns negative values on errors. I've
missed the fact I'm storing the result in size_t. Do you think I should
drop the "written > 0" condition or change the type of "written" to
ssize_t for extra safety? :)

> > +}
> > +
> >  int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con)
> >  {
> >      if (g_slist_find(spice_consoles, con)) {
> > @@ -878,7 +900,28 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin,
> > QemuConsole *con)
> >      }
> >      qxlin->id = qemu_console_get_index(con);
> >      spice_consoles = g_slist_append(spice_consoles, con);
> > -    return qemu_spice_add_interface(&qxlin->base);
> > +    int res = qemu_spice_add_interface(&qxlin->base);
> > +
> > +#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
> > +    DeviceState *dev = DEVICE(object_property_get_link(OBJECT(con),
> > "device", &error_abort));
> > +    PCIDevice *pci = (PCIDevice *) object_dynamic_cast(OBJECT(dev),
> > TYPE_PCI_DEVICE);
> > +
> > +    if (pci == NULL) {
> > +        warn_report("Setting PCI path of a display device to SPICE: Not a
> > PCI device.");
> > +        return res;
> > +    }
> > +
> > +    char device_path[128] = "pci/0000";  // hardcoded PCI domain 0000
> > +    if (!append_pci_address_recursive(device_path, sizeof(device_path),
> > pci)) {
> > +        warn_report("Setting PCI path of a display device to SPICE: "
> > +            "Too many PCI devices in the chain.");
> > +        return res;
> > +    }
> > +
> > +    spice_qxl_set_device_address(qxlin, device_path);
> > +#endif
> > +
> > +    return res;
> >  }
> >  
> >  static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn)
> > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > index 2f8adb6b9f..f620750803 100644
> > --- a/ui/spice-display.c
> > +++ b/ui/spice-display.c
> > @@ -1129,6 +1129,11 @@ static void qemu_spice_display_init_one(QemuConsole
> > *con)
> >  
> >      ssd->qxl.base.sif = &dpy_interface.base;
> >      qemu_spice_add_display_interface(&ssd->qxl, con);
> > +
> > +#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
> 
> Surely OT: won't be better to have something like
> 
> #if SPICE_SERVER_VERSION >= SPICE_SERVER_VERSION_NUMBER(0,14,2)

It surely would be better :)

Cheers,
Lukas

> > +    spice_qxl_monitor_set_device_display_id(&ssd->qxl, 0,
> > qemu_console_get_head(con));
> > +#endif
> > +
> >      qemu_spice_create_host_memslot(ssd);
> >  
> >      register_displaychangelistener(&ssd->dcl);
> 
> Frediano
