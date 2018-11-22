Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPskr-0006hL-C7
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPskn-0000sY-Hh
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gPskm-0000ga-1Y
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:27:01 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 17:26:50 +0000
Message-Id: <20181122172653.3413-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-4.0 0/3] Avoid
 cpu_physical_memory_read() in generic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patchset takes three places in generic code which
use cpu_physical_memory_read(), and changes them to use
address_space_read() instead.

Changes v1->v2:
 * patches 1, 2 unchanged (and reviewed)
 * patch 3: handle as being NULL (which for the
   load_elf APIs means "use address_space_memory")

cpu_physical_memory_{read,rw,write} all implicitly assume
that there is exactly one view of physical memory. This
is sort-of true today, but we'd like to be able to move
to having heterogenous systems where not all CPUs share
the same view of physical memory.

In disas.c we are disassembling for a particular CPU, so
use that CPU's primary address space (cs->as).

In monitor.c we are reading physical memory for a
particular CPU, so again use that CPU's primary address
space; we fall back to address_space_memory for the case
where there are no CPUs in the system (-machine none).

In elf_ops.h the function was passed an address space to
use, so just use it.

Other places in generic code that use these functions are:
 * dump.c -- the whole UI here seems to assume that there
   is only one view of memory and that is what is being dumped
 * cpu.c:qmp_pmemsave() -- again, the UI assumption is that
   there's only one view of memory
So I've left those alone.

NB: git grep command line for finding callsites:
 git grep '\<cpu_physical_memory_\(read\|write\|rw\)\>'

thanks
-- PMM


Peter Maydell (3):
  disas.c: Use address_space_read() to read memory
  monitor: Use address_space_read() to read memory
  elf_ops.h: Use address_space_write() to write memory

 include/hw/elf_ops.h | 4 +++-
 disas.c              | 5 ++++-
 monitor.c            | 8 +++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.19.1
