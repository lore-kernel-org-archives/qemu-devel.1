Received: from eggs.gnu.org ([2001:4830:134:3::10]:49505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1csvEV-0007YQ-4Q
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1csvEU-0005dG-4r
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:48:39 -0400
Date: Tue, 28 Mar 2017 11:48:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170328114836.63dcde23@t450s.home>
In-Reply-To: <20170328090530.20052-3-aik@ozlabs.ru>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/3] vfio-pci: Reorder
 group-to-container attaching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 28 Mar 2017 20:05:29 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment VFIO PCI device initialization works as follows:
> vfio_realize
> 	vfio_get_group
> 		vfio_connect_container
> 			register memory listeners (1)
> 			update QEMU groups lists
> 		vfio_kvm_device_add_group
> 
> Then (example for pseries) the machine reset hook triggers region_add()
> for all regions where listeners from (1) are listening:
> 
> ppc_spapr_reset
> 	spapr_phb_reset
> 		spapr_tce_table_enable
> 			memory_region_add_subregion
> 				vfio_listener_region_add
> 					vfio_spapr_create_window
> 
> This scheme works fine until we need to handle VFIO PCI device hotplug
> _and_ we want to enable in-kernel acceleration on, i.e. after PCI hotplug
> we need a place to call
> ioctl(vfio_kvm_device_fd, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE).
> Since the ioctl needs a LIOBN fd (from sPAPRTCETable) and a IOMMU group fd
> (from VFIOGroup), vfio_listener_region_add() seems to be the only place
> for this ioctl().
> 
> However this only works during boot time because the machine reset
> happens strictly after all devices are finalized. When hotplug happens,
> vfio_listener_region_add() is called when a memory listener is registered
> but when this happens:
> 1. new group is not added to the container->group_list yet;
> 2. VFIO KVM device is unaware of the new IOMMU group.
> 
> This moves bits around to have all necessary VFIO infrastructure
> in place for both initial startup and hotplug cases.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/vfio/common.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f3ba9b9007..c75c7594d5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1086,6 +1086,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          goto free_container_exit;
>      }
>  
> +    container->initialized = true;

This ignores the purpose of this variable, which is to make runtime
mapping faults fatal, but device realize time faults simply cause the
device to be rejected.  This cannot be moved above
memory_listener_register().

> +
> +    vfio_kvm_device_add_group(group);
> +
> +    QLIST_INIT(&container->group_list);
> +    QLIST_INSERT_HEAD(&space->containers, container, next);
> +
> +    group->container = container;
> +    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +
>      container->listener = vfio_memory_listener;
>  
>      memory_listener_register(&container->listener, container->space->as);
> @@ -1097,16 +1107,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          goto listener_release_exit;
>      }
>  
> -    container->initialized = true;
> -
> -    QLIST_INIT(&container->group_list);
> -    QLIST_INSERT_HEAD(&space->containers, container, next);
> -
> -    group->container = container;
> -    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> -
>      return 0;
>  listener_release_exit:
> +    vfio_kvm_device_del_group(group);


Where's the QLIST cleanup?


>      vfio_listener_release(container);
>  
>  free_container_exit:
> @@ -1210,8 +1213,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>  
>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>  
> -    vfio_kvm_device_add_group(group);
> -
>      return group;
>  
>  close_fd_exit:
