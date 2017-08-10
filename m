Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfnOC-0007ez-1z
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfnOA-0004Uj-PR
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:20:39 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfnOA-0004TC-Ap
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:20:38 -0400
Received: by mail-wr0-x22f.google.com with SMTP id f21so2907403wrf.5
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 06:20:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <432cdd39-1016-c38e-ebaa-ecaabf51076d@adacore.com>
References: <1502367698-4539-1-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA8A+KC=8tR4i0UMgykdbKim-D0DFZ5FGyj1XDuyBBKTkw@mail.gmail.com>
	<432cdd39-1016-c38e-ebaa-ecaabf51076d@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 14:20:16 +0100
Message-ID: <CAFEAcA_k_aVsiNxivagGzAh8XCyN-FYVO03A8jKUQx5OpWCMxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] xlnx-qspi: add a property for
 mmio-execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10 August 2017 at 14:08, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>
>
> On 08/10/2017 02:43 PM, Peter Maydell wrote:
>>
>> On 10 August 2017 at 13:21, KONRAD Frederic <frederic.konrad@adacore.com>
>> wrote:
>>>

>> Looking at the implementation it seems like this will work in
>> practice (because the invalidate code in memory.c checks that
>> the MR it's about to drop really is an MMIO_INTERFACE), but
>> if so we should document this. However, I'm not totally convinced
>> that it really will work in complicated cases like where you
>> have device A part of whose memory range is a container which
>> holds a device B which is also using the mmio_pointer API:
>> in that case if device A calls invalidate_mmio_ptr with an
>> address that's in the part of A's memory region that is the
>> device B container it could end up invalidating an mmio-interface
>> that's actually inside device B. So it would be safer to say
>> "the caller may only invalidate pointers it's actually told
>> the memory system about".
>>
>
> I see what you mean but I'm not sure this will happen because the
> mmio-interface is mapped on @mr which is passed to invalidate.
>
> So if device A doesn't have any mmio-interface mapped it can't
> find the device B mmio-interface as we pass device A
> MemoryRegion.

I think what you're saying is (1) you can't create an mmio-ptr
for a container region (2) when you call invalidate_mmio_ptr
you have to pass exactly the MR that has the memory-region-ops
that the have the request_ptr set. This isn't entirely clear
from the docs, but OTOH it seems reasonable and I agree that
in that case you can't get the situation I suggested above.

> But I agree the doc is a little confusing about that.
>
>> (Conversely if we're convinced that passing bogus pointers
>> to memory_region_invalidate_mmio_ptr() is fine then we
>> don't need to add the q->mmio_execution_enabled flag check.)
>
>
> True but this will trigger an async_safe_work with all the
> overhead.

If we care about that then we should have a "have we used the
cached region as an mmio_ptr" flag separately anyway, so that
we don't trigger async_safe_work for the case of "not executing
from the memory, but we had to call lqspi_load_cache() because
the guest did a read from some address that was outside the
cached section".

thanks
-- PMM
