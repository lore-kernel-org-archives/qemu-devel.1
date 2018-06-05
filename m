Received: from eggs.gnu.org ([2001:4830:134:3::10]:42906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQCvT-0003fr-Ae
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQCvP-0007Lp-8r
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQCvP-0007Le-3F
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:03 -0400
Date: Tue, 5 Jun 2018 22:26:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605142655.GI9216@xz-mi>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-4-peterx@redhat.com>
	<CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 3/3] memory: introduce
 IOMMU_NOTIFIER_USER_[UN]SET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On Tue, Jun 05, 2018 at 02:54:18PM +0100, Peter Maydell wrote:
> On 5 June 2018 at 14:19, Peter Xu <peterx@redhat.com> wrote:
> > Add two more IOMMU notifier flags to selectively choose whether the
> > notifier would like to listen to an event that with USER bit set/unset.
> > Note that all existing notifiers should always been registered with both
> > of the flags set to make sure they'll receive the notification no matter
> > whether the USER bit is set or unset in the attributes.  To simplify
> > this procedure, some new macros are defined.  The old UNMAP-only
> > notifiers should now be registered with IOMMU_NOTIFIER_UNMAP_ALL
> > flags (rather than the old IOMMU_NOTIFIER_UNMAP flag), while the old
> > MAP+UNMAP case can keep to use the IOMMU_NOTIFIER_ALL flag.
> >
> > Now if a new notifier would like to register to only UNMAP notifications
> > with USER bit set, it should register with below flag:
> >
> >   IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_USER_SET
> >
> > Then when we want to notify a DMA invalidation (we call it IOMMUTLBEntry
> > in QEMU), we should do this:
> >
> >   IOMMUTLBEntry entry;
> >   ... (set up the fields)
> >   entry.perm = IOMMU_NONE;
> >   entry.attrs.user = 1;
> >   memory_region_notify_iommu(mr, &entry);
> 
> I don't think this works, because there is not a single unique
> MemTxAttrs for a particular invalidation event. Invalidates
> will affect classes of transaction attributes. For instance
> in the MPC, changing the lookup table can invalidate cached
> IOMMU information for any translation that was done either
> with attrs.secure = 1, or for translations with attrs.unspecified = 1.
> 
> In general, at the point where the IOMMU calls notifiers it
> won't have a single MemTxAttrs it can use, so you don't want
> to put an attrs into the IOMMUTLBEntry.

So we have a requirement that we want to send an invalidation for
either (1) unspecified, or (2) secure=1.  We can't do that with a
single MemTxAttrs.

Could we just notify twice?  One with unspecified=1 and one with
secure=1?  Is this (reduce the calls to notify functions) the major
reason we introduce this IOMMU index idea into the memory API (besides
"avoid possible programming error" you mentioned in IRC discussion)?

Again, I think the more critical question would be whether we can pass
in MemTxAttrs into translate(), and whether we can avoid introducing
this IOMMU index idea into the memory API layer... For example, would
it add complexity to other architectures without much benefit?

Thanks,

-- 
Peter Xu
