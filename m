Received: from eggs.gnu.org ([209.51.188.92]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h120W-0003JY-N7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 23:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h120V-0005QR-MN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 23:48:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h120U-0005Mf-Ll
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 23:48:47 -0500
Date: Tue, 5 Mar 2019 12:48:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190305044836.GI1657@xz-x1>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190305030934.GH1657@xz-x1> <20190305032424.GJ26129@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305032424.GJ26129@yi.y.sun>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Tue, Mar 05, 2019 at 11:24:24AM +0800, Yi Sun wrote:
> On 19-03-05 11:09:34, Peter Xu wrote:
> > On Tue, Mar 05, 2019 at 10:34:52AM +0800, Yi Sun wrote:
> > > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > > 'scalable mode', which enables PASID-granular translations for
> > > first level, second level, nested and pass-through modes. The
> > > vt-d scalable mode is the key ingredient to enable Scalable I/O
> > > Virtualization (Scalable IOV) [2] [3], which allows sharing a
> > > device in minimal possible granularity (ADI - Assignable Device
> > > Interface). As a result, previous Extended Context (ECS) mode
> > > is deprecated (no production ever implements ECS).
> > > 
> > > This patch set emulates a minimal capability set of VT-d scalable
> > > mode, equivalent to what is available in VT-d legacy mode today:
> > >     1. Scalable mode root entry, context entry and PASID table
> > >     2. Seconds level translation under scalable mode
> > >     3. Queued invalidation (with 256 bits descriptor)
> > >     4. Pass-through mode
> > > 
> > > Corresponding intel-iommu driver support will be included in
> > > kernel 5.0:
> > >     https://www.spinics.net/lists/kernel/msg2985279.html
> > > 
> > > We will add emulation of full scalable mode capability along with
> > > guest iommu driver progress later, e.g.:
> > >     1. First level translation
> > >     2. Nested translation
> > >     3. Per-PASID invalidation descriptors
> > >     4. Page request services for handling recoverable faults
> > > 
> > > To verify the patches, below cases were tested according to Peter Xu's
> > > suggestions.
> > >     +---------+----------------------------------------------------------------+----------------------------------------------------------------+
> > >     |         |                      w/ Device Passthr                         |                     w/o Device Passthr                         |
> > >     |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> > >     |         | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      | virtio-net-pci, vhost=on      | virtio-net-pci, vhost=off      |
> > >     |         +-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> > >     |         | netperf | kernel bld | data cp| netperf | kernel bld | data cp | netperf | kernel bld | data cp| netperf | kernel bld | data cp |
> > >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> > >     | Legacy  | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
> > >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> > >     | Scalable| Pass    | Pass       | Pass   | Pass    | Pass       | Pass    | Pass    | Pass       | Pass   | Pass    | Pass       | Pass    |
> > >     +---------+-------------------------------+--------------------------------+-------------------------------+--------------------------------+
> > 
> > Legacy vfio-pci?
> > 
> I tested legacy mode with below command.
> 
> w/o passthr
>     -device intel-iommu \
>     -netdev tap,id=net1,vhost=off|on \
>     -device virtio-net-pci,netdev=net1 \

Virtio devices require explicit enabling of DMAR:

https://wiki.qemu.org/Features/VT-d#With_Virtio_Devices

Otherwise it could probably still be bypassing the translation unit.

If you retest any, please feel free to skip some of the tests like
kernel build.  Quick netperf should work, which can save you time.

> 
> w/ passthr: tried net card, graphic card, and a MDEV (cmd is different)
>     -device intel-iommu,caching-mode=on \
>     -netdev tap,id=net1,vhost=off|on \
>     -device virtio-net-pci,netdev=net1 \
>     -device vfio-pci,host=0000:00:1f.6 \

This one seems correct to me, and yes covering net/graphic cards
should be far enough.

Thanks,

-- 
Peter Xu
