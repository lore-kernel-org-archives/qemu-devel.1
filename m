Received: from eggs.gnu.org ([2001:4830:134:3::10]:46064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmOtz-0004bR-6B
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmOtv-0007Pg-UE
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmOtv-0007PP-LT
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:04:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C918C4E4D8
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 18:04:27 +0000 (UTC)
Date: Fri, 10 Mar 2017 15:04:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170310180424.GJ11509@thinpad.lan.raisama.net>
References: <20170309181212.18864-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309181212.18864-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/3] Use non-blacklisted
 family/model/stepping for Haswell CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fweimer@redhat.com, libvir-list@redhat.com, dgilbert@redhat.com, carlos@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com, triegel@redhat.com

On Thu, Mar 09, 2017 at 03:12:09PM -0300, Eduardo Habkost wrote:
> I plan to merge this bug fix into 2.9.

I'm queueing this on my x86-next branch.

> 
> Changes v2 -> v3:
> * Rebase to latest master
> * Don't touch max_x86_cpu_initfn() to reduce risk post
>   hard freeze
> 
> Changes v1 -> v2:
> * Coding style fixes
> * Make series simpler:
>   * Don't use trick: char vendor[static (CPUID_VENDOR_SZ + 1)]
>     because it confuses checkpatch.pl
>   * Removed patch "Add explicit array size to x86_cpu_vendor_words2str()"
> * Rebased on top of my x86-next branch:
>   https://github.com/ehabkost/qemu x86-next
> 
> Git branch for testing:
>   https://github.com/ehabkost/qemu-hacks work/x86-rtm-blacklist
> 
> Diff from v1:
> 
>   diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>   index cd94726e43..647435a1d9 100644
>   --- a/target/i386/cpu.h
>   +++ b/target/i386/cpu.h
>   @@ -1431,7 +1431,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>    void cpu_clear_apic_feature(CPUX86State *env);
>    void host_cpuid(uint32_t function, uint32_t count,
>                    uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>   -void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping);
>   +void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> 
>    /* helper.c */
>    int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr,
>   diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>   index 25c6c5e115..eab1ad7935 100644
>   --- a/target/i386/cpu.c
>   +++ b/target/i386/cpu.c
>   @@ -682,7 +682,7 @@ void host_cpuid(uint32_t function, uint32_t count,
>            *edx = vec[3];
>    }
> 
>   -void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping)
>   +void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
>    {
>        uint32_t eax, ebx, ecx, edx;
> 
>   @@ -1570,7 +1570,8 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
>        xcc->kvm_required = true;
>        xcc->ordering = 9;
> 
>   -    host_vendor_fms(host_cpudef.vendor, &host_cpudef.family, &host_cpudef.model, &host_cpudef.stepping);
>   +    host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
>   +                    &host_cpudef.model, &host_cpudef.stepping);
> 
>        cpu_x86_fill_model_id(host_cpudef.model_id);
> 
> ---
> 
> A recent glibc commit[1] added a blacklist to ensure it won't use
> TSX on hosts that are known to have a broken TSX implementation.
> 
> Our existing Haswell CPU model has a blacklisted
> family/model/stepping combination, so it has to be updated to
> make sure guests will really use TSX. This is done by patch 5/5.
> 
> However, to do this safely we need to ensure the host CPU is not
> a blacklisted one, so we won't mislead guests by exposing
> known-to-be-good FMS values on a known-to-be-broken host. This is
> done by patch 3/5.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359
> 
> ---
> Cc: dgilbert@redhat.com
> Cc: fweimer@redhat.com
> Cc: carlos@redhat.com
> Cc: triegel@redhat.com
> Cc: berrange@redhat.com
> Cc: jdenemar@redhat.com
> Cc: pbonzini@redhat.com
> 
> Eduardo Habkost (3):
>   i386: host_vendor_fms() helper function
>   i386/kvm: Blacklist TSX on known broken hosts
>   i386: Change stepping of Haswell to non-blacklisted value
> 
>  include/hw/i386/pc.h |  5 +++++
>  target/i386/cpu.h    |  1 +
>  target/i386/cpu.c    | 21 ++++++++++++++++++++-
>  target/i386/kvm.c    | 17 +++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> -- 
> 2.11.0.259.g40922b1
> 
> 

-- 
Eduardo
