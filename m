Received: from eggs.gnu.org ([209.51.188.92]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grhNr-0007Td-JM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grhNq-0002Qi-RL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1grhNq-0002OK-Jv
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:58:18 -0500
Date: Thu, 7 Feb 2019 11:49:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190207114947.2d96ed9e@Igors-MacBook-Pro.local>
In-Reply-To: <20190206235515.r2h6sk74uggt7qg3@master>
References: <20190201010837.19278-1-richardw.yang@linux.intel.com>
	<20190206125949.511438c9@Igors-MacBook-Pro.local>
	<20190206235515.r2h6sk74uggt7qg3@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-dimm: use same mechanism for
 [get|set]_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com

On Wed, 6 Feb 2019 23:55:15 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Wed, Feb 06, 2019 at 12:59:49PM +0100, Igor Mammedov wrote:
> >On Fri,  1 Feb 2019 09:08:37 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> >> [get|set]_addr are two counterpart to access PCDIMMDevice.addr.
> >> 
> >> Since we have already set up a property PC_DIMM_ADDR_PROP for this
> >> field and use this mechanism in set_addr, it would be more proper to use
> >> the same mechanism in set_addr.
> >> 
> >> This patch uses object_property_get_uint() to replace the direct memory
> >> access to make [get|set]_addr with the same mechanism.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  hw/mem/pc-dimm.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >> 
> >> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> >> index 0c9b9e8292..c0658b9b88 100644
> >> --- a/hw/mem/pc-dimm.c
> >> +++ b/hw/mem/pc-dimm.c
> >> @@ -204,9 +204,7 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> >>  
> >>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
> >>  {
> >> -    const PCDIMMDevice *dimm = PC_DIMM(md);
> >> -
> >> -    return dimm->addr;
> >> +    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, NULL);
> >it's not good to ignore errors
> >
> >s/NULL/error_abort/
> >
> >so we would notice if error ever happened.
> 
> You mean something like this?
> 
> 	Error *err;
> 	uint64_t addr;
> 
> 	addr = object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, &err);

see how error_abort is used in QEMU,
point is if there is a error that should never happen it is programming error so
QEMU should crash and we should fix it.

> 
> 	if (err) {
> 		warn_report_err(&err);
> 		return 0;
> 	}
> 
> 	return addr;
> 
> >
> >>  }
> >>  
> >>  static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
> >
> 
