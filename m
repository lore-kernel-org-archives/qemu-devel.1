Received: from eggs.gnu.org ([2001:4830:134:3::10]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrGV-0006AT-VQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrGR-0005MK-8Z
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:30:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLrGR-0005M5-30
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:30:47 -0400
Date: Thu, 24 May 2018 17:30:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524173015-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-3-tiwei.bie@intel.com>
	<20180523163116-mutt-send-email-mst@kernel.org>
	<20180523183444-mutt-send-email-mst@kernel.org>
	<20180523184001-mutt-send-email-mst@kernel.org>
	<20180523232101.GB15604@debian> <20180524022440.GA20792@debian>
	<20180524105936.GA22101@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524105936.GA22101@debian>
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
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, May 24, 2018 at 06:59:36PM +0800, Tiwei Bie wrote:
> On Thu, May 24, 2018 at 10:24:40AM +0800, Tiwei Bie wrote:
> > On Thu, May 24, 2018 at 07:21:01AM +0800, Tiwei Bie wrote:
> > > On Wed, May 23, 2018 at 06:43:29PM +0300, Michael S. Tsirkin wrote:
> > > > On Wed, May 23, 2018 at 06:36:05PM +0300, Michael S. Tsirkin wrote:
> > > > > On Wed, May 23, 2018 at 04:44:51PM +0300, Michael S. Tsirkin wrote:
> > > > > > On Thu, Apr 12, 2018 at 11:12:28PM +0800, Tiwei Bie wrote:
> > > > > > > When multi queue is enabled e.g. for a virtio-net device,
> > > > > > > each queue pair will have a vhost_dev, and the only thing
> > > > > > > shared between vhost devs currently is the chardev. This
> > > > > > > patch introduces a vhost-user state structure which will
> > > > > > > be shared by all vhost devs of the same virtio device.
> > > > > > > 
> > > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > 
> > > > > > Unfortunately this patch seems to cause crashes.
> > > > > > To reproduce, simply run
> > > > > > make check-qtest-x86_64
> > > > > > 
> > > > > > Sorry that it took me a while to find - it triggers 90% of runs but not
> > > > > > 100% which complicates bisection somewhat.
> > > 
> > > It's my fault to not notice this bug before.
> > > I'm very sorry. Thank you so much for finding
> > > the root cause!
> > > 
> > > > > > 
> > > > > > > ---
> > > > > > >  backends/cryptodev-vhost-user.c     | 20 ++++++++++++++++++-
> > > > > > >  hw/block/vhost-user-blk.c           | 22 +++++++++++++++++++-
> > > > > > >  hw/scsi/vhost-user-scsi.c           | 20 ++++++++++++++++++-
> > > > > > >  hw/virtio/Makefile.objs             |  2 +-
> > > > > > >  hw/virtio/vhost-stub.c              | 10 ++++++++++
> > > > > > >  hw/virtio/vhost-user.c              | 31 +++++++++++++++++++---------
> > > > > > >  include/hw/virtio/vhost-user-blk.h  |  2 ++
> > > > > > >  include/hw/virtio/vhost-user-scsi.h |  2 ++
> > > > > > >  include/hw/virtio/vhost-user.h      | 20 +++++++++++++++++++
> > > > > > >  net/vhost-user.c                    | 40 ++++++++++++++++++++++++++++++-------
> > > > > > >  10 files changed, 149 insertions(+), 20 deletions(-)
> > > > > > >  create mode 100644 include/hw/virtio/vhost-user.h
> > > [...]
> > > > > > >          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> > > > > > >                                   net_vhost_user_event, NULL, nc0->name, NULL,
> > > > > > > @@ -319,6 +336,15 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> > > > > > >      assert(s->vhost_net);
> > > > > > >  
> > > > > > >      return 0;
> > > > > > > +
> > > > > > > +err:
> > > > > > > +    if (user) {
> > > > > > > +        vhost_user_cleanup(user);
> > > > > > > +        g_free(user);
> > > > > > > +        s->vhost_user = NULL;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    return -1;
> > > > > > >  }
> > > > > > >  
> > > > > > >  static Chardev *net_vhost_claim_chardev(
> > > > > > > -- 
> > > > > > > 2.11.0
> > > > > 
> > > > > So far I figured out that commenting the free of
> > > > > the structure removes the crash, so we seem to
> > > > > be dealing with a use-after free here.
> > > > > I suspect that in a MQ situation, one queue gets
> > > > > closed and attempts to free the structure
> > > > > while others still use it.
> > > > > 
> > > > > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > > > > index 525a061..6a1573b 100644
> > > > > --- a/net/vhost-user.c
> > > > > +++ b/net/vhost-user.c
> > > > > @@ -157,8 +157,8 @@ static void net_vhost_user_cleanup(NetClientState *nc)
> > > > >          s->vhost_net = NULL;
> > > > >      }
> > > > >      if (s->vhost_user) {
> > > > > -        vhost_user_cleanup(s->vhost_user);
> > > > > -        g_free(s->vhost_user);
> > > > > +        //vhost_user_cleanup(s->vhost_user);
> > > > > +        //g_free(s->vhost_user);
> > > > >          s->vhost_user = NULL;
> > > > >      }
> > > > >      if (nc->queue_index == 0) {
> > > > > @@ -339,8 +339,8 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> > > > >  
> > > > >  err:
> > > > >      if (user) {
> > > > > -        vhost_user_cleanup(user);
> > > > > -        g_free(user);
> > > > > +        //vhost_user_cleanup(user);
> > > > > +        //g_free(user);
> > > > >          s->vhost_user = NULL;
> > > > >      }
> > > > >  
> > > > 
> > > > 
> > > > So the following at least gets rid of the crashes.
> > > > I am not sure it does not leak memory though,
> > > > and not sure there aren't any configurations where
> > > > the 1st queue gets cleaned up first.
> > > > 
> > > > Thoughts?
> > > 
> > > Thank you so much for catching it and fixing
> > > it! I'll keep your SoB there. Thank you so
> > > much! I do appreciate it!
> > > 
> > > You are right. This structure is freed multiple
> > > times when multi-queue is enabled.
> > 
> > After a deeper digging, I got your point now..
> > It could be a use-after-free instead of a double
> > free.. As it's safe to deinit the char which is
> > shared by all queue pairs when cleanup the 1st
> > queue pair, it should be safe to free vhost-user
> > structure there too.
> 
> One thing worried me is that, I can't reproduce
> the crash with `make check-qtest-x86_64`.

I sent a patch that will make test fail on qemu coredump.

> I tried
> to run it a lot of times, but the only output I
> got each time was:
> 
>         CHK version_gen.h
>   GTESTER check-qtest-x86_64
> 
> I did a quick glance of the `check-qtest-x86_64`
> target in the makefile, it seems that the relevant
> test is `tests/vhost-user-test`. So I also tried
> to run this test directly:
> 
> make tests/vhost-user-test
> while true; do
>   QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 ./tests/vhost-user-test
> done
> 
> And the only output in each loop I got was:
> 
> /x86_64/vhost-user/migrate: OK
> /x86_64/vhost-user/multiqueue: OK
> /x86_64/vhost-user/read-guest-mem/memfd: OK
> /x86_64/vhost-user/read-guest-mem/memfile: OK
> 
> So I'm still not quite sure what caused the crash
> on your side. But it does make more sense to free
> the vhost-user structure only when cleanup the
> 1st queue pair (i.e. where the `chr` is deinit-ed).
> 
> I have sent a new patch set with above change:
> 
> http://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05508.html
> https://patchwork.kernel.org/bundle/btw/vhost-user-host-notifiers/
> 
> Because the above change is got from your diff
> and also based on your analysis, I kept your SoB
> in that patch (if you have any concern about it,
> please let me know).
> 
> In this patch set, I also introduced a protocol
> feature to allow slave to send fds to master via
> the slave channel.
> 
> If you still see crashes with the new patch set,
> please provide me a bit more details, e.g. the
> crash message. Thanks a lot!
> 
> Best regards,
> Tiwei Bie
