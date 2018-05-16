Received: from eggs.gnu.org ([2001:4830:134:3::10]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIz93-0000kP-IH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIz92-00033v-Je
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:19:17 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIz92-00033X-EY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:19:16 -0400
Received: by mail-ot0-x242.google.com with SMTP id l12-v6so1567910oth.6
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87b443ba-43e5-73c5-9710-e1a6c61ca1ad@redhat.com>
References: <20180501101907.22638-1-peter.maydell@linaro.org>
	<a660c604-5e6e-29c7-ed3f-47e40de8da1b@redhat.com>
	<CAFEAcA_+gu3fWW9jNwT9DM5Yh2OFgehVDOnckAVACFPouzp58A@mail.gmail.com>
	<703a3977-7490-9c45-5fcd-66b96840b865@redhat.com>
	<CAFEAcA-XfLPQzPPxWC+ugCufnFt+nzFfWuDH_m+xP-mH=w9M_Q@mail.gmail.com>
	<87b443ba-43e5-73c5-9710-e1a6c61ca1ad@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 May 2018 16:18:55 +0000
Message-ID: <CAFEAcA-fLwfcs1TcWyqY26iwJ-bLCCSHaiiaQegiwx7kmEwvig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "patches@linaro.org" <patches@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 16 May 2018 at 15:33, Auger Eric <eric.auger@redhat.com> wrote:
> On 05/08/2018 06:25 PM, Peter Maydell wrote:
>> This runs into something I found when I was implementing the Arm
>> Memory Protection Controller -- at the point when the guest changes
>> the config,
> do you mean the config structures (STE, CD) or the page table update?

The Memory Protection Controller is not the SMMUv3. The MPC
config is set using some registers to write to the MPC's LUT
(lookup table).

>  it doesn't have enough information to be able to call a
>> "map" notifier, because the mapping depends on the memory transaction
>> attributes, it's not fixed and dependent only on the address.
>
> I am not sure I understand what you mean here. When the notifier get's
> called, aren't we supposed to look for the info in the actual page table
> (where memory access control attributes and others can be found at that
> time, ie. ARM AP[] for instance) and send those through the notifier (as
> stored in the IOTLBEnry)?

The problem is that if your translations depend on the tx attributes,
ie "secure access to address X should translate to Y, but nonsecure
access to address X should translate to Z", then the notifier
API doesn't let you report that, because all it knows about is
unmap events which are "address X unmapped" and map events which
are "address X translates to Y".

Paolo has suggested some API changes in another thread (roughly,
having the notifier say which tx attributes matter for the translation,
and send multiple map events with appropriate information).

> For instance in the intel iommu code, the whole table is parsed and the
> replay hook is called for all valid entries.

This works because the intel iommu does not care about memory
transaction attributes: it has one translation for the input
address, regardless.

thanks
-- PMM
