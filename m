Received: from eggs.gnu.org ([2001:4830:134:3::10]:35451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePp-0002YJ-Hn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePm-0007wt-FM
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:44873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwePm-0007w8-68
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:42 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Fri,  7 Apr 2017 17:45:32 -0700
Message-Id: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 0/4] pam: make pam configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, Anthony Xu <anthony.xu@intel.com>

Qemu creates 13 enabled memory regions and 39 disabled memory regions
for pam. in normal setup, more than half of all memory regions in
system root region are memory regions for pam. Which slow down all
memory region related operations. 

This patch makes pam configurable, by default it is enabled.
it keeps the old behavior by default.

you can disable pam by appending pam=off to -machine. If pam is
disabled, all memory regions for pam are gone, and some memory
region operations are gone since these memory regions are gone,
and memory region operations is fast because there are much less
memory regions. This patch works on both seabios and qboot,
it reduces Qemu heap size from ~12MB to ~9MB

if pam is disabled, pc.rom is useless, so it is disabled as well.

when pam is disabled, pc.bios and isa.bios are writeable memory
region, and isa.bios is put under system memory region, otherwise
isa.bios is acctually disabled because it is under pci memory region
which has lower priority than pc.ram region.

Anthony Xu (4):
  pam: refactor PAM related code
  pam: Make PAM configurable
  pam: disable pc.rom when pam is disabled
  pam: setup pc.bios

 hw/i386/pc.c         | 33 ++++++++++++++++++++++------
 hw/i386/pc_sysfw.c   | 30 +++++++++++++++++--------
 hw/pci-host/piix.c   | 62 ++++++++++++++++++++++++++++++++++++++--------------
 hw/pci-host/q35.c    | 43 ++++++++++++++++++++++--------------
 include/hw/i386/pc.h |  6 ++++-
 5 files changed, 123 insertions(+), 51 deletions(-)

-- 
1.8.3.1
