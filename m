Received: from eggs.gnu.org ([2001:4830:134:3::10]:33446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cMg4l-0007zm-Cq
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 14:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cMg4i-00040l-Mx
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 14:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cMg4i-0003zQ-H9
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 14:09:16 -0500
Date: Thu, 29 Dec 2016 16:57:27 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20161229185725.GA2536@amt.cnet>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-2-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482866480-26208-2-git-send-email-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] kvm: Simplify invtsc check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Tue, Dec 27, 2016 at 05:21:17PM -0200, Eduardo Habkost wrote:
> Instead of searching the table we have just built, we can check
> the env->features field directly.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 10a9cd8..a26290f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -962,8 +962,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
>      }
>  
> -    c = cpuid_find_entry(&cpuid_data.cpuid, 0x80000007, 0);
> -    if (c && (c->edx & 1<<8) && invtsc_mig_blocker == NULL) {
> +    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> +        invtsc_mig_blocker == NULL) {
>          /* for migration */
>          error_setg(&invtsc_mig_blocker,
>                     "State blocked by non-migratable CPU device"
> -- 
> 2.7.4


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
