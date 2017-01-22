Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVA6p-0004pv-T6
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVA6m-0004mm-Pd
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVA6m-0004mi-JM
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:50:28 -0500
Date: Sun, 22 Jan 2017 12:50:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122045023.GF13810@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
	<20170120090506.GJ4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C15103@SHSMSX101.ccr.corp.intel.com>
	<20170120092736.GM4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C1525C@SHSMSX101.ccr.corp.intel.com>
	<20170120100426.GO4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C16A18@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C16A18@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 02/14] intel_iommu: simplify irq
 region translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

On Sun, Jan 22, 2017 at 04:42:13AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, January 20, 2017 6:04 PM
> > 
> > On Fri, Jan 20, 2017 at 09:52:01AM +0000, Tian, Kevin wrote:
> > 
> > [...]
> > 
> > > btw what about guest setups a valid mapping at 0xFEEx_xxxx in
> > > its remapping structure, which is then programmed to virtual
> > > device as DMA destination? Then when emulating that virtual DMA,
> > > vtd_do_iommu_translate should simply return (maybe throw out
> > > a warning for diagnostic purpose) instead of assert here.
> > >
> > > VT-d spec defines as below:
> > >
> > > 	Software must ensure the second-level paging-structure entries
> > > 	are programmed not to remap input addresses to the interrupt
> > > 	address range. Hardware behavior is undefined for memory
> > > 	requests remapped to the interrupt address range.
> > 
> > Thanks for this reference. That's something I was curious about.
> > 
> > >
> > > I don't think "hardware behavior is undefined" is equal to "assert
> > > thus kill VM"...
> > 
> > I don't think it will kill the VM. After we have the MSI region, it
> > should just use that IR region for everything (read/write/translate).
> > So iiuc when anyone setups IOVA mapping within range 0xfeexxxxx, then
> > a DMA will trigger an interrupt (rather than memory moves), but in
> > most cases the interrupt will be illegal since either the data is
> > invalid (e.g., non-zero reserved bits, or SID verification failure),
> > further it should trigger a vIOMMU fault (though IR fault reporting is
> > still incomplete, that's my next thing to do after this series).
> > 
> 
> Yes, you're right here. Sorry for bothering with my wrong understanding. :-)

No problem at all.

Looking forward to any of your further comments on v4. :-)

-- peterx
