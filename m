Received: from eggs.gnu.org ([2001:4830:134:3::10]:56556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLqmK-0005Mt-Jk
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLqmG-00062o-T5
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:59:40 -0400
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
	<CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
Date: Thu, 24 May 2018 15:59:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

Hi,

On 05/24/2018 03:14 PM, Peter Maydell wrote:
> On 24 May 2018 at 10:04, Auger Eric <eric.auger@redhat.com> wrote:
>> Now I am unclear about the semantics of the s->gicd_ipriority & friends.
>> With that change, is it supposed to contain only the states of SPIs or
>> contain the RAZ states of PPI/SGIs + states of SPIs. The array is
>> dimensionned to contain states for PPI/SGI+SPIs, right? In other words,
>> shouldn't we also shift field?
> 
> The semantics of the gicd_ipriority and other data structures are
> set by the TCG GIC implementation, and include blank space at
> the start where the PPI/SGI bits would live. See this comment
> from arm_gicv3_common.h:
> 
>  * Each bitmap contains a bit for each interrupt. Although there is
>  * space for the PPIs and SGIs, those bits (the first 32) are never
>  * used as that state lives in the redistributor. The unused bits are
>  * provided purely so that interrupt X's state is always in bit X; this
>  * avoids bugs where we forget to subtract GIC_INTERNAL from an
>  * interrupt number.

If I understand Shannon's code correctly, the space for PPIs/SGIs is
currently overwritten by SPI state, hence my comment. If we stick to the
current semantics, can't we just add the last missing 32 SPI states and
we don't need the subsection?

Thanks

Eric
> 
> thanks
> -- PMM
> 
