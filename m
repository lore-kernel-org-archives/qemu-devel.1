Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTlw-0000mk-PZ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTlr-0006bp-UI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSTlr-0006Zl-Nt
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:50:35 -0400
Date: Mon, 11 Jun 2018 17:50:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611205030.GW7451@localhost.localdomain>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528498581-131037-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Fri, Jun 08, 2018 at 06:56:19PM -0400, Babu Moger wrote:
> Enable TOPOEXT feature on EPYC CPU. This is required to support
> hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> 
> TOPOEXT feature is disabled for legacy machines.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d3411ed..4dd9a82 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2574,6 +2574,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x8000000A,
>          .model_id = "AMD EPYC Processor",
>          .cache_info = &epyc_cache_info,
> +        .auto_topoext = 1,
>      },
>      {
>          .name = "EPYC-IBPB",
> @@ -2621,6 +2622,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x8000000A,
>          .model_id = "AMD EPYC Processor (with IBPB)",
>          .cache_info = &epyc_cache_info,
> +        .auto_topoext = 1,
>      },
>  };
>  
> @@ -4672,6 +4674,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
>          }
>  
> +        /* TOPOEXT feature requires 0x8000001E */
> +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
> +        }

I suggest moving this hunk to a separate patch.  I'm not 100%
sure yet if this will require compat_props code to disable
auto-xlevel-increase on older machine-types.

-- 
Eduardo
