Received: from eggs.gnu.org ([2001:4830:134:3::10]:36437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmOJg-0007pN-Br
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmOJc-0007s0-Ch
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dmOJc-0007rX-7F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:59:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1073F80B29
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 17:59:11 +0000 (UTC)
Date: Mon, 28 Aug 2017 14:59:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170828175901.GQ15315@localhost.localdomain>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-3-ehabkost@redhat.com>
	<20170825191858.GK27715@localhost.localdomain>
	<291e006c-0fac-caa8-041a-3b2991c7171e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291e006c-0fac-caa8-041a-3b2991c7171e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] pci: Add interface names to hybrid PCI
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Sun, Aug 27, 2017 at 11:33:46AM +0300, Marcel Apfelbaum wrote:
> Hi Eduardo,
> 
> On 25/08/2017 22:18, Eduardo Habkost wrote:
> > On Wed, Aug 23, 2017 at 07:14:42PM -0300, Eduardo Habkost wrote:
> > > The following devices support both PCIe and legacy PCI, by
> > > including special code to handle the QEMU_PCI_CAP_EXPRESS flag:
> > > 
> > > * vfio-pci (is_express=1, but legacy PCI handled by
> > >    vfio_populate_device())
> > > * vmxnet3 (is_express=0, but PCIe handled by vmxnet3_realize())
> > > * pvscsi (is_express=0, but PCIe handled by pvscsi_realize())
> > > * virtio-pci (is_express=0, but PCIe handled by
> > >    virtio_pci_dc_realize(), and additional legacy PCI code at
> > >    virtio_pci_realize())
> > 
> > Oh, the rules are even messier than that: QEMU_PCI_CAP_EXPRESS
> > controls _some_ of the code that makes a device become a PCI
> > Express device, but not every case.
> > 
> > In addition to vmxnet3, pvscsi and virtio-pci, PCIe caps
> > initialization is conditional on hcd-xhci (see below).
> > 
> > This means xhci is also a hybrid device.  But it doesn't seem to
> > clear QEMU_PCI_CAP_EXPRESS.  Doesn't it mean pci_config_size() is
> > broken if xhci is plugged to a legacy PCI bus?  How does it
> > affect migration?
> > 
> 
> If this is the case we reserve more config space than needed.
> Other than wasted space it should be OK, including migration.

Yeah, it looks harmless, except that we need to take the
migration format into account if refactoring that code.

-- 
Eduardo
