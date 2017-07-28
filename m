Received: from eggs.gnu.org ([2001:4830:134:3::10]:60310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1db1Qh-0005xt-CF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1db1Qd-0005Sw-5C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1db1Qc-0005R2-Rm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:27 -0400
Date: Fri, 28 Jul 2017 11:19:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170728111918.33a1dee8@nial.brq.redhat.com>
In-Reply-To: <20170726185814-mutt-send-email-mst@kernel.org>
References: <1500813971-82408-1-git-send-email-peng.hao2@zte.com.cn>
	<20170724111419.720aa168@nial.brq.redhat.com>
	<20170724234849-mutt-send-email-mst@kernel.org>
	<20170725104438.5eb90865@nial.brq.redhat.com>
	<20170725161025-mutt-send-email-mst@kernel.org>
	<20170726160543.1a66bf10@nial.brq.redhat.com>
	<20170726185814-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 26 Jul 2017 19:01:39 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 26, 2017 at 04:05:43PM +0200, Igor Mammedov wrote:
> > On Tue, 25 Jul 2017 22:47:18 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, Jul 25, 2017 at 10:44:38AM +0200, Igor Mammedov wrote:  
> > > > On Mon, 24 Jul 2017 23:50:00 +0300
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >     
> > > > > On Mon, Jul 24, 2017 at 11:14:19AM +0200, Igor Mammedov wrote:    
> > > > > > On Sun, 23 Jul 2017 20:46:11 +0800
> > > > > > Peng Hao <peng.hao2@zte.com.cn> wrote:
> > > > > >       
> > > > > > > When a guest that has several hotplugged dimms is migrated, on
> > > > > > > destination it will fail to resume. Because regions on source
> > > > > > > are merged and on destination the order of realizing devices
> > > > > > > is different from on source with dimms, so when part of devices
> > > > > > > are realizd some region can not be merged.That may be more than
> > > > > > > vhost slot limit.
> > > > > > > 
> > > > > > > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > > > > > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > > > > > ---
> > > > > > >  hw/mem/pc-dimm.c        | 2 +-
> > > > > > >  include/sysemu/sysemu.h | 1 +
> > > > > > >  vl.c                    | 5 +++++
> > > > > > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > > > > > index ea67b46..13f3db5 100644
> > > > > > > --- a/hw/mem/pc-dimm.c
> > > > > > > +++ b/hw/mem/pc-dimm.c
> > > > > > > @@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > > > > > >          goto out;
> > > > > > >      }
> > > > > > >  
> > > > > > > -    if (!vhost_has_free_slot()) {
> > > > > > > +    if (!vhost_has_free_slot() && qemu_is_machine_init_done()) {
> > > > > > >          error_setg(&local_err, "a used vhost backend has no free"
> > > > > > >                                 " memory slots left");      
> > > > > > that doesn't fix issue,
> > > > > >    1st: number of used entries is changing after machine_init_done() is called
> > > > > >         as regions continue to mapped/unmapped during runtime      
> > > > > 
> > > > > But that's fine, we want hotplug to fail if we can not guarantee vhost
> > > > > will work.    
> > > > don't we want guarantee that vhost will work with dimm devices at startup
> > > > if it were requested on CLI or fail startup cleanly if it can't?    
> > > 
> > > Yes. And failure to start vhost will achieve this without need to much with
> > > DIMMs. The issue is only with DIMM hotplug when vhost is already running,
> > > specifically because notifiers have no way to report or handle errors.
> > >   
> > > > >     
> > > > > >    2nd: it brings regression and allows to start QEMU with number memory
> > > > > >         regions more than supported by backend, which combined with missing
> > > > > >         error handling in vhost will lead to qemu crashes or obscure bugs in
> > > > > >         guest breaking vhost enabled drivers.
> > > > > >         i.e. patch undoes what were fixed by
> > > > > >         https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00789.html      
> > > > > 
> > > > > Why does it? The issue you fixed there is hotplug, and that means
> > > > > pc_dimm_memory_plug called after machine done.    
> > > > I wasn't able to crash fc24 guest with current qemu/rhen7 kernel,
> > > > it fallbacks back to virtio and switches off vhost.     
> > > 
> > > I think vhostforce should make vhost fail and not fall back,
> > > but that is another bug.  
> > currently vhostforce is broken, qemu continues to happily run with this patch
> > and without patch it fails to start up so I'd just NACK this patch
> > on this behavioral change and ask to fix both issues in the same series.  
> 
> Please do not send nacks. They are not really helpful.
> 
> Ack is like +1. You save some space since all you are saying is "all's
> well". But if there's an issue you want to explain what it is 99% of the
> time. So nack does not save any space and just pushes contributors away.
> Especially if it's in all caps, that's just against netiquette.
I'm sorry to the author if it were taken as offense,
an intent was to say that by itself patch allows to start QEMU in invalid
configuration and that it should be fixed as well.

Anyway I've just posted an alternative patch that should workaround issue
at the hand while not removing check:
[PATCH for 2.10] pc: make 'pc.rom' readonly when machine has PCI enabled

Peng Hao,
could you check if it solves the problem for you
