Received: from eggs.gnu.org ([2001:4830:134:3::10]:50215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJUA-0007mn-Pi
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJU9-0002fd-Ov
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:12:02 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZJU9-0002fU-H4
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:12:01 -0400
Received: by mail-pf0-x241.google.com with SMTP id o88so8640278pfk.1
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:12:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170723054322-mutt-send-email-mst@kernel.org>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-4-git-send-email-zuban32s@gmail.com>
	<20170723054322-mutt-send-email-mst@kernel.org>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 19:12:00 +0300
Message-ID: <CAKSfGUAffh8WdR+HAZNi2YdshnsG0KLLTeAMWiLCxYeoSi3xeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] pci: add QEMU-specific PCI
 capability structure
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

2017-07-23 5:44 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:

> On Sun, Jul 23, 2017 at 01:11:49AM +0300, Aleksandr Bezzubikov wrote:
> > On PCI init PCI bridge devices may need some
> > extra info about bus number to reserve, IO, memory and
> > prefetchable memory limits. QEMU can provide this
> > with special vendor-specific PCI capability.
> >
> > This capability is intended to be used only
> > for Red Hat PCI bridges, i.e. QEMU cooperation.
> >
> > Sizes of limits match ones from
> > PCI Type 1 Configuration Space Header,
> > number of buses to reserve occupies only 1 byte
> > since it is the size of Subordinate Bus Number register.
> >
> > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> > ---
> >  src/hw/pci_cap.h | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 src/hw/pci_cap.h
> >
> > diff --git a/src/hw/pci_cap.h b/src/hw/pci_cap.h
> > new file mode 100644
> > index 0000000..1382b0b
> > --- /dev/null
> > +++ b/src/hw/pci_cap.h
> > @@ -0,0 +1,23 @@
> > +#ifndef _PCI_CAP_H
> > +#define _PCI_CAP_H
> > +
> > +#include "types.h"
> > +
> > +struct vendor_pci_cap {
> > +    u8 id;
> > +    u8 next;
> > +    u8 len;
> > +};
> > +
> > +struct redhat_pci_bridge_cap {
> > +    struct vendor_pci_cap hdr;
>
> Hi Michael,
Thanks for the quick reply.


> You want to add some kind of identifier here after
> the header, such that more capabilities can be added
> in future without breaking this one.
>

You mean to distinguish different vendor-specific capabilities?
Agreed if so, will add it in the next version.


>
> > +    u8 bus_res;
> > +    u32 pref_lim_upper;
> > +    u16 pref_lim;
> > +    u16 mem_lim;
> > +    u16 io_lim_upper;
> > +    u8 io_lim;
> > +    u8 padd;
>
> Please add documentation.
>
>
> > +};
> > +
> > +#endif /* _PCI_CAP_H */
> > --
> > 2.7.4
>



-- 
Alexander Bezzubikov
