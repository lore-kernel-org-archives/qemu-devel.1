Received: from eggs.gnu.org ([209.51.188.92]:44227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzcPG-0006l4-OJ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzcPF-0005LC-HM
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:16:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:60707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gzcPF-0005K0-8E
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:16:29 -0500
Date: Fri, 1 Mar 2019 15:13:04 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190301071304.GB26129@yi.y.sun>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190301070734.GD22229@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301070734.GD22229@xz-x1>
Subject: Re: [Qemu-devel] [RFC v2 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-03-01 15:07:34, Peter Xu wrote:
> On Thu, Feb 28, 2019 at 09:47:54PM +0800, Yi Sun wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for
> > first level, second level, nested and pass-through modes. The
> > vt-d scalable mode is the key ingredient to enable Scalable I/O
> > Virtualization (Scalable IOV) [2] [3], which allows sharing a
> > device in minimal possible granularity (ADI - Assignable Device
> > Interface). As a result, previous Extended Context (ECS) mode
> > is deprecated (no production ever implements ECS).
> > 
> > This patch set emulates a minimal capability set of VT-d scalable
> > mode, equivalent to what is available in VT-d legacy mode today:
> >     1. Scalable mode root entry, context entry and PASID table
> >     2. Seconds level translation under scalable mode
> >     3. Queued invalidation (with 256 bits descriptor)
> >     4. Pass-through mode
> > 
> > Corresponding intel-iommu driver support will be included in
> > kernel 5.0:
> >     https://www.spinics.net/lists/kernel/msg2985279.html
> > 
> > We will add emulation of full scalable mode capability along with
> > guest iommu driver progress later, e.g.:
> >     1. First level translation
> >     2. Nested translation
> >     3. Per-PASID invalidation descriptors
> >     4. Page request services for handling recoverable faults
> > 
> > To verify the patches, below cases were tested according to Peter Xu's
> > suggestions.
> >     +---------+----------------------------------------------------------------+----------------------------------------------------------------+
> >     |         |                      w/ Device Passthr                         |                     w/o Device Passthr                         |
> >     |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> >     |         | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      |
> >     |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> >     |         | netperf | kernel bld | data cp| netperf | kernel bld | data cp | netperf | kernel bld | data cp| netperf | kernel bld | data cp |
> >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> >     | Legacy  | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
> >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> >     | Scalable| Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
> >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> 
> Hi, Yi,
> 
> Thanks very much for the thorough test matrix!
> 
Thanks for the review and comments! :)

> The last thing I'd like to confirm is have you tested device
> assignment with v2?  And note that when you test with virtio devices

Yes, I tested a MDEV assignment which can walk the Scalable Mode
patches flows (both kernel and qemu).

> you should not need caching-mode=on (but caching-mode=on should not
> break anyone though).
> 
For virtio-net-pci without device assignment, I did not use
"caching-mode=on".
 
> I've still got some comments here and there but it looks very good at
> least to me overall.
> 
> Thanks,
> 
> -- 
> Peter Xu
