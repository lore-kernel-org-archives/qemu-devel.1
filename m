Received: from eggs.gnu.org ([2001:4830:134:3::10]:54573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1drUED-0001gx-HH
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1drUEA-0006Wr-TB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1drUEA-0006US-NO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:18:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89738C01C108
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:18:36 +0000 (UTC)
Date: Mon, 11 Sep 2017 13:18:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170911131831.11fe32a0@t450s.home>
In-Reply-To: <1505156192-18994-1-git-send-email-wexu@redhat.com>
References: <1505156192-18994-1-git-send-email-wexu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Patch 0/3] vfio: reusing address space for the
 same iommu group devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, marcel@redhat.com, Peter Xu <peterx@redhat.com>

On Tue, 12 Sep 2017 02:56:29 +0800
wexu@redhat.com wrote:

> From: Wei Xu <wexu@redhat.com>
> 
> Recently I have been testing passing through 2 ixgbe(82599ES) nics which
> belong to the same iommu group to a guest with virtual iommu(vIOMMU) on
> my desktop, while vfio failed to realize the second device and prompted
> error message as 'group xxx used in multiple address spaces'.
> 
> It turned out to be that vtd doesn't know any group info while choosing
> an address space for the two devices, therefore it creates two separate
> address space for each which breaks granularity isolation.
> 
> This patch fixes this by looking up if there is any exist device within
> the same iommu group and shares the address space before creating a new
> one.
> 
> I am not sure if this fixes the problem in a correct way due to my limited
> knowledge about vfio, please come back to me for any feedback & comments,
> Thanks.

Hi Wei,

Are the devices in the same IOMMU group on the host or guest or both?
My impression is that host IOMMU groups with more than a single
endpoint are fundamentally incompatible with vIOMMU.  Even if we could
enforce a VM topology which logically should place them into the same
IOMMU group, IOMMU groups themselves are a Linux concept and another
guest OS could rightfully attempt to use them in separate VT-d contexts.
The only way we could ensure a shared context is if they were in a
conventional PCI hierarchy within the VM.  I'd suggest that vIOMMU
should be reserved for hosts and devices which have full isolation and
for which the VM and guest can create separate mappings per device.

I'm not sure if what I describe is the actual problem you're facing as I
thought we had quirks to expose the per-port isolation on 82599
devices, but perhaps the lack of isolation is coming from an upstream
device.  If I'm off, please provide further details of exactly the host
and guest scenarios.  Thanks,

Alex

> Wei Xu (3):
>   vfio: reusing address space for the same iommu group devices
>   vfio: invoke looking up address space.
>   vfio: remove checking duplicated vfio device
> 
>  hw/vfio/common.c              | 28 ++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 | 15 ++++++---------
>  include/hw/vfio/vfio-common.h |  1 +
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
