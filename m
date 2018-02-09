Received: from eggs.gnu.org ([2001:4830:134:3::10]:47404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekAuP-0006Eq-CY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekAuO-000573-Fs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:48:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180209152412.23626-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b0c7678-21b1-562e-5315-f6a761f21237@amsat.org>
Date: Fri, 9 Feb 2018 12:48:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180209152412.23626-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/nvme: fix Coverity reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com

On 02/09/2018 12:24 PM, Paolo Bonzini wrote:
> 1) string not null terminated in sysfs_find_group_file

CID 1385854

> 
> 2) NULL pointer dereference and dead local variable in nvme_init.

CID 1385855

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nvme.c        | 14 ++++++--------
>  util/vfio-helpers.c |  2 +-
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index e9d0e218fc..ce217ffc81 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -553,7 +553,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      uint64_t cap;
>      uint64_t timeout_ms;
>      uint64_t deadline, now;
> -    Error *local_err = NULL;
>  
>      qemu_co_mutex_init(&s->dma_map_lock);
>      qemu_co_queue_init(&s->dma_flush_queue);
> @@ -645,11 +644,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>                             false, nvme_handle_event, nvme_poll_cb);
>  
>      nvme_identify(bs, namespace, errp);

The problem seems local_err is not used as nvme_identify() argument;
however this big function uses both errp and local_err so maybe clean it
to keep one style is better.

Isn't local_err + error_propagate() the cleaner way?

> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        ret = -EIO;
> -        goto fail_handler;
> -    }
>  
>      /* Set up command queues. */
>      if (!nvme_add_io_queue(bs, errp)) {
> @@ -665,8 +659,12 @@ fail_queue:
>      nvme_free_queue_pair(bs, s->queues[0]);
>  fail:
>      g_free(s->queues);
> -    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> -    qemu_vfio_close(s->vfio);
> +    if (s->regs) {
> +        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> +    }
> +    if (s->vfio) {
> +        qemu_vfio_close(s->vfio);
> +    }
>      event_notifier_cleanup(&s->irq_notifier);
>      return ret;
>  }
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index f478b68400..006674c916 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -104,7 +104,7 @@ static char *sysfs_find_group_file(const char *device, Error **errp)
>      char *path = NULL;
>  
>      sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group", device);
> -    sysfs_group = g_malloc(PATH_MAX);
> +    sysfs_group = g_malloc0(PATH_MAX);

This looks odd... When can sysfs_group not be null-terminated?
Since we have strlen(sysfs_link) > 0, readlink() can not return 0.

Maybe this is enough to silent coverity:

    if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) <= 0) {

>      if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) == -1) {
>          error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
>          goto out;
> 
