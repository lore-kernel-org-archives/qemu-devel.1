Received: from eggs.gnu.org ([2001:4830:134:3::10]:54117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gEbMx-0001B4-RK
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gEbMt-0005Ho-QR
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:39:47 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:41802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gEbMt-000552-HP
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:39:43 -0400
Received: from player711.ha.ovh.net (unknown [10.109.143.109])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 39C8137516
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:39:36 +0200 (CEST)
Date: Mon, 22 Oct 2018 16:39:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181022163923.35ad7a4e@bahia.lan>
In-Reply-To: <20180921081819.9203-8-eric.auger@redhat.com>
References: <20180921081819.9203-1-eric.auger@redhat.com>
	<20180921081819.9203-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 07/28] hw/vfio/common: Refactor container
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
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, yi.l.liu@intel.com, cdall@kernel.org, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, alex.williamson@redhat.com

On Fri, 21 Sep 2018 10:17:58 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> To prepare for testing yet another extension, let's
> refactor the code. We introduce vfio_iommu_get_type()
> helper which selects the richest API (v2 first). Then
> vfio_init_container() does the SET_CONTAINER and
> SET_IOMMU ioctl calls. So we end up with a switch/case
> on the iommu_type which should be a little bit more readable
> when introducing the NESTING extension check. Also ioctl's
> get called once per iommu_type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/common.c | 102 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c185e5a2e..53b8f773cc 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1036,12 +1036,58 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>      }
>  }
>  
> +/*
> + * vfio_iommu_get_type - selects the richest iommu_type (v2 first)
> + * nested only is selected if requested by @force_nested

It seems the second line belongs to patch 8.

Appart from that, this definitely makes the code more readable.

Reviewed-by: Greg Kurz <groug@kaod.org>

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
> @@ -1101,23 +1147,20 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
> @@ -1137,28 +1180,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
> @@ -1222,10 +1253,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
