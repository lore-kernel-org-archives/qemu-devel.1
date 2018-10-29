Received: from eggs.gnu.org ([2001:4830:134:3::10]:47206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1gH5cN-00058a-GH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1gH5cG-000659-NI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:21:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liliang.opensource@gmail.com>)
	id 1gH5cG-000622-Ba
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:21:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id c25-v6so3843499pfe.6
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:21:52 -0700 (PDT)
From: Liang Li <liliang.opensource@gmail.com>
Date: Mon, 29 Oct 2018 19:21:45 +0800
Message-ID: <20181029112143.GA15746@localhost>
References: <20180927143338.GA56570@bogon>
	<CAJ+F1CKf5625pUPBvxv6gCX0eVeDEYBj9s08phpGe8sh4LvWaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKf5625pUPBvxv6gCX0eVeDEYBj9s08phpGe8sh4LvWaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix qemu crash caused by
 failed backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Oct 02, 2018 at 01:54:25PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Sep 27, 2018 at 7:37 PM Liang Li <liliangleo@didiglobal.com> wrote:
> >
> > During live migration, when stopping vhost-user device, 'vhost_dev_stop'
> > will be called, 'vhost_dev_stop' will call a batch of 'vhost_user_read'
> > and 'vhost_user_write'. If a previous 'vhost_user_read' or 'vhost_user_write'
> > failed because the vhost user backend failed, the 'CHR_EVENT_CLOSED' event
> > will be triggerd, followed by the call chain chr_closed_bh()->vhost_user_stop()->
> > vhost_net_cleanup()->vhost_dev_cleanup()
> >
> > vhost_dev_cleanup will clear vhost_dev struct, so the later 'vhost_user_read'
> > or 'vhost_user_read' will reference null pointer and cause qemu crash
> 
> Do you have a backtrace to help understand the issue?
> thanks
> 

sorry for late response.

Yes, I have. But it's the backtrace for qemu-kvm-2.10.
and we found this issue when doing pressure test, it was triggered
by a buggy ovs-dpdk backend, an ovs-dpdk coredump followed by a qemu
coredump. 

the backtrace is like bellow:

 ======================================================================
    0  0x00007f0af85ea069 in vhost_user_read (msg=msg@entry=0x7f0a2a4b5300, dev=0x7f0afaee0340) at /usr/src/debug/qemu-2.10.0/hw/virtio/vhost-user.c:139
    1  0x00007f0af85ea2df in vhost_user_get_vring_base (dev=0x7f0afaee0340, ring=0x7f0a2a4b5450) at /usr/src/debug/qemu-2.10.0/hw/virtio/vhost-user.c:458
    2  0x00007f0af85e715e in vhost_virtqueue_stop (dev=dev@entry=0x7f0afaee0340, vdev=vdev@entry=0x7f0afcba0170, vq=0x7f0afaee05d0, idx=1)
        at /usr/src/debug/qemu-2.10.0/hw/virtio/vhost.c:1138
    3  0x00007f0af85e8e24 in vhost_dev_stop (hdev=hdev@entry=0x7f0afaee0340, vdev=vdev@entry=0x7f0afcba0170) at /usr/src/debug/qemu-2.10.0/hw/virtio/vhost.c:1601
    4  0x00007f0af85d1418 in vhost_net_stop_one (net=0x7f0afaee0340, dev=0x7f0afcba0170) at /usr/src/debug/qemu-2.10.0/hw/net/vhost_net.c:289
    5  0x00007f0af85d191b in vhost_net_stop (dev=dev@entry=0x7f0afcba0170, ncs=<optimized out>, total_queues=total_queues@entry=1) at /usr/src/debug/qemu-2.10.0/hw/net/vhost_net.c:3
    6  0x00007f0af85ceba6 in virtio_net_set_status (status=<optimized out>, n=0x7f0afcba0170) at /usr/src/debug/qemu-2.10.0/hw/net/virtio-net.c:180
    7  0x00007f0af85ceba6 in virtio_net_set_status (vdev=0x7f0afcba0170, status=15 '\017') at /usr/src/debug/qemu-2.10.0/hw/net/virtio-net.c:254
    8  0x00007f0af85e0f2c in virtio_set_status (vdev=0x7f0afcba0170, val=<optimized out>) at /usr/src/debug/qemu-2.10.0/hw/virtio/virtio.c:1147
    9  0x00007f0af866dce2 in vm_state_notify (running=running@entry=0, state=state@entry=RUN_STATE_FINISH_MIGRATE) at vl.c:1623
    10 0x00007f0af858f11a in do_vm_stop (state=RUN_STATE_FINISH_MIGRATE, send_stop=send_stop@entry=true) at /usr/src/debug/qemu-2.10.0/cpus.c:941
    11 0x00007f0af858f159 in vm_stop (state=<optimized out>) at /usr/src/debug/qemu-2.10.0/cpus.c:1818
    12 0x00007f0af858f296 in vm_stop_force_state (state=state@entry=RUN_STATE_FINISH_MIGRATE) at /usr/src/debug/qemu-2.10.0/cpus.c:1868
    13 0x00007f0af87551d7 in migration_thread (start_time=<synthetic pointer>, old_vm_running=<synthetic pointer>, current_active_state=4, s=0x7f0afaf00500)
        at migration/migration.c:1956
    14 0x00007f0af87551d7 in migration_thread (opaque=0x7f0afaf00500) at migration/migration.c:2129
    15 0x00007f0af217fdc5 in start_thread () at /lib64/libpthread.so.0
    16 0x00007f0af1eae73d in clone () at /lib64/libc.so.6
    
    (gdb) l
    134 }
    135
    136 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
    137 {
    138     struct vhost_user *u = dev->opaque;
    139     CharBackend *chr = u->chr;
    140     uint8_t *p = (uint8_t *) msg;
    141     int r, size = VHOST_USER_HDR_SIZE;
    142
    143     r = qemu_chr_fe_read_all(chr, p, size);
    144     if (r != size) {
    145         error_report("Failed to read msg header. Read %d instead of %d."
    146                      " Original request %d.", r, size, msg->request);
    147         goto fail;
    148     }
    149
    150     /* validate received flags */
    151     if (msg->flags != (VHOST_USER_REPLY_MASK | VHOST_USER_VERSION)) {
    152         error_report("Failed to read msg header."
    153                 " Flags 0x%x instead of 0x%x.", msg->flags,
    (gdb) p u
    $1 = (struct vhost_user *) 0x0
    (gdb) p dev
    $2 = (struct vhost_dev *) 0x7f0afaee0340
    (gdb) p *dev
    $3 = {vdev = 0x0, memory_listener = {begin = 0x0, commit = 0x0, region_add = 0x0, region_del = 0x0, region_nop = 0x0, log_start = 0x0, log_stop = 0x0, log_sync = 0x0,
        log_global_start = 0x0, log_global_stop = 0x0, eventfd_add = 0x0, eventfd_del = 0x0, coalesced_mmio_add = 0x0, coalesced_mmio_del = 0x0, priority = 0, address_space = 0x0,
        link = {tqe_next = 0x0, tqe_prev = 0x0}, link_as = {tqe_next = 0x0, tqe_prev = 0x0}}, iommu_listener = {begin = 0x0, commit = 0x0, region_add = 0x0, region_del = 0x0,
        region_nop = 0x0, log_start = 0x0, log_stop = 0x0, log_sync = 0x0, log_global_start = 0x0, log_global_stop = 0x0, eventfd_add = 0x0, eventfd_del = 0x0, coalesced_mmio_add =
        0x0, coalesced_mmio_del = 0x0, priority = 0, address_space = 0x0, link = {tqe_next = 0x0, tqe_prev = 0x0}, link_as = {tqe_next = 0x0, tqe_prev = 0x0}}, mem = 0x0,
      n_mem_sections = 0, mem_sections = 0x0, vqs = 0x0, nvqs = 0, vq_index = 0, features = 0, acked_features = 0, backend_features = 0, protocol_features = 0, max_queues = 0,
      started = false, log_enabled = false, log_size = 0, migration_blocker = 0x0, memory_changed = false, mem_changed_start_addr = 0, mem_changed_end_addr = 0, vhost_ops = 0x0,
      opaque = 0x0, log = 0x0, entry = {le_next = 0x0, le_prev = 0x0}, iommu_list = {lh_first = 0x0}, n = {notify = 0x0, notifier_flags = IOMMU_NOTIFIER_NONE, start = 0, end = 0,
        node = {le_next = 0x0, le_prev = 0x0}}}
========================================================================

I checked the latest upstream qemu code, and found there was no new fix for this issue. 

Liang
> >
> > Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> > ---
> >  hw/net/vhost_net.c        |  6 ++++++
> >  hw/virtio/vhost-user.c    | 15 +++++++++++++--
> >  include/hw/virtio/vhost.h |  1 +
> >  include/net/vhost_net.h   |  1 +
> >  net/vhost-user.c          |  3 +++
> >  5 files changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index e037db6..77994e9 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -113,6 +113,11 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
> >              features);
> >  }
> >
> > +void vhost_net_mark_break_down(struct vhost_net *net)
> > +{
> > +    net->dev.break_down = true;
> > +}
> > +
> >  void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
> >  {
> >      net->dev.acked_features = net->dev.backend_features;
> > @@ -156,6 +161,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
> >      net->dev.max_queues = 1;
> >      net->dev.nvqs = 2;
> >      net->dev.vqs = net->vqs;
> > +    net->dev.break_down = false;
> >
> >      if (backend_kernel) {
> >          r = vhost_net_get_fd(options->net_backend);
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index b041343..1394719 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -213,14 +213,20 @@ static bool ioeventfd_enabled(void)
> >  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
> >  {
> >      struct vhost_user *u = dev->opaque;
> > -    CharBackend *chr = u->user->chr;
> > +    CharBackend *chr;
> >      uint8_t *p = (uint8_t *) msg;
> >      int r, size = VHOST_USER_HDR_SIZE;
> >
> > +    if (dev->break_down) {
> > +        goto fail;
> > +    }
> > +
> > +    chr = u->user->chr;
> >      r = qemu_chr_fe_read_all(chr, p, size);
> >      if (r != size) {
> >          error_report("Failed to read msg header. Read %d instead of %d."
> >                       " Original request %d.", r, size, msg->hdr.request);
> > +        dev->break_down = true;
> >          goto fail;
> >      }
> >
> > @@ -299,9 +305,12 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
> >                              int *fds, int fd_num)
> >  {
> >      struct vhost_user *u = dev->opaque;
> > -    CharBackend *chr = u->user->chr;
> > +    CharBackend *chr;
> >      int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
> >
> > +    if (dev->break_down) {
> > +        return -1;
> > +    }
> >      /*
> >       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
> >       * we just need send it once in the first time. For later such
> > @@ -312,6 +321,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
> >          return 0;
> >      }
> >
> > +    chr = u->user->chr;
> >      if (qemu_chr_fe_set_msgfds(chr, fds, fd_num) < 0) {
> >          error_report("Failed to set msg fds.");
> >          return -1;
> > @@ -319,6 +329,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
> >
> >      ret = qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
> >      if (ret != size) {
> > +        dev->break_down = true;
> >          error_report("Failed to write msg."
> >                       " Wrote %d instead of %d.", ret, size);
> >          return -1;
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index a7f449f..86d0dc5 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -74,6 +74,7 @@ struct vhost_dev {
> >      bool started;
> >      bool log_enabled;
> >      uint64_t log_size;
> > +    bool break_down;
> >      Error *migration_blocker;
> >      const VhostOps *vhost_ops;
> >      void *opaque;
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 77e4739..06f2c08 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -27,6 +27,7 @@ void vhost_net_cleanup(VHostNetState *net);
> >
> >  uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
> >  void vhost_net_ack_features(VHostNetState *net, uint64_t features);
> > +void vhost_net_mark_break_down(VHostNetState *net);
> >
> >  bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
> >  void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index a39f9c9..b99e20b 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -270,6 +270,9 @@ static void net_vhost_user_event(void *opaque, int event)
> >          if (s->watch) {
> >              AioContext *ctx = qemu_get_current_aio_context();
> >
> > +            if (s->vhost_net) {
> > +                vhost_net_mark_break_down(s->vhost_net);
> > +            }
> >              g_source_remove(s->watch);
> >              s->watch = 0;
> >              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> > --
> > 1.8.3.1
> >
> >
> 
> 
> -- 
> Marc-André Lureau
> 
