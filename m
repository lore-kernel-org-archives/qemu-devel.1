Received: from eggs.gnu.org ([2001:4830:134:3::10]:52004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erh0B-0001HD-Fe
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erh06-000090-Dm
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:28100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1erh05-00007A-Tu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:14 -0500
Message-ID: <5A991A17.9070704@intel.com>
Date: Fri, 02 Mar 2018 17:32:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-2-git-send-email-wei.w.wang@intel.com>
	<20180207020743-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207020743-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 02/07/2018 09:04 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2018 at 07:08:17PM +0800, Wei Wang wrote:
>> The new feature enables the virtio-balloon device to receive the hint of
>> guest free pages from the free page vq, and clears the corresponding bits
>> of the free page from the dirty bitmap, so that those free pages are not
>> transferred by the migration thread.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> ---
>>   balloon.c                                       |  39 +++++--
>>   hw/virtio/virtio-balloon.c                      | 145 +++++++++++++++++++++---
>>   include/hw/virtio/virtio-balloon.h              |  11 +-
>>   include/migration/misc.h                        |   3 +
>>   include/standard-headers/linux/virtio_balloon.h |   7 ++
>>   include/sysemu/balloon.h                        |  12 +-
>>   migration/ram.c                                 |  10 ++
>>   7 files changed, 198 insertions(+), 29 deletions(-)
>>
>> diff --git a/balloon.c b/balloon.c
>> index 1d720ff..0f0b30c 100644
>> --- a/balloon.c
>> +++ b/balloon.c
>> @@ -36,6 +36,8 @@
>>   
>>   static QEMUBalloonEvent *balloon_event_fn;
>>   static QEMUBalloonStatus *balloon_stat_fn;
>> +static QEMUBalloonFreePageSupport *balloon_free_page_support_fn;
>> +static QEMUBalloonFreePagePoll *balloon_free_page_poll_fn;
>>   static void *balloon_opaque;
>>   static bool balloon_inhibited;
>>   
>> @@ -64,19 +66,34 @@ static bool have_balloon(Error **errp)
>>       return true;
>>   }
>>   
>> -int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
>> -                             QEMUBalloonStatus *stat_func, void *opaque)
>> +bool balloon_free_page_support(void)
>>   {
>> -    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
>> -        /* We're already registered one balloon handler.  How many can
>> -         * a guest really have?
>> -         */
>> -        return -1;
>> +    return balloon_free_page_support_fn &&
>> +           balloon_free_page_support_fn(balloon_opaque);
>> +}
>> +
>> +void balloon_free_page_poll(void)
>> +{
>> +    balloon_free_page_poll_fn(balloon_opaque);
>> +}
>> +
>> +void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
>> +                              QEMUBalloonStatus *stat_fn,
>> +                              QEMUBalloonFreePageSupport *free_page_support_fn,
>> +                              QEMUBalloonFreePagePoll *free_page_poll_fn,
>> +                              void *opaque)
>> +{
>> +    if (balloon_event_fn || balloon_stat_fn || balloon_free_page_support_fn ||
>> +        balloon_free_page_poll_fn || balloon_opaque) {
>> +        /* We already registered one balloon handler. */
>> +        return;
>>       }
>> -    balloon_event_fn = event_func;
>> -    balloon_stat_fn = stat_func;
>> +
>> +    balloon_event_fn = event_fn;
>> +    balloon_stat_fn = stat_fn;
>> +    balloon_free_page_support_fn = free_page_support_fn;
>> +    balloon_free_page_poll_fn = free_page_poll_fn;
>>       balloon_opaque = opaque;
>> -    return 0;
>>   }
>>   
>>   void qemu_remove_balloon_handler(void *opaque)
>> @@ -86,6 +103,8 @@ void qemu_remove_balloon_handler(void *opaque)
>>       }
>>       balloon_event_fn = NULL;
>>       balloon_stat_fn = NULL;
>> +    balloon_free_page_support_fn = NULL;
>> +    balloon_free_page_poll_fn = NULL;
>>       balloon_opaque = NULL;
>>   }
>>   
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 14e08d2..b424d4e 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -23,6 +23,7 @@
>>   #include "hw/virtio/virtio-balloon.h"
>>   #include "sysemu/kvm.h"
>>   #include "exec/address-spaces.h"
>> +#include "exec/ram_addr.h"
>>   #include "qapi/visitor.h"
>>   #include "qapi-event.h"
>>   #include "trace.h"
>> @@ -30,6 +31,7 @@
>>   
>>   #include "hw/virtio/virtio-bus.h"
>>   #include "hw/virtio/virtio-access.h"
>> +#include "migration/misc.h"
>>   
>>   #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>>   
>> @@ -305,6 +307,87 @@ out:
>>       }
>>   }
>>   
>> +static void virtio_balloon_poll_free_page_hints(VirtIOBalloon *dev)
>> +{
>> +    VirtQueueElement *elem;
>> +    VirtQueue *vq = dev->free_page_vq;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    bool page_poisoning = virtio_vdev_has_feature(vdev,
>> +                                              VIRTIO_BALLOON_F_PAGE_POISON);
>> +    uint32_t id;
>> +
>> +    /* Poll the vq till a stop cmd id is received */
>> +    while (dev->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
>> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>> +        if (!elem) {
>> +            continue;
>> +        }
>> +
>> +        if (elem->out_num) {
>> +            iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(uint32_t));
>> +            virtqueue_push(vq, elem, sizeof(id));
>> +            g_free(elem);
>> +            if (id == dev->free_page_report_cmd_id) {
>> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>> +            } else {
>> +                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>
> So if migration on source times out, then you migrate to
> another destination, this will cancel the in-progress reporting
> due to while loop above.  Probably not what was intended.
>
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (elem->in_num) {
>> +            RAMBlock *block;
>> +            ram_addr_t offset;
>> +            void *base;
>> +            size_t total_len, len;
>> +
>> +            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START &&
>> +                !page_poisoning) {
> So when poisoning is enabled, you can't skip the pages?
>
> I suspect if poison is 0 you actually can.
>
>
>
>> +                base = elem->in_sg[0].iov_base;
>> +                total_len = elem->in_sg[0].iov_len;
>> +                len = total_len;
> the below list looks like it'd be a better API.
> How about an API that just gives hints to qemu?
> qemu_guest_page_free_hint(start, len)?
>
>> +                while (total_len > 0) {
>> +                    block = qemu_ram_block_from_host(base, false, &offset);
>> +                    if (unlikely(offset + total_len > block->used_length)) {
>> +                        len = block->used_length - offset;
>> +                        base += len;
>> +                    }
>> +                    skip_free_pages_from_dirty_bitmap(block, offset, len);
> For post-copy migration, this does not look like it will DTRT.
>
> Doesn't look like it will DTRT for tcg either.
>
> And generally, this only works as long as you don't call log_sync.
>
> Once you call log_sync, you can't rely on old hints, and you must increment
> command id.
>
> which isn't a good API, in my opinion.
>
>> +                    total_len -= len;
>> +                }
>> +            }
>> +            virtqueue_push(vq, elem, total_len);
>> +            g_free(elem);
>> +        }
>> +    }
>> +}
>> +
>> +static bool virtio_balloon_free_page_support(void *opaque)
>> +{
>> +    VirtIOBalloon *s = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>> +
>> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>> +}
>> +
>> +static void virtio_balloon_free_page_poll(void *opaque)
>> +{
>> +    VirtIOBalloon *s = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>> +
>> +    if (unlikely(s->free_page_report_cmd_id == UINT_MAX)) {
>> +        s->free_page_report_cmd_id = 1;
>> +    } else {
>> +        s->free_page_report_cmd_id++;
>> +    }
> I think it is prudent to reserve a range of command IDs that we don't use.
> These can then be used later for more commands.
>
> E.g. how about VIRTIO_BALLOON_FREE_PAGE_REPORT_MIN_ID 0x80000000
> and let the ID go between 0x80000000 and UINT_MAX?
>
> No guest changes needed, but patching uapi in linux to add the enum
> might not be a bad idea.
>
>
>> +
>> +    virtio_notify_config(vdev);
>> +    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
>> +
>> +    virtio_balloon_poll_free_page_hints(s);
>> +}
>> +
>>   static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>   {
>>       VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>> @@ -312,6 +395,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>   
>>       config.num_pages = cpu_to_le32(dev->num_pages);
>>       config.actual = cpu_to_le32(dev->actual);
>> +    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
>>   
>>       trace_virtio_balloon_get_config(config.num_pages, config.actual);
>>       memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> You need to set config.poison_val as well.
>
>> @@ -365,6 +449,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>>                           ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
>>                           &error_abort);
>>       }
>> +    dev->poison_val = le32_to_cpu(config.poison_val);
> This will have to be migrated.
>
>
>>       trace_virtio_balloon_set_config(dev->actual, oldactual);
>>   }
>>   
>> @@ -374,6 +459,7 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
>>       VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>>       f |= dev->host_features;
>>       virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
>> +    virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> Needs a compat property to avoid breaking cross-version migration.
>
>>       return f;
>>   }
>>   
>> @@ -410,6 +496,17 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
>>       return 0;
>>   }
>>   
>> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>> +    .name = "virtio-balloon-device/free-page-report",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = virtio_balloon_free_page_support,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static const VMStateDescription vmstate_virtio_balloon_device = {
>>       .name = "virtio-balloon-device",
>>       .version_id = 1,
>> @@ -420,30 +517,29 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>>           VMSTATE_UINT32(actual, VirtIOBalloon),
>>           VMSTATE_END_OF_LIST()
>>       },
>> +    .subsections = (const VMStateDescription * []) {
>> +        &vmstate_virtio_balloon_free_page_report,
>> +        NULL
>> +    }
>>   };
>>   
>>   static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VirtIOBalloon *s = VIRTIO_BALLOON(dev);
>> -    int ret;
>>   
>>       virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
>>                   sizeof(struct virtio_balloon_config));
>>   
>> -    ret = qemu_add_balloon_handler(virtio_balloon_to_target,
>> -                                   virtio_balloon_stat, s);
>> -
>> -    if (ret < 0) {
>> -        error_setg(errp, "Only one balloon device is supported");
>> -        virtio_cleanup(vdev);
>> -        return;
>> -    }
>> -
>>       s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>>       s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>>       s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>> -
>> +    if (virtio_has_feature(s->host_features,
>> +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
>> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>> +        s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
>> +    }
>>       reset_stats(s);
>>   }
>>   
>> @@ -472,11 +568,26 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
>>   {
>>       VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
>>   
>> -    if (!s->stats_vq_elem && vdev->vm_running &&
>> -        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->svq, 1)) {
>> -        /* poll stats queue for the element we have discarded when the VM
>> -         * was stopped */
>> -        virtio_balloon_receive_stats(vdev, s->svq);
>> +    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>> +        if (!s->stats_vq_elem && vdev->vm_running &&
>> +            virtqueue_rewind(s->svq, 1)) {
>> +            /*
>> +             * Poll stats queue for the element we have discarded when the VM
>> +             * was stopped.
>> +             */
>> +            virtio_balloon_receive_stats(vdev, s->svq);
>> +        }
>> +
>> +        if (virtio_balloon_free_page_support(s)) {
>> +            qemu_add_balloon_handler(virtio_balloon_to_target,
>> +                                     virtio_balloon_stat,
>> +                                     virtio_balloon_free_page_support,
>> +                                     virtio_balloon_free_page_poll,
>> +                                     s);
>> +        } else {
>> +            qemu_add_balloon_handler(virtio_balloon_to_target,
>> +                                     virtio_balloon_stat, NULL, NULL, s);
>> +        }
>>       }
>>   }
>>   
>> @@ -506,6 +617,8 @@ static const VMStateDescription vmstate_virtio_balloon = {
>>   static Property virtio_balloon_properties[] = {
>>       DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
>>                       VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>> +    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>> +                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
>> index 1ea13bd..11b4e01 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -31,11 +31,20 @@ typedef struct virtio_balloon_stat_modern {
>>          uint64_t val;
>>   } VirtIOBalloonStatModern;
>>   
>> +enum virtio_balloon_free_page_report_status {
>> +    FREE_PAGE_REPORT_S_REQUESTED,
>> +    FREE_PAGE_REPORT_S_START,
>> +    FREE_PAGE_REPORT_S_STOP,
>> +};
>> +
>>   typedef struct VirtIOBalloon {
>>       VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>> +    uint32_t free_page_report_status;
>>       uint32_t num_pages;
>>       uint32_t actual;
>> +    uint32_t free_page_report_cmd_id;
>> +    uint32_t poison_val;
>>       uint64_t stats[VIRTIO_BALLOON_S_NR];
>>       VirtQueueElement *stats_vq_elem;
>>       size_t stats_vq_offset;
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 77fd4f5..6df419c 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -14,11 +14,14 @@
>>   #ifndef MIGRATION_MISC_H
>>   #define MIGRATION_MISC_H
>>   
>> +#include "exec/cpu-common.h"
>>   #include "qemu/notify.h"
>>   
>>   /* migration/ram.c */
>>   
>>   void ram_mig_init(void);
>> +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
>> +                                       size_t len);
>>   
>>   /* migration/block.c */
>>   
>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
>> index 9d06ccd..19d0d8b 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -34,15 +34,22 @@
>>   #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>>   #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>>   #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>> +#define VIRTIO_BALLOON_F_FREE_PAGE_HINT 3 /* VQ to report free pages */
>> +#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>>   
>>   /* Size of a PFN in the balloon interface. */
>>   #define VIRTIO_BALLOON_PFN_SHIFT 12
>>   
>> +#define VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID 0
>>   struct virtio_balloon_config {
>>   	/* Number of pages host wants Guest to give up. */
>>   	uint32_t num_pages;
>>   	/* Number of pages we've actually got in balloon. */
>>   	uint32_t actual;
>> +	/* Free page report command id, readonly by guest */
>> +	uint32_t free_page_report_cmd_id;
>> +	/* Stores PAGE_POISON if page poisoning is in use */
>> +	uint32_t poison_val;
>>   };
>>   
>>   #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
>> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
>> index af49e19..53db4dc 100644
>> --- a/include/sysemu/balloon.h
>> +++ b/include/sysemu/balloon.h
>> @@ -18,11 +18,19 @@
>>   
>>   typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
>>   typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
>> +typedef bool (QEMUBalloonFreePageSupport)(void *opaque);
>> +typedef void (QEMUBalloonFreePagePoll)(void *opaque);
>>   
>> -int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
>> -			     QEMUBalloonStatus *stat_func, void *opaque);
>>   void qemu_remove_balloon_handler(void *opaque);
>>   bool qemu_balloon_is_inhibited(void);
>>   void qemu_balloon_inhibit(bool state);
>> +bool balloon_free_page_support(void);
>> +void balloon_free_page_poll(void);
>> +
>> +void qemu_add_balloon_handler(QEMUBalloonEvent *event_fn,
>> +                              QEMUBalloonStatus *stat_fn,
>> +                              QEMUBalloonFreePageSupport *free_page_support_fn,
>> +                              QEMUBalloonFreePagePoll *free_page_poll_fn,
>> +                              void *opaque);
>>   
>>   #endif
>> diff --git a/migration/ram.c b/migration/ram.c
>> index cb1950f..d6f462c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2186,6 +2186,16 @@ static int ram_init_all(RAMState **rsp)
>>       return 0;
>>   }
>>   
>> +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
>> +                                       size_t len)
>> +{
>> +    long start = offset >> TARGET_PAGE_BITS,
>> +         nr = len >> TARGET_PAGE_BITS;
> start is the length calculated from length?
> What does this mean?
>
> I suspect a typo, and this makes me doubt this was tested
> under any kind of stress. When poking at the migration
> stream, you can't just test with a completely idle guest.
>
> After having reviewed 26 versions of the guest support code,
> I admit to a bit of a burnout. How about you work harder
> on isolating migration bits from virtio bits, then get
> migration core devs review these migration parts of
> the patchset?
>
>
>> +
>> +    bitmap_clear(block->bmap, start, nr);
>> +    ram_state->migration_dirty_pages -= nr;
>> +}
>> +
>>   /*
>>    * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>>    * long-running RCU critical section.  When rcu-reclaims in the code
>> -- 
>> 1.8.3.1

Thanks Michael and Dave for the comments. I've made changes based on the 
comments above. Please have a check of the v3 patches that were just 
posted out. Test results based on the latest implementation have also 
been added at the cover letter there.

Best,
Wei
