Received: from eggs.gnu.org ([2001:4830:134:3::10]:60156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fBnpE-00059L-UX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fBnpB-0006NL-0Q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:49:09 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:48208)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fBnpA-0006LM-GE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:49:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Apr 2018 06:49:00 +1000
From: geoff@hostfission.com
In-Reply-To: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
Message-ID: <6161324950f8166f1c0eda88eaab8d06@hostfission.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/9] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net

Works well for me, thanks!

Tested-by: Geoffrey McRae <geoff@hostfission.com>

On 2018-04-27 02:26, Babu Moger wrote:
> This series enables the TOPOEXT feature for AMD CPUs. This is required=20
> to
> support hyperthreading on kvm guests.
>=20
> This addresses the issues reported in these bugs:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1481253
> https://bugs.launchpad.net/qemu/+bug/1703506
>=20
> v7:
>  Rebased on top of latest tree after 2.12 release and done few basic
> tests. There are
>  no changes except for few minor hunks. Hopefully this gets pulled
> into 2.13 release.
>  Please review, let me know of any feedback.
>=20
> v6:
> 1.Fixed problem with patch#4(Add new property to control cache info).
> The parameter
>  legacy_cache should be "on" by default on machine type "pc-q35-2.10".=20
> This was
>  found by Alexandr Iarygin.
> 2.Fixed the l3 cache size for EPYC based machines(patch#3). Also,
> fixed the number of
>  logical processors sharing the cache(patch#6). Only L3 cache is
> shared by multiple
>  cores but not L1 or L2. This was a bug while decoding. This was found
> by Geoffrey McRae
>  and he verified the fix.
>=20
> v5:
>  In this series I tried to address the feedback from Eduardo Habkost.
>  The discussion thread is here.
>  https://patchwork.kernel.org/patch/10299745/
>  The previous thread is here.
>  http://patchwork.ozlabs.org/cover/884885/
>=20
> Reason for these changes.
>  The cache properties for AMD family of processors have changed from
>  previous releases. We don't want to display the new information on the
>  old family of processors as this might cause compatibility issues.
>=20
> Changes:
> 1.Based the patches on top of Eduardo's(patch#1) patch.
>   Changed few things.
>   Moved the Cache definitions to cpu.h file.
>   Changed the CPUID_4 names to generic names.
> 2.Added a new propery "legacy-cache" in cpu object(patch#2). This can=20
> be
>   used to display the old property even if the host supports the new=20
> cache
>   properties.
> 3.Added cache information in X86CPUDefinition and CPUX86State
> 4.Patch 6-7 changed quite a bit from previous version does to new=20
> approach.
> 5.Addressed few issues with CPUID_8000_001d and CPUID_8000_001E.
>=20
> v4:
> 1.Removed the checks under cpuid 0x8000001D leaf(patch #2). These check=
=20
> are
>   not necessary. Found this during internal review.
> 2.Added CPUID_EXT3_TOPOEXT feature for all the 17 family(patch #4).=20
> This was
>   found by Kash Pande during his testing.
> 3.Removed th hardcoded cpuid xlevel and dynamically extended if
> CPUID_EXT3_TOPOEXT
>   is supported(Suggested by Brijesh Singh).
>=20
> v3:
> 1.Removed the patch #1. Radim mentioned that original typo problem is=20
> in
>   linux kernel header. qemu is just copying those files.
> 2.In previous version, I used the cpuid 4 definitions for AMDs cpuid=20
> leaf
>   0x8000001D. CPUID 4 is very intel specific and we dont want to expose=
=20
> those
>   details under AMD. I have renamed some of these definitions as=20
> generic.
>   These changes are in patch#1. Radim, let me know if this is what you=20
> intended.
> 3.Added assert to for core_id(Suggested by Radim Kr=C4=8Dm=C3=A1=C5=99)=
.
> 4.Changed the if condition under "L3 cache info"(Suggested by Gary=20
> Hook).
> 5.Addressed few more text correction and code cleanup(Suggested by
> Thomas Lendacky).
>=20
> v2:
>   Fixed few more minor issues per Gary Hook's comments. Thank you Gary.
>   Removed the patch#1. We need to handle the instruction cache=20
> associativity
>   seperately. It varies based on the cpu family. I will comeback to=20
> that later.
>   Added two more typo corrections in patch#1 and patch#5.
>=20
> v1:
>   Stanislav Lanci posted few patches earlier.
>   https://patchwork.kernel.org/patch/10040903/
>=20
> Rebased his patches with few changes.
> 1.Spit the patches into two, separating cpuid functions
>   0x8000001D and 0x8000001E (Patch 2 and 3).
> 2.Removed the generic non-intel check and made a separate patch
>   with some changes(Patch 5).
> 3.Fixed L3_N_SETS_AMD(from 4096 to 8192) based on=20
> CPUID_Fn8000001D_ECX_x03.
>=20
> Added 2 more patches.
> Patch 1. Fixes cache associativity.
> Patch 4. Adds TOPOEXT feature on AMD EPYC CPU.
>=20
>=20
> Babu Moger (8):
>   i386: Add cache information in X86CPUDefinition
>   i386: Initialize cache information for EPYC family processors
>   i386: Add new property to control cache info
>   i386: Use the statically loaded cache definitions
>   i386: Populate AMD Processor Cache Information for cpuid 0x8000001D
>   i386: Add support for CPUID_8000_001E for AMD
>   i386: Enable TOPOEXT feature on AMD EPYC CPU
>   i386: Remove generic SMT thread check
>=20
> Eduardo Habkost (1):
>   i386: Helpers to encode cache information consistently
>=20
>  include/hw/i386/pc.h |   4 +
>  target/i386/cpu.c    | 736=20
> ++++++++++++++++++++++++++++++++++++++++++---------
>  target/i386/cpu.h    |  66 +++++
>  target/i386/kvm.c    |  29 +-
>  4 files changed, 702 insertions(+), 133 deletions(-)
