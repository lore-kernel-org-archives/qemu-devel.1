Received: from eggs.gnu.org ([2001:4830:134:3::10]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fk9nn-0002a8-8o
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fk9nj-0007vm-2Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fk9ni-0007vR-S6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F8BD3082A2A
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 15:09:34 +0000 (UTC)
Date: Mon, 30 Jul 2018 09:01:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180730090137.15917879@t450s.home>
In-Reply-To: <20180730174601-mutt-send-email-mst@kernel.org>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
	<20180730083939.23f3b9cc@t450s.home>
	<20180730174601-mutt-send-email-mst@kernel.org>
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

On Mon, 30 Jul 2018 17:51:28 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 30, 2018 at 08:39:39AM -0600, Alex Williamson wrote:
> > This is more
> > compatible with the IOMMU mappings,  
> 
> Precisely. These are at page granularity.

(This/these being memory API mappings for context)

SubRegions are not page granule, the entire previous SubRegion needs to
be unmapped and any remaining SubRegions re-mapped.
 
> > but I don't think it can be done
> > atomically with respect to inflight DMA of a physical device where we
> > cannot halt the device without interfering with its state.  
> 
> Guests never add pages to the balloon if they are under DMA,
> so that's fine - there's never an in-flight DMA, if
> there is guest is buggy and it's ok to crash it.

It's not the ballooned page that I'm trying to note, it's the entire
remainder of the SubRegion which needs to be unmapped to remove that
one page.  It's more compatible from an IOMMU perspective in that we're
only unmapping with the same granularity with which we mapped, but it's
incompatible with inflight DMA as we have no idea what DMA targets may
reside within the remainder of that mapping while it's temporarily
unmapped.  Thanks,

Alex
