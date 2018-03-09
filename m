Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euIOv-0001hf-2N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euIOu-0005wC-6r
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:49:37 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-5-git-send-email-eric.auger@redhat.com>
	<CAFEAcA871Ju5cV8EYiXEg65Rofh=Pn2=2h8wy4-QXj-wUzoj+g@mail.gmail.com>
	<d8fbbd0d-3e15-92b2-9e26-fb0103abe65f@redhat.com>
	<CAFEAcA-XzeLWfb5tjHYF=3LQbeMge2yaEYRPqeMLn72u0xJ+kg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ee49a2ff-3f2c-4276-50d6-1b258d0a8a60@redhat.com>
Date: Fri, 9 Mar 2018 14:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XzeLWfb5tjHYF=3LQbeMge2yaEYRPqeMLn72u0xJ+kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/14] hw/arm/smmuv3: Skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

Hi Peter,

On 09/03/18 14:37, Peter Maydell wrote:
> On 9 March 2018 at 13:19, Auger Eric <eric.auger@redhat.com> wrote:
>> On 08/03/18 15:27, Peter Maydell wrote:
>>> Consider specifically catching 8-byte accesses to non-64-bit registers?
>>> This is CONSTRAINED UNPREDICTABLE (see spec section 6.2), and "one
>>> of the registers is read/written and other half is RAZ/WI" is permitted
>>> behaviour, but it does mean you need to be a little careful about not
>>> letting the top 32 bits of val become non-zero for the 32-bit register
>>> codepaths. Logging bad 64-bit accesses as LOG_GUEST_ERROR and making
>>> them RAZ/WI might be nicer for guest software developers.
>>
>> I moved to ops with attrs and if a 64-bit access is attempted on
>> something not a 64b reg base, I return an error + log a guest error.
> 
> Ah, you probably don't want to return MEMTX_ERROR, because that
> becomes a guest CPU external-abort exception. An abort is listed
> as one of the permitted constrained-unpredictable behaviours for
> bad 64-bit accesses, but there is a note that "strongly recommends"
> not to abort for cases where the registers might be used by software
> associated with lower exception levels. Rather than trying to decide
> which registers do or don't get to return MEMTX_ERROR, it's probably
> easier just to RAZ/WI and return MEMTX_OK.
> 
> (We had to fix a bug like this in the gicv3 in commits f1945632b43e3
> and 0cf09852015e when we started making MEMTX_ERROR generate aborts,
> though in that case the spec is more definite that abort is not a
> permitted behaviour.)

Yes saw those modifs in gic. I will check & fix this.

Thanks

Eric
> 
> thanks
> -- PMM
> 
