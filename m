Received: from eggs.gnu.org ([2001:4830:134:3::10]:49883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e47cW-0001Ua-Ft
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e47cT-0007mF-DV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1e47cT-0007lK-6O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:47:57 -0400
Date: Mon, 16 Oct 2017 09:47:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171016094754.0ba814c1@t450s.home>
In-Reply-To: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com

On Mon, 16 Oct 2017 16:56:21 +0800
Yang Zhong <yang.zhong@intel.com> wrote:

> Qemu does not need pin NVDIMM memory for VFIO device during VFIO
> hotplug, what's more, if there is no NVDIMM hw in the test machine,
> the VFIO hotplug operation will need at least 10 minutes to pin RAM
> as the NVDIMM, this time is not accepted. So we add "nopin=on" option
> in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.
> 
> The new command like below:
> -object memory-backend-file,id=mem0,share,nopin=on,mem-path=kvm.img,size=9161408512 
> 
> The default of "nopin" still "off" value, which is same with previous value.


If an NVDIMM is not a possible DMA target for a VFIO assigned device
then it should be in a different AddressSpace from the device.  If an
NVDIMM can be a DMA target then it's the correct thing to do to pin it
through the IOMMU for a VFIO device even if it might take considerable
time to do so.  Thanks,

Alex
