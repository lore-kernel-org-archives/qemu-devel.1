Received: from eggs.gnu.org ([2001:4830:134:3::10]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dWAYV-0000Sg-CZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dWAYS-0005FP-9g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:03:31 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dWAYR-0005Ez-VN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:03:28 -0400
Received: by mail-pg0-x242.google.com with SMTP id y129so12119047pgy.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 17:03:26 -0700 (PDT)
References: <20170711053218.6700-1-aik@ozlabs.ru>
	<20170714151740.60394531@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <77ddd257-99ba-07bc-e6e6-eb33b6eeda77@ozlabs.ru>
Date: Sat, 15 Jul 2017 10:03:20 +1000
MIME-Version: 1.0
In-Reply-To: <20170714151740.60394531@w520.home>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] vfio-pci,
 ppc64/spapr: Reorder group-to-container attaching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 15/07/17 07:17, Alex Williamson wrote:
> On Tue, 11 Jul 2017 15:32:18 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> At the moment VFIO PCI device initialization works as follows:
>> vfio_realize
>> 	vfio_get_group
>> 		vfio_connect_container
>> 			register memory listeners (1)
>> 			update QEMU groups lists
>> 		vfio_kvm_device_add_group
>>
>> Then (example for pseries) the machine reset hook triggers region_add()
>> for all regions where listeners from (1) are listening:
>>
>> ppc_spapr_reset
>> 	spapr_phb_reset
>> 		spapr_tce_table_enable
>> 			memory_region_add_subregion
>> 				vfio_listener_region_add
>> 					vfio_spapr_create_window
>>
>> This scheme works fine until we need to handle VFIO PCI device hotplug
>> and we want to enable PPC64/sPAPR in-kernel TCE acceleration on,
>> i.e. after PCI hotplug we need a place to call
>> ioctl(vfio_kvm_device_fd, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE).
>> Since the ioctl needs a LIOBN fd (from sPAPRTCETable) and a IOMMU group fd
>> (from VFIOGroup), vfio_listener_region_add() seems to be the only place
>> for this ioctl().
>>
>> However this only works during boot time because the machine reset
>> happens strictly after all devices are finalized. When hotplug happens,
>> vfio_listener_region_add() is called when a memory listener is registered
>> but when this happens:
>> 1. new group is not added to the container->group_list yet;
>> 2. VFIO KVM device is unaware of the new IOMMU group.
>>
>> This moves bits around to have all necessary VFIO infrastructure
>> in place for both initial startup and hotplug cases.
> 
> 
> Wow, for a fairly straight forward patch this changelog is brutal.  Can
> this be summarized as "Register vfio groups with kvm prior to memory
> listener registration such that kvm-vfio pseudo device ioctls are
> available during the region_add callback"?  If so I'll queue this up
> for a pull request prior to soft freeze.  Thanks,


It just could have looked like an unnecessary change, hence this changelog.
Since it is straight forward, I am ok with your shorter version as well.
Thanks.



> 
> Alex
> 
>  
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>
>>
>> This is an independend part of a bigger patchset to enable in-kernel
>> acceleration of TCE operations. While I stuck with IOMMU MR QOM-fication,
>> let's try to parallel patchset pieces' review/acceptance.
>>
>> ---
>> Changes:
>> v3:
>> * rebased on current upstream
>>
>> v2:
>> * moved container->initialized back to its correct location
>> * added missing QLIST_REMOVE()
>> ---
>>  hw/vfio/common.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 2965b68e5d..4e75dc8c56 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1107,6 +1107,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>          goto free_container_exit;
>>      }
>>  
>> +    vfio_kvm_device_add_group(group);
>> +
>> +    QLIST_INIT(&container->group_list);
>> +    QLIST_INSERT_HEAD(&space->containers, container, next);
>> +
>> +    group->container = container;
>> +    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> +
>>      container->listener = vfio_memory_listener;
>>  
>>      memory_listener_register(&container->listener, container->space->as);
>> @@ -1120,14 +1128,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>  
>>      container->initialized = true;
>>  
>> -    QLIST_INIT(&container->group_list);
>> -    QLIST_INSERT_HEAD(&space->containers, container, next);
>> -
>> -    group->container = container;
>> -    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> -
>>      return 0;
>>  listener_release_exit:
>> +    QLIST_REMOVE(group, container_next);
>> +    QLIST_REMOVE(container, next);
>> +    vfio_kvm_device_del_group(group);
>>      vfio_listener_release(container);
>>  
>>  free_container_exit:
>> @@ -1232,8 +1237,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>>  
>>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>>  
>> -    vfio_kvm_device_add_group(group);
>> -
>>      return group;
>>  
>>  close_fd_exit:
> 


-- 
Alexey
