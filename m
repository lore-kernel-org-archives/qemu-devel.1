Received: from eggs.gnu.org ([2001:4830:134:3::10]:34368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJRyh-0007ln-0Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJRyd-0006Kb-65
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:01:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJRyd-0006KQ-0N
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:01:55 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so17973984qtb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 15:01:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609133426.11447-1-david@redhat.com>
	<20170609133426.11447-3-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <68dff3f0-df71-df52-8370-8e5f6c7f8a52@twiddle.net>
Date: Fri, 9 Jun 2017 15:01:50 -0700
MIME-Version: 1.0
In-Reply-To: <20170609133426.11447-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x/cpumodel: wire up cpu type +
 id for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/09/2017 06:34 AM, David Hildenbrand wrote:
> Let's properly expose the CPU type (machine-type number) via "STORE CPU
> ID" and "STORE SUBSYSTEM INFORMATION".
> 
> As TCG emulates basic mode, the CPU identification number has the format
> "Annnnn", whereby A is the CPU address, and n are parts of the CPU serial
> number (0 for us for now).
> 
> A specification exception will be injected if the address is not aligned
> to a double word. Low address protection will not be checked as
> we're missing some more general support for that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   target/s390x/cpu.h         | 2 +-
>   target/s390x/cpu_models.c  | 8 ++++++--
>   target/s390x/insn-data.def | 2 +-
>   target/s390x/misc_helper.c | 9 ++++++---
>   target/s390x/translate.c   | 9 ++-------
>   5 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index a4d31df..502d3d7 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -149,7 +149,7 @@ typedef struct CPUS390XState {
>       CPU_COMMON
>   
>       uint32_t cpu_num;
> -    uint32_t machine_type;
> +    uint64_t cpuid;
>   
>       uint64_t tod_offset;
>       uint64_t tod_basetime;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index b34318f..c508ae1 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -737,8 +737,6 @@ static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
>   
>       if (kvm_enabled()) {
>           kvm_s390_apply_cpu_model(model, errp);
> -    } else if (model) {
> -        /* FIXME TCG - use data for stdip/stfl */
>       }
>   
>       if (!*errp) {
> @@ -786,6 +784,12 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
>       }
>   
>       apply_cpu_model(cpu->model, errp);
> +
> +    cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
> +    if (tcg_enabled()) {
> +        /* basic mode, write the cpu address into the first 4 bit of the ID */
> +        cpu->env.cpuid |= ((uint64_t)cpu->env.cpu_num & 0xf) << 54;

I changed this to deposit64 and applied the patch to my tree.


r~
