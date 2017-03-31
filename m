Received: from eggs.gnu.org ([2001:4830:134:3::10]:54796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cu2Yg-0004O2-4d
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cu2Yc-0000JX-SU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cu2Yc-0000IU-K6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:50:02 -0400
Date: Fri, 31 Mar 2017 15:49:55 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <537494730.10012113.1490989795569.JavaMail.zimbra@redhat.com>
In-Reply-To: <ad2e87d5-f8bc-7abf-a376-bc6972c03fd5@redhat.com>
References: <20170331044711.21749-1-aik@ozlabs.ru>
	<ad2e87d5-f8bc-7abf-a376-bc6972c03fd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Only unmap
 bus_master_enabled_region if was added previously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

> On 03/31/2017 12:47 AM, Alexey Kardashevskiy wrote:
> > Normally pci_init_bus_master() would be called either via
> > bus->machine_done.notify or directly from do_pci_register_device().
> > 
> > However if a device's realize() failed, pci_init_bus_master() is not
> > called, and do_pci_unregister_device() fails on
> > memory_region_del_subregion() as it was not mapped.
> > 
> > This adds a check that subregion was mapped before unmapping it.
> > 
> > Fixes: c53598ed18e4 ("pci: Add missing drop of bus master AS reference")
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > This is to pass iotest 051 which does run QEMU like this:
> > 
> > ppc64-softmmu/qemu-system-ppc64 -nodefaults -machine accel=qtest -nographic
> > -monitor stdio -serial none -drive if=virtio
> > 
> > which normally fails with:
> > 
> > qemu-system-ppc64: -drive if=virtio: Device needs media, but drive is empty
> > 
> > or asserts (without this patch):
> > 
> > qemu-system-ppc64: /home/aik/p/qemu-kvm/memory.c:2118:
> > memory_region_del_subregion: Assertion `subregion->container == mr'
> > failed.
> > ---
> >  hw/pci/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index bd8043c460..259483b1c0 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -869,8 +869,10 @@ static void do_pci_unregister_device(PCIDevice
> > *pci_dev)
> >      pci_dev->bus->devices[pci_dev->devfn] = NULL;
> >      pci_config_free(pci_dev);
> >  
> > -    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> > -                                &pci_dev->bus_master_enable_region);
> > +    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {
> > +        memory_region_del_subregion(&pci_dev->bus_master_container_region,
> > +                                    &pci_dev->bus_master_enable_region);
> > +    }
> >      address_space_destroy(&pci_dev->bus_master_as);
> >  }
> >  
> > 
> 
> Thanks for the quick turnaround!
> 
> Tested-by: John Snow <jsnow@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
