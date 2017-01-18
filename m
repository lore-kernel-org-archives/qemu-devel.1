Received: from eggs.gnu.org ([2001:4830:134:3::10]:37683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTy0u-0006hP-Eq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTy0p-0005yx-Jn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cTy0p-0005y5-BQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:43:23 -0500
Date: Wed, 18 Jan 2017 14:43:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170118144321.38c984bf@t450s.home>
In-Reply-To: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 0/4] vfio-pci: pass non-fatal error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com

On Sat, 31 Dec 2016 17:13:04 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> As previous discussion suggest, we could take a step back to handle non-fatal
> error first, this will make this patchset much more thinner, because we could
> drop all the configuration restriction related patches.
> 
> FYI: patch 1 has been cherry picked into another series, and wait to be merged
> first, so this patchset can't compile in your host.
> 
> v11 changelog:
> 1. drop a bunch of code which check the configuration.
> 2. modify patch 3 to handle non-fatal error only, fatal error still
>    results in vm stop.
>    Doesn't modify as suggestion "add another eventfd do distinguish fatal &
>    non-fatal error", because 1st, user has the ability to distinguish them
>    just from the uncorrectable error status; 2nd, for back compatible, e.g.
>    an old user handle both error, rely on the current error eventfd.
> 
> Test:
> Test it with intel 82576 NIC, which has 2 functions, function 1 has cable
> connected to gateway, function 0 has no link. Test in 4 scenario.
> 1. just assign function 1 to one vm, function 0 has no user
> 2. assign 2 function to one vm, totally comply previous configuraton restrction
> 3. assign 2 function to one vm, under different virtual bus
> 4, assign functions to 2 different vm
> 
> The test steps are the same as v10: assign ip to function 1, add route info,
> and ping the gateway. The results meet expectation. But the unsteady hardware
> often emit fatal error, still don't know why. And igb driver in guest seems
> has bug: ping gateway for a while, even if I don't do anything, it will show
> "Destination Host Unreachable" after many successful ping. But obviously,
> neither of these has relationship with this patchset.

So something doesn't work right regardless and this doesn't describe
what testing was done of the functionality added here.  Were AER events
injected?  Did fatal ones cause a vmstop, did non-fatal ones continue?
How can you know if he other function was affected if you don't even
have a cable connected?  How is testing on something that doesn't seem
to work correctly already valid?  Thanks,

Alex

> Chen Fan (3):
>   vfio: new function to init aer cap for vfio device
>   vfio-pci: pass the aer error to guest
>   vfio: add 'aer' property to expose aercap
> 
> Dou Liyang (1):
>   pcie_aer: support configurable AER capa version
> 
>  hw/net/e1000e.c                    |   3 +-
>  hw/pci-bridge/ioh3420.c            |   2 +-
>  hw/pci-bridge/xio3130_downstream.c |   2 +-
>  hw/pci-bridge/xio3130_upstream.c   |   2 +-
>  hw/pci/pcie_aer.c                  |   5 +-
>  hw/vfio/pci.c                      | 139 +++++++++++++++++++++++++++++++++----
>  hw/vfio/pci.h                      |   3 +
>  include/hw/pci/pcie_aer.h          |   3 +-
>  8 files changed, 139 insertions(+), 20 deletions(-)
> 
