Received: from eggs.gnu.org ([2001:4830:134:3::10]:40406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPQU-0003kV-Eh
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPQQ-00012E-Nv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:03:34 -0500
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-4-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-mOzfHhGt0jXtTVMe4_GGp6bg_SK1R4JBbQxpw2+gokg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96e94933-7381-7448-5d3b-ae8ad14d2097@redhat.com>
Date: Thu, 14 Dec 2017 10:03:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mOzfHhGt0jXtTVMe4_GGp6bg_SK1R4JBbQxpw2+gokg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/8] cputlb: Support generating
 CPU exceptions on memory transaction failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 13/12/2017 17:39, Peter Maydell wrote:
> I was looking at a bug that involved stepping through this function,
> and it turns out that the value in the variable "physaddr" here is
> not in fact the physical address of the access. It's just the offset
> into the memory region.
> 
> This doesn't matter for Arm or Alpha, which don't actually need the
> physaddr for reporting the exceptions, and those are the only
> current implementations of the transaction_failed hook.
> But we should fix this so it doesn't bite us when we do eventually
> have a cpu that needs the physaddr...
> 
> If we have a CPUIOTLBEntry how do we get back to the physaddr for it?

iotlb_to_region only gets the MemoryRegion from the MemoryRegionSection,
but you could actually make it return the whole MRS.  Then you can sum
the MRS's offset_with_address_space.

Thanks,

Paolo
