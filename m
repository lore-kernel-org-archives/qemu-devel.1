Received: from eggs.gnu.org ([209.51.188.92]:56286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmLbg-0000dN-Ot
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmLba-0001HD-Jl
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:42:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gmLbS-00010p-Ba
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:42:15 -0500
Date: Wed, 23 Jan 2019 09:41:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190123094159.115ee4dd@w520.home>
In-Reply-To: <20190123154035.29425-1-eric.auger@redhat.com>
References: <20190123154035.29425-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/vfio/common: Refactor container
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
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, aik@ozlabs.ru, groug@kaod.org

On Wed, 23 Jan 2019 16:40:35 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> We introduce the vfio_init_container_type() helper.
> It computes the highest usable iommu type and then
> set the container and the iommu type.
> 
> Its usage in vfio_connect_container() makes the code
> ready for addition of new iommu types.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - Take into account Alex' suggestions. Only exception is
>   I kept v2 bool.
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
>  hw/vfio/common.c | 117 +++++++++++++++++++++++++++++------------------
>  1 file changed, 72 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4262b80c44..eb209c776c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1036,6 +1036,61 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>      }
>  }
>  
> +/*
> + * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
> + */
> +static int vfio_get_iommu_type(VFIOContainer *container,
> +                               Error **errp)
> +{
> +    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> +                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
> +    int fd = container->fd;
> +    int i;

nit, do we really need an fd variable since it's only used once now?

> +
> +    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
> +        if (ioctl(fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
> +            return iommu_types[i];
> +        }
> +    }
> +    error_setg(errp, "No available IOMMU models");
> +    return -EINVAL;
> +}
> +
> +static int vfio_init_container_type(VFIOContainer *container, int group_fd,
> +                                    Error **errp)

Sorry, I was a bit unclear with the suggestion of this function name, I
meant to suggest this would have been a slightly more descriptive name
for the previous version which had an iommu_type parameter.  As the
function now determines the type itself, the original name of simply
vfio_init_container() looks correct.  Looks good otherwise.  Thanks,

Alex

> +{
> +    int iommu_type, ret;
> +
> +    iommu_type = vfio_get_iommu_type(container, errp);
> +    if (iommu_type < 0) {
> +        return iommu_type;
> +    }
> +
> +    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to set group container");
> +        return -errno;
> +    }
> +
> +    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
> +        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> +            /*
> +             * On sPAPR, despite the IOMMU subdriver always advertises v1 and
> +             * v2, the running platform may not support v2 and there is no
> +             * way to guess it until an IOMMU group gets added to the container.
> +             * So in case it fails with v2, try v1 as a fallback.
> +             */
> +            iommu_type = VFIO_SPAPR_TCE_IOMMU;
> +            continue;
> +        }
> +        error_setg_errno(errp, errno, "Failed to set iommu for container");
> +        return -errno;
> +    }
> +
> +    container->iommu_type = iommu_type;
> +    return 0;
> +}
> +
>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                    Error **errp)
>  {
> @@ -1101,26 +1156,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->fd = fd;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
> -    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
> -        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> -        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> +
> +    ret = vfio_init_container_type(container, group->fd, errp);
> +    if (ret) {
> +        goto free_container_exit;
> +    }
> +
> +    switch (container->iommu_type) {
> +    case VFIO_TYPE1v2_IOMMU:
> +    case VFIO_TYPE1_IOMMU:
> +    {
>          struct vfio_iommu_type1_info info;
>  
> -        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> -        if (ret) {
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
> -            goto free_container_exit;
> -        }
> -
>          /*
>           * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
>           * IOVA whatsoever.  That's not actually true, but the current
> @@ -1137,30 +1184,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
> -
> -        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> -        if (ret) {
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
> -            goto free_container_exit;
> -        }
> +        bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>  
>          /*
>           * The host kernel code implementing VFIO_IOMMU_DISABLE is called
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
