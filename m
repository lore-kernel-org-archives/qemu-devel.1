Received: from eggs.gnu.org ([2001:4830:134:3::10]:42860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1cjBVO-0007Vy-TF
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1cjBVL-0001jM-O5
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:09:50 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:49903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1cjBVL-0001ik-FH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:09:47 -0500
Date: Wed, 1 Mar 2017 16:09:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170301210938.GE9043@char.us.ORACLE.com>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC Design Doc v3] Enable Shared Virtual Memory
 feature in pass-through scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hao, Xudong" <xudong.hao@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, 'Peter Xu' <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

.snip..
> > > Shared Virtual Memory feature in pass-through scenarios is actually SVM
> > > virtualization. It is to let application programs(running in guest)share their
> > > virtual address with assigned device(e.g. graphics processors or accelerators).
> > 
> > I think I am missing something obvious, but the current way that DRM
> > works is that the kernel sets up its VA addresses for the GPU and it uses
> > that for its ring. It also setups an user level mapping for the GPU if the
> > application (Xorg) really wants it - but most of the time the kernel is
> > in charge of poking at the ring, and the memory that is shared with the
> > Xorg is normal RAM allocated via alloc_pages (see
> > drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > and drivers/gpu/drm/ttm/ttm_page_alloc.c).
> > 
> > So are talking about the guest applications having access to the
> > ring of the GPU?
> 
> No. SVM is purely about sharing CPU address space with device. Command
> submission is still through kernel driver which controls rings (with SVM then
> you can put VA into those commands). There are other vendor specific 
> features to enable direct user space submission which is orthogonal to SVM.

Apologies for my ignorance but how is this beneficial? As in
currently you would put in bus addresses on the ring, but now you
can put VA addresses.

The obvious benefit I see is that you omit the DMA ops which means there is
less of 'lookup' (VA->bus address) in software - but I would have thought this
would be negligible performance impact? And now the IOMMU alongside with
the CPU would do this lookup.

Or are there some other improvements in this?

> 
> Thanks
> Kevin
