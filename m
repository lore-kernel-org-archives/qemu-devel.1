Received: from eggs.gnu.org ([2001:4830:134:3::10]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn82f-0007ai-I1
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn82b-0000yN-Mi
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:53:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fn82b-0000xX-Fl
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:53:13 -0400
Date: Tue, 7 Aug 2018 13:53:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180807135303.3938b3a2@t450s.home>
In-Reply-To: <20180807224033-mutt-send-email-mst@kernel.org>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807224033-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Tue, 7 Aug 2018 22:44:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Aug 07, 2018 at 01:31:21PM -0600, Alex Williamson wrote:
> > v3:
> >  - Drop "nested" term in commit log (David)
> >  - Adopt suggested wording in ccw code (Cornelia)
> >  - Explain balloon inhibitor usage in vfio common (Peter)
> >  - Fix to call inhibitor prior to re-using existing containers
> >    to avoid gap that pinning may have occurred in set container
> >    ioctl (self) - Peter, this change is the reason I didn't
> >    include your R-b.
> >  - Add R-b to patches 1 & 2
> > 
> > v2:
> >  - Use atomic ops for balloon inhibit counter (Peter)
> >  - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
> >    default, vfio-pci opt-in by device option, only allowed for mdev
> >    devices, no support added for platform as there are no platform
> >    mdev devices.
> > 
> > See patch 3/4 for detailed explanation why ballooning and device
> > assignment typically don't mix.  If this eventually changes, flags
> > on the iommu info struct or perhaps device info struct can inform
> > us for automatic opt-in.  Thanks,
> > 
> > Alex  
> 
> One of the issues with pass-through is that it breaks overcommit
> through swap. ballooning seems to offer one solution, instead of
> making it work this patch just attempts to block ballooning.
> 
> I guess it's better than corrupting memory but I personally find this
> approach disappointing.

Memory hotplug is the way to achieve variable density with assigned
device VMs, otherwise look towards approaches like mdev and shared
virtual addresses with PASID support.  We cannot shoehorn page faulting
without both hardware and software support.  Some class of "legacy"
device assignment will always have this incompatibility.  Thanks,

Alex
