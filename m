Received: from eggs.gnu.org ([2001:4830:134:3::10]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSAK-0004Jh-RV
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSAF-0006C0-R2
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:43:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQSAF-0006Bf-Jn
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:43:23 -0400
Date: Wed, 6 Jun 2018 14:43:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180606064315.GB7815@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:

[...]

> +static void virtio_balloon_poll_free_page_hints(void *opaque)
> +{
> +    VirtQueueElement *elem;
> +    VirtIOBalloon *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtQueue *vq = dev->free_page_vq;
> +    uint32_t id;
> +    size_t size;
> +
> +    while (1) {
> +        qemu_mutex_lock(&dev->free_page_lock);
> +        while (dev->block_iothread) {
> +            qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
> +        }
> +
> +        /*
> +         * If the migration thread actively stops the reporting, exit
> +         * immediately.
> +         */
> +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
> +            qemu_mutex_unlock(&dev->free_page_lock);
> +            break;
> +        }
> +
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            qemu_mutex_unlock(&dev->free_page_lock);
> +            continue;
> +        }
> +
> +        if (elem->out_num) {
> +            size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
> +            virtqueue_push(vq, elem, size);

Silly question: is this sending the same id back to guest?  Why?

> +            g_free(elem);
> +
> +            virtio_tswap32s(vdev, &id);
> +            if (unlikely(size != sizeof(id))) {
> +                virtio_error(vdev, "received an incorrect cmd id");

Forgot to unlock?

Maybe we can just move the lock operations outside:

  mutex_lock();
  while (1) {
    ...
    if (block) {
      qemu_cond_wait();
    }
    ...
    if (skip) {
      continue;
    }
    ...
    if (error) {
      break;
    }
    ...
  }
  mutex_unlock();

> +                break;
> +            }
> +            if (id == dev->free_page_report_cmd_id) {
> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
> +            } else {
> +                /*
> +                 * Stop the optimization only when it has started. This
> +                 * avoids a stale stop sign for the previous command.
> +                 */
> +                if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
> +                    dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> +                    qemu_mutex_unlock(&dev->free_page_lock);
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (elem->in_num) {
> +            /* TODO: send the poison value to the destination */
> +            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
> +                !dev->poison_val) {
> +                qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
> +                                          elem->in_sg[0].iov_len);
> +            }
> +            virtqueue_push(vq, elem, 0);
> +            g_free(elem);
> +        }
> +        qemu_mutex_unlock(&dev->free_page_lock);
> +    }
> +    virtio_notify(vdev, vq);
> +}

[...]

> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> +    .name = "virtio-balloon-device/free-page-report",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_balloon_free_page_support,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),

(could we move all the poison-related lines into another patch or
 postpone?  after all we don't support it yet, do we?)

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_balloon_device = {
>      .name = "virtio-balloon-device",
>      .version_id = 1,
> @@ -423,30 +572,42 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
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
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> +        s->free_page_report_cmd_id =
> +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;

Why explicitly -1?  I thought ID_MIN would be fine too?

> +        if (s->iothread) {
> +            object_ref(OBJECT(s->iothread));
> +            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
> +                                       virtio_balloon_poll_free_page_hints, s);

Just to mention that now we can create internal iothreads.  Please
have a look at iothread_create().

> +            qemu_mutex_init(&s->free_page_lock);
> +            qemu_cond_init(&s->free_page_cond);
> +            s->block_iothread = false;
> +        } else {
> +            /* Simply disable this feature if the iothread wasn't created. */
> +            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +            virtio_error(vdev, "iothread is missing");
> +        }
> +    }
>      reset_stats(s);
>  }

Regards,

-- 
Peter Xu
