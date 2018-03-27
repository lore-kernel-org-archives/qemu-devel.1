Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBi-0002MH-FO
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBf-0003pY-8H
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:26 -0400
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com
	([104.47.33.64]:43315
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wBe-0003oR-Pp
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:23 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 27 Mar 2018 17:31:02 -0400
Message-ID: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/9] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, babu.moger@amd.com

This series enables the TOPOEXT feature for AMD CPUs. This is required to
support hyperthreading on kvm guests.

This addresses the issues reported in these bugs:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1481253
https://bugs.launchpad.net/qemu/+bug/1703506=20


v5:
In this series I tried to address the feedback from Eduardo Habkost.
The discussion thread is here.
https://patchwork.kernel.org/patch/10299745/
The previous thread is here.
http://patchwork.ozlabs.org/cover/884885/

Reason for these changes
The cache properties for AMD family of processors have changed from
previous releases. We don't want to display the new information on the
old family of processors as this might cause compatibility issues.

Changes:
 1. Based the patches on top of Eduardo's(patch#1) patch.
    Changed few things.
    Moved the Cache definitions to cpu.h file.
    Changed the CPUID_4 names to generic names.
2. Added a new propery "legacy-cache" in cpu object(patch#2). This can be
   used to display the old property even if the host supports the new cache
   properties.
3. Added cache information in X86CPUDefinition and CPUX86State
4. Patch 6-7 changed quite a bit from previous version does to new approach=
.
5. Addressed few issues with CPUID_8000_001d and CPUID_8000_001E.


v4:
1.Removed the checks under cpuid 0x8000001D leaf(patch #2). These check are
  not necessary. Found this during internal review.
2.Added CPUID_EXT3_TOPOEXT feature for all the 17 family(patch #4). This wa=
s
  found by Kash Pande during his testing.
3.Removed th hardcoded cpuid xlevel and dynamically extended if CPUID_EXT3_=
TOPOEXT
  is supported(Suggested by Brijesh Singh).=20

v3:
1.Removed the patch #1. Radim mentioned that original typo problem is in=20
  linux kernel header. qemu is just copying those files.
2.In previous version, I used the cpuid 4 definitions for AMDs cpuid leaf
  0x8000001D. CPUID 4 is very intel specific and we dont want to expose tho=
se
  details under AMD. I have renamed some of these definitions as generic.
  These changes are in patch#1. Radim, let me know if this is what you inte=
nded.
3.Added assert to for core_id(Suggested by Radim Kr=C4=8Dm=C3=A1=C5=99).
4.Changed the if condition under "L3 cache info"(Suggested by Gary Hook).
5.Addressed few more text correction and code cleanup(Suggested by Thomas L=
endacky).

v2:
  Fixed few more minor issues per Gary Hook's comments. Thank you Gary.
  Removed the patch#1. We need to handle the instruction cache associativit=
y=20
  seperately. It varies based on the cpu family. I will comeback to that la=
ter.
  Added two more typo corrections in patch#1 and patch#5.

v1:
  Stanislav Lanci posted few patches earlier.=20
  https://patchwork.kernel.org/patch/10040903/

Rebased his patches with few changes.
1.Spit the patches into two, separating cpuid functions=20
  0x8000001D and 0x8000001E (Patch 2 and 3).
2.Removed the generic non-intel check and made a separate patch
  with some changes(Patch 5).
3.Fixed L3_N_SETS_AMD(from 4096 to 8192) based on CPUID_Fn8000001D_ECX_x03.

Added 2 more patches.
Patch 1. Fixes cache associativity.
Patch 4. Adds TOPOEXT feature on AMD EPYC CPU.


Babu Moger (8):
  i386: Add cache information in X86CPUDefinition
  i386: Initialize cache information for EPYC family processors
  i386: Add new property to control cache info
  i386: Use the statically loaded cache definitions
  i386: Populate AMD Processor Cache Information for cpuid 0x8000001D
  i386: Add support for CPUID_8000_001E for AMD
  i386: Enable TOPOEXT feature on AMD EPYC CPU
  i386: Remove generic SMT thread check

Eduardo Habkost (1):
  i386: Helpers to encode cache information consistently

 include/hw/i386/pc.h |   6 +-
 target/i386/cpu.c    | 735 ++++++++++++++++++++++++++++++++++++++++++-----=
----
 target/i386/cpu.h    |  66 +++++
 target/i386/kvm.c    |  29 +-
 4 files changed, 702 insertions(+), 134 deletions(-)

--=20
1.8.3.1
