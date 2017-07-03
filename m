Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS3Y6-0000jW-FI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS3Y3-0008TP-CP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dS3Y3-0008SL-51
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:46:03 -0400
References: <20170703152338.20024-1-haozhong.zhang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c016d0d6-1a89-6455-6b9c-c09769dcd1af@redhat.com>
Date: Mon, 3 Jul 2017 17:45:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170703152338.20024-1-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: mask MSR_IA32_BNDCFGS if MPX is
 not enabled in guest cpuid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 03/07/2017 17:23, Haozhong Zhang wrote:
> Otherwise, QEMU on a host with MPX support will try to set guest
> MSR_IA32_BNDCFGS although guest MPX is not enabled, and result in
> abort.
> 
> For example,
>    qemu-system-x86_64 -enable-kvm -cpu qemu64,-mpx ...
> aborts with messages:
>    qemu-system-x86_64: error: failed to set MSR 0xd90 to 0x0
>    qemu-system-x86_64: /root/qemu.git/target/i386/kvm.c:1832: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed

I think the fix should be in KVM, allowing BNDCFGS = 0 if
host_initiated, even if MPX is not enabled.

Paolo

> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  target/i386/kvm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ee36502789..7b3a310a31 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -943,6 +943,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
>      }
>  
> +    if (has_msr_bndcfgs) {
> +        c = cpuid_find_entry(&cpuid_data.cpuid, 7, 0);
> +        has_msr_bndcfgs = c && (c->ebx & CPUID_7_0_EBX_MPX);
> +    }
> +
>      if (!env->user_tsc_khz) {
>          if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
>              invtsc_mig_blocker == NULL) {
> 
