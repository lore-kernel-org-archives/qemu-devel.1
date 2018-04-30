Received: from eggs.gnu.org ([2001:4830:134:3::10]:53958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fD8Iu-0000mU-9g
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fD8Ip-0003y2-Ee
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:53:16 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:48614
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1fD8Ip-0003qb-7i
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:53:11 -0400
References: <20180426150901.30278-1-peter.maydell@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <952b1548-0606-0010-1282-e6f6b467eaa3@adacore.com>
Date: Mon, 30 Apr 2018 14:52:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180426150901.30278-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] mmio-exec: Make device return
 MemoryRegion rather than host pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Francisco Iglesias <frasse.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>



On 04/26/2018 05:09 PM, Peter Maydell wrote:
> Our current interface for allowing a device to support execution from
> MMIO regions has the device return a pointer into host memory
> containing the contents to be used for execution.  Unfortunately the
> obvious implementation this encourages (and which our only in-tree
> user uses) is to have a single buffer which is reused for each new
> request_ptr call.  This doesn't work, because RCU means that removal
> of the old RAMBlock based on the host pointer may be deferred until a
> point after a new RAMBlock with the same pointer has been added to
> the list.  The RAMBlock APIs assume that the host-pointer to ram_addr
> mapping is unique, and mmio-exec is breaking that assumption.
> 
> Instead, change the API so that the device is responsible for
> allocating a new RAM MemoryRegion and populating it.  The
> MemoryRegion will be g_free()d when the region is eventually
> invalidated or otherwise unneeded.
> 
> HACKS:
>   * Note that in order for the refcounting to work correctly without
>     having to manufacture a device purely to be the owner of the
>     MemoryRegion, we must pass OBJECT(newmr) as the owner (so the MR is
>     its own owner!) and NULL as the name (or the property created on the
>     owner causes the refcount to go negative during finalization)...
> 
> QUESTIONS:
>   * do we really need to postpone things from
>     memory_region_invalidate_mmio_ptr() to
>     memory_region_do_invalidate_mmio_ptr(), given that the deletion of
>     the memory region and ramblock is RCU-deferred anyway?
>   * should we add the subregion at elevated prio so it definitely hits
>     first?  I've left it the way the existing code does for the
>     moment...
>   * is there any way to avoid the weird self-owning MemoryRegion
>     and corresponding need to pass a NULL name pointer?

About refcounting and self-owning MemoryRegion:
I put the MemoryRegion in the mmio_interface to avoid this issues
and to passes the base address, size, etc.

Fred

> 
> NOTES:
>   * This change means that hw/misc/mmio_interface.c is no longer
>     used; if this gets beyond RFC stage then another patch to
>     delete it can follow.
>   * The "request_mmio_exec mustn't fail after it has called
>     memory_region_mmio_ptr_alloc()" requirement is a bit ugly, but
>     could probably be removed.
