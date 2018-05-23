Received: from eggs.gnu.org ([2001:4830:134:3::10]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLd3m-0001J5-TY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLd3j-0002Yw-Ns
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:20:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:25097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLd3j-0002YJ-9y
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:20:43 -0400
Date: Thu, 24 May 2018 07:21:01 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180523232101.GB15604@debian>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-3-tiwei.bie@intel.com>
	<20180523163116-mutt-send-email-mst@kernel.org>
	<20180523183444-mutt-send-email-mst@kernel.org>
	<20180523184001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523184001-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vhost-user: introduce shared
 vhost-user state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Wed, May 23, 2018 at 06:43:29PM +0300, Michael S. Tsirkin wrote:
> On Wed, May 23, 2018 at 06:36:05PM +0300, Michael S. Tsirkin wrote:
> > On Wed, May 23, 2018 at 04:44:51PM +0300, Michael S. Tsirkin wrote:
> > > On Thu, Apr 12, 2018 at 11:12:28PM +0800, Tiwei Bie wrote:
> > > > When multi queue is enabled e.g. for a virtio-net device,
> > > > each queue pair will have a vhost_dev, and the only thing
> > > > shared between vhost devs currently is the chardev. This
> > > > patch introduces a vhost-user state structure which will
> > > > be shared by all vhost devs of the same virtio device.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > 
> > > Unfortunately this patch seems to cause crashes.
> > > To reproduce, simply run
> > > make check-qtest-x86_64
> > > 
> > > Sorry that it took me a while to find - it triggers 90% of runs but not
> > > 100% which complicates bisection somewhat.

It's my fault to not notice this bug before.
I'm very sorry. Thank you so much for finding
the root cause!

> > > 
> > > > ---
> > > >  backends/cryptodev-vhost-user.c     | 20 ++++++++++++++++++-
> > > >  hw/block/vhost-user-blk.c           | 22 +++++++++++++++++++-
> > > >  hw/scsi/vhost-user-scsi.c           | 20 ++++++++++++++++++-
> > > >  hw/virtio/Makefile.objs             |  2 +-
> > > >  hw/virtio/vhost-stub.c              | 10 ++++++++++
> > > >  hw/virtio/vhost-user.c              | 31 +++++++++++++++++++---------
> > > >  include/hw/virtio/vhost-user-blk.h  |  2 ++
> > > >  include/hw/virtio/vhost-user-scsi.h |  2 ++
> > > >  include/hw/virtio/vhost-user.h      | 20 +++++++++++++++++++
> > > >  net/vhost-user.c                    | 40 ++++++++++++++++++++++++++++++-------
> > > >  10 files changed, 149 insertions(+), 20 deletions(-)
> > > >  create mode 100644 include/hw/virtio/vhost-user.h
[...]
> > > >          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> > > >                                   net_vhost_user_event, NULL, nc0->name, NULL,
> > > > @@ -319,6 +336,15 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> > > >      assert(s->vhost_net);
> > > >  
> > > >      return 0;
> > > > +
> > > > +err:
> > > > +    if (user) {
> > > > +        vhost_user_cleanup(user);
> > > > +        g_free(user);
> > > > +        s->vhost_user = NULL;
> > > > +    }
> > > > +
> > > > +    return -1;
> > > >  }
> > > >  
> > > >  static Chardev *net_vhost_claim_chardev(
> > > > -- 
> > > > 2.11.0
> > 
> > So far I figured out that commenting the free of
> > the structure removes the crash, so we seem to
> > be dealing with a use-after free here.
> > I suspect that in a MQ situation, one queue gets
> > closed and attempts to free the structure
> > while others still use it.
> > 
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index 525a061..6a1573b 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -157,8 +157,8 @@ static void net_vhost_user_cleanup(NetClientState *nc)
> >          s->vhost_net = NULL;
> >      }
> >      if (s->vhost_user) {
> > -        vhost_user_cleanup(s->vhost_user);
> > -        g_free(s->vhost_user);
> > +        //vhost_user_cleanup(s->vhost_user);
> > +        //g_free(s->vhost_user);
> >          s->vhost_user = NULL;
> >      }
> >      if (nc->queue_index == 0) {
> > @@ -339,8 +339,8 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> >  
> >  err:
> >      if (user) {
> > -        vhost_user_cleanup(user);
> > -        g_free(user);
> > +        //vhost_user_cleanup(user);
> > +        //g_free(user);
> >          s->vhost_user = NULL;
> >      }
> >  
> 
> 
> So the following at least gets rid of the crashes.
> I am not sure it does not leak memory though,
> and not sure there aren't any configurations where
> the 1st queue gets cleaned up first.
> 
> Thoughts?

Thank you so much for catching it and fixing
it! I'll keep your SoB there. Thank you so
much! I do appreciate it!

You are right. This structure is freed multiple
times when multi-queue is enabled.

I think it's safe to let the first queue pair
free the vhost-user structure, because it won't
be touched by other queue pairs during cleanup.

Best regards,
Tiwei Bie


> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 525a061..7549d25 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -156,19 +156,20 @@ static void net_vhost_user_cleanup(NetClientState *nc)
>          g_free(s->vhost_net);
>          s->vhost_net = NULL;
>      }
> -    if (s->vhost_user) {
> -        vhost_user_cleanup(s->vhost_user);
> -        g_free(s->vhost_user);
> -        s->vhost_user = NULL;
> -    }
>      if (nc->queue_index == 0) {
>          if (s->watch) {
>              g_source_remove(s->watch);
>              s->watch = 0;
>          }
>          qemu_chr_fe_deinit(&s->chr, true);
> +        if (s->vhost_user) {
> +            vhost_user_cleanup(s->vhost_user);
> +            g_free(s->vhost_user);
> +        }
>      }
>  
> +    s->vhost_user = NULL;
> +
>      qemu_purge_queued_packets(nc);
>  }
>  
> @@ -341,7 +342,6 @@ err:
>      if (user) {
>          vhost_user_cleanup(user);
>          g_free(user);
> -        s->vhost_user = NULL;
>      }
>  
>      return -1;
