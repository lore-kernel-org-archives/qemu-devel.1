Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKT-0006G2-1r
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKO-0007SI-Ru
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:05 -0400
Received: from mail-eopbgr730053.outbound.protection.outlook.com
	([40.107.73.53]:16992
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTsKO-0007R7-Fh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:00 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 15 Jun 2018 13:15:44 -0400
Message-ID: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v15 0/3] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

This series enables the TOPOEXT feature for AMD CPUs. This is required to
support hyperthreading on kvm guests.

This addresses the issues reported in these bugs:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1481253
https://bugs.launchpad.net/qemu/+bug/1703506=20

v15:
 Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git x86-=
next.
 Some of the patches are queued already. Submitting remaining series.
 Summary of changes.
 1. Added changes to support all the currently supported nr_cores and nr_th=
reads.
    Fixed up the node id to support this.
 2. Removed topology_supports_topoext function. This is not required anymor=
e as
    we allow all the combinations to work now.
 3. Fixed other feedback from Eduardo for v14.

v14:
 Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git x86-=
next.
 Some of the patches are queued already. Submitting remaining series.
 Summary of changes.
 1. Always set TOPOEXT feature in kvm_arch_get_supported_cpuid
 2. Implemented topology_supports_topoext bit differently. Reason for this =
is, if we
    need to disable this feature before the x86_cpu_expand_features. But pr=
oblem is
    nr_cores and nr_threads are not populated at this time. It is populated=
 in qemu_init_vcpus.
 3. Removed auto-topoext feature completely. The can cause lots of compatib=
ility issues.

v13:
 Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git x86-=
next.
 Some of the patches are queued already. Submitting remaining series.
 Summary of changes.
 1.Fixed the error format if the topology cannot be supported.
 2.Fixed the compatibility issues with old cpu models and new machine types=
.
   Here is the discussion thread.
   Here is the discussion thread. https://lists.gnu.org/archive/html/qemu-d=
evel/2018-06/msg01239.html
 3.I am still testing it. But sending it to get review feedback.

v12:
 Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git x86-=
next.
 Some of the patches are queued already. Submitting remaining series.

 Summary of changes.
 1.Added more comments explaining CPUID_Fn8000001E bit definitions.
 2.Split the patch into separate patch to check the topology. Moved the cod=
e to
   x86_cpu_realizefn. Display the error if topoext feature cannot be enable=
d.
 3.Few more text corrections.

v11:
 Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git x86-=
next.
 Summary of changes.
 1.Added more comments explaining different constants and variables.
 2.Removed NUM_SHARING_CACHE macro and made the code simpler.
 3.Changed the function name num_sharing_l3_cache to cores_in_core_complex.
   This function is actually finding the number of cores in a core complex.
   Purpose here is to re-use the code in couple more places.
 4.Added new function nodes_in_socket to find number of nodes in the config=
.
   Purpose here is to re-use the code.
 5.Used DIV_ROUND_UP wherever applicable.
 6.Renamed few constants and functions to generic names.
 7.Few more text corrections.
=20
v10:
 Based the patches on Eduardo's git://github.com/ehabkost/qemu.git x86-next
 Some of the earlier patches are already queued. So, submitting the rest of
 the series here. This series adds complete redesign of the cpu topology.
 Based on user given parameter, we try to build topology very close to the
 hardware. Maintains symmetry as much as possible. Added new function
 epyc_build_topology to build the topology based on user given nr_cores,
 nr_threads.
 Summary of changes.
 1. Build the topology dinamically based on nr_cores and nr_threads
 2. Added new epyc_build_topology to build the new topology.
 3. Added new function num_sharing_l3_cache to calculate the L3 sharing
 4. Added a check to verify the topology. Disabled the TOPOEXT if the
    topology cannot be built.

v9:
 Based the patches on Eduardo's git://github.com/ehabkost/qemu.git x86-next
 tree. Following 3 patches from v8 are already queued.
  i386: Add cache information in X86CPUDefinition
  i386: Initialize cache information for EPYC family processors
  i386: Helpers to encode cache information consistently
 So, submitting the rest of the series here.

 Changes:
 1. Included Eduardo's clean up patch
 2. Added 2.13 machine types
 3. Disabled topoext for 2.12 and below versions.
 4. Added the assert to core_id as discussed.

v8:
 Addressed feedback from Eduardo. Thanks Eduardo for being patient with me.
 Tested on AMD EPYC server and also did some basic testing on intel box.
 Summary of changes.
 1. Reverted back l2 cache associativity. Kept it same as legacy.
 2. Changed cache_info structure in X86CPUDefinition and CPUX86State to=20
pointers.
 3. Added legacy_cache property in PC_COMPAT_2_12 and initialized legacy_ca=
che
    based on static cache_info availability.
 4. Squashed patch 4 and 5 and applied it before patch 3.
 5. Added legacy cache check for cpuid[2] and cpuid[4] for consistancy.
 6. Simplified NUM_SHARING_CACHE definition for readability,
 7. Removed assert for core_id as it appeared redundant.
 8. Simplified encode_cache_cpuid8000001d little bit.
 9. Few more minor changes

v7:
 Rebased on top of latest tree after 2.12 release and done few basic tests.=
=20
There are
 no changes except for few minor hunks. Hopefully this gets pulled into 2.1=
3=20
release.
 Please review, let me know of any feedback.

v6:
1.Fixed problem with patch#4(Add new property to control cache info). The=20
parameter
 legacy_cache should be "on" by default on machine type "pc-q35-2.10". This=
 was
 found by Alexandr Iarygin.
2.Fixed the l3 cache size for EPYC based machines(patch#3). Also, fixed the=
=20
number of
 logical processors sharing the cache(patch#6). Only L3 cache is shared by=
=20
multiple
 cores but not L1 or L2. This was a bug while decoding. This was found by=20
Geoffrey McRae
 and he verified the fix.=20

v5:
 In this series I tried to address the feedback from Eduardo Habkost.
 The discussion thread is here.
 https://patchwork.kernel.org/patch/10299745/
 The previous thread is here.
 http://patchwork.ozlabs.org/cover/884885/

Reason for these changes.
 The cache properties for AMD family of processors have changed from
 previous releases. We don't want to display the new information on the
 old family of processors as this might cause compatibility issues.

Changes:
1.Based the patches on top of Eduardo's(patch#1) patch.
  Changed few things.
  Moved the Cache definitions to cpu.h file.
  Changed the CPUID_4 names to generic names.
2.Added a new propery "legacy-cache" in cpu object(patch#2). This can be
  used to display the old property even if the host supports the new cache
  properties.
3.Added cache information in X86CPUDefinition and CPUX86State
4.Patch 6-7 changed quite a bit from previous version does to new approach.
5.Addressed few issues with CPUID_8000_001d and CPUID_8000_001E.

v4:
1.Removed the checks under cpuid 0x8000001D leaf(patch #2). These check are
  not necessary. Found this during internal review.
2.Added CPUID_EXT3_TOPOEXT feature for all the 17 family(patch #4). This wa=
s
  found by Kash Pande during his testing.
3.Removed th hardcoded cpuid xlevel and dynamically extended if=20
CPUID_EXT3_TOPOEXT
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
3.Added assert to for core_id(Suggested by Radim Krcm=C3=A1r).
4.Changed the if condition under "L3 cache info"(Suggested by Gary Hook).
5.Addressed few more text correction and code cleanup(Suggested by Thomas=20
Lendacky).

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


Babu Moger (3):
  i386: Fix up the Node id for CPUID_8000_001E
  i386: Enable TOPOEXT feature on AMD EPYC CPU
  i386: Remove generic SMT thread check

 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.c    | 50 +++++++++++++++++++++++++++++++++++++++---------=
--
 2 files changed, 47 insertions(+), 11 deletions(-)

--=20
1.8.3.1
