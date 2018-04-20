Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9aFx-0001BC-J4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9aFw-0007Ld-L0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:55:33 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9aFw-0007KZ-20
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:55:32 -0400
Received: by mail-ot0-x22f.google.com with SMTP id 77-v6so4412225otd.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:55:31 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 18:55:10 +0100
Message-ID: <CAFEAcA_1J-39JgtTabVYad_B1zYV-pq8agvzpmHyRY98RwoiFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] race between tb_gen_code() and qemu_ram_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>

There seems to be a race between tb_gen_code() and qemu_ram_free(),
which results in an abort() in Edgar's test case that exercises the
xilinx-spips mmio-exec functionality.

Here's what happens:
 (1) memory_region_invalidate_mmio_ptr() is called, and it deletes
 the temporary ram MemoryRegion. This doesn't immediately result in
 deletion of the RAMBlock (which is done from the RCU thread later)
 (2) we try to execute from this physaddr, so tb_gen_code() is called.
 This calls get_page_addr_code(). Since the RAMBlock hasn't yet
 really been deleted, get_page_addr_code() finds it, and returns a
 ram_addr in the about-to-go-away memory...
 (3) while the CPU thread is busy doing codegen, the RCU thread runs.
 It does a flatview_destroy() which ends up doing an object_unref on the
 memory region, whose destructor calls qemu_ram_free(), removing the
 RAMBlock from the ram list
 (4) when the CPU thread has done its codegen, it calls tb_link_page,
 which calls tb_alloc_page, which calls tlb_protect_code(), with the
 ram_addr that it got in step 2. We end up in tlb_reset_dirty_range_all(),
 which calls qemu_get_ram_block() on that ram_addr.
 (5) qemu_get_ram_block() aborts, because it can't find the RAMBlock
 corresponding to the ram_addr (because we removed it in step 3).

How should we resolve this race ?

(PS: rr is really useful for identifying what's actually happening
in multi-thread races like this...)

thanks
-- PMM
