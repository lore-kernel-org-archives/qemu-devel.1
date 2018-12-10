Received: from eggs.gnu.org ([2001:4830:134:3::10]:37092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrJ-0001Ny-5m
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrI-00081p-BI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gWOrI-00080R-3r
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:40 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 16:56:33 +0000
Message-Id: <20181210165636.28366-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 0/3] target/m68k: convert to transaction_failed
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This patchset converts the m68k target from the deprecated
unassigned_access hook to the new transaction_failed hook.
It's RFC for a couple of reasons:
 * it's untested, since I don't have an m68k test image
 * the second patch just makes "bus error while trying to
   read page tables" be treated as a page fault, when it
   should probably cause a fault reporting it as a bus error
   of some kind
 * I don't understand why the old unassigned_access hook
   set the ATC bit in the MMU SSW, since the docs I have say
   this should be set if the fault happened during a table
   search, but cleared if it's just an ordinary bus-errored
   data or insn access. Probably this is a pre-existing bug?

Anyway, I send it out as a skeleton for comments, because
it would be nice to get rid of the old unassigned_access
hook, which is fundamentally broken (it's still used by m68k,
microblaze, mips and sparc).

thanks
-- PMM

Peter Maydell (3):
  target/m68k: In dump_address_map() check for memory access failures
  target/m68k: In get_physical_address() check for memory access
    failures
  target/m68k: Switch to transaction_failed hook

 target/m68k/cpu.h       |  7 ++--
 target/m68k/cpu.c       |  2 +-
 target/m68k/helper.c    | 84 ++++++++++++++++++++++++++++++++---------
 target/m68k/op_helper.c | 20 ++++------
 4 files changed, 80 insertions(+), 33 deletions(-)

-- 
2.19.2
