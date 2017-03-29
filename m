Received: from eggs.gnu.org ([2001:4830:134:3::10]:39614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct8mY-000577-Ln
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct8mV-0005lM-FD
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ct8mV-0005lE-9L
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:16:39 -0400
Date: Wed, 29 Mar 2017 16:16:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170329081630.GF3152@pxdev.xzpeter.org>
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>

On Wed, Mar 29, 2017 at 04:00:37PM +0800, Jason Wang wrote:
> Hi:
> 
> I meet an issue when doing reboot for a guest with two virtio-net-pci cards
> when iommu is enabled. What happens is:
> 
> 
> 1) vtd was reset first

I'll add an extra question:

Currently with Q35 and VT-d, our system qtree looks like (simplified
version):

bus: system bus
  dev: intel-iommu
  dev: q35-pcihost
    bus: pcie.0
      dev: pci device 1
      dev: pci device 2
      ...

Not sure whether it'll be clearer to switch to:

bus: system bus
  dev: q35-pcihost
    bus: iommu-scope 0
      dev: intel-iommu
        bus: pcie.0
          dev: pci device 1
          dev: pci device 2
          ...

since logically the IOMMU device should be part of q35 pci-host?

Further, if we'll have more intel-iommus in the future in a single
guest, we'll be able to have devices dangle under the specific iommu
that it belongs. That'll be nice imho.

(Btw, I see that we are using qbus-qdev-qbus-... iterations to
 describe the system tree. Why cannot we have qdev under another qdev?
 Sorry if the question is stupid... Any pointers on explanations to
 these qdev logics would be appreciated as well.)

> 
> 2) during the reset of virtio-net-pci #1, deletion of msix subregion will
> cause a commit of all memory listeners
> 
> 3) virito-net-pci #2's region cache will be update, but since vtd has
> already been reset, it can't get a valid mappings here
> 
> 
> Any ideas on how to fix this? Need region cache be aware of IOMMU/IOTLB
> state in this case? Or can we simply reset IOMMU as the last one?
> 
> Thanks
> 

-- peterx
