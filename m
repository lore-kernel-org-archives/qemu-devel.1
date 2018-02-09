Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ekAwi-00005t-CI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ekAwh-00076s-8i
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:50:40 -0500
Date: Fri, 9 Feb 2018 08:50:24 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180209085024.004b6f9e@w520.home>
In-Reply-To: <1518189456-2873-5-git-send-email-geert+renesas@glider.be>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
	<1518189456-2873-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] vfio: No-IOMMU mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org

On Fri,  9 Feb 2018 16:17:35 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> Add qemu support for the newly introduced VFIO No-IOMMU driver.
> 
> We need to add special handling for:
> - Group character device is /dev/vfio/noiommu-$GROUP.
> - No-IOMMU does not rely on a memory listener.
> - No IOMMU will be set for its group, so no need to call
>   vfio_kvm_device_add_group.
> 
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> [geert: Rebase]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  hw/vfio/common.c              | 61 ++++++++++++++++++++++++++++++++++---------
>  include/hw/vfio/vfio-common.h |  2 ++
>  2 files changed, 50 insertions(+), 13 deletions(-)

NAK.  I'm opposed to no-iommu support in QEMU in general, but accepting
vfio devices with no-iommu (which provide no DMA translation!!!)
transparently as if they might actually work like a regular vfio device
is absolutely unacceptable.  Without DMA translation and isolation, you
might want to think about another interface, I'm not keen on the idea
of corrupting vfio support in order to blink some LEDs.  Thanks,

Alex

> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f895e3c3359af779..2ee94a3304202a74 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1019,6 +1019,33 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->fd = fd;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
> +    container->noiommu = group->noiommu;
> +
> +    if (container->noiommu) {
> +        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> +        if (ret) {
> +            error_report("vfio: failed to set group container: %m");
> +            ret = -errno;
> +            goto free_container_exit;
> +        }
> +
> +        ret = ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_NOIOMMU_IOMMU);
> +        if (!ret) {
> +            error_report("vfio: No available IOMMU models");
> +            ret = -EINVAL;
> +            goto free_container_exit;
> +        }
> +
> +        ret = ioctl(fd, VFIO_SET_IOMMU, VFIO_NOIOMMU_IOMMU);
> +        if (ret) {
> +            error_report("vfio: failed to set iommu for container: %m");
> +            ret = -errno;
> +            goto free_container_exit;
> +        }
> +
> +        goto listener_register;
> +    }
> +
>      if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
>          ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
>          bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> @@ -1151,15 +1178,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      group->container = container;
>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>  
> -    container->listener = vfio_memory_listener;
> -
> -    memory_listener_register(&container->listener, container->space->as);
> -
> -    if (container->error) {
> -        ret = container->error;
> -        error_setg_errno(errp, -ret,
> -                         "memory listener initialization failed for container");
> -        goto listener_release_exit;
> +listener_register:
> +    if (!container->noiommu) {
> +        container->listener = vfio_memory_listener;
> +        memory_listener_register(&container->listener, container->space->as);
> +        if (container->error) {
> +            ret = container->error;
> +            error_setg_errno(errp, -ret,
> +                    "memory listener initialization failed for container");
> +            goto listener_release_exit;
> +        }
>      }
>  
>      container->initialized = true;
> @@ -1169,7 +1197,9 @@ listener_release_exit:
>      QLIST_REMOVE(group, container_next);
>      QLIST_REMOVE(container, next);
>      vfio_kvm_device_del_group(group);
> -    vfio_listener_release(container);
> +    if (!container->noiommu) {
> +        vfio_listener_release(container);
> +    }
>  
>  free_container_exit:
>      g_free(container);
> @@ -1195,7 +1225,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       * since unset may destroy the backend container if it's the last
>       * group.
>       */
> -    if (QLIST_EMPTY(&container->group_list)) {
> +    if (QLIST_EMPTY(&container->group_list) && !container->noiommu) {
>          vfio_listener_release(container);
>      }
>  
> @@ -1249,8 +1279,13 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>      snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>      group->fd = qemu_open(path, O_RDWR);
>      if (group->fd < 0) {
> -        error_setg_errno(errp, errno, "failed to open %s", path);
> -        goto free_group_exit;
> +        snprintf(path, sizeof(path), "/dev/vfio/noiommu-%d", groupid);
> +        group->fd = qemu_open(path, O_RDWR);
> +        if (group->fd < 0) {
> +            error_setg_errno(errp, errno, "failed to open %s", path);
> +            goto free_group_exit;
> +        }
> +        group->noiommu = 1;
>      }
>  
>      if (ioctl(group->fd, VFIO_GROUP_GET_STATUS, &status)) {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9fee02066f..aca2e33efb9b118c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -77,6 +77,7 @@ struct VFIOGroup;
>  typedef struct VFIOContainer {
>      VFIOAddressSpace *space;
>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> +    bool noiommu;
>      MemoryListener listener;
>      MemoryListener prereg_listener;
>      unsigned iommu_type;
> @@ -136,6 +137,7 @@ struct VFIODeviceOps {
>  typedef struct VFIOGroup {
>      int fd;
>      int groupid;
> +    bool noiommu;
>      VFIOContainer *container;
>      QLIST_HEAD(, VFIODevice) device_list;
>      QLIST_ENTRY(VFIOGroup) next;
