Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNhfX-0005oG-NZ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNhfS-0000tF-Uj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:12:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gNhfS-0000ru-MU
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:12:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D09B699D2F
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 17:12:29 +0000 (UTC)
Date: Fri, 16 Nov 2018 17:12:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181116171226.GC2457@work-vm>
References: <20181116164806.26929-1-pbonzini@redhat.com>
	<20181116164806.26929-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116164806.26929-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: consult migration
 blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> There is really no difference between live migration and savevm, except
> that savevm does not require bdrv_invalidate_cache to be implemented
> by all disks.  However, it is unlikely that savevm is used with anything
> except qcow2 disks, so the penalty is small and worth the improvement
> in catching bad usage of savevm.
> 
> Only one place was taking care of savevm when adding a migration blocker,
> and it can be removed.

OK, I'm not sure if it was actually a split between savevm and migration
or just that the migration blockers were added later.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  migration/savevm.c | 4 ++++
>  target/i386/kvm.c  | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ef707b8c43..1c49776a91 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2455,6 +2455,10 @@ int save_snapshot(const char *name, Error **errp)
>      struct tm tm;
>      AioContext *aio_context;
>  
> +    if (migration_is_blocked(errp)) {
> +        return false;
> +    }
> +
>      if (!replay_can_snapshot()) {
>          error_setg(errp, "Record/replay does not allow making snapshot "
>                     "right now. Try once more later.");
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b6fbd3f20..d222b68fe4 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1284,7 +1284,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (!env->user_tsc_khz) {
>          if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
>              invtsc_mig_blocker == NULL) {
> -            /* for migration */
>              error_setg(&invtsc_mig_blocker,
>                         "State blocked by non-migratable CPU device"
>                         " (invtsc flag)");
> @@ -1294,8 +1293,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                  error_free(invtsc_mig_blocker);
>                  return r;
>              }
> -            /* for savevm */
> -            vmstate_x86_cpu.unmigratable = 1;

So that means vmstate_x86_cpu can be static now - but why does it live
in machine.c rather than cpu.c ?

Dave

>          }
>      }
>  
> -- 
> 2.19.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
