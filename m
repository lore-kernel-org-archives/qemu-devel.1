Received: from eggs.gnu.org ([2001:4830:134:3::10]:54182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ch2mD-0006eP-UE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ch2mA-0006dv-Ow
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ch2mA-0006dr-IV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:26:18 -0500
Date: Fri, 24 Feb 2017 01:26:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170224012200-mutt-send-email-mst@kernel.org>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<20170222202451.458de865@t450s.home>
	<20170223054234.GF4015@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223054234.GF4015@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 23, 2017 at 01:42:34PM +0800, Peter Xu wrote:
> On Wed, Feb 22, 2017 at 08:24:51PM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > > Now Jintack reported another issue, that we may have two default
> > > devices there if not specifying "-nodefaults", and that two devices
> > > will always be the first ones to be inited.
> > > 
> > > How about here we just explicitly check against vfio-pci devices, so
> > > we just make sure vfio-pci devices will be put after intel-iommu?
> > > Since actually vfio-pci devices are the only ones that we know we need
> > > to be inited explicitly after the VT-d device.
> > 
> > I was afraid you were going to come to this conclusion.  That works,
> > BUT it just means the problem gets ignored as a vfio problem when
> > really vfio is doing nothing wrong other than caring about the device
> > address space during its initialization.

And that part is broken at this stage.  We can add a flag
"uses_address_space_in_init". Would that be better?


>  Then users have a perfectly
> > working config, add a vfio-pci device and things explode.  If you want
> > to impose a user ordering requirement, do it consistently.

This is not a new thing however. vfio previously did not work with
an iommu either. It seems reasonable to make sure iommu
is initialized first.

But it also seems reasonable to enable that gradually
and not require removing ordering requirements upfront.


>  Thanks,
> 
> We cannot guarantee that guest won't "explode" only if we
> automatically order the device init, but that's something I am not
> quite sure about that we will need now, especially I don't know
> whether it would be a 2.9 material, considering that 2.9 soft freeze
> should be on Feb 28th. :(
> 
> I kind of understand your concern, but would that really a so-called
> explosion? The user will just be warned that he/she should move the
> intel-iommu line slightly higher. Imho that's tolerable, since the
> user is definitely adding something new to the parameters, and it's
> possible the new command line just don't work. Also, imho it's not
> anyone's fault if it happens, it's just a new rule that we need to
> make sure things work properly...
> 
> I just want to know what would be the most feasible approach that we
> can safely have the vtd vfio series in before 2.9. Any further input
> would be welcomed.
> 
> Thanks,
> 
> -- peterx
