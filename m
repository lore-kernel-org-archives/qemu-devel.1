Received: from eggs.gnu.org ([2001:4830:134:3::10]:41082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evn7W-0003hK-A7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evn7R-0001cW-Fi
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:49:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37440 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evn7R-0001cK-7b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:49:45 -0400
Date: Tue, 13 Mar 2018 18:49:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180313183558-mutt-send-email-mst@kernel.org>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520426065-40265-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Wed, Mar 07, 2018 at 08:34:24PM +0800, Wei Wang wrote:
> The new feature enables the virtio-balloon device to receive hints of
> guest free pages from the free page vq.
> 
> balloon_free_page_start - start guest free page hint reporting.
> balloon_free_page_stop - stop guest free page hint reporting.
> 
> Note: balloon will report pages which were free at the time
> of this call. As the reporting happens asynchronously, dirty bit logging
> must be enabled before this call is made. Guest reporting must be
> disabled before the migration dirty bitmap is synchronized.

Add this usage documentation in code as well, not just
in the commit log.

Another limitation seems to be that machine needs
to be running. I think ideally you should not teach callers
about this limitation though.

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>

I find it suspicious that neither unrealize nor reset
functions have been touched at all.
Are you sure you have thought through scenarious like
hot-unplug or disabling the device by guest?
  
> ---
>  balloon.c                                       |  49 +++++--
>  hw/virtio/virtio-balloon.c                      | 183 +++++++++++++++++++++---
>  include/hw/virtio/virtio-balloon.h              |  15 +-
>  include/standard-headers/linux/virtio_balloon.h |   7 +
>  include/sysemu/balloon.h                        |  15 +-
>  5 files changed, 240 insertions(+), 29 deletions(-)
> 
> diff --git a/balloon.c b/balloon.c
> index d8dd6fe..b0b0749 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -36,6 +36,9 @@
>  
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
> +static QEMUBalloonFreePageSupport *balloon_free_page_support_fn;
> +static QEMUBalloonFreePageStart *balloon_free_page_start_fn;
> +static QEMUBalloonFreePageStop *balloon_free_page_stop_fn;
>  static void *balloon_opaque;
>  static bool balloon_inhibited;
>  
> @@ -64,19 +67,42 @@ static bool have_balloon(Error **errp)
>      return true;
>  }
>  
> -int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> -                             QEMUBalloonStatus *stat_func, void *opaque)
> +bool balloon_free_page_support(void)
>  {
> -    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
> -        /* We're already registered one balloon handler.  How many can
> -         * a guest really have?
> -         */
> -        return -1;
> +    return balloon_free_page_support_fn &&
> +           balloon_free_page_support_fn(balloon_opaque);
> +}
> +
> +void balloon_free_page_start(void)
> +{
> +    balloon_free_page_start_fn(balloon_opaque);
> +}
> +
> +void balloon_free_page_stop(void)
> +{
> +    balloon_free_page_stop_fn(balloon_opaque);
> +}
> +
> +void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
> +                              QEMUBalloonStatus *stat_fn,
> +                              QEMUBalloonFreePageSupport *free_page_support_fn,
> +                              QEMUBalloonFreePageStart *free_page_start_fn,
> +                              QEMUBalloonFreePageStop *free_page_stop_fn,
> +                              void *opaque)
> +{
> +    if (balloon_event_fn || balloon_stat_fn || balloon_free_page_support_fn ||
> +        balloon_free_page_start_fn || balloon_free_page_stop_fn ||
> +        balloon_opaque) {
> +        /* We already registered one balloon handler. */
> +        return;
>      }
> -    balloon_event_fn = event_func;
> -    balloon_stat_fn = stat_func;
> +
> +    balloon_event_fn = event_fn;
> +    balloon_stat_fn = stat_fn;
> +    balloon_free_page_support_fn = free_page_support_fn;
> +    balloon_free_page_start_fn = free_page_start_fn;
> +    balloon_free_page_stop_fn = free_page_stop_fn;
>      balloon_opaque = opaque;
> -    return 0;
>  }
>  
>  void qemu_remove_balloon_handler(void *opaque)
> @@ -86,6 +112,9 @@ void qemu_remove_balloon_handler(void *opaque)
>      }
>      balloon_event_fn = NULL;
>      balloon_stat_fn = NULL;
> +    balloon_free_page_support_fn = NULL;
> +    balloon_free_page_start_fn = NULL;
> +    balloon_free_page_stop_fn = NULL;
>      balloon_opaque = NULL;
>  }
>  
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 4822449..48ed2ec 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -31,6 +31,7 @@
>  
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> +#include "migration/misc.h"
>  
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>  
> @@ -308,6 +309,111 @@ out:
>      }
>  }
>  
> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
> +{
> +    VirtQueueElement *elem;
> +    VirtIOBalloon *dev = opaque;
> +    VirtQueue *vq = dev->free_page_vq;
> +    uint32_t id;
> +    size_t size;

What makes it safe to poke at this device from multiple threads?
I think that it would be safer to do it from e.g. BH.

> +
> +    /*
> +     * Poll the vq till the status changed to STOP. This happens when
> +     * the guest finishes reporting hints or the migration thread actively
> +     * stops the reporting.
> +     */
> +    while (dev->free_page_report_status < FREE_PAGE_REPORT_S_STOP) {
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            continue;
> +        }
> +
> +        if (elem->out_num) {
> +            size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
> +            virtqueue_push(vq, elem, size);
> +            g_free(elem);
> +            if (unlikely(size != sizeof(id))) {
> +                warn_report("%s: received an incorrect cmd id", __func__);
> +                break;
> +            }
> +            if (id == dev->free_page_report_cmd_id) {
> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
> +            } else if (dev->free_page_report_status ==
> +                       FREE_PAGE_REPORT_S_START) {
> +                /*
> +                 * Stop the optimization only when it has started. This avoids
> +                 * obsolete stop sign for the previous command.

obsolete -> a stale

> +                 */
> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> +                break;
> +            }
> +        }
> +
> +        if (elem->in_num) {
> +            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
> +                !dev->poison_val) {
> +                qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
> +                                          elem->in_sg[0].iov_len);
> +            }
> +            virtqueue_push(vq, elem, 0);
> +            g_free(elem);
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static bool virtio_balloon_free_page_support(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +}
> +
> +static void virtio_balloon_free_page_start(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    if (unlikely(s->free_page_report_cmd_id == UINT_MAX)) {
> +        s->free_page_report_cmd_id =
> +                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> +    } else {
> +        s->free_page_report_cmd_id++;
> +    }
> +
> +    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
> +    virtio_notify_config(vdev);
> +    qemu_thread_create(&s->free_page_thread, "free_page_optimization_thread",
> +                       virtio_balloon_poll_free_page_hints, s,
> +                       QEMU_THREAD_JOINABLE);
> +}
> +
> +static void virtio_balloon_free_page_stop(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    switch (s->free_page_report_status) {
> +    case FREE_PAGE_REPORT_S_REQUESTED:
> +    case FREE_PAGE_REPORT_S_START:
> +        /*
> +         * The guest hasn't done the reporting, so host sends a notification
> +         * to the guest to actively stop the reporting before joining the
> +         * optimization thread.
> +         */
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> +        virtio_notify_config(vdev);
> +    case FREE_PAGE_REPORT_S_STOP:
> +        /* The guest has stopped the reporting. Join the optimization thread */
> +        qemu_thread_join(&s->free_page_thread);
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_EXIT;
> +    case FREE_PAGE_REPORT_S_EXIT:
> +        /* The optimization thread has gone. No actions needded so far. */
> +        break;
> +    }
> +}
> +
>  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  {
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> @@ -315,6 +421,15 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
> +    config.poison_val = cpu_to_le32(dev->poison_val);
> +
> +    if (dev->free_page_report_status >= FREE_PAGE_REPORT_S_STOP) {
> +        config.free_page_report_cmd_id =
> +                       cpu_to_le32(VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
> +    } else {
> +        config.free_page_report_cmd_id =
> +                       cpu_to_le32(dev->free_page_report_cmd_id);
> +    }
>  
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
>      memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> @@ -368,6 +483,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
>                          &error_abort);
>      }
> +    dev->poison_val = le32_to_cpu(config.poison_val);
>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>  }
>  
> @@ -377,6 +493,11 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>      f |= dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +
> +    if (dev->host_features & 1ULL << VIRTIO_BALLOON_F_FREE_PAGE_HINT) {
> +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> +    }
> +
>      return f;
>  }
>  
> @@ -413,6 +534,18 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
>      return 0;
>  }
>  
> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> +    .name = "virtio-balloon-device/free-page-report",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_balloon_free_page_support,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_balloon_device = {
>      .name = "virtio-balloon-device",
>      .version_id = 1,
> @@ -423,30 +556,30 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>          VMSTATE_UINT32(actual, VirtIOBalloon),
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_virtio_balloon_free_page_report,
> +        NULL
> +    }
>  };
>  
>  static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIOBalloon *s = VIRTIO_BALLOON(dev);
> -    int ret;
>  
>      virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
>                  sizeof(struct virtio_balloon_config));
>  
> -    ret = qemu_add_balloon_handler(virtio_balloon_to_target,
> -                                   virtio_balloon_stat, s);
> -
> -    if (ret < 0) {
> -        error_setg(errp, "Only one balloon device is supported");
> -        virtio_cleanup(vdev);
> -        return;
> -    }
> -
>      s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> -
> +    if (virtio_has_feature(s->host_features,
> +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_EXIT;
> +        s->free_page_report_cmd_id =
> +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
> +    }
>      reset_stats(s);
>  }
>
> @@ -475,11 +608,27 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
>  
> -    if (!s->stats_vq_elem && vdev->vm_running &&
> -        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
> -        /* poll stats queue for the element we have discarded when the VM
> -         * was stopped */
> -        virtio_balloon_receive_stats(vdev, s->svq);
> +    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +        if (!s->stats_vq_elem && vdev->vm_running &&
> +            virtqueue_rewind(s->svq, 1)) {
> +            /*
> +             * Poll stats queue for the element we have discarded when the VM
> +             * was stopped.
> +             */
> +            virtio_balloon_receive_stats(vdev, s->svq);
> +        }
> +
> +        if (virtio_balloon_free_page_support(s)) {
> +            qemu_add_balloon_handler(virtio_balloon_to_target,
> +                                     virtio_balloon_stat,
> +                                     virtio_balloon_free_page_support,
> +                                     virtio_balloon_free_page_start,
> +                                     virtio_balloon_free_page_stop,
> +                                     s);
> +        } else {
> +            qemu_add_balloon_handler(virtio_balloon_to_target,
> +                                     virtio_balloon_stat, NULL, NULL, NULL, s);
> +        }
>      }
>  }
>  
> @@ -509,6 +658,8 @@ static const VMStateDescription vmstate_virtio_balloon = {
>  static Property virtio_balloon_properties[] = {
>      DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> +    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 1ea13bd..12fde2f 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -23,6 +23,8 @@
>  #define VIRTIO_BALLOON(obj) \
>          OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
>  
> +#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
> +
>  typedef struct virtio_balloon_stat VirtIOBalloonStat;
>  
>  typedef struct virtio_balloon_stat_modern {
> @@ -31,15 +33,26 @@ typedef struct virtio_balloon_stat_modern {
>         uint64_t val;
>  } VirtIOBalloonStatModern;
>  
> +enum virtio_balloon_free_page_report_status {
> +    FREE_PAGE_REPORT_S_REQUESTED,
> +    FREE_PAGE_REPORT_S_START,
> +    FREE_PAGE_REPORT_S_STOP,
> +    FREE_PAGE_REPORT_S_EXIT,
> +};
> +
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> +    uint32_t free_page_report_cmd_id;
> +    uint32_t poison_val;
>      uint64_t stats[VIRTIO_BALLOON_S_NR];
>      VirtQueueElement *stats_vq_elem;
>      size_t stats_vq_offset;
>      QEMUTimer *stats_timer;
> +    QemuThread free_page_thread;
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
>      uint32_t host_features;
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index 7b0a41b..f89e80f 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -34,15 +34,22 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_FREE_PAGE_HINT 3 /* VQ to report free pages */
> +#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
>  
> +#define VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID 0
>  struct virtio_balloon_config {
>  	/* Number of pages host wants Guest to give up. */
>  	uint32_t num_pages;
>  	/* Number of pages we've actually got in balloon. */
>  	uint32_t actual;
> +	/* Free page report command id, readonly by guest */
> +	uint32_t free_page_report_cmd_id;
> +	/* Stores PAGE_POISON if page poisoning is in use */
> +	uint32_t poison_val;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
> index af49e19..16a2aae 100644
> --- a/include/sysemu/balloon.h
> +++ b/include/sysemu/balloon.h
> @@ -18,11 +18,22 @@
>  
>  typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
>  typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
> +typedef bool (QEMUBalloonFreePageSupport)(void *opaque);
> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
> +typedef void (QEMUBalloonFreePageStop)(void *opaque);
>  
> -int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> -			     QEMUBalloonStatus *stat_func, void *opaque);
>  void qemu_remove_balloon_handler(void *opaque);
>  bool qemu_balloon_is_inhibited(void);
>  void qemu_balloon_inhibit(bool state);
> +bool balloon_free_page_support(void);
> +void balloon_free_page_start(void);
> +void balloon_free_page_stop(void);
> +
> +void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
> +                              QEMUBalloonStatus *stat_fn,
> +                              QEMUBalloonFreePageSupport *free_page_support_fn,
> +                              QEMUBalloonFreePageStart *free_page_start_fn,
> +                              QEMUBalloonFreePageStop *free_page_stop_fn,
> +                              void *opaque);
>  
>  #endif
> -- 
> 1.8.3.1
