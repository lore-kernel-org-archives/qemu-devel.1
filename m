Received: from eggs.gnu.org ([2001:4830:134:3::10]:34471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCQ4-0004r4-QT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCQ3-0007bS-Te
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:54:40 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:33282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQCQ3-0007ab-NS
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:54:39 -0400
Received: by mail-ot0-x22d.google.com with SMTP id h6-v6so2907555otj.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:54:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605131944.14649-4-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-4-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 14:54:18 +0100
Message-ID: <CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On 5 June 2018 at 14:19, Peter Xu <peterx@redhat.com> wrote:
> Add two more IOMMU notifier flags to selectively choose whether the
> notifier would like to listen to an event that with USER bit set/unset.
> Note that all existing notifiers should always been registered with both
> of the flags set to make sure they'll receive the notification no matter
> whether the USER bit is set or unset in the attributes.  To simplify
> this procedure, some new macros are defined.  The old UNMAP-only
> notifiers should now be registered with IOMMU_NOTIFIER_UNMAP_ALL
> flags (rather than the old IOMMU_NOTIFIER_UNMAP flag), while the old
> MAP+UNMAP case can keep to use the IOMMU_NOTIFIER_ALL flag.
>
> Now if a new notifier would like to register to only UNMAP notifications
> with USER bit set, it should register with below flag:
>
>   IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_USER_SET
>
> Then when we want to notify a DMA invalidation (we call it IOMMUTLBEntry
> in QEMU), we should do this:
>
>   IOMMUTLBEntry entry;
>   ... (set up the fields)
>   entry.perm = IOMMU_NONE;
>   entry.attrs.user = 1;
>   memory_region_notify_iommu(mr, &entry);

I don't think this works, because there is not a single unique
MemTxAttrs for a particular invalidation event. Invalidates
will affect classes of transaction attributes. For instance
in the MPC, changing the lookup table can invalidate cached
IOMMU information for any translation that was done either
with attrs.secure = 1, or for translations with attrs.unspecified = 1.

In general, at the point where the IOMMU calls notifiers it
won't have a single MemTxAttrs it can use, so you don't want
to put an attrs into the IOMMUTLBEntry.

thanks
-- PMM
