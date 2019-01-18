Received: from eggs.gnu.org ([209.51.188.92]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gkM8U-0005qh-3d
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gkM8T-0000gQ-1T
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:52:06 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gkM8S-0000bs-I2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:52:04 -0500
Received: by mail-pl1-x642.google.com with SMTP id z23so5804875plo.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 20:52:03 -0800 (PST)
References: <20190117210245.18364-1-eric.auger@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <801e1f19-4746-9485-670b-e1b958880f03@ozlabs.ru>
Date: Fri, 18 Jan 2019 15:51:57 +1100
MIME-Version: 1.0
In-Reply-To: <20190117210245.18364-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: groug@kaod.org



On 18/01/2019 08:02, Eric Auger wrote:
> In vfio_connect_container() the code that selects the
> iommu type can benefit from helpers such as
> vfio_iommu_get_type() and vfio_init_container(). As
> a result we end up with a switch/case on the iommu type
> that makes the code a little bit more readable and ready
> for addition of new iommu types. Also ioctl's get called
> once per iommu_type.


I'd argue that. This adds 2 more functions to deal with different IOMMU
types: 75 insertions(+), 37 deletions(-).


> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - handle SPAPR case, s/ret/errno in error error_setg_errno,
>   fix ret value when vfio_iommu_get_type fails
> - removed Greg's R-b
> 
> v1:
> - originally submitted in [RFC v2 00/28] vSMMUv3/pSMMUv3
>   2 stage VFIO integration
> ---
>  hw/vfio/common.c | 112 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4262b80c44..33335cee47 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1036,12 +1036,65 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>      }
>  }
>  
> +/*
> + * vfio_iommu_get_type - selects the richest iommu_type (v2 first)
> + */
> +static int vfio_iommu_get_type(VFIOContainer *container,
> +                               Error **errp)
> +{
> +    int fd = container->fd;
> +
> +    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> +        return VFIO_TYPE1v2_IOMMU;
> +    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
> +        return VFIO_TYPE1_IOMMU;
> +    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
> +        return VFIO_SPAPR_TCE_v2_IOMMU;
> +    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU)) {
> +        return VFIO_SPAPR_TCE_IOMMU;
> +    } else {
> +        error_setg(errp, "No available IOMMU models");
> +        return -EINVAL;
> +    }
> +}
> +
> +static int vfio_init_container(VFIOContainer *container, int group_fd,
> +                               int iommu_type, Error **errp)
> +{
> +    int ret;
> +
> +    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "failed to set group container");



This replaces errno with ret which is not the same thing.


> +        return ret;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_SET_IOMMU, iommu_type);
> +    if (ret && iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> +        /*
> +         * On sPAPR, despite the IOMMU subdriver always advertises v1 and v2,
> +         * the running platform may not support v2 and there is no way to
> +         * guess it until an IOMMU group gets added to the container. So in
> +         * case it fails with v2, try v1 as a fallback
> +         */
> +        iommu_type = VFIO_SPAPR_TCE_IOMMU;
> +        ret = ioctl(container->fd, VFIO_SET_IOMMU, iommu_type);
> +    }
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "failed to set iommu for container");
> +        return ret;
> +    }
> +    container->iommu_type = iommu_type;
> +    return ret;
> +}
> +
>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                    Error **errp)
>  {
>      VFIOContainer *container;
>      int ret, fd;
>      VFIOAddressSpace *space;
> +    int iommu_type;
>  
>      space = vfio_get_address_space(as);
>  
> @@ -1101,23 +1154,21 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->fd = fd;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
> -    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
> -        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> -        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> +
> +    iommu_type = vfio_iommu_get_type(container, errp);
> +    if (iommu_type < 0) {
> +            ret = -EINVAL;
> +            goto free_container_exit;
> +    }
> +
> +    switch (iommu_type) {
> +    case VFIO_TYPE1v2_IOMMU:
> +    case VFIO_TYPE1_IOMMU:
> +    {
>          struct vfio_iommu_type1_info info;
>  
> -        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> +        ret = vfio_init_container(container, group->fd, iommu_type, errp);
>          if (ret) {
> -            error_setg_errno(errp, errno, "failed to set group container");
> -            ret = -errno;
> -            goto free_container_exit;
> -        }
> -
> -        container->iommu_type = v2 ? VFIO_TYPE1v2_IOMMU : VFIO_TYPE1_IOMMU;
> -        ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> -        if (ret) {
> -            error_setg_errno(errp, errno, "failed to set iommu for container");
> -            ret = -errno;
>              goto free_container_exit;
>          }
>  
> @@ -1137,31 +1188,21 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          }
>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
>          container->pgsizes = info.iova_pgsizes;
> -    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
> -               ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
> +        break;
> +    }
> +    case VFIO_SPAPR_TCE_v2_IOMMU:
> +    case VFIO_SPAPR_TCE_IOMMU:
> +    {
>          struct vfio_iommu_spapr_tce_info info;
> -        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU);
> +        bool v2;
>  
> -        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> +        ret = vfio_init_container(container, group->fd, iommu_type, errp);
>          if (ret) {
> -            error_setg_errno(errp, errno, "failed to set group container");
> -            ret = -errno;
> -            goto free_container_exit;
> -        }
> -        container->iommu_type =
> -            v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
> -        ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> -        if (ret) {
> -            container->iommu_type = VFIO_SPAPR_TCE_IOMMU;
> -            v2 = false;
> -            ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> -        }
> -        if (ret) {
> -            error_setg_errno(errp, errno, "failed to set iommu for container");
> -            ret = -errno;
>              goto free_container_exit;
>          }
>  
> +        v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
> +
>          /*
>           * The host kernel code implementing VFIO_IOMMU_DISABLE is called
>           * when container fd is closed so we do not call it explicitly
> @@ -1222,10 +1263,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                info.dma32_window_size - 1,
>                                0x1000);
>          }
> -    } else {
> -        error_setg(errp, "No available IOMMU models");
> -        ret = -EINVAL;
> -        goto free_container_exit;
> +    }
>      }
>  
>      vfio_kvm_device_add_group(group);
> 

-- 
Alexey
