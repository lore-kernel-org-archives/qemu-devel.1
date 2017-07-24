Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZkO1-0000Hh-LQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZkNy-0007Vj-Il
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZkNy-0007VI-89
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:55:26 -0400
Date: Mon, 24 Jul 2017 23:55:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170724235248-mutt-send-email-mst@kernel.org>
References: <201707241832350823841@zte.com.cn>
	<20170724135333.083d8934@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724135333.083d8934@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] vhost: fix a migration failed becauseof
 vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peng.hao2@zte.com.cn, wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

On Mon, Jul 24, 2017 at 01:53:33PM +0200, Igor Mammedov wrote:
> On Mon, 24 Jul 2017 18:32:35 +0800 (CST)
> <peng.hao2@zte.com.cn> wrote:
> 
> > > On Sun, 23 Jul 2017 20:46:11 +0800  
> > 
> > 
> > 
> > 
> > 
> > > Peng Hao <peng.hao2@zte.com.cn> wrote:  
> > 
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
> > > >          goto out
> > > >      }
> > > >  
> > > > -    if (!vhost_has_free_slot()) {
> > > > +    if (!vhost_has_free_slot() && qemu_is_machine_init_done()) {
> > > >          error_setg(&local_err, "a used vhost backend has no free"
> > > >                                 " memory slots left")  
> > > that doesn't fix issue,
> > >    1st: number of used entries is changing after machine_init_done() is called
> > >         as regions continue to mapped/unmapped during runtime
> > >    2nd: it brings regression and allows to start QEMU with number memory
> > >         regions more than supported by backend, which combined with missing
> > >         error handling in vhost will lead to qemu crashes or obscure bugs in
> >  >        guest breaking vhost enabled drivers.
> > >         i.e. patch undoes what were fixed by
> > >         https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00789.html  
> > I don't think I undo the previous patch. There are tow scenarios :
> > 
> > hotplugging memory happens after machine_init_done(). so the modified code is no 
> > 
> > influence.
> > 
> > hotplugged memory's VM is just migrated . on source its regions is less than 
> > 
> > supported by backend ,so on destination it should satisfy. During restoring VM's regions
> > 
> > may be more than supported by backend but after machine_init_done VM's regions
> > 
> > 
> > 
> > can be less than  supported by backend.
> 
> here is simulation with vhost-kernel where /sys/module/vhost/parameters/max_mem_regions set to 8
> for limit to look like vhost user.
> 
> qemu-system-x86_64 --enable-kvm -m 128,slots=256,maxmem=1T  \
>  -netdev type=tap,id=guest0,vhost=on,script=/bin/true,vhostforce \
>  -device virtio-net-pci,netdev=guest0 \
>  `i=0; while [ $i -lt 10 ]; do echo "-object memory-backend-ram,id=m$i,size=128M -device pc-dimm,id=d$i,memdev=m$i"; i=$(($i + 1)); done`
> 
> it end ups with 12 used_memslots, and prints following error messages:
> 
> qemu-system-x86_64: vhost_set_mem_table failed: Argument list too long (7)
> qemu-system-x86_64: unable to start vhost net: 7: falling back on userspace virtio
> 
> above CLI should fail to startup as it's above supported limit even with merging
> (with merging available slots is 'random' number and merging could happen regardless
> of the order devices are created).

Without hotplug there is not need to fail it early at all.
It should fail in vhost, need to debug it - falling back should
only happen when vhost is not forced.


> 
> vhost_dev_init() also has checks vhost_backend_memslots_limit(),
> and skipping check in pc_dimm_memory_plug() might lead to failure
> later in vhost_dev_init() - I'm not sure when it's called and to what
> consequences it would lead.

It should fail cleanly. Only reason for your patch is for memory hotplug
where it's too late to stop vhost.

> > >          goto out
> > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > index b213696..48228ad 100644
> > > --- a/include/sysemu/sysemu.h
> > > +++ b/include/sysemu/sysemu.h
> > > @@ -88,6 +88,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
> > >  void qemu_add_exit_notifier(Notifier *notify)
> > >  void qemu_remove_exit_notifier(Notifier *notify)
> > >  
> > > +bool qemu_is_machine_init_done(void)
> > >  void qemu_add_machine_init_done_notifier(Notifier *notify)
> > >  void qemu_remove_machine_init_done_notifier(Notifier *notify)
> > >  
> > > diff --git a/vl.c b/vl.c
> > > index fb6b2ef..43aee22 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -2681,6 +2681,11 @@ static void qemu_run_exit_notifiers(void)
> > >  
> > >  static bool machine_init_done
> > >  
> > > +bool qemu_is_machine_init_done(void)
> > > +{
> > > +    return machine_init_done
> > > +}
> > > +
> > >  void qemu_add_machine_init_done_notifier(Notifier *notify)
> > >  {
> > >      notifier_list_add(&machine_init_done_notifiers, notify  
