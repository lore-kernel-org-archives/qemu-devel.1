Received: from eggs.gnu.org ([2001:4830:134:3::10]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5MR-0001up-Fz
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5MN-0000Vi-IO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS5MN-0000Uu-8E
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:42:07 -0400
Date: Mon, 3 Jul 2017 20:41:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703204129-mutt-send-email-mst@kernel.org>
References: <cover.1498542538.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1498542538.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/9]  Convert to realize and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com, dmitry@daynix.com, jasowang@redhat.com, kraxel@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Tue, Jun 27, 2017 at 02:16:46PM +0800, Mao Zhongyi wrote:
> This series mainly implements the conversions of pci-bridge devices
> i82801b11, io3130_upstream/downstream and so on to realize(). Naturally
> part of error messages need to be converted to Error, then propagate
> to its callers via the argument errp, bonus clean related minor flaw
> up. In short, the former patches are prerequisites for latter ones.


Applied, thanks!

Please remember to Cc maintainers on all patches, this was
missing on patch 3.

> v7:
> * patch7: -drop the !local_err assert is really not appropriate,
>            now revert it.    [Marcel Apfelbaum] 
> 
> v6:
> * patch3: -rename the subject.
> * patch6: -simplify the commit message.
>           -use error_append_hint replace original error_setg rather
>            than remove it directly. [Marcel Apfelbaum]
>           -report the error message from local_err. [Marcel Apfelbaum]
> v5:
> * patch5: replace pci_add_capability2() with pci_add_capability(), because
>           it's confusing to have a function named pci_add_capability2() if
>           pci_add_capability() doesn't exist anymore. [Eduardo Habkost]
> * patch8: a new patch that fix the return type of verify_irqchip_kernel().
> * patch9: a new patch that use the errp directly instead of the local_err to
>           propagate the error messages.
> 
> v4:
> * patch4: changed from patch 5 in v3. use a elegant way to check
>           the error, like
> 
>           function(...);
>           if (function succeeded) {
>              /* non-error code path here */
>              foo = bar;
>           }
> 
>           or
> 
>           function(...);
>           if (function succeeded) {
>               /* non-error code path here */
>               foo = bar;
>           } else {
>               /* error path here */
>               return ret;
>           }
> 
>           for readability, instead of this:
> 
>           function(...)
>           if (function failed) {
>               return ...;  /* or: "goto out" */
>           }
> 
>           /* non-error code path here */
>           foo = bar;             [Eduardo Habkost]
> 
>           meanwhile, split previous patch4 out. [Michael S. Tsirkin]
> * patch5: a new patch that replace pci_add_capability() with
>           pci_add_capability2(). [Eduardo Habkost]
> 
> v3:
> * patch2: explain the specified means of the return value, also
>           improve the commit message. [Marcel Apfelbaum]
> * patch3: simplify the subject and commit message, fix another
>           wrong assert. [Marcel Apfelbaum]
> * patch4: adjust the subject.
> * patch5: fix a wrong optimization for errp. [Eduardo Habkost]
> * patch7: a new patch that converts shpc_init() to Error in order
>           to propagate the error better.                                       
> v2:
> * patch1: subject and commit message was rewrited by markus.
> * patch2: comment was added to pci_add_capability2().
> * patch3: a new patch that fix the wrong return value judgment condition.
> * patch4: a new patch that fix code style problems.
> * patch5: add an errp argument for pci_add_capability to pass
>           error for its callers.
> * patch6: convert part of pci-bridge device to realize.
> 
> v1:
> * patch1: fix unreasonable return value check
> 
> Cc: mst@redhat.com
> Cc: marcel@redhat.com
> Cc: armbru@redhat.com
> Cc: dmitry@daynix.com
> Cc: jasowang@redhat.com
> Cc: kraxel@redhat.com
> Cc: alex.williamson@redhat.com
> Cc: pbonzini@redhat.com
> Cc: rth@twiddle.net
> Cc: ehabkost@redhat.com
> 
> Mao Zhongyi (9):
>   pci: Clean up error checking in pci_add_capability()
>   pci: Add comment for pci_add_capability2()
>   pci: Fix the wrong assertion.
>   pci: Make errp the last parameter of pci_add_capability()
>   pci: Replace pci_add_capability2() with pci_add_capability()
>   pci: Convert to realize
>   pci: Convert shpc_init() to Error
>   i386/kvm/pci-assign: Fix return type of verify_irqchip_kernel()
>   i386/kvm/pci-assign: Use errp directly rather than local_err
> 
>  hw/i386/amd_iommu.c                | 24 ++++++++++++-----
>  hw/i386/kvm/pci-assign.c           | 54 ++++++++++++++------------------------
>  hw/ide/ich.c                       |  2 +-
>  hw/net/e1000e.c                    | 30 ++++++++++++---------
>  hw/net/eepro100.c                  | 18 ++++++++++---
>  hw/pci-bridge/i82801b11.c          | 12 ++++-----
>  hw/pci-bridge/pci_bridge_dev.c     | 14 +++++-----
>  hw/pci-bridge/pcie_root_port.c     | 18 ++++++-------
>  hw/pci-bridge/xio3130_downstream.c | 20 +++++++-------
>  hw/pci-bridge/xio3130_upstream.c   | 20 +++++++-------
>  hw/pci/msi.c                       |  2 +-
>  hw/pci/msix.c                      |  2 +-
>  hw/pci/pci.c                       | 24 +++--------------
>  hw/pci/pci_bridge.c                |  8 ++++--
>  hw/pci/pcie.c                      | 28 +++++++++++++++-----
>  hw/pci/shpc.c                      | 10 ++++---
>  hw/pci/slotid_cap.c                | 12 ++++++---
>  hw/usb/hcd-xhci.c                  |  2 +-
>  hw/vfio/pci.c                      | 15 ++++++-----
>  hw/virtio/virtio-pci.c             | 12 ++++++---
>  include/hw/pci/pci.h               |  2 --
>  include/hw/pci/pci_bridge.h        |  3 ++-
>  include/hw/pci/pcie.h              |  3 ++-
>  include/hw/pci/shpc.h              |  3 ++-
>  include/hw/pci/slotid_cap.h        |  3 ++-
>  25 files changed, 183 insertions(+), 158 deletions(-)
> 
> -- 
> 2.9.4
> 
> 
