Received: from eggs.gnu.org ([2001:4830:134:3::10]:33934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTj5-0004Kw-KT
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTj2-0007bK-Ge
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:27:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3415
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTj1-0007VI-OV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:27:00 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170407154650.GN2138@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58EB338C.5040801@huawei.com>
Date: Mon, 10 Apr 2017 15:26:04 +0800
MIME-Version: 1.0
In-Reply-To: <20170407154650.GN2138@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] net/colo: Add notifier/callback
 related helpers for filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>

On 2017/4/7 23:46, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> We will use this notifier to help COLO to notify filter object
>> to do something, like do checkpoint, or process failover event.
>>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>   net/colo.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/colo.h | 18 ++++++++++++
>>   2 files changed, 110 insertions(+)
>>
> <..>
>
>> +FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
>                            ^^^^^^^^^ Typo - no*i*tifier

Good catch, will fix it in next version.

> (I've not looked at this patch much, I'll leave networking stuff to Jason)

OK, thanks.

> Dave
>
>> +                    void *opaque, Error **errp)
>> +{
>> +    FilterNotifier *notify;
>> +    int ret;
>> +
>> +    notify = (FilterNotifier *)g_source_new(&notifier_source_funcs,
>> +                sizeof(FilterNotifier));
>> +    ret = event_notifier_init(&notify->event, false);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Failed to initialize event notifier");
>> +        goto fail;
>> +    }
>> +    notify->pfd.fd = event_notifier_get_fd(&notify->event);
>> +    notify->pfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
>> +    notify->cb = cb;
>> +    notify->opaque = opaque;
>> +    g_source_add_poll(&notify->source, &notify->pfd);
>> +
>> +    return notify;
>> +
>> +fail:
>> +    g_source_destroy(&notify->source);
>> +    return NULL;
>> +}
>> +
>> +int filter_notifier_set(FilterNotifier *notify, uint64_t value)
>> +{
>> +    ssize_t ret;
>> +
>> +    do {
>> +        ret = write(notify->event.wfd, &value, sizeof(value));
>> +    } while (ret < 0 && errno == EINTR);
>> +
>> +    /* EAGAIN is fine, a read must be pending.  */
>> +    if (ret < 0 && errno != EAGAIN) {
>> +        return -errno;
>> +    }
>> +    return 0;
>> +}
>> diff --git a/net/colo.h b/net/colo.h
>> index cd9027f..00f03b5 100644
>> --- a/net/colo.h
>> +++ b/net/colo.h
>> @@ -19,6 +19,7 @@
>>   #include "qemu/jhash.h"
>>   #include "qemu/timer.h"
>>   #include "slirp/tcp.h"
>> +#include "qemu/event_notifier.h"
>>   
>>   #define HASHTABLE_MAX_SIZE 16384
>>   
>> @@ -89,4 +90,21 @@ void connection_hashtable_reset(GHashTable *connection_track_table);
>>   Packet *packet_new(const void *data, int size);
>>   void packet_destroy(void *opaque, void *user_data);
>>   
>> +typedef void FilterNotifierCallback(void *opaque, int value);
>> +typedef struct FilterNotifier {
>> +    GSource source;
>> +    EventNotifier event;
>> +    GPollFD pfd;
>> +    FilterNotifierCallback *cb;
>> +    void *opaque;
>> +} FilterNotifier;
>> +
>> +FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
>> +                    void *opaque, Error **errp);
>> +int filter_notifier_set(FilterNotifier *notify, uint64_t value);
>> +
>> +enum {
>> +    COLO_CHECKPOINT = 2,
>> +    COLO_FAILOVER,
>> +};
>>   #endif /* QEMU_COLO_PROXY_H */
>> -- 
>> 1.8.3.1
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
