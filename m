Received: from eggs.gnu.org ([2001:4830:134:3::10]:54782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eMO6H-0000RU-9M
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 20:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eMO6E-0003yF-4D
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 20:02:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eMO6D-0003xf-RF
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 20:02:10 -0500
Received: by mail-pg0-x242.google.com with SMTP id y6so1464228pgp.4
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 17:02:09 -0800 (PST)
References: <20171205205409.5348.53070.stgit@gimli.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9519f733-ddb1-beea-830b-4c9cda69ca67@ozlabs.ru>
Date: Wed, 6 Dec 2017 12:02:01 +1100
MIME-Version: 1.0
In-Reply-To: <20171205205409.5348.53070.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
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
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com

On 06/12/17 08:09, Alex Williamson wrote:
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

For what it is worth

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Sorry for the breakage...

One question - how was this discovered? I'd love to set up a test
environment on my old thinkpad x230 if possible.



> Thanks,
> 
> Alex
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


-- 
Alexey
