Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek7af-0002bP-HS
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek7aa-0005RR-6y
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ek7aZ-0005R1-SF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:36 -0500
Date: Fri, 9 Feb 2018 12:15:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180209121517.GD2428@work-vm>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio-balloon: add a timer to
 limit the free page report waiting time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> This patch adds a timer to limit the time that host waits for the free
> page hints reported by the guest. Users can specify the time in ms via
> "free-page-wait-time" command line option. If a user doesn't specify a
> time, host waits till the guest finishes reporting all the free page
> hints. The policy (wait for all the free page hints to be reported or
> use a time limit) is determined by the orchestration layer.

That's kind of a get-out; but there's at least two problems:
   a) With a timeout of 0 (the default) we might hang forever waiting
      for the guest; broken guests are just too common, we can't do
      that.
   b) Even if we were going to do that, you'd have to make sure that
      migrate_cancel provided a way out.
   c) How does that work during a savevm snapshot or when the guest is
      stopped?
   d) OK, the timer gives us some safety (except c); but how does the
      orchestration layer ever come up with a 'safe' value for it?
      Unless we can suggest a safe value that the orchestration layer
      can use, or a way they can work it out, then they just wont use
      it.

Dave


> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c         | 84 +++++++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-pci.c             |  3 ++
>  include/hw/virtio/virtio-balloon.h |  4 ++
>  3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index b424d4e..9ee0de4 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -207,6 +207,65 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>  
> +static void balloon_free_page_change_timer(VirtIOBalloon *s, int64_t ms)
> +{
> +    timer_mod(s->free_page_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + ms);
> +}
> +
> +static void balloon_stop_free_page_report(void *opaque)
> +{
> +    VirtIOBalloon *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    timer_del(dev->free_page_timer);
> +    timer_free(dev->free_page_timer);
> +    dev->free_page_timer = NULL;
> +
> +    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
> +        dev->host_stop_free_page = true;
> +        virtio_notify_config(vdev);
> +    }
> +}
> +
> +static void balloon_free_page_get_wait_time(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    VirtIOBalloon *s = opaque;
> +
> +    visit_type_int(v, name, &s->free_page_wait_time, errp);
> +}
> +
> +static void balloon_free_page_set_wait_time(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    VirtIOBalloon *s = opaque;
> +    Error *local_err = NULL;
> +    int64_t value;
> +
> +    visit_type_int(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    if (value < 0) {
> +        error_setg(errp, "free page wait time must be greater than zero");
> +        return;
> +    }
> +
> +    if (value > UINT32_MAX) {
> +        error_setg(errp, "free page wait time value is too big");
> +        return;
> +    }
> +
> +    s->free_page_wait_time = value;
> +    g_assert(s->free_page_timer == NULL);
> +    s->free_page_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                      balloon_stop_free_page_report, s);
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -330,6 +389,7 @@ static void virtio_balloon_poll_free_page_hints(VirtIOBalloon *dev)
>              if (id == dev->free_page_report_cmd_id) {
>                  dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>              } else {
> +                dev->host_stop_free_page = false;
>                  dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>                  break;
>              }
> @@ -385,6 +445,10 @@ static void virtio_balloon_free_page_poll(void *opaque)
>      virtio_notify_config(vdev);
>      s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
>  
> +    if (s->free_page_wait_time) {
> +        balloon_free_page_change_timer(s, s->free_page_wait_time);
> +    }
> +
>      virtio_balloon_poll_free_page_hints(s);
>  }
>  
> @@ -395,7 +459,19 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
> -    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
> +    if (dev->host_stop_free_page) {
> +        /*
> +         * Host is actively requesting to stop the free page reporting, send
> +         * the stop sign to the guest. This happens when the migration thread
> +         * has reached the phase to send pages to the destination while the
> +         * guest hasn't done the reporting.
> +         */
> +        config.free_page_report_cmd_id =
> +                                    VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
> +    } else {
> +        config.free_page_report_cmd_id =
> +                                    cpu_to_le32(dev->free_page_report_cmd_id);
> +    }
>  
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
>      memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> @@ -539,6 +615,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
>          s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>          s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
> +        s->host_stop_free_page = false;
>      }
>      reset_stats(s);
>  }
> @@ -602,6 +679,11 @@ static void virtio_balloon_instance_init(Object *obj)
>                          balloon_stats_get_poll_interval,
>                          balloon_stats_set_poll_interval,
>                          NULL, s, NULL);
> +
> +    object_property_add(obj, "free-page-wait-time", "int",
> +                        balloon_free_page_get_wait_time,
> +                        balloon_free_page_set_wait_time,
> +                        NULL, s, NULL);
>  }
>  
>  static const VMStateDescription vmstate_virtio_balloon = {
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 6c75cca..3345104 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2250,6 +2250,9 @@ static void virtio_balloon_pci_instance_init(Object *obj)
>      object_property_add_alias(obj, "guest-stats-polling-interval",
>                                OBJECT(&dev->vdev),
>                                "guest-stats-polling-interval", &error_abort);
> +    object_property_add_alias(obj, "free-page-wait-time",
> +                              OBJECT(&dev->vdev),
> +                              "free-page-wait-time", &error_abort);
>  }
>  
>  static const TypeInfo virtio_balloon_pci_info = {
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 11b4e01..c16855b 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -40,6 +40,8 @@ enum virtio_balloon_free_page_report_status {
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
>      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    /* Host is requesting the guest to stop free page reporting */
> +    bool host_stop_free_page;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> @@ -49,8 +51,10 @@ typedef struct VirtIOBalloon {
>      VirtQueueElement *stats_vq_elem;
>      size_t stats_vq_offset;
>      QEMUTimer *stats_timer;
> +    QEMUTimer *free_page_timer;
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
> +    int64_t free_page_wait_time;
>      uint32_t host_features;
>  } VirtIOBalloon;
>  
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
