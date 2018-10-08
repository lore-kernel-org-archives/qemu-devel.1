Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ewV-0000fs-OQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ewS-0000Ux-BS
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9ewR-0000Ty-WD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  8 Oct 2018 19:27:51 -0400
Message-Id: <20181008232756.30704-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 0/5] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01146.html

Changes since v1:

- Add tlb_index and tlb_entry helpers from Richard

- Introduce sizeof_tlb() and tlb_n_entries()

- Extract tlb_mask as its own array in CPUArchState, as
  suggested by Richard. For the associated helpers (tlb_index etc)
  I tried several approaches, and performance-wise they're all
  the same, so went for the simplest implementation.

- Use uintptr_t for tlb_mask, as done in Richard's patch
  + tcg/i386: use hrexw when reading tlb_mask
  + Define tlbtype and tlbrexw solely based on TARGET_PAGE_BITS

- Rename tlb_is_invalid to tlb_entry_is_empty, comparing all
  fields (except .addend) against -1.

- Rename CPUTLBDesc.used to .n_used_entries.

- Drop the MIN/MAX CPU_TLB_BITS patches, defining instead
  some values for MIN/MAX as well as a default.

- Use new_size and old_size consistently in the resizing function,
  as suggested by Richard.

- Add an additional chart to the last patch, where softmmu
  performance is compared against user-mode:
    https://imgur.com/a/eXkjMCE

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn-v2

Note that it applies on top of my tlb-lock-v4 series:
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01421.html

Thanks,

		Emilio
