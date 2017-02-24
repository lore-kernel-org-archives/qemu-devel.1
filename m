Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1chA17-0005he-0z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1chA12-0001Oc-25
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1chA11-0001LX-Pr
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:10:07 -0500
Date: Fri, 24 Feb 2017 15:10:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170224071001.GE10022@pxdev.xzpeter.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<153715427.26269614.1487912853628.JavaMail.zimbra@redhat.com>
	<20170224055005.GC10022@pxdev.xzpeter.org>
	<750665985.26278283.1487918110693.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <750665985.26278283.1487918110693.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, yi l liu <yi.l.liu@intel.com>, "\\ Michael S . Tsirkin \"; \"Alex Williamson\";
	\"Marcel Apfelbaum\" <marcel@redhat.com>;
	\"Jintack Lim" <alex.williamson@redhat.com>

On Fri, Feb 24, 2017 at 01:35:10AM -0500, Pankaj Gupta wrote:
> 
> > 
> > On Fri, Feb 24, 2017 at 12:07:33AM -0500, Pankaj Gupta wrote:
> > > Hello Peter,
> > 
> > Hi, Pankaj!
> > 
> > > 
> > > This solution looks to check dependency of 'vfio-pci' over 'intel-iommu'
> > > before 'intel-iommu' is not initialized.
> > > 
> > > Overall it looks good to me, just a small nit below.
> > >  
> > > > 
> > > > Intel vIOMMU devices are created with "-device" parameter, while here
> > > > actually we need to make sure the dmar device be created before other
> > > > PCI devices (like vfio-pci) so that we know iommu_fn will be setup
> > > > correctly before realizations of those PCI devices (it is sensible that
> > > > PCI device fetch these info during its realization). Now this ordering
> > > > yet cannot be achieved elsewhere, and devices will be created in the
> > > > order that user specified. That might be dangerous.
> > > > 
> > > > Here we add one more function to detect this kind of misordering issue,
> > > > then report to guest. Currently, the only known device that is affected
> > > > by this VT-d defect is the vfio-pci typed devices. So for now we just
> > > > check against it to make sure we are safe.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  hw/i386/intel_iommu.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > > 
> > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > index 22d8226..b723ece 100644
> > > > --- a/hw/i386/intel_iommu.c
> > > > +++ b/hw/i386/intel_iommu.c
> > > > @@ -2560,6 +2560,24 @@ static bool vtd_decide_config(IntelIOMMUState *s,
> > > > Error **errp)
> > > >      return true;
> > > >  }
> > > >  
> > > > +/*
> > > > + * TODO: we should have a better way to achieve the ordering rather
> > > > + * than this misorder check explicitly against vfio-pci. After all, no
> > > > + * one should be blamed for this, and vfio-pci did nothing wrong.
> > > > + */
> > > > +static bool vtd_detected_misorder_init(Error **errp)
> > > > +{
> > > > +    Object *dev = object_resolve_path_type("", "vfio-pci", NULL);
> > > > +
> > > > +    if (dev) {
> > > > +        error_setg(errp, "Please specify \"intel-iommu\" before all the
> > > > rest
> > > 
> > >             "before all the rest" does not give much clue to user. Do you
> > >             think better
> > >             error message would help? just a thought.
> > 
> > Yes this is my intention to emphasize that we should possibly put
> > intel-iommu even before all the PCI devices. As mentioned above (and
> > also in the commit message), although vfio-pci is the only one that is
> > affected by this, we should probably put intel-iommu even before all
> > the rest of PCI devices. E.g., in the future we can have new devices
> > that need this dependency as well (that vt-d being inited before that
> > device), which is still legal imho.
> 
> yes, something like this can help "intel-iommu should be specified as first device"?

I can switch this description if you prefer this one. :) Not sure
whether this can be touched up during merge if this patch is good for
2.9, or I'll just repost with yours if there is further comments.

> Or we can just check for "intel-iommu" as first device at the start in place of
> checking for "vfio-pci". This will also help us to check for all other devices. 

Actually your suggestion is just what I did in version 1. The problem
is that, it's not easy to let vt-d really be the first device to be
inited... Please check pc_q35_init(), within that we have:

    pc_vga_init(isa_bus, host_bus);
    pc_nic_init(isa_bus, host_bus);

These are integrated devices along with ICH9. Such devices are
possibly pci devices as well, but they are created much earlier than
vt-d device, since that's still during machine init.

Thanks,

-- peterx
