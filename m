Received: from eggs.gnu.org ([2001:4830:134:3::10]:53502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1da5nm-0002GY-2Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1da5ni-0003es-4n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1da5nh-0003em-RQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:47:26 -0400
Date: Tue, 25 Jul 2017 22:47:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170725161025-mutt-send-email-mst@kernel.org>
References: <1500813971-82408-1-git-send-email-peng.hao2@zte.com.cn>
	<20170724111419.720aa168@nial.brq.redhat.com>
	<20170724234849-mutt-send-email-mst@kernel.org>
	<20170725104438.5eb90865@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725104438.5eb90865@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] vhost: fix a migration failed because
 of vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>, qemu-devel@nongnu.org

On Tue, Jul 25, 2017 at 10:44:38AM +0200, Igor Mammedov wrote:
> On Mon, 24 Jul 2017 23:50:00 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 24, 2017 at 11:14:19AM +0200, Igor Mammedov wrote:
> > > On Sun, 23 Jul 2017 20:46:11 +0800
> > > Peng Hao <peng.hao2@zte.com.cn> wrote:
> > >   
> > > > When a guest that has several hotplugged dimms is migrated, on
> > > > destination it will fail to resume. Because regions on source
> > > > are merged and on destination the order of realizing devices
> > > > is different from on source with dimms, so when part of devices
> > > > are realizd some region can not be merged.That may be more than
> > > > vhost slot limit.
> > > > 
> > > > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > > ---
> > > >  hw/mem/pc-dimm.c        | 2 +-
> > > >  include/sysemu/sysemu.h | 1 +
> > > >  vl.c                    | 5 +++++
> > > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > > index ea67b46..13f3db5 100644
> > > > --- a/hw/mem/pc-dimm.c
> > > > +++ b/hw/mem/pc-dimm.c
> > > > @@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > > >          goto out;
> > > >      }
> > > >  
> > > > -    if (!vhost_has_free_slot()) {
> > > > +    if (!vhost_has_free_slot() && qemu_is_machine_init_done()) {
> > > >          error_setg(&local_err, "a used vhost backend has no free"
> > > >                                 " memory slots left");  
> > > that doesn't fix issue,
> > >    1st: number of used entries is changing after machine_init_done() is called
> > >         as regions continue to mapped/unmapped during runtime  
> > 
> > But that's fine, we want hotplug to fail if we can not guarantee vhost
> > will work.
> don't we want guarantee that vhost will work with dimm devices at startup
> if it were requested on CLI or fail startup cleanly if it can't?

Yes. And failure to start vhost will achieve this without need to much with
DIMMs. The issue is only with DIMM hotplug when vhost is already running,
specifically because notifiers have no way to report or handle errors.

> > 
> > >    2nd: it brings regression and allows to start QEMU with number memory
> > >         regions more than supported by backend, which combined with missing
> > >         error handling in vhost will lead to qemu crashes or obscure bugs in
> > >         guest breaking vhost enabled drivers.
> > >         i.e. patch undoes what were fixed by
> > >         https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00789.html  
> > 
> > Why does it? The issue you fixed there is hotplug, and that means
> > pc_dimm_memory_plug called after machine done.
> I wasn't able to crash fc24 guest with current qemu/rhen7 kernel,
> it fallbacks back to virtio and switches off vhost. 

I think vhostforce should make vhost fail and not fall back,
but that is another bug.

> 
> > 
> > >   
> > > >          goto out;
> > > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > > index b213696..48228ad 100644
> > > > --- a/include/sysemu/sysemu.h
> > > > +++ b/include/sysemu/sysemu.h
> > > > @@ -88,6 +88,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info);
> > > >  void qemu_add_exit_notifier(Notifier *notify);
> > > >  void qemu_remove_exit_notifier(Notifier *notify);
> > > >  
> > > > +bool qemu_is_machine_init_done(void);
> > > >  void qemu_add_machine_init_done_notifier(Notifier *notify);
> > > >  void qemu_remove_machine_init_done_notifier(Notifier *notify);
> > > >  
> > > > diff --git a/vl.c b/vl.c
> > > > index fb6b2ef..43aee22 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -2681,6 +2681,11 @@ static void qemu_run_exit_notifiers(void)
> > > >  
> > > >  static bool machine_init_done;
> > > >  
> > > > +bool qemu_is_machine_init_done(void)
> > > > +{
> > > > +    return machine_init_done;
> > > > +}
> > > > +
> > > >  void qemu_add_machine_init_done_notifier(Notifier *notify)
> > > >  {
> > > >      notifier_list_add(&machine_init_done_notifiers, notify);  
