Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E7C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842B62168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZEnzcni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842B62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2RLm-0007jn-M2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 22:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j2RKr-00074x-0x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j2RKn-0006p1-2C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:08:08 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j2RKm-0006hV-HR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:08:05 -0500
Received: by mail-lf1-x141.google.com with SMTP id m30so5740054lfp.8
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 19:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AXHLR2ax7RgHzYSjPbrDZV8eh/F2S5UJD/RWqeJPZ4U=;
 b=pZEnzcnis6IyUSb5i5wLyvxwWhK5G1T8U1nqyVhYhnpQzlavLwIgSFKGtrP487XSn6
 tm4RDl1koxtZCETYejsHsemC7E/sDwEr0J9dY7n2o5UVK8dVhOd7+gM1MC7cQ+edL/mn
 97ObrzMxX0wS5jJR/GolRxsRsvy8ewMyr8qjK7vjrqoRK7wFe/ysYMwcekjh3fEullY6
 TVzRy55fDpsCflZXfNv73E6Jzr3G5hDXsb+sihXOzfJ/vszifI7EnXIEv1PYB/rbPm72
 DTUFUl7fNhFZH1xr/9AwTPRdY0DdovalKKsW8epE0dqN9jNisvQLFzaTibplu7D3Xp5C
 HfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AXHLR2ax7RgHzYSjPbrDZV8eh/F2S5UJD/RWqeJPZ4U=;
 b=hCg4i/O3jFTb93N8qyk3/OdOAAaxkZBXH5dBktqN4eBcAb3tz+l9fkjsR5gvYCJjpB
 SA/IHqL3wCmmRsijVho3usnu3W/GYOK4/wz008mRnqdjc6xwJGPHaxUOhRzdOjdpr3xw
 W4BnkL3H0O/8E+ItsYeNbsYbeQKr1Uw5SbYX97uGxBXLfR7yUMVkTz4vpLVJ+CCNjc9I
 mMqPcJ5Q/erhyK5PSOtAFI1Ywi+pMVAHeGn52AI+xIHeHvHWa4gtZIb1l55Zc3m1KSbL
 fNnt1Fv6Hff4jAFPdsZ/NCiHIS9Y8UrqGuJojVOyN10BCRt+HIkNxgY1e978Aruvjryz
 KzKw==
X-Gm-Message-State: APjAAAWCfxPduDGNciMmP6RpaWpxiFvzciItkmaW9OHkvLLIyFe7V7rd
 HFDE4quCLFndZXrP16q0qm+QtTBikZXAht7Rdu4=
X-Google-Smtp-Source: APXvYqzOfUgu4DuiiX4fglXOMDjNKAX769OGPbPB2xG7H7Yvx6BuhZI1eUuChi2BtlQ9QRhhnF1tE+6rz/5fLQl8RRY=
X-Received: by 2002:a19:748:: with SMTP id 69mr537445lfh.40.1581649680801;
 Thu, 13 Feb 2020 19:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-2-coiby.xu@gmail.com>
 <20200116135122.GI163546@stefanha-x1.localdomain>
In-Reply-To: <20200116135122.GI163546@stefanha-x1.localdomain>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Fri, 14 Feb 2020 11:07:23 +0800
Message-ID: <CAJAkqrXtOkonPaAOzT_OdOYZdyyYdA8RY6=ZQxy4Fw-YhYtkcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vhost-user block device backend
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for reviewing this patch! I'm already posted v3 based on
your feedback.

> > +#include "hw/qdev-properties.h"
> > +enum {
> > +    VHOST_USER_BLK_MAX_QUEUES = 8,
> > +};

> The number of queues is hardcoded to 1 so this constant can be removed
for now.

> > +
> > +static QTAILQ_HEAD(, VubDev) vub_devs = QTAILQ_HEAD_INITIALIZER(vub_devs);

> I'm not sure if this list will be necessary.  See my comments about
> replacing the "name" property with Object's built-in "id" property.

There is no need to start vhost-user-blk-server with the same exported
drive since vhost-user-blk-server can serve multiple clients
simutanously. And we shoudn't started two vhost-user-blk-servers with
the same unix socket path. So we need this list to avoid dupliate
servers. And as pointed out by Kevin, "name" property actually means
node-name which is used in v3.


> > +#include "hw/qdev-properties.h"
> > +enum {
> > +    VHOST_USER_BLK_MAX_QUEUES = 8,
> > +};

> The number of queues is hardcoded to 1 so this constant can be removed
for now.

I've set VHOST_USER_BLK_MAX_QUEUES = 1 in v3 to avoid magic number.

> > +    config->seg_max = 128 - 2;

> This is okay for now but should be changed in the future.

> hw/block/virtio-blk.c was recently modified to calculate seg_max based
> on the virtqueue size (which is where the hardcoded 128 originally came
> from).  Applications that use large buffer sizes (128+ KB) benefit from
> larger virtqueue sizes and seg_max.

I've looked at the implementation of "-device
vhost-user-blk-pci,queue-size=512" regarding seg_max and found out
vhost-user-blk-server doesn' have the chance to caculate seg_max based
on the virtqueue size and report it back to QEMU as vhost-user client
in time.

QEMU as vhost-user client will create virtqueues with the size of
queue-size parameter. Later it will get the configureation including
seg_max from vhost-user-blk-server by sending VHOST_USER_SET_CONFIG
message and this seg_max vallue will be sent to guest OS.  Guest OS
will set the real size of virtqueue which will be sent to
vhost-user-blk-server through VHOST_USER_SET_VRING_NUM message. After
that QEMU as vhost-user client will never send VHOST_USER_SET_CONFIG
again.

There could be three ways to address this issue,
1. Add seg_max_adjust and queue-size object property for
vhost-user-blk device in a way similar to virtio-blk device. And QEMU
as vhost-user client will ignore seg_max parameter from
vhost-user-blk-server. It will caculate seg_max based on queue-size
and report it to guest OS.
2. Add seg_max_adjust and queue-size object property for
vhost-user-blk server and let  vhost-user-blk server calculate seg_max
based on queue-size
3. Let QEMU as vhost-user client tell vhost-user-blk-server its queue
size by sending VHOST_USER_SET_VRING_NUM message first. When
vhost-user-blk-server receive the VHOST_USER_SET_CONFIG message, it
will calculate seg_max and report it back to QEMU as vhost-user
client.

Which way do you is the best?


> > +void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> > +                gpointer opaque)
> > +{
> > +    VuClient *client;
> > +    VubDev *vub_device = opaque;
> > +    client = g_new0(VuClient, 1);

> Is it helpful to have a separate VuClient struct even though only a
> single vhost-user client can be connected at a time?  It may be simpler
> to keep connection state directly in VubDev.

Currently, I don't use chardev as an object property of
vhost-user-blk-server. So actually multiple clients can be connected
simutaneously.

All the other suggestions have been adopted in v3. Thank you for your advice!


On Thu, Jan 16, 2020 at 9:51 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jan 14, 2020 at 10:06:16PM +0800, Coiby Xu wrote:
> > By making use of libvhost, multiple block device drives can be exported and each drive can serve multiple clients simultaneously. Since vhost-user-server needs a block drive to be created first, delay the creation of this object.
> >
> > Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> > ---
> >  blockdev-vu.c              | 1008 ++++++++++++++++++++++++++++++++++++
>
> This file contains both vhost-user-blk code and generic vhost-user
> protocol code.  Please split them into two files:
> 1. backends/vhost-user-blk-server.c
> 2. util/vhost-user-server.c
>
> (As I read and understand the code better I may have better suggestions
> about where to put these source files and how to name them.)
>
> >  include/block/vhost-user.h |   46 ++
> >  vl.c                       |    4 +
> >  3 files changed, 1058 insertions(+)
> >  create mode 100644 blockdev-vu.c
> >  create mode 100644 include/block/vhost-user.h
> >
> > diff --git a/blockdev-vu.c b/blockdev-vu.c
> > new file mode 100644
> > index 0000000000..45f0bb43a7
> > --- /dev/null
> > +++ b/blockdev-vu.c
> > @@ -0,0 +1,1008 @@
> > +#include "qemu/osdep.h"
> > +#include "block/vhost-user.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qapi-types-sockets.h"
> > +#include "qapi/qapi-commands-block.h"
> > +
> > +#include "sysemu/block-backend.h"
> > +#include "qemu/main-loop.h"
> > +
> > +#include "qemu/units.h"
> > +
> > +#include "block/block.h"
> > +
> > +#include "qom/object_interfaces.h"
> > +
> > +#include <sys/eventfd.h>
> > +
> > +#include "hw/qdev-properties.h"
> > +enum {
> > +    VHOST_USER_BLK_MAX_QUEUES = 8,
> > +};
>
> The number of queues is hardcoded to 1 so this constant can be removed
> for now.
>
> > +
> > +struct virtio_blk_inhdr {
> > +    unsigned char status;
> > +};
> > +
> > +
> > +static QTAILQ_HEAD(, VubDev) vub_devs = QTAILQ_HEAD_INITIALIZER(vub_devs);
>
> I'm not sure if this list will be necessary.  See my comments about
> replacing the "name" property with Object's built-in "id" property.
>
> > +
> > +
> > +typedef struct VubReq {
> > +    VuVirtqElement *elem;
> > +    int64_t sector_num;
> > +    size_t size;
> > +    struct virtio_blk_inhdr *in;
> > +    struct virtio_blk_outhdr out;
> > +    VuClient *client;
> > +    struct VuVirtq *vq;
> > +} VubReq;
> > +
> > +static void
> > +remove_watch(VuDev *vu_dev, int fd)
> > +{
> > +    VuClient *client;
> > +
> > +    g_assert(vu_dev);
> > +    g_assert(fd >= 0);
> > +
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    aio_set_fd_handler(client->blk->ctx, fd, false, NULL, NULL, NULL, NULL);
> > +}
> > +
> > +static void close_client(VuClient *client)
> > +{
> > +    vu_deinit(&client->parent);
> > +    /** g_source_destroy(vub_device->parent.src); */
> > +    client->sioc = NULL;
> > +    object_unref(OBJECT(client->ioc));
> > +    client->closed = true;
> > +
> > +}
> > +
> > +static void vub_panic_cb(VuDev *vu_dev, const char *buf)
> > +{
> > +    if (buf) {
> > +        g_warning("vu_panic: %s", buf);
> > +    }
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    if (client->blk->exit_panic) {
> > +        client->blk->close = true;
> > +    }
> > +    if (!client->closed) {
> > +        close_client(client);
> > +    }
> > +}
> > +
> > +
> > +static void vub_req_complete(VubReq *req)
> > +{
> > +    VuDev *vu_dev = &req->client->parent;
> > +
> > +    /* IO size with 1 extra status byte */
> > +    vu_queue_push(vu_dev, req->vq, req->elem,
> > +                  req->size + 1);
> > +    vu_queue_notify(vu_dev, req->vq);
> > +
> > +    if (req->elem) {
> > +        free(req->elem);
> > +    }
> > +
> > +    g_free(req);
> > +}
> > +
> > +
> > +
> > +static int
> > +vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
> > +                         uint32_t type)
> > +{
> > +    struct virtio_blk_discard_write_zeroes *desc;
> > +    ssize_t size;
> > +    void *buf;
> > +
> > +    size = iov_size(iov, iovcnt);
> > +    if (size != sizeof(*desc)) {
> > +        fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*desc));
> > +        return -1;
> > +    }
> > +    buf = g_new0(char, size);
> > +
> > +    iov_to_buf_full(iov, iovcnt, 0, buf, size);
>
> Simpler:
>
>   struct virtio_blk_discard_write_zeroes desc;
>
>   if (unlikely(iov_to_buf(iov, iovcnt, 0, &desc, sizeof(desc)) !=
>                sizeof(desc)) {
>       /* TODO handle error */
>   }
>
> No heap allocation.  One variable (desc) instead of two (desc and buf).
>
> > +
> > +
> > +    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
> > +    VubDev *vdev_blk;
> > +    VuClient *client = container_of(dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    desc = (struct virtio_blk_discard_write_zeroes *)buf;
> > +    uint64_t range[2] = { le64toh(desc->sector) << 9,
> > +                          le32toh(desc->num_sectors) << 9 };
> > +    if (type == VIRTIO_BLK_T_DISCARD) {
> > +        if (blk_pdiscard(vdev_blk->blk, range[0], range[1]) == 0) {
> > +            g_free(buf);
> > +            return 0;
> > +        }
> > +    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
> > +        if (blk_pwrite_zeroes(vdev_blk->blk, range[0], range[1]) == 0) {
> > +            g_free(buf);
> > +            return 0;
> > +        }
> > +    }
> > +    #endif
> > +
> > +    g_free(buf);
> > +    return -1;
> > +}
> > +
> > +
> > +static void
> > +vub_flush(VubReq *req)
> > +{
> > +    VuClient *client = req->client;
> > +    blk_co_flush(client->blk->backend);
> > +}
>
> Any function that calls a *_co_*() function must be marked coroutine_fn:
>
>   static void coroutine_fn
>   vub_flush(VubReq *req)
>
> > +
> > +
> > +#define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
> > +typedef struct BlkRwCo {
> > +    BlockBackend *blk;
> > +    int64_t offset;
> > +    void *iobuf;
> > +    int ret;
> > +    BdrvRequestFlags flags;
> > +} BlkRwCo;
> > +
> > +static void blk_read_entry(void *opaque)
> > +{
> > +    BlkRwCo *rwco = opaque;
> > +    QEMUIOVector *qiov = rwco->iobuf;
> > +
> > +    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
> > +                              qiov, rwco->flags);
> > +    aio_wait_kick();
> > +}
> > +
> > +
> > +static void blk_write_entry(void *opaque)
> > +{
> > +    BlkRwCo *rwco = opaque;
> > +    QEMUIOVector *qiov = rwco->iobuf;
> > +
> > +    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
> > +                              qiov, rwco->flags);
> > +    aio_wait_kick();
> > +}
> > +
> > +
> > +static int blk_prw(BlockBackend *blk, QEMUIOVector *qiov, int64_t offset,
> > +                   CoroutineEntry co_entry, BdrvRequestFlags flags)
>
> Why is block/block-backend.c:blk_prw() duplicated here?
>
> > +{
> > +
> > +    BlkRwCo rwco = {
> > +        .blk    = blk,
> > +        .offset = offset,
> > +        .iobuf  = qiov,
> > +        .flags  = flags,
> > +        .ret    = NOT_DONE,
> > +    };
> > +
> > +    if (qemu_in_coroutine()) {
> > +        /* Fast-path if already in coroutine context */
> > +        co_entry(&rwco);
> > +    } else {
> > +        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
> > +        bdrv_coroutine_enter(blk_bs(blk), co);
> > +        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
> > +    }
> > +
> > +    return rwco.ret;
> > +}
> > +
> > +
> > +static ssize_t
> > +vub_rwv(VubReq *req, struct iovec *iov,
> > +        uint32_t iovcnt,
> > +        CoroutineEntry co_entry)
> > +{
> > +    VuClient *client = req->client;
> > +    ssize_t rc;
> > +
> > +    if (!iovcnt) {
> > +        fprintf(stderr, "Invalid Read/Write IOV count\n");
> > +        return -1;
> > +    }
> > +
> > +    int64_t offset = req->sector_num * 512;
> > +    QEMUIOVector *qiov = g_new0(QEMUIOVector, 1);
> > +    qemu_iovec_init_external(qiov, iov, iovcnt);
> > +    rc = blk_prw(client->blk->backend, qiov, offset, co_entry, 0);
> > +
> > +    req->size = iov_size(iov, iovcnt);
> > +    if (rc < 0) {
> > +        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with %s\n",
> > +                client->blk->name, req->sector_num, req->size,
> > +                strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static int vub_virtio_process_req(VuClient *client,
> > +                                     VuVirtq *vq)
> > +{
> > +    VuDev *vu_dev = &client->parent;
> > +    VuVirtqElement *elem;
> > +    uint32_t type;
> > +    VubReq *req;
> > +
> > +    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) + sizeof(VubReq));
> > +    if (!elem) {
> > +        return -1;
> > +    }
> > +
> > +    struct iovec *in_iov = elem->in_sg;
> > +    struct iovec *out_iov = elem->out_sg;
> > +    unsigned in_num = elem->in_num;
> > +    unsigned out_num = elem->out_num;
> > +    /* refer to hw/block/virtio_blk.c */
> > +    if (elem->out_num < 1 || elem->in_num < 1) {
> > +        fprintf(stderr, "virtio-blk request missing headers\n");
> > +        free(elem);
> > +        return -1;
> > +    }
> > +
> > +    req = g_new0(VubReq, 1);
> > +    req->client = client;
> > +    req->vq = vq;
> > +    req->elem = elem;
> > +
> > +    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
> > +                            sizeof(req->out)) != sizeof(req->out))) {
> > +        fprintf(stderr, "virtio-blk request outhdr too short");
> > +        goto err;
> > +    }
> > +
> > +    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
> > +
> > +    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> > +        fprintf(stderr, "virtio-blk request inhdr too short");
> > +        goto err;
> > +    }
> > +
> > +    /* We always touch the last byte, so just see how big in_iov is.  */
> > +    req->in = (void *)in_iov[in_num - 1].iov_base
> > +              + in_iov[in_num - 1].iov_len
> > +              - sizeof(struct virtio_blk_inhdr);
> > +    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> > +
> > +
> > +    type = le32toh(req->out.type);
> > +    switch (type & ~VIRTIO_BLK_T_BARRIER) {
> > +    case VIRTIO_BLK_T_IN:
> > +    case VIRTIO_BLK_T_OUT: {
> > +        ssize_t ret = 0;
> > +        bool is_write = type & VIRTIO_BLK_T_OUT;
> > +        req->sector_num = le64toh(req->out.sector);
> > +        if (is_write) {
> > +            ret = vub_rwv(req, out_iov, out_num, blk_write_entry);
> > +        } else {
> > +            ret = vub_rwv(req, in_iov, in_num, blk_read_entry);
> > +        }
> > +        if (ret >= 0) {
> > +            req->in->status = VIRTIO_BLK_S_OK;
> > +        } else {
> > +            req->in->status = VIRTIO_BLK_S_IOERR;
> > +        }
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    case VIRTIO_BLK_T_FLUSH:
> > +        vub_flush(req);
> > +        req->in->status = VIRTIO_BLK_S_OK;
> > +        vub_req_complete(req);
> > +        break;
> > +    case VIRTIO_BLK_T_GET_ID: {
> > +        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
> > +                          VIRTIO_BLK_ID_BYTES);
> > +        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
> > +        req->in->status = VIRTIO_BLK_S_OK;
> > +        req->size = elem->in_sg[0].iov_len;
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    case VIRTIO_BLK_T_DISCARD:
> > +    case VIRTIO_BLK_T_WRITE_ZEROES: {
> > +        int rc;
> > +        rc = vub_discard_write_zeroes(req, &elem->out_sg[1], out_num, type);
> > +        if (rc == 0) {
> > +            req->in->status = VIRTIO_BLK_S_OK;
> > +        } else {
> > +            req->in->status = VIRTIO_BLK_S_IOERR;
> > +        }
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    default:
> > +        req->in->status = VIRTIO_BLK_S_UNSUPP;
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    free(elem);
> > +    g_free(req);
> > +    return -1;
> > +}
> > +
> > +
> > +static void vub_process_vq(VuDev *vu_dev, int idx)
> > +{
> > +    VuClient *client;
> > +    VuVirtq *vq;
> > +    int ret;
> > +
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    assert(client);
> > +
> > +    vq = vu_get_queue(vu_dev, idx);
> > +    assert(vq);
> > +
> > +    while (1) {
> > +        ret = vub_virtio_process_req(client, vq);
> > +        if (ret) {
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +
> > +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started)
> > +{
> > +    VuVirtq *vq;
> > +
> > +    assert(vu_dev);
> > +
> > +    vq = vu_get_queue(vu_dev, idx);
> > +    vu_set_queue_handler(vu_dev, vq, started ? vub_process_vq : NULL);
> > +}
> > +
> > +static uint64_t
> > +vub_get_features(VuDev *dev)
> > +{
> > +    uint64_t features;
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +
> > +    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
> > +               1ull << VIRTIO_BLK_F_SEG_MAX |
> > +               1ull << VIRTIO_BLK_F_TOPOLOGY |
> > +               1ull << VIRTIO_BLK_F_BLK_SIZE |
> > +               1ull << VIRTIO_BLK_F_FLUSH |
> > +               #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
> > +               1ull << VIRTIO_BLK_F_DISCARD |
> > +               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
> > +               #endif
> > +               1ull << VIRTIO_BLK_F_CONFIG_WCE |
> > +               1ull << VIRTIO_F_VERSION_1 |
> > +               1ull << VIRTIO_RING_F_INDIRECT_DESC |
> > +               1ull << VIRTIO_RING_F_EVENT_IDX |
> > +               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> > +
> > +    if (!vdev_blk->writable) {
> > +        features |= 1ull << VIRTIO_BLK_F_RO;
> > +    }
> > +
> > +    return features;
> > +}
> > +
> > +static uint64_t
> > +vub_get_protocol_features(VuDev *dev)
> > +{
> > +    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
> > +           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
> > +}
> > +
> > +static int
> > +vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
> > +{
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    memcpy(config, &vdev_blk->blkcfg, len);
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vub_set_config(VuDev *vu_dev, const uint8_t *data,
> > +               uint32_t offset, uint32_t size, uint32_t flags)
> > +{
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    uint8_t wce;
> > +
> > +    /* don't support live migration */
> > +    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
> > +        return -1;
> > +    }
> > +
> > +
> > +    if (offset != offsetof(struct virtio_blk_config, wce) ||
> > +        size != 1) {
> > +        return -1;
> > +    }
> > +
> > +    wce = *data;
> > +    if (wce == vdev_blk->blkcfg.wce) {
> > +        /* Do nothing as same with old configuration */
> > +        return 0;
> > +    }
> > +
> > +    vdev_blk->blkcfg.wce = wce;
> > +    blk_set_enable_write_cache(vdev_blk->backend, true);
> > +    return 0;
> > +}
> > +
> > +
> > +/*
> > + * When the client disconnects, it send a VHOST_USER_NONE request
> > + * and vu_process_message will simple call exit which cause the VM
> > + * to exit abruptly.
> > + * To avoid this issue,  process VHOST_USER_NONE request ahead
> > + * of vu_process_message.
> > + *
> > + */
> > +static int vub_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
> > +{
> > +    if (vmsg->request == VHOST_USER_NONE) {
> > +        dev->panic(dev, "disconnect");
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> > +static void
> > +vmsg_close_fds(VhostUserMsg *vmsg)
> > +{
> > +    int i;
> > +    for (i = 0; i < vmsg->fd_num; i++) {
> > +        close(vmsg->fds[i]);
> > +    }
> > +}
> > +
> > +static bool
> > +vu_message_read_co(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
>
> Why is this function called *_co()?  It appears to be callable from
> outside coroutine context too.
>
> > +{
> > +    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
> > +    struct iovec iov = {
> > +        .iov_base = (char *)vmsg,
> > +        .iov_len = VHOST_USER_HDR_SIZE,
> > +    };
> > +    struct msghdr msg = {
> > +        .msg_iov = &iov,
> > +        .msg_iovlen = 1,
> > +        .msg_control = control,
> > +        .msg_controllen = sizeof(control),
> > +    };
> > +    size_t fd_size;
> > +    struct cmsghdr *cmsg;
> > +    int rc;
> > +    char buffer[100];
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    QIOChannel *ioc = client->ioc;
> > +    do {
> > +        rc = recvmsg(conn_fd, &msg, 0);
> > +        if (rc < 0) {
> > +            if (errno == EAGAIN) {
> > +                if (qemu_in_coroutine()) {
> > +                    qio_channel_yield(ioc, G_IO_IN);
> > +                } else {
> > +                    qio_channel_wait(ioc, G_IO_IN);
> > +                }
> > +                continue;
> > +            } else if (errno == EINTR) {
> > +                continue;
> > +            }
> > +        }
> > +        break;
> > +    } while (true);
> > +
> > +    if (rc < 0) {
> > +        sprintf(buffer, "Error while recvmsg: %s", strerror(errno));
> > +        vub_panic_cb(vu_dev, buffer);
> > +        return false;
> > +    }
> > +
> > +    assert(rc == VHOST_USER_HDR_SIZE || rc == 0);
> > +
> > +    vmsg->fd_num = 0;
> > +    for (cmsg = CMSG_FIRSTHDR(&msg);
> > +         cmsg != NULL;
> > +         cmsg = CMSG_NXTHDR(&msg, cmsg))
> > +    {
> > +        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
> > +            fd_size = cmsg->cmsg_len - CMSG_LEN(0);
> > +            vmsg->fd_num = fd_size / sizeof(int);
> > +            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (vmsg->size > sizeof(vmsg->payload)) {
> > +        sprintf(buffer,
> > +                "Error: too big message request: %d, size: vmsg->size: %u, "
> > +                "while sizeof(vmsg->payload) = %zu\n",
> > +                vmsg->request, vmsg->size, sizeof(vmsg->payload));
> > +        vub_panic_cb(vu_dev, buffer);
> > +        goto fail;
> > +    }
> > +
> > +    if (vmsg->size) {
> > +        do {
> > +            rc = read(conn_fd, &vmsg->payload, vmsg->size);
> > +            if (rc < 0) {
> > +                if (errno == EAGAIN) {
> > +                    if (qemu_in_coroutine()) {
> > +                        qio_channel_yield(ioc, G_IO_IN);
> > +                    } else {
> > +                        qio_channel_wait(ioc, G_IO_IN);
> > +                    }
> > +                    continue;
> > +                } else if (errno == EINTR) {
> > +                    continue;
> > +                }
> > +            }
> > +            break;
> > +        } while (true);
> > +
> > +        if (rc <= 0) {
> > +            sprintf(buffer, "Error while reading: %s", strerror(errno));
> > +            vub_panic_cb(vu_dev, buffer);
> > +            goto fail;
> > +        }
> > +
> > +        assert(rc == vmsg->size);
> > +    }
> > +
> > +    return true;
> > +
> > +fail:
> > +    vmsg_close_fds(vmsg);
> > +
> > +    return false;
> > +}
> > +
> > +static void vub_kick_cb(void *opaque)
> > +{
> > +    vu_watch_cb_data *data = (vu_watch_cb_data *) opaque;
> > +    int index = data->index;
> > +    VuDev *dev = data->vu_dev;
> > +    VuVirtq *vq = &dev->vq[index];
> > +    int sock = vq->kick_fd;
> > +    eventfd_t kick_data;
> > +    ssize_t rc;
> > +
> > +    rc = eventfd_read(sock, &kick_data);
> > +    if (rc == -1) {
> > +        char buffer[100];
> > +        sprintf(buffer, "kick eventfd_read(): %s", strerror(errno));
> > +        vub_panic_cb(dev, buffer);
> > +        g_free(data);
> > +        dev->remove_watch(dev, dev->vq[index].kick_fd);
> > +    } else {
> > +        if (vq->handler) {
> > +            vq->handler(dev, index);
> > +        }
> > +    }
> > +}
>
> This is a generic vhost-user function that is not specific to
> vhost-user-blk.  It should be in a different source file.
>
> > +
> > +static const VuDevIface vub_iface = {
> > +    .get_features = vub_get_features,
> > +    .queue_set_started = vub_queue_set_started,
> > +    .get_protocol_features = vub_get_protocol_features,
> > +    .get_config = vub_get_config,
> > +    .set_config = vub_set_config,
> > +    .process_msg = vub_process_msg,
> > +    .read_msg = vu_message_read_co,
> > +    .kick_callback = vub_kick_cb,
> > +};
> > +
> > +
> > +void vub_free(VubDev *vub_dev, bool called_by_QOM)
> > +{
> > +    if (!vub_dev) {
> > +        return;
> > +    }
> > +
> > +    blk_unref(vub_dev->backend);
> > +    g_free(vub_dev->name);
> > +    g_free(vub_dev->unix_socket);
> > +
> > +    if (vub_dev->next.tqe_circ.tql_prev) {
> > +        /*
> > +         * if vub_dev->next.tqe_circ.tql_prev = null,
> > +         * vub_dev hasn't been inserted into the queue and
> > +         * vub_free is called by obj->instance_finalize.
> > +         */
> > +        QTAILQ_REMOVE(&vub_devs, vub_dev, next);
> > +    }
> > +    /*
> > +     * Needn't to free vub_dev if called by QOM
> > +     * because QOM will do the clean-up work.
> > +     */
> > +    if (!called_by_QOM) {
> > +        g_free(vub_dev);
> > +    }
> > +}
> > +
> > +static coroutine_fn void vu_client_trip(void *opaque)
> > +{
> > +    VuClient *client = opaque;
> > +
> > +    while (!client->closed) {
> > +        vu_dispatch(&client->parent);
> > +    }
> > +
> > +    QTAILQ_REMOVE(&client->blk->clients, client, next);
> > +
> > +}
> > +
> > +static void vu_client_start(VuClient *client)
> > +{
> > +    Coroutine *co = qemu_coroutine_create(vu_client_trip, client);
> > +    qemu_coroutine_enter(co);
> > +}
>
> What is the coroutine and threading model here?  This launches
> vu_client_trip() in the current thread's event loop but vu_dispatch()
> performs blocking I/O and will prevent the event loop from continuing.
>
> > +
> > +
> > +G_STATIC_ASSERT((int)G_IO_IN == (int)VU_WATCH_IN);
> > +G_STATIC_ASSERT((int)G_IO_OUT == (int)VU_WATCH_OUT);
> > +G_STATIC_ASSERT((int)G_IO_PRI == (int)VU_WATCH_PRI);
> > +G_STATIC_ASSERT((int)G_IO_ERR == (int)VU_WATCH_ERR);
> > +G_STATIC_ASSERT((int)G_IO_HUP == (int)VU_WATCH_HUP);
> > +
> > +static void
> > +set_watch(VuDev *vu_dev, int fd, int vu_evt,
> > +          vu_watch_cb_packed_data cb, void *pvt)
> > +{
> > +    /*
> > +     * since aio_dispatch can only pass one user data pointer to the
> > +     * callback function, pack VuDev, pvt into a struct
> > +     */
> > +    VuClient *client;
> > +
> > +    g_assert(vu_dev);
> > +    g_assert(fd >= 0);
> > +    g_assert(cb);
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    vu_watch_cb_data *cb_data = g_new0(vu_watch_cb_data, 1);
> > +    cb_data->index = (intptr_t) pvt;
> > +    cb_data->vu_dev = vu_dev;
> > +    aio_set_fd_handler(client->blk->ctx, fd, false, (void *) cb,
> > +                       NULL, NULL, cb_data);
> > +}
> > +
> > +
> > +void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> > +                gpointer opaque)
> > +{
> > +    VuClient *client;
> > +    VubDev *vub_device = opaque;
> > +    client = g_new0(VuClient, 1);
>
> Is it helpful to have a separate VuClient struct even though only a
> single vhost-user client can be connected at a time?  It may be simpler
> to keep connection state directly in VubDev.
>
> > +
> > +    if (!vu_init_packed_data(&client->parent, VHOST_USER_BLK_MAX_QUEUES,
> > +                             sioc->fd, vub_panic_cb, set_watch,
> > +                             remove_watch, &vub_iface)) {
> > +        fprintf(stderr, "Failed to initialized libvhost-user\n");
> > +        g_free(client);
> > +        return;
> > +    }
> > +
> > +    client->blk = vub_device;
> > +    client->refcount = 1;
> > +    client->sioc = sioc;
> > +    /*
> > +     * increase the object reference, so cioc will not freed by
> > +     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
> > +     */
> > +    object_ref(OBJECT(client->sioc));
> > +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
> > +    client->ioc = QIO_CHANNEL(sioc);
> > +    object_ref(OBJECT(client->ioc));
> > +    object_ref(OBJECT(sioc));
> > +
> > +    qio_channel_set_blocking(QIO_CHANNEL(client->sioc), false, NULL);
> > +    client->closed = false;
> > +    QTAILQ_INSERT_TAIL(&client->blk->clients, client, next);
> > +    vu_client_start(client);
> > +}
> > +
> > +
> > +void
> > +vub_initialize_config(BlockDriverState *bs, struct virtio_blk_config *config)
> > +{
> > +    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
> > +    config->blk_size = BDRV_SECTOR_SIZE;
>
> At some point this should become a configuration parameter because using
> 512B sectors on a native 4K sector image file results in poor
> performance.
>
> > +    config->size_max = 65536;
>
> Why 65536?  hw/block/virtio-blk.c sets it to 0.
>
> > +    config->seg_max = 128 - 2;
>
> This is okay for now but should be changed in the future.
>
> hw/block/virtio-blk.c was recently modified to calculate seg_max based
> on the virtqueue size (which is where the hardcoded 128 originally came
> from).  Applications that use large buffer sizes (128+ KB) benefit from
> larger virtqueue sizes and seg_max.
>
> > +    config->min_io_size = 1;
> > +    config->opt_io_size = 1;
> > +    config->num_queues = 1;
> > +    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
> > +    config->max_discard_sectors = 32768;
> > +    config->max_discard_seg = 1;
> > +    config->discard_sector_alignment = config->blk_size >> 9;
> > +    config->max_write_zeroes_sectors = 32768;
> > +    config->max_write_zeroes_seg = 1;
> > +    #endif
> > +}
> > +
> > +
> > +static VubDev *vub_new(VubDev *vub_device, const char *name,
> > +                       const char *unix_socket, bool writable, Error **errp)
>
> This function does not allocate and return a new VubDev, so vub_new() is
> not an accurate name for this function.  The name vub_init() is clearer.
>
> Why are name, unix_socket, and writable passed in?  They are already
> vub_device fields.
>
> > +{
> > +
> > +    BlockBackend *blk;
> > +
> > +    /*
> > +     * Don't allow resize while the vhost user server is running,
> > +     * otherwise we don't care what happens with the node.
> > +     */
> > +    uint64_t perm = BLK_PERM_CONSISTENT_READ;
> > +    int ret;
> > +
> > +    AioContext *ctx;
> > +
> > +    BlockDriverState *bs = bdrv_lookup_bs(name,
> > +                                          name,
> > +                                          errp);
> > +
> > +    if (!bs) {
> > +        error_setg(errp,
> > +                   "No drive with name '%s'."
> > +                   " Please find the list of names with "
> > +                   "'info block'", name);
> > +        return NULL;
> > +    }
> > +
> > +    if (bdrv_is_read_only(bs)) {
> > +        writable = false;
> > +    }
> > +
> > +    if (writable) {
> > +        perm |= BLK_PERM_WRITE;
> > +    }
> > +
> > +    ctx = bdrv_get_aio_context(bs);
> > +    aio_context_acquire(ctx);
> > +    bdrv_invalidate_cache(bs, NULL);
> > +    aio_context_release(ctx);
> > +
> > +    blk = blk_new(bdrv_get_aio_context(bs), perm,
> > +                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> > +                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
> > +    ret = blk_insert_bs(blk, bs, errp);
> > +
> > +    if (ret < 0) {
> > +        goto fail;
> > +    }
> > +
> > +
> > +    blk_set_enable_write_cache(blk, false);
> > +
> > +    blk_set_allow_aio_context_change(blk, true);
> > +
> > +
> > +    vub_device->name = g_strdup(name);
> > +    vub_device->unix_socket = g_strdup(unix_socket);
> > +    vub_device->writable = writable;
> > +    vub_device->blkcfg.wce = 0;
> > +    vub_device->backend = blk;
> > +    vub_device->ctx = ctx;
> > +    vub_initialize_config(bs, &vub_device->blkcfg);
> > +    return vub_device;
> > +
> > +fail:
> > +    blk_unref(blk);
> > +    return NULL;
> > +}
> > +
> > +void vhost_user_server_free(VubDev *vub_device, bool called_by_QOM)
> > +{
> > +    if (!vub_device) {
> > +        return;
> > +    }
> > +
> > +    VuClient *client, *next;
> > +    QTAILQ_FOREACH_SAFE(client, &vub_device->clients, next, next) {
> > +        if (!client->closed) {
> > +            close_client(client);
> > +        }
> > +    }
> > +
> > +    if (vub_device->listener) {
> > +        qio_net_listener_disconnect(vub_device->listener);
> > +        object_unref(OBJECT(vub_device->listener));
> > +    }
> > +    vub_free(vub_device, called_by_QOM);
> > +
> > +}
> > +
> > +
> > +VubDev *vub_dev_find(const char *name)
> > +{
> > +    VubDev *vub_device;
> > +    QTAILQ_FOREACH(vub_device, &vub_devs, next) {
> > +        if (strcmp(name, vub_device->name) == 0) {
> > +            return vub_device;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +
> > +static VubDev *vub_dev_find_by_unix_socket(const char *unix_socket)
> > +{
> > +    VubDev *vub_device;
> > +    QTAILQ_FOREACH(vub_device, &vub_devs, next) {
> > +        if (strcmp(unix_socket, vub_device->unix_socket) == 0) {
> > +            return vub_device;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void vhost_user_server_start(VubDev *vub_device, const char *unix_socket,
> > +                                    const char *name, bool writable,
> > +                                    Error **errp)
> > +{
> > +
> > +    if (vub_dev_find(name) || vub_dev_find_by_unix_socket(unix_socket)) {
> > +        error_setg(errp, "Vhost user server with name '%s' or "
> > +                "with socket_path '%s' has already been started",
> > +                name, unix_socket);
> > +        return;
> > +    }
> > +
> > +
> > +    if (!vub_new(vub_device, name, unix_socket, writable, errp)) {
> > +        return;
> > +    }
> > +
> > +
> > +    vub_device->listener = qio_net_listener_new();
> > +
> > +    qio_net_listener_set_name(vub_device->listener,
> > +                              "vhost-user-backend-listener");
> > +
> > +    SocketAddress *addr = g_new0(SocketAddress, 1);
>
> addr is never freed.  This variable could live on the stack instead:
>
>   SocketAddress addr = {};
>
> > +    addr->u.q_unix.path = (char *) unix_socket;
> > +    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> > +    if (qio_net_listener_open_sync(vub_device->listener, addr, 1, errp) < 0) {
> > +        goto error;
> > +    }
> > +
> > +
> > +    QTAILQ_INSERT_TAIL(&vub_devs, vub_device, next);
> > +    QTAILQ_INIT(&vub_device->clients);
> > +
> > +    qio_net_listener_set_client_func(vub_device->listener,
> > +                                     vub_accept,
> > +                                     vub_device,
> > +                                     NULL);
> > +
> > +    return;
> > +
> > + error:
> > +    vub_free(vub_device, false);
> > +}
> > +
> > +static void vu_set_block_name(Object *obj, const char *value,
> > +                                           Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +
> > +    if (vus->name) {
> > +        error_setg(errp, "evdev property already set");
> > +        return;
> > +    }
> > +
> > +    vus->name = g_strdup(value);
> > +}
> > +
> > +static char *vu_get_block_name(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +    return g_strdup(vus->name);
> > +}
> > +
> > +
> > +static void vu_set_unix_socket(Object *obj, const char *value,
> > +                                            Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +
> > +    if (vus->unix_socket) {
> > +        error_setg(errp, "unix_socket property already set");
> > +        return;
> > +    }
> > +
> > +    vus->unix_socket = g_strdup(value);
> > +    vhost_user_server_start(vus, value, vus->name,
> > +                            vus->writable, errp);
>
> Property setters should only perform input validation and store the
> data.  Actions like creating network connections, opening files, etc
> should happen later in a UserCreatableClass->complete() callback.
>
> This is necessary because vus->writable is also a property and may be
> set after unix_socket.  The ->complete() callback is called after all
> setters so it can access the final values of all properties.
>
> See iothread_class_init() and iothread_complete() for an example.
>
> > +}
> > +
> > +static char *vu_get_unix_socket(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +    return g_strdup(vus->unix_socket);
> > +}
> > +
> > +static bool vu_get_block_writable(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +    return vus->writable;
> > +}
> > +
> > +static void vu_set_block_writable(Object *obj, bool value, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +
> > +    vus->writable = value;
> > +}
> > +
> > +static void vhost_user_server_instance_init(Object *obj)
> > +{
> > +
> > +    object_property_add_bool(obj, "writable",
> > +                            vu_get_block_writable,
> > +                            vu_set_block_writable, NULL);
> > +
> > +    object_property_add_str(obj, "name",
> > +                            vu_get_block_name,
> > +                            vu_set_block_name, NULL);
> > +
> > +    object_property_add_str(obj, "unix_socket",
> > +                            vu_get_unix_socket,
> > +                            vu_set_unix_socket, NULL);
> > +
> > +}
> > +
> > +static void vhost_user_server_instance_finalize(Object *obj)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +    vhost_user_server_free(vus, true);
> > +    /* object_del shouldn't free this object struct */
> > +    obj->free = NULL;
> > +}
> > +
> > +static const TypeInfo vhost_user_server_info = {
> > +    .name = TYPE_VHOST_USER_SERVER,
> > +    .parent = TYPE_OBJECT,
> > +    .instance_size = sizeof(VuDev),
> > +    .instance_init = vhost_user_server_instance_init,
> > +    .instance_finalize = vhost_user_server_instance_finalize,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        {TYPE_USER_CREATABLE},
> > +        {}
> > +    },
> > +};
> > +
> > +static void vhost_user_server_register_types(void)
> > +{
> > +    type_register_static(&vhost_user_server_info);
> > +}
> > +
> > +type_init(vhost_user_server_register_types)
> > +
> > diff --git a/include/block/vhost-user.h b/include/block/vhost-user.h
> > new file mode 100644
> > index 0000000000..ef6d695244
> > --- /dev/null
> > +++ b/include/block/vhost-user.h
> > @@ -0,0 +1,46 @@
> > +#include "io/channel-socket.h"
> > +#include "io/net-listener.h"
> > +#include "contrib/libvhost-user/libvhost-user.h"
> > +#include "standard-headers/linux/virtio_blk.h"
> > +typedef struct VubDev VubDev;
> > +typedef struct VuClient VuClient;
> > +#define TYPE_VHOST_USER_SERVER "vhost-user-server"
> > +
> > +#define VHOST_USER_SERVER(obj) \
> > +   OBJECT_CHECK(VubDev, obj, TYPE_VHOST_USER_SERVER)
> > +/* vhost user block device */
> > +struct VubDev {
> > +    Object parent_obj;
> > +    char *name;
> > +    char *unix_socket;
> > +    bool exit_panic;
> > +    bool close;
> > +    BlockBackend *backend;
> > +    AioContext *ctx;
> > +    QIONetListener *listener;
> > +    QIOChannelSocket *sioc;
> > +    QTAILQ_HEAD(, VuClient) clients;
> > +    QTAILQ_ENTRY(VubDev) next;
> > +    struct virtio_blk_config blkcfg;
> > +    bool writable;
> > +};
> > +
> > +struct VuClient {
> > +    VuDev parent;
> > +    int refcount;
> > +    VubDev *blk;
> > +    QIOChannelSocket *sioc; /* The underlying data channel */
> > +    QIOChannel *ioc; /* The current I/O channel */
> > +    QTAILQ_ENTRY(VuClient) next;
> > +    bool closed;
> > +};
> > +VubDev *vub_dev_find(const char *name);
>
> All -object instances already have an id=ID property.  There is no need
> to declare a separate "name" property.  Please look at iothread_by_id()
> and iothread_get_id() for examples.
>
> > +
> > +void vhost_user_server_free(VubDev *vub_device, bool called_by_QOM);
> > +void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> > +                gpointer opaque);
> > +
> > +void vub_free(VubDev *vub_dev, bool called_by_QOM);
> > +
> > +void vub_initialize_config(BlockDriverState *bs,
> > +                           struct virtio_blk_config *config);
> > diff --git a/vl.c b/vl.c
> > index 86474a55c9..72ac506342 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2553,6 +2553,10 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
> >      }
> >  #endif
> >
> > +    /* Reason: vhost-user-server property "name" */
> > +    if (g_str_equal(type, "vhost-user-server")) {
> > +        return false;
> > +    }
>
> I don't understand why the "name" property introduces a creation order
> dependency.  It's just a string and has no dependency on other
> command-line objects.  Can you explain why this change is necessary?
>
> >      /*
> >       * Reason: filter-* property "netdev" etc.
> >       */
> > --
> > 2.24.1
> >



--
Best regards,
Coiby

