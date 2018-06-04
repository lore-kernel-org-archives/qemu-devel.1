Received: from eggs.gnu.org ([2001:4830:134:3::10]:33759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPnHV-0003WL-RX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPnHV-0001rt-1q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:04:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fPnHU-0001k4-Ro
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:04:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 12:03:56 +0100
Message-Id: <20180604110358.2821-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] mips boston/malta: don't have nomigrate
 RAM regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com

This patchset fixes a a bug in the MIPS boston and malta boards:
they currently use memory_region_init_rom_nomigrate() to create
memory regions for their BIOS/flash, and they don't manually
register the MR with vmstate_register_ram() either. This currently
means that its contents are migrated, but as a RAM block whose
name is the empty string; in future (when a patch which is currently
in the outstanding migration tree pull request hits master) it
will mean they are not migrated at all. Switch to using
memory_region_init_ram() instead, so the memory contents are
migrated with a reasonable name.

Note that this is a cross-version migration compatibility break
for both machines, but:
 (a) migration will break anyway due to the "don't migrate
     unnamed RAM blocks" patch
 (b) neither machine is versioned, so we don't really care about
     maintaining cross-version migration compatibility AFAIK

thanks
-- PMM

Peter Maydell (2):
  hw/mips/boston: don't make flash region 'nomigrate'
  hw/mips/mips_malta: don't make bios region 'nomigrate'

 hw/mips/boston.c     | 3 +--
 hw/mips/mips_malta.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1
