Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEQHq-0007XB-Lt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEQHn-0005G2-GL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fEQHn-0005FK-CT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:17:27 -0400
Date: Fri, 4 May 2018 10:17:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180504021722.GI29580@xz-mi>
References: <20180503213458.2749.28566.stgit@gimli.home>
	<20180503214505.2749.34062.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503214505.2749.34062.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] vfio/quirks: ioeventfd quirk
 acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, eric.auger@redhat.com

On Thu, May 03, 2018 at 03:45:05PM -0600, Alex Williamson wrote:
> The NVIDIA BAR0 quirks virtualize the PCI config space mirrors found
> in device MMIO space.  Normally PCI config space is considered a slow
> path and further optimization is unnecessary, however NVIDIA uses a
> register here to enable the MSI interrupt to re-trigger.  Exiting to
> QEMU for this MSI-ACK handling can therefore rate limit our interrupt
> handling.  Fortunately the MSI-ACK write is easily detected since the
> quirk MemoryRegion otherwise has very few accesses, so simply looking
> for consecutive writes with the same data is sufficient, in this case
> 10 consecutive writes with the same data and size is arbitrarily
> chosen.  We configure the KVM ioeventfd with data match, so there's
> no risk of triggering for the wrong data or size, but we do risk that
> pathological driver behavior might consume all of QEMU's file
> descriptors, so we cap ourselves to 10 ioeventfds for this purpose.
> 
> In support of the above, generic ioeventfd infrastructure is added
> for vfio quirks.  This automatically initializes an ioeventfd list
> per quirk, disables and frees ioeventfds on exit, and allows
> ioeventfds marked as dynamic to be dropped on device reset.  The
> rationale for this latter feature is that useful ioeventfds may
> depend on specific driver behavior and since we necessarily place a
> cap on our use of ioeventfds, a machine reset is a reasonable point
> at which to assume a new driver and re-profile.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
