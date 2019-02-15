Received: from eggs.gnu.org ([209.51.188.92]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guYEK-0008NZ-IA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guYEJ-0006DD-N0
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:48:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:49145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1guYEJ-00067k-EC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:48:15 -0500
Date: Fri, 15 Feb 2019 15:44:49 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190215074449.GJ16968@yi.y.sun>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-4-git-send-email-yi.y.sun@linux.intel.com>
	<20190212064629.GL1011@xz-x1> <20190215052234.GI16968@yi.y.sun>
	<20190215053905.GA5875@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215053905.GA5875@xz-x1>
Subject: Re: [Qemu-devel] [RFC v1 3/3] intel_iommu: add scalable-mode option
 to make scalable mode work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-02-15 13:39:05, Peter Xu wrote:
> On Fri, Feb 15, 2019 at 01:22:34PM +0800, Yi Sun wrote:
> 
> [...]
> 
> > > > +    /* TODO: read cap/ecap from host to decide which cap to be exposed. */
> > > > +    if (s->scalable_mode) {
> > > > +        if (!s->caching_mode) {
> > > > +            error_report("Need to set caching-mode for scalable mode");
> > > 
> > > Could I ask why?
> > > 
> > My intention is to make guest explicitly send to make sure SLT shadowing
> > correctly.
> > 
> > For this point, I also have question. Why does legacy mode not check CM?
> > If CM is not set, may the DMA remapping be wrong because SLT cannot
> > match guest's latest change?
> 
> Because CM is currently only required for device assignment.  For
> example, if you only have an emulated device like virtio-net-pci in
> the guest, then you don't need the CM capability to let it work with
> the vIOMMU.  That's because we'll walk the 2nd level IOMMU page table
> only when the virtio-net-pci device does DMA, and QEMU can easily do
> that (QEMU is emulating the DMA of the virtio-net-pci device, and QEMU
> has the knowledge of the guest 2nd level IOMMU page tables).  Assigned
> devices are special because the host hardware knows nothing about
> guest 2nd level page tables, so QEMU needs to shadow them before DMA
> starts.
> 
Thanks for the explanation! As CM is must for device assignment, I may
remove the check in current codes. In fact, CM is optional for SM.

> That's also why I listed "device assignment" as a special case in the
> test device matrix, because that's the only case where we can torture
> the IOMMU page shadowing code a bit.
> 
> For the scalable mode I would suppose you will still allow it to work
> without caching mode.  The example is the same as above - when there's
> only emulated devices in the guest.
> 
Yes, I verified it by using virtio-net-pci without device assignment.
The netperf simple case runs well.

> Regards,
> 
> -- 
> Peter Xu
