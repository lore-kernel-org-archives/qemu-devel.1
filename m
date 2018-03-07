Received: from eggs.gnu.org ([2001:4830:134:3::10]:35268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etTAJ-0004Qm-Rr
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etTAF-0002xx-N9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:07:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etTAF-0002w1-Ij
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:07:03 -0500
Date: Wed, 7 Mar 2018 15:06:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307070659.GL17720@xz-mi>
References: <20180228201837.26629.3346.stgit@gimli.home>
	<20180228204554.26629.59183.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228204554.26629.59183.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH 3/5] vfio/quirks: ioeventfd quirk
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

On Wed, Feb 28, 2018 at 01:45:54PM -0700, Alex Williamson wrote:
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

I don't know when will there be non-dynamic vfio-ioeventfds, but it
looks fine at least to me even if all of them are dynamic now:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
