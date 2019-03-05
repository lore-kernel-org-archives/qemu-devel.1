Received: from eggs.gnu.org ([209.51.188.92]:40770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h10kE-0007I9-TE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h10kD-0000e2-3h
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:27:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:20458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1h10kC-0000Yz-2q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:27:52 -0500
Date: Tue, 5 Mar 2019 11:24:24 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190305032424.GJ26129@yi.y.sun>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190305030934.GH1657@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305030934.GH1657@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] intel_iommu: support scalable mode
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

On 19-03-05 11:09:34, Peter Xu wrote:
> On Tue, Mar 05, 2019 at 10:34:52AM +0800, Yi Sun wrote:
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
> Legacy vfio-pci?
> 
I tested legacy mode with below command.

w/o passthr
    -device intel-iommu \
    -netdev tap,id=net1,vhost=off|on \
    -device virtio-net-pci,netdev=net1 \

w/ passthr: tried net card, graphic card, and a MDEV (cmd is different)
    -device intel-iommu,caching-mode=on \
    -netdev tap,id=net1,vhost=off|on \
    -device virtio-net-pci,netdev=net1 \
    -device vfio-pci,host=0000:00:1f.6 \

> I've reviewed the whole series, I would assume that the maintainer
> might still test it a bit before a pull but again even before that I
> would really like to double confirm this series won't break anything.
> 
> Thanks,
> 
> -- 
> Peter Xu
