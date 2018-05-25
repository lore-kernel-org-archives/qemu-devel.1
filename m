Received: from eggs.gnu.org ([2001:4830:134:3::10]:59249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM9W0-0000Yo-Uh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM9W0-0003wX-5Y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:00:05 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM9Vz-0003vw-OV
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:00:04 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so5441854otf.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 03:00:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e253665e-18db-49c7-afca-8284e975b80f@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-18-peter.maydell@linaro.org>
	<8736yivgw3.fsf@linaro.org>
	<f568933d-2d8c-da22-c588-3ca4d3140538@redhat.com>
	<CAFEAcA--wyed8qg=4P-DG9QyZe1eACWh+68g99Gowx71CFAh_w@mail.gmail.com>
	<e253665e-18db-49c7-afca-8284e975b80f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 10:59:42 +0100
Message-ID: <CAFEAcA-b7Son5FMwQkkjZvjpWs3UrVgQtcRPxhTLzuM-PpPq1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/27] exec.c: Handle IOMMUs in
 address_space_translate_for_iotlb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 25 May 2018 at 10:50, Auger Eric <eric.auger@redhat.com> wrote:
> On 05/25/2018 10:52 AM, Peter Maydell wrote:
>> Once we've flushed the TLB it is empty and will have no cached
>> information from the IOMMU. So there's no point in flushing the
>> TLB again (which is expensive) until the next time a transaction
>> goes through the IOMMU and we're caching something from it.
> Ak OK. there is no finer granularity for TLB flush?

Yes, there is -- you can flush by (input) address; but I
opted to do a global flush, because it doesn't require
complicated tracking of which parts of the IOMMU's address
range we care about, and in general I expect IOMMU config
changes to be fairly rare:

+        /* Rather than trying to register interest in the specific part
+         * of the iommu's address space that we've accessed and then
+         * expand it later as subsequent accesses touch more of it, we
+         * just register interest in the whole thing, on the assumption
+         * that iommu reconfiguration will be rare.
+         */

We can always come back and revisit that if there turns
out to be a performance problem here in practice.

>> We need to know all the permissions (because we'll cache the result
>> in the TCG TLB and later use them for future read and write accesses),
>> so we pass IOMMU_NONE.
>>
>> My understanding from previous discussion is that the only
>> reason to pass in some other access flag value is if you
>> only care about one of read or write and want to allow the
>> IOMMU to stop walking the page table early as soon as it decides
>> it doesn't have permissions.
>
> agreed. So you need to fetch the whole set of table permissions to
> update the TLB. By the way where is the TLB updated?

tlb_set_page_with_attrs() calls address_space_translate_for_iotlb(),
which looks up what's at that address, including doing IOMMU
translations. Then tlb_set_page_with_attrs() fills in the TLB
data structure with the results.

thanks
-- PMM
