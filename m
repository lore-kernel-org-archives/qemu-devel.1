Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ek4FB-0001YE-QU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ek4F6-0001Rm-VO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:17 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ek4F6-0001RZ-PQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:12 -0500
Received: by mail-wr0-x244.google.com with SMTP id h9so7360902wre.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 00:41:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <bonzini@gnu.org>
Message-ID: <5100a4b2-0fe4-b6be-5d6f-4b61a23dc870@gnu.org>
Date: Fri, 9 Feb 2018 09:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 08/02/2018 10:44, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Add PV_DEDICATED hint cpuid feature bit.

Please add a new feature word, since this is not a PV feature but more
like a performance hint.

Thanks,

Paolo

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  target/i386/cpu.h | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d70954b..cf48931 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>              x86_cpu_get_supported_feature_word(w, false);
>          uint32_t requested_features = env->features[w];
>          env->features[w] &= host_feat;
> +        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
> +            env->features[w] |= CPUID_PV_DEDICATED;
> +        }
>          cpu->filtered_features[w] = requested_features & ~env->features[w];
>          if (cpu->filtered_features[w]) {
>              rv = 1;
> @@ -4682,6 +4685,7 @@ static Property x86_cpu_properties[] = {
>                       false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> +    DEFINE_PROP_BOOL("pv-dedicated", X86CPU, pv_dedicated, false),
>  
>      /*
>       * From "Requirements for Implementing the Microsoft
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index f91e37d..8000da5 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -672,6 +672,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>  
> +#define CPUID_PV_DEDICATED     (1U << 8)
> +
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>  #define CPUID_XSAVE_XSAVEC     (1U << 1)
>  #define CPUID_XSAVE_XGETBV1    (1U << 2)
> @@ -1276,6 +1278,7 @@ struct X86CPU {
>      bool expose_kvm;
>      bool expose_tcg;
>      bool migratable;
> +    bool pv_dedicated;
>      bool max_features; /* Enable all supported features automatically */
>      uint32_t apic_id;
>  
> 
