Received: from eggs.gnu.org ([2001:4830:134:3::10]:38598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYZ8J-00048D-Us
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYZ8F-0008J2-51
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dYZ8E-0008IZ-SN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:42:19 -0400
Date: Fri, 21 Jul 2017 16:41:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170721164158.72fc3798@nial.brq.redhat.com>
In-Reply-To: <20170719184748-mutt-send-email-mst@kernel.org>
References: <1500477452-59643-1-git-send-email-peng.hao2@zte.com.cn>
	<20170719095058.4d46359d@Igors-MacBook-Pro.local>
	<20170719114612.GC3500@work-vm>
	<20170719152427.620b2a2a@nial.brq.redhat.com>
	<20170719184748-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a migration failed because of
 vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>, qemu-devel@nongnu.org

On Wed, 19 Jul 2017 18:52:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 19, 2017 at 03:24:27PM +0200, Igor Mammedov wrote:
> > On Wed, 19 Jul 2017 12:46:13 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Igor Mammedov (imammedo@redhat.com) wrote:  
> > > > On Wed, 19 Jul 2017 23:17:32 +0800
> > > > Peng Hao <peng.hao2@zte.com.cn> wrote:
> > > >     
> > > > > When a guest that has several hotplugged dimms is migrated, in
> > > > > destination host it will fail to resume. Because vhost regions of
> > > > > several dimms in source host are merged and in the restore stage
> > > > > in destination host it computes whether more than vhost slot limit
> > > > > before merging vhost regions of several dimms.    
> > > > could you provide a bit more detailed description of the problem
> > > > including command line+used device_add commands on source and
> > > > command line on destination?    
> > > 
> > > (ccing in Marc Andre and Maxime)
> > > 
> > > Hmm, I'd like to understade the situation where you get merging between
> > > RAMBlocks; that complicates some stuff for postcopy.  
> > and probably inconsistent merging breaks vhost as well
> > 
> > merging might happen if regions are adjacent or overlap
> > but for that to happen merged regions must have equal
> > distance between their GPA:HVA pairs, so that following
> > translation would work:
> > 
> > if gva in regionX[gva_start, len, hva_start]
> >    hva = hva_start + gva - gva_start
> > 
> > while GVA of regions is under QEMU control and deterministic
> > HVA is not, so in migration case merging might happen on source
> > side but not on destination, resulting in different memory maps.
> > 
> > Maybe Michael might know details why migration works in vhost usecase,
> > but I don't see vhost sending any vmstate data.  
> 
> We aren't merging ramblocks at all.
> When we are passing blocks A and B to vhost, if we see that
> 
> hvaB=hvaA + lenA
> gpaB=gpaA + lenA
> 
> then we can improve performance a bit by passing a single
> chunk to vhost: hvaA,gpaA,lena+lenB
kernel used to maintain flat array map for look up where
such optimization could give some benefit which is negligible
as in practice merging reduces array size only by ~5 entries.

In addition kernel backend has been converted to interval tree
as flat array doesn't scale, so merging doesn't really matters
there anymore.

If we can get rid of merging on QEMU side, resulting memory
map will become of the same size regardless of the order
in which entries are added or chancy random allocation
that could allow region merging (i.e. size will become
deterministic).

Looking at vhost_user_set_mem_table() it sends actual number of
entries to backend over the wire, so it shouldn't break backend
if it were written right (i.e. uses msg.payload.memory.nregions
instead of VHOST_MEMORY_MAX_NREGIONS from QEMU.), if it breaks
then it's backend's fault and it should be fixed.

Another thing that could break is too low limit
 VHOST_MEMORY_MAX_NREGIONS = 8
and QEMU started with default options takes upto 7 entries in map
unmerged, so any configuration that consumes additional slots won't
start after upgrade. We could counter the most of issues by rising
VHOST_MEMORY_MAX_NREGIONS limit and/or teaching vhost-user protocol
to fetch limit from backend similar to vhost_kernel_memslots_limit().


> so it does not affect migration normally.
> 
> >   
> > >   
> > > > > 
> > > > > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > > > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > > > ---
> > > > >  hw/mem/pc-dimm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > > > index ea67b46..bb0fa08 100644
> > > > > --- a/hw/mem/pc-dimm.c
> > > > > +++ b/hw/mem/pc-dimm.c
> > > > > @@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > > > >          goto out;
> > > > >      }
> > > > >  
> > > > > -    if (!vhost_has_free_slot()) {
> > > > > +    if (!vhost_has_free_slot() && runstate_is_running()) {
> > > > >          error_setg(&local_err, "a used vhost backend has no free"
> > > > >                                 " memory slots left");
> > > > >          goto out;    
> > > 
> > > Even this produces the wrong error message in this case,
> > > it also makes me think if the existing code should undo a lot of
> > > the object_property_set's that happen.
> > > 
> > > Dave  
> > > > 
> > > >     
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK  
