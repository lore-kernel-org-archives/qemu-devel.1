Received: from eggs.gnu.org ([208.118.235.92]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gc2Fu-0003La-Ej
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gc2Fq-0007tG-9D
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:01:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:64941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gc2Fp-0007nK-VM
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:01:18 -0500
Date: Wed, 26 Dec 2018 13:58:00 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181226055800.52gwpncvif33a7fd@linux.intel.com>
References: <20181219055743.okeszdqlqkg7tagk@linux.intel.com>
	<20181219100355-mutt-send-email-mst@kernel.org>
	<20181220054921.sk5wnmlo2vvjgcs6@linux.intel.com>
	<20181220132644-mutt-send-email-mst@kernel.org>
	<20181221161920.45fnlmcp7aqu6ibi@linux.intel.com>
	<20181221120657-mutt-send-email-mst@kernel.org>
	<20181221173401.cb5vgokgxopnnpes@linux.intel.com>
	<20181221130713-mutt-send-email-mst@kernel.org>
	<20181222004137.b7hj623kmzsq5ttv@linux.intel.com>
	<20181225115658-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181225115658-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 25, 2018 at 12:00:08PM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 22, 2018 at 08:41:37AM +0800, Yu Zhang wrote:
> > On Fri, Dec 21, 2018 at 01:10:13PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 22, 2018 at 01:34:01AM +0800, Yu Zhang wrote:
> > > > On Fri, Dec 21, 2018 at 12:15:26PM -0500, Michael S. Tsirkin wrote:
> > > > > On Sat, Dec 22, 2018 at 12:19:20AM +0800, Yu Zhang wrote:
> > > > > > > I'd like to avoid poking at the CPU from VTD code. That's all.
> > > > > > 
> > > > > > OK. So for the short term，how about I remove the check of host cpu, and add a TODO
> > > > > > in the comments in vtd_decide_config()? 
> > > > > 
> > > > > My question would be what happens on an incorrect use?
> > > > 
> > > > I believe the vfio_dma_map will return failure for an incorrect use.
> > > > 
> > > > > And how does user figure out which values to set?
> > > > 
> > > > Well, for now I don't think user can figure out. E.g. if we expose a vIOMMU with
> > > > 48-bit IOVA capability, yet host only supports 39-bit IOVA, vfio shall return failure,
> > > > but the user does not know whose fault it is.
> > > > > 
> > > > > > As to the check against hardware IOMMU, Peter once had a proposal in
> > > > > > http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02281.html
> > > > > > 
> > > > > > Do you have any comment or suggestion on Peter's proposal?
> > > > > 
> > > > > Sounds reasonable to me. Do we do it on vfio attach or unconditionally?
> > > > > 
> > > > 
> > > > I guess on vfio attach? Will need more thinking in it.
> > > 
> > > 
> > > Things like live migration (e.g. after hot removal of the vfio device)
> > > are also concerns.
> > 
> > Sorry, why live migration shall be a problem? I mean, if the DMA address
> > width of vIOMMU does not match the host IOMMU's, we can just stop creating
> > the VM, there's no live migration. 
> 
> I don't see code like this though.
> 
> Also management needs to somehow be able to figure out that migration
> will fail. It's not nice to transfer all memory and then have it fail
> when viommu is migrated.  So from that POV a flag is better. It can be
> validated agains host capabilities.
> 
> We can still have something like aw=host just like cpu host.

Well, I think vIOMMU's requirement is kind of different:
1> the vIOMMU could be an emulated one, and there can be no physical
IOMMU underneath. And the emulated device can still use this vIOMMU;
2> there might be multiple physical IOMMUs on one platform, I am not
sure if all these IOMMUs will have the same capability setting.

So I think we should have a more generic solution, to check the host
capability, e.g. like Kevin's and Peter's suggestion. It's not just
about 5-level vIOMMU, existing 4-level vIOMMU and future virtual SVM
have similar requirement. :)

> 
> > > 
> > > > > 
> > > > > > I still do not quite know
> > > > > > how to do it for now...
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > 
> > > > > > B.R.
> > > > > > Yu
> > > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > MST
> > > > 
> > > > B.R.
> > > > Yu
> > 
> > B.R.
> > Yu
> 

B.R.
Yu
