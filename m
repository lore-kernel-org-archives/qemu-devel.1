Received: from eggs.gnu.org ([2001:4830:134:3::10]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec8as-0005Ed-9A
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec8ap-0001Sc-6a
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:42:54 -0500
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-3-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b886bf4-df10-c686-bf46-066f5206de20@redhat.com>
Date: Thu, 18 Jan 2018 12:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180118085628.40798-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 18.01.2018 09:56, Christian Borntraeger wrote:
> We need to handle the bpb control on reset and migration. Normally
> stfle.82 is transparent (and the normal guest part works without
> hypervisor activity). To prevent any issues we require full
> host kernel support for this feature.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu.c              |  1 +
>  target/s390x/cpu.h              |  1 +
>  target/s390x/cpu_features.c     |  1 +
>  target/s390x/cpu_features_def.h |  1 +
>  target/s390x/gen-features.c     |  1 +
>  target/s390x/kvm.c              | 14 ++++++++++++++
>  target/s390x/machine.c          | 17 +++++++++++++++++
>  7 files changed, 36 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index ae3cee9..d2e6b9f 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -89,6 +89,7 @@ static void s390_cpu_reset(CPUState *s)
>      CPUS390XState *env = &cpu->env;
>  
>      env->pfault_token = -1UL;
> +    env->bpbc = false;
>      scc->parent_reset(s);
>      cpu->env.sigp_order = 0;
>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1a8b6b9..c0ef85d 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -93,6 +93,7 @@ struct CPUS390XState {
>  
>      uint32_t fpc;          /* floating-point control register */
>      uint32_t cc_op;
> +    bool bpbc;             /* branch prediction blocking */
>  
>      float_status fpu_status; /* passed to softfloat lib */
>  
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 31a4676..5d1c210 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
> +    FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
>      FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),

I'm not an expert with all this CPU model stuff, but at least for me,
the patch looks fine now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
