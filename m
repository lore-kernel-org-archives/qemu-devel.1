Received: from eggs.gnu.org ([209.51.188.92]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h10g7-0005dP-M2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h10g6-0004Jk-Jn
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:23:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h10g6-0004JX-ER
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:23:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id z13so4065003qki.2
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 19:23:38 -0800 (PST)
Date: Mon, 4 Mar 2019 22:23:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190304222241-mutt-send-email-mst@kernel.org>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190305030934.GH1657@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Yi Sun <yi.y.sun@linux.intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Tue, Mar 05, 2019 at 11:09:34AM +0800, Peter Xu wrote:
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
> I've reviewed the whole series, I would assume that the maintainer
> might still test it a bit before a pull but again even before that I
> would really like to double confirm this series won't break anything.
> 
> Thanks,

If that's me FYI I don't normally test with vfio either.
Yes I'd appreciate testing with that from contributor.

> -- 
> Peter Xu
