Received: from eggs.gnu.org ([2001:4830:134:3::10]:58821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eMbB6-00034S-0n
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eMbAz-0006S1-TI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:00:04 -0500
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
	<20171114084735.68e87546@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA83845EDBF@FRAEML521-MBX.china.huawei.com>
	<20171115112513.3c035023@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA8384704C0@FRAEML521-MBX.china.huawei.com>
	<20171120085745.0147df5c@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA838622618@FRAEML521-MBX.china.huawei.com>
	<e500dd54-04b6-5f19-316f-0598655751ea@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA838622A1D@FRAEML521-MBX.china.huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3fcae1c1-6195-59ce-68f2-1a0b13a130c2@redhat.com>
Date: Wed, 6 Dec 2017 15:59:44 +0100
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838622A1D@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
 reserved_region of device iommu group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, Zhuyijun <zhuyijun@huawei.com>

Hi Shameer,

On 06/12/17 15:38, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Wednesday, December 06, 2017 2:01 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Alex Williamson <alex.williamson@redhat.com>
>> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org; Linuxarm
>> <linuxarm@huawei.com>; qemu-arm@nongnu.org; Zhaoshenglong
>> <zhaoshenglong@huawei.com>; Zhuyijun <zhuyijun@huawei.com>
>> Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
>> reserved_region of device iommu group
>>
>> Hi Shameer,
>>
>> On 06/12/17 11:30, Shameerali Kolothum Thodi wrote:
>>> Hi Alex,
>>>
>>>> -----Original Message-----
>>>> From: Shameerali Kolothum Thodi
>>>> Sent: Monday, November 20, 2017 4:31 PM
>>>> To: 'Alex Williamson' <alex.williamson@redhat.com>
>>>> Cc: eric.auger@redhat.com; Zhuyijun <zhuyijun@huawei.com>; qemu-
>>>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>>>> Zhaoshenglong <zhaoshenglong@huawei.com>; Linuxarm
>>>> <linuxarm@huawei.com>
>>>> Subject: RE: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
>>>> reserved_region of device iommu group
>>> [...]
>>>>>>> And sysfs is a good interface if the user wants to use it to
>>>>>>> configure the VM in a way that's compatible with a device.  For
>>>>>>> instance, in your case, a user could evaluate these reserved
>>>>>>> regions across all devices in a system, or even across an entire
>>>>>>> cluster, and instantiate the VM with a memory map compatible with
>>>>>>> hotplugging any of those evaluated devices (QEMU implementation of
>>>> allowing the user to do this TBD).
>>>>>>> Having the vfio device evaluate these reserved regions only helps
>>>>>>> in the cold-plug case.  So the proposed solution is limited in
>>>>>>> scope and doesn't address similar needs on other platforms.  There
>>>>>>> is value to verifying that a device's IOVA space is compatible
>>>>>>> with a VM memory map and modifying the memory map on cold-plug or
>>>>>>> rejecting the device on hot-plug, but isn't that why we have an
>>>>>>> ioctl within vfio to expose information about the IOMMU?  Why take
>>>>>>> the path of allowing QEMU to rummage through sysfs files outside
>>>>>>> of vfio, implying additional security and access concerns, rather
>>>>>>> than filling the gap within the vifo API?
>>>>>>
>>>>>> Thanks Alex for the explanation.
>>>>>>
>>>>>> I came across this patch[1] from Eric where he introduced the IOCTL
>>>>> interface to
>>>>>> retrieve the reserved regions. It looks like this can be reworked to
>>>>> accommodate
>>>>>> the above requirement.
>>>>>
>>>>> I don't think we need a new ioctl for this, nor do I think that
>>>>> describing the holes is the correct approach.  The existing
>>>>> VFIO_IOMMU_GET_INFO ioctl can be extended to support capability
>>>>> chains, as we've done for VFIO_DEVICE_GET_REGION_INFO.
>>>>
>>>> Right, as far as I can see the above mentioned patch is doing exactly the
>> same,
>>>> extending the VFIO_IOMMU_GET_INFO ioctl with capability chain.
>>>>
>>>>> IMO, we should try to
>>>>> describe the available fixed IOVA regions which are available for
>>>>> mapping rather than describing various holes within the address space
>>>>> which are unavailable.  The latter method always fails to describe the
>>>>> end of the mappable IOVA space and gets bogged down in trying to
>>>>> classify the types of holes that might exist.  Thanks,
>>>>
>>>
>>> I was going through this and noticed that it is possible to have multiple
>>> iommu domains associated with a container. If that's true, is it safe to
>>> make the assumption that all the domains will have the same iova
>>> geometry or not?
>> To me the answer is no.
>>
>> There are several iommu domains "underneath" a single container. You
>> attach vfio groups to a container. Each of them is associated to an
>> iommu group and an iommu domain. See vfio_iommu_type1_attach_group().
>>
>> Besides, the reserved regions are per iommu group.
>>
> 
> Thanks for your reply. Yes, container can have multiple groups(hence multiple 
> iommu domains) and reserved regions are per group. Hence while deciding
> the default supported iova geometry we have to go through all the domains
> in the container and select smallest aperture as the supported default iova
> range.
> 
> Please find below snippet from a patch I am working on. Please
> let me know your thoughts on this.
> 
> Thanks,
> Shameer
> 
> -- >8 --
> +static int vfio_build_iommu_iova_caps(struct vfio_iommu *iommu,
> +                               struct vfio_info_cap *caps) {
> +       struct iommu_resv_region *resv, *resv_next;
> +       struct vfio_iommu_iova *iova, *iova_next;
> +       struct list_head group_resv_regions, vfio_iova_regions;
> +       struct vfio_domain *domain;
> +       struct vfio_group *g;
> +       phys_addr_t start, end;
> +       int ret = 0;
> +
> +       domain = list_first_entry(&iommu->domain_list,
> +                                 struct vfio_domain, next);
> +       /* Get the default iova range supported */
> +       start = domain->domain->geometry.aperture_start;
> +       end = domain->domain->geometry.aperture_end;
> 
> This is where I am confused. I think instead I should go over
> the domain_list and select the smallest aperture as default
> iova range.
yes that's correct. I Just want to warn you Pierre is working on the
same topic. May be worth to sync together.

[PATCH] vfio/iommu_type1: report the IOMMU aperture info
(https://patchwork.kernel.org/patch/10084655/)

I think he plans to rework his series with capability chain too.

Thanks

Eric


> 
> +       INIT_LIST_HEAD(&vfio_iova_regions);
> +       vfio_insert_iova(start, end, &vfio_iova_regions);
> +
> +       /* Get reserved regions if any */
> +       INIT_LIST_HEAD(&group_resv_regions);
> +       list_for_each_entry(g, &domain->group_list, next)
> +               iommu_get_group_resv_regions(g->iommu_group,
> +                                               &group_resv_regions);
> +       list_sort(NULL, &group_resv_regions, vfio_resv_cmp);
> +
> +       /* Update iova range excluding reserved regions */
>  ...
> -- >8 --
> 
> 
