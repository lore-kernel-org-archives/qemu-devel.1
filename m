Received: from eggs.gnu.org ([2001:4830:134:3::10]:34016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0ojP-0008Ke-Uv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0ojM-00087E-PF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:33:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:13768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f0ojM-00086j-Gm
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:33:40 -0400
Date: Tue, 27 Mar 2018 21:32:02 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327133201.iauxquit2ji3igyh@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180319071537.28649-3-tiwei.bie@intel.com>
	<20180322165800-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322165800-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 2/6] vhost-user:
 introduce shared vhost-user state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 22, 2018 at 05:13:41PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:33PM +0800, Tiwei Bie wrote:
> > @@ -22,7 +23,7 @@
> >  
> >  typedef struct VhostUserState {
> >      NetClientState nc;
> > -    CharBackend chr; /* only queue index 0 */
> > +    VhostUser vhost_user; /* only queue index 0 */
> >      VHostNetState *vhost_net;
> >      guint watch;
> >      uint64_t acked_features;
> 
> Is the comment still valid?

The comment is still valid in this patch. But the
implementation in this patch is inelegant. I plan
to rewrite this patch.

> 
> > @@ -64,7 +65,7 @@ static void vhost_user_stop(int queues, NetClientState *ncs[])
> >      }
> >  }
> >  
> > -static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
> > +static int vhost_user_start(int queues, NetClientState *ncs[], void *be)
> >  {
> >      VhostNetOptions options;
> >      struct vhost_net *net = NULL;
> 
> Type safety going away here. This is actually pretty scary:
> are we sure no users cast this pointer to CharBackend?
> 
> For example it seems that vhost_user_init does exactly that.
> 
> Need to find a way to add type safety before making
> such a change.

I have changed vhost_user_init() to cast this pointer
to the new type (VhostUser) in this patch. But my bad,
I shouldn't change the type to 'void *'. Will fix this.

Best regards,
Tiwei Bie

> 
> 
> > @@ -158,7 +159,7 @@ static void vhost_user_cleanup(NetClientState *nc)
> >              g_source_remove(s->watch);
> >              s->watch = 0;
> >          }
> > -        qemu_chr_fe_deinit(&s->chr, true);
> > +        qemu_chr_fe_deinit(&s->vhost_user.chr, true);
> >      }
> >  
> >      qemu_purge_queued_packets(nc);
> > @@ -192,7 +193,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
> >  {
> >      VhostUserState *s = opaque;
> >  
> > -    qemu_chr_fe_disconnect(&s->chr);
> > +    qemu_chr_fe_disconnect(&s->vhost_user.chr);
> >  
> >      return TRUE;
> >  }
> > @@ -217,7 +218,8 @@ static void chr_closed_bh(void *opaque)
> >      qmp_set_link(name, false, &err);
> >      vhost_user_stop(queues, ncs);
> >  
> > -    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
> > +    qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
> > +                             net_vhost_user_event,
> >                               NULL, opaque, NULL, true);
> >  
> >      if (err) {
> > @@ -240,15 +242,15 @@ static void net_vhost_user_event(void *opaque, int event)
> >      assert(queues < MAX_QUEUE_NUM);
> >  
> >      s = DO_UPCAST(VhostUserState, nc, ncs[0]);
> > -    chr = qemu_chr_fe_get_driver(&s->chr);
> > +    chr = qemu_chr_fe_get_driver(&s->vhost_user.chr);
> >      trace_vhost_user_event(chr->label, event);
> >      switch (event) {
> >      case CHR_EVENT_OPENED:
> > -        if (vhost_user_start(queues, ncs, &s->chr) < 0) {
> > -            qemu_chr_fe_disconnect(&s->chr);
> > +        if (vhost_user_start(queues, ncs, &s->vhost_user) < 0) {
> > +            qemu_chr_fe_disconnect(&s->vhost_user.chr);
> >              return;
> >          }
> > -        s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> > +        s->watch = qemu_chr_fe_add_watch(&s->vhost_user.chr, G_IO_HUP,
> >                                           net_vhost_user_watch, s);
> >          qmp_set_link(name, true, &err);
> >          s->started = true;
> > @@ -264,8 +266,8 @@ static void net_vhost_user_event(void *opaque, int event)
> >  
> >              g_source_remove(s->watch);
> >              s->watch = 0;
> > -            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> > -                                     NULL, NULL, false);
> > +            qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL, NULL,
> > +                                     NULL, NULL, NULL, false);
> >  
> >              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> >          }
> > @@ -297,7 +299,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> >          if (!nc0) {
> >              nc0 = nc;
> >              s = DO_UPCAST(VhostUserState, nc, nc);
> > -            if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
> > +            if (!qemu_chr_fe_init(&s->vhost_user.chr, chr, &err)) {
> >                  error_report_err(err);
> >                  return -1;
> >              }
> > @@ -307,11 +309,11 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> >  
> >      s = DO_UPCAST(VhostUserState, nc, nc0);
> >      do {
> > -        if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
> > +        if (qemu_chr_fe_wait_connected(&s->vhost_user.chr, &err) < 0) {
> >              error_report_err(err);
> >              return -1;
> >          }
> > -        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> > +        qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
> >                                   net_vhost_user_event, NULL, nc0->name, NULL,
> >                                   true);
> >      } while (!s->started);
> > -- 
> > 2.11.0
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
