Received: from eggs.gnu.org ([2001:4830:134:3::10]:42143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkBFQ-00086j-Rp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkBFM-0000I7-K2
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkBFM-0000HT-Cs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:42:12 -0400
Date: Mon, 30 Jul 2018 10:42:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180730104205.1fb5a826@t450s.home>
In-Reply-To: <20180730182951-mutt-send-email-mst@kernel.org>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
	<20180730083939.23f3b9cc@t450s.home>
	<20180730174601-mutt-send-email-mst@kernel.org>
	<20180730090137.15917879@t450s.home>
	<20180730182951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, 30 Jul 2018 18:49:58 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 30, 2018 at 09:01:37AM -0600, Alex Williamson wrote:
> > > > but I don't think it can be done
> > > > atomically with respect to inflight DMA of a physical device where we
> > > > cannot halt the device without interfering with its state.    
> > > 
> > > Guests never add pages to the balloon if they are under DMA,
> > > so that's fine - there's never an in-flight DMA, if
> > > there is guest is buggy and it's ok to crash it.  
> > 
> > It's not the ballooned page that I'm trying to note, it's the entire
> > remainder of the SubRegion which needs to be unmapped to remove that
> > one page.  It's more compatible from an IOMMU perspective in that we're
> > only unmapping with the same granularity with which we mapped, but it's
> > incompatible with inflight DMA as we have no idea what DMA targets may
> > reside within the remainder of that mapping while it's temporarily
> > unmapped.  
> 
> I see. Yes you need to be careful to replace the host IOMMU PTE
> atomically. Same applies to vIOMMU though - if guest changes
> a PTE atomically host should do the same.

I'm not sure the hardware supports atomic updates in these cases and
therefore I don't think the vIOMMU does either.  Thanks,

Alex
