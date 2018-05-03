Received: from eggs.gnu.org ([2001:4830:134:3::10]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE6I5-0000Of-Ps
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE6I2-0007lI-MY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:56:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE6I2-0007l0-GP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 00:56:22 -0400
Date: Thu, 3 May 2018 12:56:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503045603.GG8239@xz-mi>
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164346.28940.93328.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501164346.28940.93328.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vfio/quirks: Enable ioeventfd
 quirks to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, eric.auger@redhat.com

On Tue, May 01, 2018 at 10:43:46AM -0600, Alex Williamson wrote:

[...]

> -static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> +static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
>  {
>      QLIST_REMOVE(ioeventfd, next);
> +
>      memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
>                                ioeventfd->match_data, ioeventfd->data,
>                                &ioeventfd->e);
> -    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
> +
> +    if (ioeventfd->vfio) {
> +        struct vfio_device_ioeventfd vfio_ioeventfd;
> +
> +        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
> +        vfio_ioeventfd.flags = ioeventfd->size;
> +        vfio_ioeventfd.data = ioeventfd->data;
> +        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
> +                                ioeventfd->region_addr;
> +        vfio_ioeventfd.fd = -1;
> +
> +        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);

(If the series is going to respin, I am thinking whether it would
 worth it to capture this error to dump something.  But it's for sure
 optional since even error happened we should have something in dmesg
 so it only matters on whether we also want something to be dumped
 from QEMU side too... After all there aren't much we can do)

> +
> +    } else {
> +        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> +                            NULL, NULL, NULL);
> +    }
> +
>      event_notifier_cleanup(&ioeventfd->e);
>      trace_vfio_ioeventfd_exit(memory_region_name(ioeventfd->mr),
>                                (uint64_t)ioeventfd->addr, ioeventfd->size,

[...]

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ba1239551115..84e27c7bb2d1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3177,6 +3177,8 @@ static Property vfio_pci_dev_properties[] = {
>                       no_geforce_quirks, false),
>      DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>                       false),
> +    DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
> +                     false),

Here it looks more like a tri-state for me, so we can either:

- disable the acceleration in general, or
- enable QEMU-side acceleration only, or
- enable kernel-side acceleration

In other words, IIUC x-no-vfio-ioeventfd won't matter much if
x-no-kvm-ioeventfd is already set.  So not sure whether a single
parameter would be nicer.

Anyway, I'm even fine with two-parameter way, so I'll leave the
decision to Alex and other reviewers:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
