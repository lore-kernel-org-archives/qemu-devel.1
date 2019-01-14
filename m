Received: from eggs.gnu.org ([209.51.188.92]:59931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1givnp-0007X4-Au
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1givnn-0008Be-9y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:32:52 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1givnm-0008BG-Rl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:32:51 -0500
Received: by mail-pf1-x443.google.com with SMTP id q1so9873027pfi.5
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 22:32:50 -0800 (PST)
References: <20190111164503.14796-1-eric.auger@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <249c40ab-da9e-b626-37cf-a55dad02b820@ozlabs.ru>
Date: Mon, 14 Jan 2019 17:32:44 +1100
MIME-Version: 1.0
In-Reply-To: <20190111164503.14796-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio/common: Refactor container
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



On 12/01/2019 03:45, Eric Auger wrote:
> In vfio_connect_container() the code that selects the
> iommu type can benefit from helpers such as
> vfio_iommu_get_type() and vfio_init_container(). As
> a result we end up with a switch/case on the iommu type
> that makes the code a little bit more readable and ready
> for addition of new iommu types. Also ioctl's get called
> once per iommu_type.


ioctl(VFIO_SET_IOMMU) is called twice for a reason - on sPAPR, the IOMMU
subdriver is always capable of v1 and v2 but the running platform is not
- powernv supports v2, pseries does not but there is no way telling this
until an IOMMU group is added to a container. So the existing code tries
v2, if that fails, it tries v1:
https://git.qemu.org/?p=qemu.git;a=commitdiff;h=c6e7958eb76ed267f7



> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> ---
> 
> v2 -> v3:
> - originally submitted in [RFC v2 00/28] vSMMUv3/pSMMUv3
>   2 stage VFIO integration
> - remove "nested only is selected if requested by @force_nested"
> - added Greg's R-b
> ---
>  hw/vfio/common.c | 101 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 64 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c185e5a2e..8535bfe66f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1036,12 +1036,57 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
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
> +        error_setg_errno(errp, errno, "failed to set group container");
> +        return -errno;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_SET_IOMMU, iommu_type);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "failed to set iommu for container");
> +        return -errno;
> +    }
> +    container->iommu_type = iommu_type;
> +    return 0;
> +}
> +
>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                    Error **errp)
>  {
>      VFIOContainer *container;
>      int ret, fd;
>      VFIOAddressSpace *space;
> +    int iommu_type;
> +    bool v2 = false;
> +
>  
>      space = vfio_get_address_space(as);
>  
> @@ -1101,23 +1146,20 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->fd = fd;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
> -    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
> -        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> -        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> +
> +    iommu_type = vfio_iommu_get_type(container, errp);
> +    if (iommu_type < 0) {
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
> @@ -1137,28 +1179,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          }
>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
>          container->pgsizes = info.iova_pgsizes;
> -    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
> -               ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
> +        break;
> +    }
> +    case VFIO_SPAPR_TCE_v2_IOMMU:
> +        v2 = true;
> +    case VFIO_SPAPR_TCE_IOMMU:
> +    {
>          struct vfio_iommu_spapr_tce_info info;
> -        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU);
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
> @@ -1222,10 +1252,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
