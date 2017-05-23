Received: from eggs.gnu.org ([2001:4830:134:3::10]:42091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=309f0b608=anthony.perard@citrix.com>)
	id 1dDDGS-0003G8-BA
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=309f0b608=anthony.perard@citrix.com>)
	id 1dDDGN-0000m9-Ir
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:06:32 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:56998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=309f0b608=anthony.perard@citrix.com>)
	id 1dDDGN-0000lD-CL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:06:27 -0400
Date: Tue, 23 May 2017 18:06:22 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170523170622.GD1591@perard.uk.xensource.com>
References: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
	<1495085580-10631-2-git-send-email-tianyu.lan@intel.com>
	<20170519111622.GA3260@perard.uk.xensource.com>
	<591EFB5D020000780015B47A@prv-mh.provo.novell.com>
	<3f3c2075-da6b-dd14-279f-23525f46b3c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f3c2075-da6b-dd14-279f-23525f46b3c5@intel.com>
Subject: Re: [Qemu-devel] [Xen-devel] [RFC PATCH V2 1/2] xen-pt: bind/unbind
 interrupt remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Jan Beulich <JBeulich@suse.com>, Chao Gao <chao.gao@intel.com>, kevin.tian@intel.com, sstabellini@kernel.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, marcel@redhat.com, mst@redhat.com

On Tue, May 23, 2017 at 08:16:25PM +0800, Lan Tianyu wrote:
> On 2017年05月19日 20:04, Jan Beulich wrote:
> >>>> On 19.05.17 at 13:16, <anthony.perard@citrix.com> wrote:
> >> On Thu, May 18, 2017 at 01:32:59AM -0400, Lan Tianyu wrote:
> >>> --- a/include/hw/i386/apic-msidef.h
> >>> +++ b/include/hw/i386/apic-msidef.h
> >>> @@ -26,6 +26,7 @@
> >>>  
> >>>  #define MSI_ADDR_DEST_ID_SHIFT          12
> >>>  #define MSI_ADDR_DEST_IDX_SHIFT         4
> >>> -#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
> >>> +#define  MSI_ADDR_DEST_ID_MASK          0x000fff00
> >> The value of MSI_ADDR_DEST_ID_MASK is changed here. I think the patch
> >> should be:
> >> +#define  MSI_ADDR_DEST_ID_MASK          0x000ffff0
> > Judging from other sources, rather the other way around - the
> > mask needs to have further bits removed (should be 0x000ff000
> > afaict). Xen sources confirm this, and while Linux has the value
> > you suggest, that contradicts
> Agree. Defining the mask as "0x000ff000" makes more sense.
> Just check Qemu source code. Only apic_send_msi() and msi_dest_id() use
> the mask
> to get dest apic id. They mask MSI address field with 
> MSI_ADDR_DEST_ID_MASK and
> then right-shift 12bit. The low 12bit won't be used.
> 
> Anthony, does this make sense?

Yes, it does.
The change to MSI_ADDR_DEST_ID_MASK should probably go in its own patch.

-- 
Anthony PERARD
