Received: from eggs.gnu.org ([2001:4830:134:3::10]:51732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fCgbn-0005Xo-3H
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 03:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fCgbj-0007br-U5
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 03:18:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fCgbj-0007bD-JM
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 03:18:51 -0400
Date: Sun, 29 Apr 2018 10:18:38 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180429071837.GB2597@yuvallap>
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-10-marcel@redhat.com>
	<CAFEAcA8yh0hhbhqBM3-iBXWHB72qx--FmnwFdQiPt9Fx13Fzmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yh0hhbhqBM3-iBXWHB72qx--FmnwFdQiPt9Fx13Fzmg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH PULL v2 09/10] hw/rdma: Implementation of
 PVRDMA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com

On Fri, Apr 27, 2018 at 03:55:16PM +0100, Peter Maydell wrote:
> On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
> > From: Yuval Shaia <yuval.shaia@oracle.com>
> >
> > PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> > It works with its Linux Kernel driver AS IS, no need for any special
> > guest modifications.
> >
> > While it complies with the VMware device, it can also communicate with
> > bare metal RDMA-enabled machines and does not require an RDMA HCA in the
> > host, it can work with Soft-RoCE (rxe).
> >
> > It does not require the whole guest RAM to be pinned allowing memory
> > over-commit and, even if not implemented yet, migration support will be
> > possible with some HW assistance.
> >
> > Implementation is divided into 2 components, rdma general and pvRDMA
> > specific functions and structures.
> >
> > The second PVRDMA sub-module - interaction with PCI layer.
> > - Device configuration and setup (MSIX, BARs etc).
> > - Setup of DSR (Device Shared Resources)
> > - Setup of device ring.
> > - Device management.
> >
> > Reviewed-by: Dotan Barak <dotanb@mellanox.com>
> > Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> 
> > +static void free_ports(PVRDMADev *dev)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < MAX_PORTS; i++) {
> > +        g_free(dev->rdma_dev_res.ports[i].gid_tbl);
> 
> Coverity (CID 1390628) points out that this is attempting to
> call free on an array, which is not valid...
> 
> > +    }
> > +}
> > +
> > +static void init_ports(PVRDMADev *dev, Error **errp)
> > +{
> > +    int i;
> > +
> > +    memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
> > +
> > +    for (i = 0; i < MAX_PORTS; i++) {
> > +        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
> > +
> > +        dev->rdma_dev_res.ports[i].pkey_tbl =
> > +            g_malloc0(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
> > +                      MAX_PORT_PKEYS);
> 
> ...init_ports() is allocated memory into ports[i].pkey_tbl,
> so maybe this is what free_ports() is intended to be freeing ?

Thanks!
Since pkey_tbl is currently not supported i will remove it completely
(along with the unneeded-anymore free_ports function).

Yuval

> 
> > +    }
> > +}
> 
> thanks
> -- PMM
