Received: from eggs.gnu.org ([2001:4830:134:3::10]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fItQq-0005n6-EL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fItQm-0005EQ-3y
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:13:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fItQl-0005Dm-Vh
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:13:12 -0400
References: <1526405722-10887-1-git-send-email-lpetrut@cloudbasesolutions.com>
	<1526405722-10887-3-git-send-email-lpetrut@cloudbasesolutions.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2bc8288-d21f-41d4-8a9f-08ff8b18b30d@redhat.com>
Date: Wed, 16 May 2018 12:13:08 +0200
MIME-Version: 1.0
In-Reply-To: <1526405722-10887-3-git-send-email-lpetrut@cloudbasesolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] WHPX: fix some compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: petrutlucian94@gmail.com
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 15/05/2018 19:35, petrutlucian94@gmail.com wrote:
> From: Lucian Petrut <lpetrut@cloudbasesolutions.com>
> 
> This patch fixes a few compiler warnings, especially in case of
> x86 targets, where the number of registers was not properly handled
> and could cause an overflow.
> 
> Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
> ---
>  target/i386/whpx-all.c | 49 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 0a29d56..2fd3397 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -226,24 +226,31 @@ static void whpx_set_registers(CPUState *cpu)
>      struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
>      struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
>      X86CPU *x86_cpu = X86_CPU(cpu);
> -    struct whpx_register_set vcxt = {0};
> +    struct whpx_register_set vcxt;
>      HRESULT hr;
> -    int idx = 0;
> +    int idx;
> +    int idx_next;
>      int i;
>      int v86, r86;
>  
>      assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>  
> +    memset(&vcxt, 0, sizeof(struct whpx_register_set));

This change does not seem like an improvement, can you send a patch with
the bugfix only?

Thanks,

Paolo
