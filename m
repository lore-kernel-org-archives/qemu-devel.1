Received: from eggs.gnu.org ([2001:4830:134:3::10]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIcoc-0004RK-6c
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIcob-00082t-8B
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:28:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIcob-00082Y-2q
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:28:41 -0400
Received: by mail-oi0-x241.google.com with SMTP id k5-v6so731788oiw.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:28:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
	<c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 17:28:19 +0100
Message-ID: <CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs
 argument to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2 May 2018 at 10:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 01/05/2018 10:59, Peter Maydell wrote:
>> As well as the SMMU, I'm also thinking about using the IOMMU
>> infrastructure for the v8M Memory Protection Controller
>> (though that is a bit trickier as I also need it to support
>> TCG execution in an IOMMU-controlled region, which is an
>> orthogonal bit of work to attribute support).

> This is going to conflict with the MemoryRegionCache patches (review
> welcome :)), as they add a new function address_space_translate_iommu.
> But apart from this it seems like a no brainer.

(We talked about this on IRC, but I don't really have any
good ideas about the API changes needed, so I figured I'd
write it up here.)

While working through this and the MPC changes, I realized that
if we pass transaction attributes through to the IOMMU translate
method then we also need to change the API of the IOMMU notifier
system. This is because a txattrs-aware IOMMU might return more
than one mapping for a particular input address (eg "use mapping
A if txattrs.secure, but mapping B if not"). So map/unmap events
become more complex than just "unmap for address X" and "map for
address X" -- you need to distinguish "here's the new map for
address X with txattrs XA".

Presumably we also want a way for notifier users like vfio to
detect "I'm dealing with an IOMMU that is txattrs aware in a
way I can't deal with" so they can usefully bail out rather than
not working.

Unfortunately I don't really know enough about our two current
users of notifiers (vhost and vfio) to know what they actually
need the iommu notifications for...

(For the notifier I need to add for TCG, the requirements are
easy: I just want to be able to get unmap events so I can
flush the TCG TLB when the info I've cached from translate
calls is stale.)

thanks
-- PMM
