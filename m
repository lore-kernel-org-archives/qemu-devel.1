Received: from eggs.gnu.org ([2001:4830:134:3::10]:39565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFnSy-0004gi-LS
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFnSv-0007qJ-Ha
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFnSv-0007q8-B0
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:14:37 -0400
Date: Mon, 7 May 2018 18:14:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507211427.GJ13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-10-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-10-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 9/9] i386: Remove generic SMT thread
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, Apr 26, 2018 at 11:26:49AM -0500, Babu Moger wrote:
> Remove generic non-intel check while validating hyperthreading support.
> Certain AMD CPUs can support hyperthreading now.
> 
> CPU family with TOPOEXT feature can support hyperthreading now.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  target/i386/cpu.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6ebbef2..54d908f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4830,17 +4830,20 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      qemu_init_vcpu(cs);
>  
> -    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
> -     * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
> -     * based on inputs (sockets,cores,threads), it is still better to gives
> +    /* Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
> +     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
> +     * based on inputs (sockets,cores,threads), it is still better to give
>       * users a warning.
>       *
>       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
>       * cs->nr_threads hasn't be populated yet and the checking is incorrect.
>       */
> -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
> -        error_report("AMD CPU doesn't support hyperthreading. Please configure"
> -                     " -smp options properly.");
> +     if (IS_AMD_CPU(env) &&
> +         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> +         cs->nr_threads > 1 && !ht_warned) {
> +            error_report("This family of AMD CPU doesn't support "
> +                         "hyperthreading. Please configure -smp "
> +                         "options properly.");
>          ht_warned = true;
>      }
>  
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
