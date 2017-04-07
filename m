Received: from eggs.gnu.org ([2001:4830:134:3::10]:54881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwW6K-00064K-5Q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwW6F-0000b2-FJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwW6F-0000aq-6z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:46:59 -0400
Date: Fri, 7 Apr 2017 16:46:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407154650.GN2138@work-vm>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-2-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487734936-43472-2-git-send-email-zhang.zhanghailiang@huawei.com>
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
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> We will use this notifier to help COLO to notify filter object
> to do something, like do checkpoint, or process failover event.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  net/colo.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/colo.h | 18 ++++++++++++
>  2 files changed, 110 insertions(+)
> 

<..>

> +FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
                          ^^^^^^^^^ Typo - no*i*tifier

(I've not looked at this patch much, I'll leave networking stuff to Jason)

Dave

> +                    void *opaque, Error **errp)
> +{
> +    FilterNotifier *notify;
> +    int ret;
> +
> +    notify = (FilterNotifier *)g_source_new(&notifier_source_funcs,
> +                sizeof(FilterNotifier));
> +    ret = event_notifier_init(&notify->event, false);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to initialize event notifier");
> +        goto fail;
> +    }
> +    notify->pfd.fd = event_notifier_get_fd(&notify->event);
> +    notify->pfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> +    notify->cb = cb;
> +    notify->opaque = opaque;
> +    g_source_add_poll(&notify->source, &notify->pfd);
> +
> +    return notify;
> +
> +fail:
> +    g_source_destroy(&notify->source);
> +    return NULL;
> +}
> +
> +int filter_notifier_set(FilterNotifier *notify, uint64_t value)
> +{
> +    ssize_t ret;
> +
> +    do {
> +        ret = write(notify->event.wfd, &value, sizeof(value));
> +    } while (ret < 0 && errno == EINTR);
> +
> +    /* EAGAIN is fine, a read must be pending.  */
> +    if (ret < 0 && errno != EAGAIN) {
> +        return -errno;
> +    }
> +    return 0;
> +}
> diff --git a/net/colo.h b/net/colo.h
> index cd9027f..00f03b5 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -19,6 +19,7 @@
>  #include "qemu/jhash.h"
>  #include "qemu/timer.h"
>  #include "slirp/tcp.h"
> +#include "qemu/event_notifier.h"
>  
>  #define HASHTABLE_MAX_SIZE 16384
>  
> @@ -89,4 +90,21 @@ void connection_hashtable_reset(GHashTable *connection_track_table);
>  Packet *packet_new(const void *data, int size);
>  void packet_destroy(void *opaque, void *user_data);
>  
> +typedef void FilterNotifierCallback(void *opaque, int value);
> +typedef struct FilterNotifier {
> +    GSource source;
> +    EventNotifier event;
> +    GPollFD pfd;
> +    FilterNotifierCallback *cb;
> +    void *opaque;
> +} FilterNotifier;
> +
> +FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
> +                    void *opaque, Error **errp);
> +int filter_notifier_set(FilterNotifier *notify, uint64_t value);
> +
> +enum {
> +    COLO_CHECKPOINT = 2,
> +    COLO_FAILOVER,
> +};
>  #endif /* QEMU_COLO_PROXY_H */
> -- 
> 1.8.3.1
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
