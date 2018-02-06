Received: from eggs.gnu.org ([2001:4830:134:3::10]:55524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ej2nU-0005TV-2J
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ej2nS-0001VC-Tu
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:56:28 -0500
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-11-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-40ucm8WZOEJC_1r4MdFXEPuX=GM2FC3hKZamLbijM7w@mail.gmail.com>
	<bdb379f2-5272-dd5c-056d-da487dd21500@redhat.com>
	<CAFEAcA8R5zYM5ppcx4wJk4jkMbCekjZVyL+m7R6mekf+nA6O+g@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f58908c7-71bd-eecb-2d67-5bfe85d82ffe@redhat.com>
Date: Tue, 6 Feb 2018 13:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8R5zYM5ppcx4wJk4jkMbCekjZVyL+m7R6mekf+nA6O+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 10/20] hw/arm/smmuv3: Implement
 translate callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Radha Mohan <mohun106@gmail.com>, Andrew Jones <drjones@redhat.com>, Trey Cain <tcain@qti.qualcomm.com>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, robin.murphy@arm.com, wtownsen@redhat.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, eric.auger.pro@gmail.com

Hi Peter,
On 06/02/18 13:43, Peter Maydell wrote:
> On 6 February 2018 at 12:19, Auger Eric <eric.auger@redhat.com> wrote:
>> On 09/10/17 19:45, Peter Maydell wrote:
>>> Incidentally, the spec requires us to perform memory accesses as
>>> at least 64-bit single-copy atomic (see 3.21.3) -- does this do that?
>>> (This gets important with SMP when the guest on another CPU might
>>> be updating the STE or page table entry at the same time as we're
>>> reading it...)
>>
>> Among all your comments on v7, here is the one I am the least
>> comfortable with. I was not able to figure out whether
>> dma_memory_read(), which I use now for all the descriptor accesses
>> guarantees this 64b single copy atomicity.
> 
> It doesn't -- it winds up in flatview_read_continue(), which will
> do a memcpy() from guest ram into the buffer, and since it's
> using an arbitrary passed-in length value the chances are high
> it won't end up using an atomic access on the host.
> 
> This is a nasty issue which we haven't figured out at all yet;
> see also this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03067.html
> 
> For the moment my suggestion would be that when you need
> to do guest memory accesses that have atomicity requirements you:
>  (a) use an accessor function which specifically loads a
>   quantity of the correct size, rather than one which takes
>   an arbitrary start-and-length
>   (when we add APIs which do have atomicity guarantees they'll
>   be "load 64 bit word" etc, so using our existing APIs of
>   that form should avoid needing to restructure this code later)
>  (b) add a TODO comment noting the required atomicity

OK thank you for the link. To start with, I will add a comment in next
version then.

Thanks

Eric
> 
> thanks
> -- PMM
> 
