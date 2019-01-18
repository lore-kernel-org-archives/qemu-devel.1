Received: from eggs.gnu.org ([209.51.188.92]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkQIx-0000Lq-6b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkQIw-0006Vb-50
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:19:11 -0500
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkQIv-0006P7-S7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:19:10 -0500
Received: from player776.ha.ovh.net (unknown [10.109.146.106])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 04DC41CB6D3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:19:05 +0100 (CET)
Date: Fri, 18 Jan 2019 10:18:59 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190118101859.246e2e2f@bahia.lan>
In-Reply-To: <20190118085525.24542-1-eric.auger@redhat.com>
References: <20190118085525.24542-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru

On Fri, 18 Jan 2019 09:55:25 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> In vfio_connect_container() the code that selects the
> iommu type can benefit from helpers such as
> vfio_iommu_get_type() and vfio_init_container(). As
> a result we end up with a switch/case on the iommu type
> that makes the code a little bit more readable and ready
> for addition of new iommu types. Also ioctl's get called
> once per iommu_type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 

LGTM, just a minor comment below.

> ---
> 
> v2 -> v3:
> - fix ret/errno
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
> index 4262b80c44..2e6d5a84b0 100644
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
> +        error_setg_errno(errp, errno, "failed to set group container");
> +        return -errno;
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
> +        error_setg_errno(errp, errno, "failed to set iommu for container");
> +        return -errno;
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

Since vfio_iommu_get_type() seems to return a negative errno on
error, ret could maybe be set to iommu_type. No big deal though
so:

Reviewed-by: Greg Kurz <groug@kaod.org>


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
