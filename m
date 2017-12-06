Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eMRcT-0000LZ-Bx
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 23:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eMRcP-0002B7-0f
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 23:47:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:32967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eMRcO-0002A8-MM
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 23:47:36 -0500
Date: Wed, 6 Dec 2017 12:31:03 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171206043103.GB1164@sky-dev>
References: <20171205205409.5348.53070.stgit@gimli.home>
	<20171206024443.GA1164@sky-dev>
	<20171205201258.6111c71c@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205201258.6111c71c@t450s.home>
Subject: Re: [Qemu-devel] [PATCH for-2.11] vfio: Fix vfio-kvm group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, eric.auger@redhat.com

On Tue, Dec 05, 2017 at 08:12:58PM -0700, Alex Williamson wrote:
> On Wed, 6 Dec 2017 10:44:43 +0800
> "Liu, Yi L" <yi.l.liu@linux.intel.com> wrote:
> 
> > On Tue, Dec 05, 2017 at 02:09:07PM -0700, Alex Williamson wrote:
> > > Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
> > > attaching") moved registration of groups with the vfio-kvm device from
> > > vfio_get_group() to vfio_connect_container(), but it missed the case
> > > where a group is attached to an existing container and takes an early
> > > exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
> > > (without viommu) all groups are connected to the same container and
> > > thus only the first group gets registered with the vfio-kvm device.
> > > This becomes a problem if we then hot-unplug the devices associated
> > > with that first group and we end up with KVM being misinformed about
> > > any vfio connections that might remain.  Fix by including the call to
> > > vfio_kvm_device_add_group() in this early exit path.
> > > 
> > > Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
> > > Cc: qemu-stable@nongnu.org # qemu-2.10+
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > > 
> > > This bug also existed in QEMU 2.10, but I think the fix is sufficiently
> > > obvious (famous last words) to propose for 2.11 at this late date.  If
> > > the first group is hot unplugged then KVM may revert to code emulation
> > > that assumes no non-coherent DMA is present on some systems.  Also for
> > > KVMGT, if the vGPU is not the first device registered, then the
> > > notifier to enable linkages to KVM would not be called.  Please review.
> > > Thanks,  
> > 
> > Alex, for x86, I suppose it doesn't exist in the case which viommu is exposed
> > to guest?
> 
> With viommu, I believe each group would be in its own AddressSpace and
> therefore get a separate container, so I don't think it'd be an issue.
> It's only subsequent groups added to the same container which are
> missed.  Thanks,

agree, thanks for the confirm. It's a nice fix~

Regards,
Yi L
> 
> > >  hw/vfio/common.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index 7b2924c0ef19..7007878e345e 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -968,6 +968,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> > >          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> > >              group->container = container;
> > >              QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> > > +            vfio_kvm_device_add_group(group);
> > >              return 0;
> > >          }
> > >      }
> > > 
> > >   
> 
