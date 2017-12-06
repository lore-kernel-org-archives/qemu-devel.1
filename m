Received: from eggs.gnu.org ([2001:4830:134:3::10]:53021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eMPxZ-0000B2-6D
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eMPxW-0000cp-54
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:01:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:40997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eMPxV-0000aY-SO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:01:18 -0500
Date: Wed, 6 Dec 2017 10:44:43 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171206024443.GA1164@sky-dev>
References: <20171205205409.5348.53070.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205205409.5348.53070.stgit@gimli.home>
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

On Tue, Dec 05, 2017 at 02:09:07PM -0700, Alex Williamson wrote:
> Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
> attaching") moved registration of groups with the vfio-kvm device from
> vfio_get_group() to vfio_connect_container(), but it missed the case
> where a group is attached to an existing container and takes an early
> exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
> (without viommu) all groups are connected to the same container and
> thus only the first group gets registered with the vfio-kvm device.
> This becomes a problem if we then hot-unplug the devices associated
> with that first group and we end up with KVM being misinformed about
> any vfio connections that might remain.  Fix by including the call to
> vfio_kvm_device_add_group() in this early exit path.
> 
> Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
> Cc: qemu-stable@nongnu.org # qemu-2.10+
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> This bug also existed in QEMU 2.10, but I think the fix is sufficiently
> obvious (famous last words) to propose for 2.11 at this late date.  If
> the first group is hot unplugged then KVM may revert to code emulation
> that assumes no non-coherent DMA is present on some systems.  Also for
> KVMGT, if the vGPU is not the first device registered, then the
> notifier to enable linkages to KVM would not be called.  Please review.
> Thanks,

Alex, for x86, I suppose it doesn't exist in the case which viommu is exposed
to guest?

Regards,
Yi L
> 
>  hw/vfio/common.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c0ef19..7007878e345e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -968,6 +968,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>              group->container = container;
>              QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +            vfio_kvm_device_add_group(group);
>              return 0;
>          }
>      }
> 
> 
