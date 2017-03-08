Received: from eggs.gnu.org ([2001:4830:134:3::10]:58396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clX4o-0000XE-68
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clX4k-0000Gl-7p
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:36:06 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:51114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clX4j-0000GW-Ur
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:36:02 -0500
Date: Wed, 8 Mar 2017 03:35:50 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
In-Reply-To: <213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
	<213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, yi l liu <yi.l.liu@intel.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>



----- Original Message -----
> From: "Marcel Apfelbaum" <marcel@redhat.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>
> Cc: qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>, "yi l liu" <yi.l.liu@intel.com>, "Jintack Lim"
> <jintack@cs.columbia.edu>, "Jason Wang" <jasowang@redhat.com>, "Alex Williamson" <alex.williamson@redhat.com>
> Sent: Thursday, March 2, 2017 7:24:44 AM
> Subject: Re: [PATCH v3] intel_iommu: check misordered init when realize
> 
> On 03/02/2017 07:13 AM, Michael S. Tsirkin wrote:
> > On Thu, Mar 02, 2017 at 11:32:18AM +0800, Peter Xu wrote:
> >> Intel vIOMMU devices are created with "-device" parameter, while here
> >> actually we need to make sure the dmar device be created before other
> >> PCI devices (like vfio-pci, virtio-pci ones) so that we know iommu_fn
> >> will be setup correctly before realizations of those PCI devices (it is
> >> legal that PCI device fetch these info during its realization). Now this
> >> ordering yet cannot be achieved elsewhere, and devices will be created
> >> in the order that user specified. We need to avoid that.
> >>
> >> This patch tries to detect this kind of misordering issue during init of
> >> VT-d device, then report to guest if misordering happened. In the
> >> future, we can provide something better to solve it, e.g., to support
> >> device init ordering, then we can live without this patch.
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > Unfortunately with virtio it's a regression, as it used to
> > work with iommu. So I'm afraid we need to look into supporting
> > arbitrary order right now :(
> >
> 
> Hi,
> 
> A fast way to do it is to initialize iommu with a new keyword, like
>      -iommu intel-iommu
> Or maybe use the existing "-object" somehow ?
>  From vl.c comments:
>    "Initial object creation happens before all other
>     QEMU data types are created.... "
> 
> Another idea is to add a third run on QEMU cmd line arguments,
> but this would affect the whole system.
> 
> However having an ordering system beats all other ideas.

The ordering should be explicit in the command line.  Since we do not have
cycles, it should be possible.

The best solution would have been to add something like

   -device intel-iommu,id=root-complex-iommu -global mch.iommu=root-complex-iommu

but it's too late for that.

Paolo
