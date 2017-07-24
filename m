Received: from eggs.gnu.org ([2001:4830:134:3::10]:36661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZhD1-0003xu-3p
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZhCw-000550-8v
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dZhCw-00054O-01
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:31:50 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-16-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <63adbf82-7833-1a53-9784-642c961499b2@redhat.com>
Date: Mon, 24 Jul 2017 19:31:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-16-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 15/29] vhost+postcopy: Send address back to
 qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

<snip\>

> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1f70f5760f..6be3e7ff2d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -19,6 +19,7 @@
>   #include "qemu/sockets.h"
>   #include "migration/migration.h"
>   #include "migration/postcopy-ram.h"
> +#include "trace.h"
>   
>   #include <sys/ioctl.h>
>   #include <sys/socket.h>
> @@ -131,6 +132,7 @@ struct vhost_user {
>       int slave_fd;
>       NotifierWithReturn postcopy_notifier;
>       struct PostCopyFD  postcopy_fd;
> +    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
>   };
>   
>   static bool ioeventfd_enabled(void)
> @@ -298,6 +300,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>   static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
> +    struct vhost_user *u = dev->opaque;
>       int fds[VHOST_MEMORY_MAX_NREGIONS];
>       int i, fd;
>       size_t fd_num = 0;
> @@ -348,6 +351,57 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>           return -1;
>       }
>   
> +    if (u->postcopy_fd.handler) {
> +        VhostUserMsg msg_reply;
> +        int region_i, reply_i;
> +        if (vhost_user_read(dev, &msg_reply) < 0) {
> +            return -1;
> +        }
> +
> +        if (msg_reply.request != VHOST_USER_SET_MEM_TABLE) {
> +            error_report("%s: Received unexpected msg type."
> +                         "Expected %d received %d", __func__,
> +                         VHOST_USER_SET_MEM_TABLE, msg_reply.request);
> +            return -1;
> +        }
> +        /* We're using the same structure, just reusing one of the
> +         * fields, so it should be the same size.
> +         */
> +        if (msg_reply.size != msg.size) {
> +            error_report("%s: Unexpected size for postcopy reply "
> +                         "%d vs %d", __func__, msg_reply.size, msg.size);
> +            return -1;
> +        }
> +
> +        memset(u->postcopy_client_bases, 0,
> +               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +
> +        /* They're in the same order as the regions that were sent
> +         * but some of the regions were skipped (above) if they
> +         * didn't have fd's
> +        */
> +        for (reply_i = 0, region_i = 0;
> +             region_i < dev->mem->nregions;
> +             region_i++) {
> +            if (reply_i < fd_num &&
> +                msg_reply.payload.memory.regions[region_i].guest_phys_addr ==
> +                dev->mem->regions[region_i].guest_phys_addr) {
> +                u->postcopy_client_bases[region_i] =
> +                    msg_reply.payload.memory.regions[reply_i].userspace_addr;
> +                trace_vhost_user_set_mem_table_postcopy(
> +                    msg_reply.payload.memory.regions[reply_i].userspace_addr,
> +                    msg.payload.memory.regions[reply_i].userspace_addr,
> +                    reply_i, region_i);
> +                reply_i++;
> +            }
> +        }
> +        if (reply_i != fd_num) {
> +            error_report("%s: postcopy reply not fully consumed "
> +                         "%d vs %zd",
> +                         __func__, reply_i, fd_num);
> +            return -1;
> +        }
> +    }
>       if (reply_supported) {
>           return process_message_reply(dev, &msg);
>       }
> 

If the backend supports reply-ack feature, the VHOST_USER_F_NEED_REPLY
flag is set to the message earlier in this function.

In this case, when postcopy is also enabled, it means that for this
request, to replies will have to be send by the backend.

Maybe it would be better not to set the VHOST_USER_F_NEED_REPLY in this
specific case? Of course, it should be documented in the spec.
