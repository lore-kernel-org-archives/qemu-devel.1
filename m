Received: from eggs.gnu.org ([2001:4830:134:3::10]:60249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dlHvs-0004br-Io
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dlHvo-00060o-NX
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dlHvo-0005xs-H2
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:58:04 -0400
Date: Fri, 25 Aug 2017 19:57:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170825195746-mutt-send-email-mst@kernel.org>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-10-git-send-email-mst@redhat.com>
	<20170825151742.GJ27715@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825151742.GJ27715@localhost.localdomain>
Subject: Re: [Qemu-devel] [PULL 09/21] pci: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, armbru@redhat.com

On Fri, Aug 25, 2017 at 12:17:42PM -0300, Eduardo Habkost wrote:
> On Mon, Jul 03, 2017 at 10:45:16PM +0300, Michael S. Tsirkin wrote:
> > From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> > 
> > Convert i82801b11, io3130_upstream, io3130_downstream and
> > pcie_root_port devices to realize.
> > 
> > Cc: mst@redhat.com
> > Cc: marcel@redhat.com
> > Cc: armbru@redhat.com
> > Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> [...]
> > diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> > index cfe8a36..e706f36 100644
> > --- a/hw/pci-bridge/xio3130_downstream.c
> > +++ b/hw/pci-bridge/xio3130_downstream.c
> > @@ -56,33 +56,33 @@ static void xio3130_downstream_reset(DeviceState *qdev)
> >      pci_bridge_reset(qdev);
> >  }
> >  
> > -static int xio3130_downstream_initfn(PCIDevice *d)
> > +static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
> >  {
> [...]
> >      pcie_chassis_create(s->chassis);
> >      rc = pcie_chassis_add_slot(s);
> >      if (rc < 0) {
> >          goto err_pcie_cap;
> 
> Missing error_setg() call here.  If pcie_chassis_add_slot() fails, realize
> won't report an error properly.  Causes crash with:
> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -device ioh3420 -device xio3130-downstream
> qemu-system-x86_64: /home/ehabkost/rh/proj/virt/qemu/memory.c:2166: memory_region_del_subregion: Assertion `subregion->container == mr' failed.
> Aborted (core dumped)
> 
> 
> >      }
> >  
> >      rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
> > -                       PCI_ERR_SIZEOF, &err);
> > +                       PCI_ERR_SIZEOF, errp);
> >      if (rc < 0) {
> > -        error_report_err(err);
> >          goto err;
> >      }
> >  
> > -    return 0;
> > +    return;
> >  
> >  err:
> >      pcie_chassis_del_slot(s);
> > @@ -114,7 +113,6 @@ err_msi:
> >      msi_uninit(d);
> >  err_bridge:
> >      pci_bridge_exitfn(d);
> > -    return rc;
> >  }
> >  
> [...]

Good catch!  Patch?

> -- 
> Eduardo
