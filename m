Received: from eggs.gnu.org ([2001:4830:134:3::10]:33335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUVEf-0002dl-H0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUVEa-0001rn-Cl
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUVEa-0001rY-6q
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:11:48 -0500
Date: Fri, 20 Jan 2017 17:11:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170120091143.GK4914@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
	<20170120085457.GI4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C150AD@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C150AD@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

On Fri, Jan 20, 2017 at 08:59:01AM +0000, Tian, Kevin wrote:

[...]

> > > Also for hot-add
> > > device path, some check of caching mode is required. If not set,
> > > should we fail hot-add operation? I don't think we have such physical
> > > platform with some devices behind IOMMU while others not.
> > 
> > Could you explain in what case will we fail a hot plug?
> > 
> 
> user enables intel-iommu, but don't set caching mode.
> 
> Then later user hot-add a PCI device to the VM. Guest will assume
> newly assigned device also behind the default vIOMMU, and thus
> needs to setup IOVA mappings, which is then broken...

Is the newly added device a vfio-pci device? If so, we should hit
this and VM will stops to work:

    if (!s->cache_mode_enabled && new & IOMMU_NOTIFIER_MAP) {
        error_report("We need to set cache_mode=1 for intel-iommu to enable "
                     "device assignment with IOMMU protection.");
        exit(1);
    }

I admit this is not user-friendly, and a better way may be that we
disallow the hot-plug in that case, telling the user about the error,
rather than crashing the VM. But, I think that can be a patch outside
this series, considering (again) that this only affects advanced
users.

Thanks,

-- peterx
