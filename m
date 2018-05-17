Received: from eggs.gnu.org ([2001:4830:134:3::10]:41409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJDT3-0002fM-Uk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJDT0-0002ip-Rn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJDT0-0002ij-MQ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:36:50 -0400
References: <20180501101907.22638-1-peter.maydell@linaro.org>
	<a660c604-5e6e-29c7-ed3f-47e40de8da1b@redhat.com>
	<CAFEAcA_+gu3fWW9jNwT9DM5Yh2OFgehVDOnckAVACFPouzp58A@mail.gmail.com>
	<703a3977-7490-9c45-5fcd-66b96840b865@redhat.com>
	<CAFEAcA-XfLPQzPPxWC+ugCufnFt+nzFfWuDH_m+xP-mH=w9M_Q@mail.gmail.com>
	<87b443ba-43e5-73c5-9710-e1a6c61ca1ad@redhat.com>
	<CAFEAcA-fLwfcs1TcWyqY26iwJ-bLCCSHaiiaQegiwx7kmEwvig@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <742d2ad0-cb63-27c4-51bd-c345fde9f437@redhat.com>
Date: Thu, 17 May 2018 09:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fLwfcs1TcWyqY26iwJ-bLCCSHaiiaQegiwx7kmEwvig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Peter,
On 05/16/2018 06:18 PM, Peter Maydell wrote:
> On 16 May 2018 at 15:33, Auger Eric <eric.auger@redhat.com> wrote:
>> On 05/08/2018 06:25 PM, Peter Maydell wrote:
>>> This runs into something I found when I was implementing the Arm
>>> Memory Protection Controller -- at the point when the guest changes
>>> the config,
>> do you mean the config structures (STE, CD) or the page table update?
> 
> The Memory Protection Controller is not the SMMUv3. The MPC
> config is set using some registers to write to the MPC's LUT
> (lookup table).
> 
>>  it doesn't have enough information to be able to call a
>>> "map" notifier, because the mapping depends on the memory transaction
>>> attributes, it's not fixed and dependent only on the address.
>>
>> I am not sure I understand what you mean here. When the notifier get's
>> called, aren't we supposed to look for the info in the actual page table
>> (where memory access control attributes and others can be found at that
>> time, ie. ARM AP[] for instance) and send those through the notifier (as
>> stored in the IOTLBEnry)?
> 
> The problem is that if your translations depend on the tx attributes,
> ie "secure access to address X should translate to Y, but nonsecure
> access to address X should translate to Z", then the notifier
> API doesn't let you report that, because all it knows about is
> unmap events which are "address X unmapped" and map events which
> are "address X translates to Y".
> 
> Paolo has suggested some API changes in another thread (roughly,
> having the notifier say which tx attributes matter for the translation,
> and send multiple map events with appropriate information).
> 
>> For instance in the intel iommu code, the whole table is parsed and the
>> replay hook is called for all valid entries.
> 
> This works because the intel iommu does not care about memory
> transaction attributes: it has one translation for the input
> address, regardless.

OK I get it now. Thank you for the explanations.

Eric
> 
> thanks
> -- PMM
> 
