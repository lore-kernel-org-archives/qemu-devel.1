Received: from eggs.gnu.org ([2001:4830:134:3::10]:46216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVzkP-0003pD-Vb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVzkE-0005hq-Lh
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cVzkE-0005hT-GJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:38 -0500
References: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ce45588-a312-aff1-6e7a-e54e29d4882c@redhat.com>
Date: Tue, 24 Jan 2017 12:58:34 +0100
MIME-Version: 1.0
In-Reply-To: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] x86-kvm: Fix Mac guest timekeeping
 by exposing TSC frequency in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org



On 20/01/2017 15:11, Phil Dennis-Jordan wrote:
> Darwin/OS X/macOS for x86-64 uses the TSC for timekeeping; it normally calibrates this by querying various clock frequency scaling MSRs. Details depend on the exact CPU model detected. The local APIC timer frequency is extracted from (EFI) firmware. Virtualisation environments including Qemu/KVM don't expose those MSRs to guests, and in any case the host and guest CPUs' MSRs may not match up. To solve this, the xnu kernel queries CPUID leaf 0x40000010 for the TSC and APIC timers if leaf 0x40000000 suggests that this leaf exists, which is the case when running inside VMWare (Fusion). This patch series replicates the behaviour of these CPUID leaves for Qemu/KVM via a new x86 CPU option, "vmware-cpuid-freq."
> 
> The option is activated by default on 2.9 and newer pc (PIIX and Q35) machine variants, if the TSC is stable and known (invtsc or user-specified).
> 
> Changelog
> ========
> 
> v1 -> v2
>  * The v1 thread was "[PATCH] x86-KVM: Supply TSC and APIC clock rates to guest like VMWare"
>  * The option has been renamed as suggested in the v1 discussion.
>  * It now checks that either invtsc or a user-specified TSC clock rate are active before activating leaf 0x40000010.
>  * CPUID leaf 0x40000000 exposed by KVM will only reference 0x40000010 if all preconditions are met and the functionality is actually active.
>  * No more error message if preconditions are not met.
>  * cpuid_data.cpuid.nent update/cpuid_find_entry bug fixed.
>  * 2 extra patches included, one for setting up PC machine version 2.8/2.9 compatibility configurations, the second for enabling the new option in version 2.9+ PIIX/q35 configurations by default, while leaving it disabled for 2.8 or older machines.
> 
> Phil Dennis-Jordan (3):
>   x86-KVM: Supply TSC and APIC clock rates to guest like VMWare
>   pc: Add 2.9 machine type
>   pc: Enable vmware-cpuid-freq CPU option for 2.9+ machine types
> 
>  hw/i386/pc_piix.c    | 13 ++++++++++++-
>  hw/i386/pc_q35.c     | 12 +++++++++++-
>  include/hw/i386/pc.h |  6 ++++++
>  target/i386/cpu.c    |  1 +
>  target/i386/cpu.h    |  4 ++++
>  target/i386/kvm.c    | 36 ++++++++++++++++++++++++++++++------
>  6 files changed, 64 insertions(+), 8 deletions(-)
> 

Looks good, thanks!  Queued patches 1 and 3 for 2.9 (patch 2 is in already).

Paolo
