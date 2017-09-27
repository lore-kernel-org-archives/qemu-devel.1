Received: from eggs.gnu.org ([2001:4830:134:3::10]:40480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx6MB-0002dH-Kb
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx6M7-0000Pg-OZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:02:07 -0400
Date: Wed, 27 Sep 2017 15:01:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170927070133.GB25011@pxdev.xzpeter.org>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
	<AM5PR0401MB25458FFED2D7D405A71F954C9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM5PR0401MB25458FFED2D7D405A71F954C9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>

On Wed, Sep 27, 2017 at 06:46:18AM +0000, Bharat Bhushan wrote:
> Hi Peter,

Hi, Bharat!

> 
> While vfio with virtio-iommu I observed one issue,  When virtio-iommu device exists but guest kernel does not have virtio-iommu driver (not enabled in Config) then IOMMU faults are reported on host.
> 
> This is because no mapping is created in IOMMU, not even default
guest-physical to real-physical. While looking at vfio_listener_region_add(), it does not create initial mapping in IOMMU and relies on guest to create mapping. Is this something known or I am missing something?

For VT-d, the trick is played using dynamic IOMMU memory region.
Please refer to commit 558e0024a428 ("intel_iommu: allow dynamic
switch of IOMMU region") for more information.

The whole idea is that, the IOMMU region will not be enabled only if
the guest enables that explicitly for the device.  Otherwise (for your
case, when guest driver is not loaded at all), the IOMMU region is by
default off, then the default GPA region will be used to build up the
mapping (just like when we don't have vIOMMU at all).  Thanks,

-- 
Peter Xu
