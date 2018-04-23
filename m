Received: from eggs.gnu.org ([2001:4830:134:3::10]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAedU-0006an-Fj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAedT-0004ON-Fu
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:48:16 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:40825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAedT-0004OC-A6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:48:15 -0400
Received: by mail-ot0-x22c.google.com with SMTP id h8-v6so17965555otj.7
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:48:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5abb19f9-a2b5-b824-5d7e-b65a3feb199c@redhat.com>
References: <CAFEAcA_1J-39JgtTabVYad_B1zYV-pq8agvzpmHyRY98RwoiFw@mail.gmail.com>
	<5abb19f9-a2b5-b824-5d7e-b65a3feb199c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 17:47:54 +0100
Message-ID: <CAFEAcA9CffNmvL2_SnErqgb=KdnURBd+4PeGNp-Xnd9J70eJ3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] race between tb_gen_code() and qemu_ram_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>

On 20 April 2018 at 19:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Note that qemu_ram_free() is _also_ RCU-freeing the RAMBlock.  If it is
> not found, it means that codegen is not running within
> rcu_read_lock()/rcu_read_unlock().  In fact it's not.

This seems to not be the only problem. We get into difficulties
somewhat earlier, because:
 * get_page_addr_code() calls memory_region_request_mmio_ptr()
 * memory_region_request_mmio_ptr() calls the xilinx-spips device's
   request_ptr function
 * the xilinx-spips code calls memory_region_invalidate_mmio_ptr()
   on the old MMIO pointer, since it only supports one at a time
 * at this point the device expects that the memory is not
   being used by anything: it always uses the same host buffer,
   so as soon as it fills it with the new page's data the
   content being used for the old page will be gone
 * but memory_region_invalidate_mmio_ptr() has merely deferred
   the invalidate for later
 * memory_region_request_mmio_ptr() now creates a new mmio-interface
   device, which maps itself into the device's memory region
   using memory_region_add_subregion()
 * we'll unly unmap the old mmio-interface device in
   memory_region_do_invalidate_mmio_ptr() at some later date

Problems:
(1) if you flip between pages too quickly you'll hit the
    old stale mmio-interface MemoryRegion rather than creating a
    fresh one

(2) since we create the new mmio-interface before the old
    one is deleted, there is an interim period when there
    are two RAMBlocks in the list with the same host address.
    Which one you get back from qemu_ram_addr_from_host()
    or qemu_ram_block_from_host() is unclear. This is actually
    the primary cause of the crash here -- get_page_addr_code()
    hits the new MemoryRegion in the TLB, but then when it
    tries to get the ram_addr from the host address that's
    also in the TLB it gets given back the ram_addr for
    the about-to-die RAMBlock rather than the new one.

The memory system design fairly strongly assumes that one
host address is only associated with one MemoryRegion at
a time, so we need to avoid breaking that with mmio-interface...

thanks
-- PMM
