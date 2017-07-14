Received: from eggs.gnu.org ([2001:4830:134:3::10]:45082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVw2o-0002SK-C1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVw2n-0007bz-HK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:33:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dVw2n-0007bK-Ae
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:33:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 09:33:42 +0100
Message-Id: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kamil Rytarowski <n54@gmx.com>, Markus Armbruster <armbru@redhat.com>

This patchset fixes the build on NetBSD by making sure we only
build the ivshmem-client and ivshmem-server tools if the host OS
actually supports ivshmem. (Previously we were only gating building
of the within-QEMU ivshmem PCI device.)

Most of this patchset is the work of Kamil Rytarowski; I just
split it up into easily-reviewable patches and fixed a few bugs.

Tested on Linux, on NetBSD, and on Linux with a '--disable-linux-user
--disable-system' config (which was the one that was failing with
our previous attempt to fix this bug).

NB: we still have some things we need to fix to be able to put
NetBSD into the build-test set. The next issue is that 'make check'
fails with

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k --verbose -m=quick tests/check-qdict
sh: arith: syntax error: "RANDOM % 255 + 1"

likely because we're using a bashism there.

thanks
-- PMM

Kamil Rytarowski (2):
  configure: Use an explicit CONFIG_IVSHMEM rather than CONFIG_EVENTFD
  configure: Don't build ivshmem tools unless CONFIG_IVSHMEM is set

Peter Maydell (1):
  configure: Rename CONFIG_IVSHMEM to CONFIG_IVSHMEM_DEVICE

 configure               | 11 +++++++++++
 Makefile                |  2 ++
 Makefile.objs           |  4 ++--
 hw/misc/Makefile.objs   |  2 +-
 tests/Makefile.include  |  4 ++--
 default-configs/pci.mak |  2 +-
 6 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.7.4
