Received: from eggs.gnu.org ([2001:4830:134:3::10]:59728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXTV0-0002Zw-Mz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXTUy-0006q9-2g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dXTUx-0006pt-PV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:29:16 -0400
Date: Tue, 18 Jul 2017 08:29:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170718082907.69893dda@w520.home>
In-Reply-To: <d0abeefc-adcf-85c3-f5d9-8c90a18f8011@arm.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
	<20170714121555.7e64d849@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A906A@shsmsx102.ccr.corp.intel.com>
	<20170717164515.2491b3bf@w520.home>
	<d0abeefc-adcf-85c3-f5d9-8c90a18f8011@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8bytes.org>

On Tue, 18 Jul 2017 10:38:40 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 17/07/17 23:45, Alex Williamson wrote:
> [..]
> >>>
> >>> How does a user learn which model(s) are supported by the interface?
> >>> How do they learn which ops are supported?  Perhaps a good use for one of those
> >>> flag bits in the outer data structure is "probe".    
> >>
> >> My initial plan to user fills it, if the underlying HW doesn't support the
> >> model, it refuses to service it. User should get a failure and stop to use
> >> it. But your suggestion to have a probe or kinds of query makes sense.
> >> How about we add one more operation for such purpose? Besides the
> >> supported model query, I'd like to add more. E.g the HW IOMMU capabilities.  
> > 
> > We also have VFIO_IOMMU_GET_INFO where the structure can be extended
> > for missing capabilities.  Depending on the capability you want to
> > describe, this might be a better, existing interface for it.  
> 
> It might become hairy when physical IOMMUs start supporting multiple
> formats, or when we want to describe multiple page table formats in
> addition to PASID tables. I was wondering if sysfs iommu_group would be
> better suited for this kind of hardware description with variable-length
> properties, but a new ioctl-based probing mechanism would work as well.

Would different groups have different properties?  Perhaps it's related
to the iommu hardware unit supporting the device, which could host one
or more groups.  Each device already has a link to its iommu where we
could add info (/sys/class/iommu/).
 
> Other things that we'll want to describe are fault reporting capability
> and PASID range, which would fit better in vfio_device_info.

Why?  The per device PASID info is in a PCI capability, so wouldn't
this be iommu info?  Isn't the fault reporting also via the iommu?
Thanks,

Alex
