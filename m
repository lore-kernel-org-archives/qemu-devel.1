Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ2I-0008Dl-MP
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ2H-0006XU-H4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:22:10 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f365f305-175c-db54-677d-6f66719b24cd@redhat.com>
Date: Mon, 28 May 2018 16:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/6] hw/arm: Add support for
 non-contiguous iova regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com

Hi Shameer,

On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
> When the kernel reports valid iova ranges as non-contiguous,
> memory should be allocated to Guest in such a way that
> reserved regions(holes) are not visible by Guest.
> 
> This series retrieves the valid iova ranges based on the new
> proposed VFIO interface for kernel [1]. It then populates the
> first 1GB ram as a non-pluggable dimm and rest as a pc-dimm if
> the valid iova ranges are non-contiguous.

Some general comments:

- what are your plans with respect to VFIO device hot-plug handling?
IIUC, at the moment, any collision between reserved regions induces by
hot-plugged devices are not detected/handled. I understand mem hotplug
is not supported on aarch64. Would you simply reject the vfio device
hotplug.

- IIUC any reserved window colliding with [4000000, 1GB] cold-plug RAM
segment is show-stopper. How was this 1GB size chosen exactly?

- Currently you create a single PC-DIMM node whereas several ones may be
possible & necessary? Do you plan to support multiple PC-DIMMS node?

- I have started looking at RAM extension on machvirt. I think adding
support of PC-DIMMS through the qemu cmd line is something that we need
to work on, in paralell.

Thanks

Eric
> 
> Patch #3 of this series is loosely based on an earlier attempt
> by Kwangwoo Lee to add hotplug/pc-dimm support to arm64[2]
> 
> RFC v1[3] --> RFCv2
>  -Based on new VFIO kernel interface
>  -Part of Mem modelled as pc-dimm 
>  -Rebased to qemu 2.12.0
> 
> [1] https://lkml.org/lkml/2018/4/18/293
> [2] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04600.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02412.html
> 
> Shameer Kolothum (6):
>   hw/vfio: Retrieve valid iova ranges from kernel
>   hw/arm/virt: Enable dynamic generation of guest RAM memory regions
>   hw/arm/virt: Add pc-dimm mem hotplug framework
>   hw/arm: Changes required to accommodate non-contiguous DT mem nodes
>   hw/arm: ACPI SRAT changes to accommodate non-contiguous mem
>   hw/arm: Populate non-contiguous memory regions
> 
>  default-configs/aarch64-softmmu.mak |   1 +
>  hw/arm/boot.c                       |  91 ++++++---
>  hw/arm/virt-acpi-build.c            |  24 ++-
>  hw/arm/virt.c                       | 367 +++++++++++++++++++++++++++++++++++-
>  hw/vfio/common.c                    | 108 ++++++++++-
>  include/hw/arm/arm.h                |  12 ++
>  include/hw/arm/virt.h               |   3 +
>  include/hw/vfio/vfio-common.h       |   7 +
>  linux-headers/linux/vfio.h          |  23 +++
>  9 files changed, 589 insertions(+), 47 deletions(-)
> 
