Received: from eggs.gnu.org ([2001:4830:134:3::10]:41811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkRU-0004xl-BN
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkRR-0008QY-3W
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:46:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLkRQ-0008H4-Q9
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 02:45:57 -0500
Date: Sun, 11 Nov 2018 09:45:42 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111074541.GB2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-14-yuval.shaia@oracle.com>
	<ee9f5ed6-f68b-eb45-2d2a-357ff1c47cf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9f5ed6-f68b-eb45-2d2a-357ff1c47cf0@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/22] hw/pvrdma: Make sure PCI function
 0 is vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, yuval.shaia@oracle.com

On Sat, Nov 10, 2018 at 08:27:44PM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 11/8/18 6:08 PM, Yuval Shaia wrote:
> > Guest driver enforces it, we should also.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/vmw/pvrdma.h      | 2 ++
> >   hw/rdma/vmw/pvrdma_main.c | 3 +++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> > index b019cb843a..10a3c4fb7c 100644
> > --- a/hw/rdma/vmw/pvrdma.h
> > +++ b/hw/rdma/vmw/pvrdma.h
> > @@ -20,6 +20,7 @@
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/msix.h"
> >   #include "chardev/char-fe.h"
> > +#include "hw/net/vmxnet3_defs.h"
> >   #include "../rdma_backend_defs.h"
> >   #include "../rdma_rm_defs.h"
> > @@ -85,6 +86,7 @@ typedef struct PVRDMADev {
> >       RdmaBackendDev backend_dev;
> >       RdmaDeviceResources rdma_dev_res;
> >       CharBackend mad_chr;
> > +    VMXNET3State *func0;
> >   } PVRDMADev;
> >   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index ac8c092db0..fa6468d221 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -576,6 +576,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >           return;
> >       }
> > +    /* Break if not vmxnet3 device in slot 0 */
> > +    dev->func0 = VMXNET3(pci_get_function_0(pdev));
> > +
> 
> I don't see the error code flow in case VMXNET3 is not func 0.
> Am I missing something?

Yes, this is a dynamic cast that will break the process when fail to cast.

This is the error message that you will get in case that device on function
0 is not vmxnet3:

pvrdma_main.c:589:pvrdma_realize: Object 0x557b959841a0 is not an instance of type vmxnet3

> 
> 
> Thanks,
> Marcel
> 
> >       memdev_root = object_resolve_path("/objects", NULL);
> >       if (memdev_root) {
> >           object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);
> 
