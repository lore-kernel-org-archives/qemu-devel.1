Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eEdRP-0006Ll-3C
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eEdRM-0001BQ-18
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:47:59 -0500
Date: Tue, 14 Nov 2017 08:47:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171114084735.68e87546@t450s.home>
In-Reply-To: <1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
 reserved_region of device iommu group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhuyijun@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

On Tue, 14 Nov 2017 09:15:50 +0800
<zhuyijun@huawei.com> wrote:

> From: Zhu Yijun <zhuyijun@huawei.com>
> 
> With kernel 4.11, iommu/smmu will populate the MSI IOVA reserved window and
> PCI reserved window which has to be excluded from Guest iova allocations.
> 
> However, If it falls within the Qemu default virtual memory address space,
> then reserved regions may get allocated for a Guest VF DMA iova and it will
> fail.
> 
> So get those reserved regions in this patch and create some holes in the Qemu
> ram address in next patchset.
> 
> Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> ---
>  hw/vfio/common.c              | 67 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |  2 ++
>  hw/vfio/platform.c            |  2 ++
>  include/exec/memory.h         |  7 +++++
>  include/hw/vfio/vfio-common.h |  3 ++
>  5 files changed, 81 insertions(+)

I generally prefer the vfio interface to be more self sufficient, if
there are regions the IOMMU cannot map, we should be describing those
via capabilities on the container through the vfio interface.  If we're
just scraping together things from sysfs, the user can just as easily
do that and provide an explicit memory map for the VM taking the
devices into account.  Of course having a device associated with a
restricted memory map that conflicts with the default memory map for
the VM implies that you can never support hot-add of such devices.
Please cc me on vfio related patches.  Thanks,

Alex
