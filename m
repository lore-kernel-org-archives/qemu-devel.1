Received: from eggs.gnu.org ([2001:4830:134:3::10]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJyy-0006RM-IF
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJyx-0002IO-Eh
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:43:52 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZJyx-0002I5-5e
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:43:51 -0400
Received: by mail-pg0-x241.google.com with SMTP id z1so9643163pgs.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:43:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170723054445-mutt-send-email-mst@kernel.org>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-5-git-send-email-zuban32s@gmail.com>
	<20170723054445-mutt-send-email-mst@kernel.org>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 19:43:49 +0300
Message-ID: <CAKSfGUAHPHwgLa=jNUGpW-saHK6rGK5epBY2ixizeuCwvE77wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] pci: enable RedHat PCI bridges
 to reserve additional buses on PCI init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: seabios@seabios.org, Marcel Apfelbaum <marcel@redhat.com>, kraxel@redhat.com, Kevin OConnor <kevin@koconnor.net>, lersek@redhat.com, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

2017-07-23 5:49 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:

> On Sun, Jul 23, 2017 at 01:11:50AM +0300, Aleksandr Bezzubikov wrote:
> > In case of Red Hat PCI bridges reserve additional buses, which number is
> provided
> > in a vendor-specific capability.
> >
> > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> > ---
> >  src/fw/pciinit.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> > index 864954f..f05a8b9 100644
> > --- a/src/fw/pciinit.c
> > +++ b/src/fw/pciinit.c
> > @@ -15,6 +15,7 @@
> >  #include "hw/pcidevice.h" // pci_probe_devices
> >  #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
> >  #include "hw/pci_regs.h" // PCI_COMMAND
> > +#include "hw/pci_cap.h" // qemu_pci_cap
> >  #include "list.h" // struct hlist_node
> >  #include "malloc.h" // free
> >  #include "output.h" // dprintf
> > @@ -578,9 +579,18 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
> >          pci_bios_init_bus_rec(secbus, pci_bus);
> >
> >          if (subbus != *pci_bus) {
> > +            u8 res_bus = 0;
> > +            if (pci_config_readw(bdf, PCI_VENDOR_ID) ==
> PCI_VENDOR_ID_REDHAT) {
>
> Check device ID as well.

Not sure what ID/IDs we want to see here exactly. Now it can be
only pcie-root-port (0xC then), but


>
> > +                u8 cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
>
> There could be multiple vendor capabilities. You want to scan them all.
>
>
> > +                if (cap) {
> > +                    res_bus = pci_config_readb(bdf,
> > +                            cap + offsetof(struct redhat_pci_bridge_cap,
> > +                                           bus_res));
>
>
> You might want to add sanity checks e.g. overflow, and capability
> length.
>
> Also, if all you use is offsetof, don't bother with a struct, just
> add some defines.
>
OK, will move this to defines.


>
> > +                }
> > +            }
> >              dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
> > -                    subbus, *pci_bus);
> > -            subbus = *pci_bus;
> > +                    subbus, *pci_bus + res_bus);
> > +            subbus = *pci_bus + res_bus;
>
> So you take all present devices and add reserved ones - is that it?
> If so it looks like this will steal extra buses each time you
> add a child bus and reboot.
>

You're right, such problem persists. Will think on what can be done here.


>
>
> >          } else {
> >              dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
> >          }
> > --
> > 2.7.4
>



-- 
Alexander Bezzubikov
