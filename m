Received: from eggs.gnu.org ([2001:4830:134:3::10]:55734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ft9YP-0001eK-3g
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ft9YL-00078b-V2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ft9YL-00077h-Nj
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:42:53 -0400
Date: Fri, 24 Aug 2018 07:42:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180824104246.GU3778@localhost.localdomain>
References: <201808241718451351057@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808241718451351057@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V3 2/4] target-i386:add coalesced_pio API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On Fri, Aug 24, 2018 at 05:18:45PM +0800, peng.hao2@zte.com.cn wrote:
[...]
> > > -            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
> > > +            if (ent->pio == 1) {
> > > +                address_space_rw(&address_space_io, ent->phys_addr,
> > > +                                 MEMTXATTRS_NONE, ent->data, ent->len, true);
> 
> > Why exactly MEMTXATTRS_NONE is the right attrs argument here?
> > Why MEMTXATTRS_UNSPECIFIED wouldn't work?
> 
> I didn't notice MEMTXATTRS_NONE is the same as MEMTXATTRS_UNSPECIFIED.
> MEMTXATTRS_NONE is redundant.

They are not exactly the same (see below), but in either case I'm
not sure it would make any difference for PIO.


> >> +            } else {
> >> +                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
> >> +            }
> >>              smp_wmb();
> >>              ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
> >>          }
> >> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> >> index d4a1642..12fd64f 100644
> >> --- a/include/exec/memattrs.h
> >> +++ b/include/exec/memattrs.h
> >> @@ -45,7 +45,7 @@ typedef struct MemTxAttrs {
> >>   * from "didn't specify" if necessary).
> >>   */
> >>  #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
> >> -
> >> +#define MEMTXATTRS_NONE ((MemTxAttrs) { 0 })


-- 
Eduardo
