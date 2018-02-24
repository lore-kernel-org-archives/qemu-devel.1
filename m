Received: from eggs.gnu.org ([2001:4830:134:3::10]:51818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPbx-000292-J6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPbu-0000Ul-ST
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:53 -0500
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com
	([104.47.38.55]:35904
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1epPbu-0000U4-Le
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:50 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 23 Feb 2018 21:30:20 -0500
Message-Id: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/5] Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com, babu.moger@amd.com

These series enable TOPOEXT feature on AMD CPU. These are required to support
hyperthreading on kvm guests. Addresses the issues reported by these bugs
https://bugzilla.redhat.com/show_bug.cgi?id=1481253
https://bugs.launchpad.net/qemu/+bug/1703506 

v2:
Fixed few more minor issues per Gary Hooks comments. Thank you Gary.
Removed the patch#1. We need to handle the instruction cache associativity 
seperately. It varies based on the cpu family. I will comeback to that later.
Added two more typo corrections in patch#1 and patch#5.

v1:
Stanislav Lanci posted few patches earlier. 
https://patchwork.kernel.org/patch/10040903/

Rebased his patches with few changes.
1. Spit the patches into two, separating cpuid functions 
   0x8000001D and 0x8000001E (Patch 2 and 3).
2. Removed the generic non-intel check and made a separate patch
   with some changes(Patch 5).
3. Fixed L3_N_SETS_AMD(from 4096 to 8192) based on CPUID_Fn8000001D_ECX_x03.

Added 2 more patches.
Patch 1. Fixes cache associativity.
Patch 4. Adds TOPOEXT feature on AMD EPYC CPU.


Babu Moger (3):
  target/i386: Fix a minor typo found while reviwing
  target/i386: Enable TOPOEXT feature on AMD EPYC CPU
  target/i386: Remove generic SMT thread check

Stanislav Lanci (2):
  target/i386: Populate AMD Processor Cache Information
  target/i386: Add support for CPUID_8000_001E for AMD

 linux-headers/asm-x86/kvm.h |   2 +-
 target/i386/cpu.c           | 104 ++++++++++++++++++++++++++++++++++++++++----
 target/i386/kvm.c           |  31 +++++++++++--
 3 files changed, 124 insertions(+), 13 deletions(-)

-- 
1.8.3.1
