Received: from eggs.gnu.org ([2001:4830:134:3::10]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9adz-0004Up-UG
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9adu-0004gh-Rg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9adu-0004fZ-CK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:18 -0400
References: <CAFEAcA_1J-39JgtTabVYad_B1zYV-pq8agvzpmHyRY98RwoiFw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5abb19f9-a2b5-b824-5d7e-b65a3feb199c@redhat.com>
Date: Fri, 20 Apr 2018 20:20:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1J-39JgtTabVYad_B1zYV-pq8agvzpmHyRY98RwoiFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] race between tb_gen_code() and qemu_ram_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>

On 20/04/2018 19:55, Peter Maydell wrote:
> There seems to be a race between tb_gen_code() and qemu_ram_free(),
> which results in an abort() in Edgar's test case that exercises the
> xilinx-spips mmio-exec functionality.
>=20
> Here's what happens:
>  (1) memory_region_invalidate_mmio_ptr() is called, and it deletes
                                                          ^^

This "it" is more precisely memory_region_do_invalidate_mmio_ptr.

>  the temporary ram MemoryRegion. This doesn't immediately result in
>  deletion of the RAMBlock (which is done from the RCU thread later)
>  (2) we try to execute from this physaddr, so tb_gen_code() is called.
>  This calls get_page_addr_code(). Since the RAMBlock hasn't yet
>  really been deleted, get_page_addr_code() finds it, and returns a
>  ram_addr in the about-to-go-away memory...
>  (3) while the CPU thread is busy doing codegen, the RCU thread runs.
>  It does a flatview_destroy() which ends up doing an object_unref on th=
e
>  memory region, whose destructor calls qemu_ram_free(), removing the
>  RAMBlock from the ram list
>  (4) when the CPU thread has done its codegen, it calls tb_link_page,
>  which calls tb_alloc_page, which calls tlb_protect_code(), with the
>  ram_addr that it got in step 2. We end up in tlb_reset_dirty_range_all=
(),
>  which calls qemu_get_ram_block() on that ram_addr.
>  (5) qemu_get_ram_block() aborts, because it can't find the RAMBlock
>  corresponding to the ram_addr (because we removed it in step 3).
>=20
> How should we resolve this race ?

Note that qemu_ram_free() is _also_ RCU-freeing the RAMBlock.  If it is
not found, it means that codegen is not running within
rcu_read_lock()/rcu_read_unlock().  In fact it's not.

So one possibility would be to add it there.  Theoretically the simplest
possibility, but rcu_read_lock() is taken _outside_ tb_lock which may be
a problem.

The alternative is to add a ref/unref pair of the MemoryRegion whenever
get_page_addr_code() uses it.  That would delay the MemoryRegion
destructor after the end of code generation.  A rough sketch would be
that get_page_addr_code() would grow a MemoryRegion** argument and would
use memory_region_from_host() instead of qemu_ram_addr_from_host().
get_page_addr_code() would either call rcu_read_lock(), or the callers
would (see the doc comment for memory_region_from_host(); it always
feels good when you can refer to doc comments!)

Thanks,

Paolo

> (PS: rr is really useful for identifying what's actually happening
> in multi-thread races like this...)
>=20
> thanks
> -- PMM
>=20
