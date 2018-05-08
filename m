Received: from eggs.gnu.org ([2001:4830:134:3::10]:40561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG3Yk-0003pk-Vb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG3Yg-0004Ln-3M
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fG3Yf-0004Lf-Rd
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:38 -0400
Date: Tue, 8 May 2018 11:25:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180508142531.GB4903@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-5-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-5-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/9] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Thu, Apr 26, 2018 at 11:26:44AM -0500, Babu Moger wrote:
> This will be used to control the cache information.
> By default new information will be displayed. If user
> passes "-cpu legacy-cache" then older information will
> be displayed even if the hardware supports new information.
> It will be "on" for machine type "pc-q35-2.10" for compatibility.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  include/hw/i386/pc.h | 4 ++++
>  target/i386/cpu.c    | 1 +
>  target/i386/cpu.h    | 5 +++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ffee841..d904a3c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -327,6 +327,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = "q35-pcihost",\
>          .property = "x-pci-hole64-fix",\
>          .value    = "off",\
> +    },{\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "legacy-cache",\
> +        .value    = "on",\
>      },

>  
>  #define PC_COMPAT_2_9 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5d88363..a27b658 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5138,6 +5138,7 @@ static Property x86_cpu_properties[] = {
>                       false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> +    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),


Hmm, this can get messy if we start adding cache info to other
CPU models in future QEMU versions.  e.g.: what if we add cache
info to Opteron_G3 on QEMU 2.14?

I suggest adding this to x86_cpu_load_def():

  cpu->legacy_cache = !cpu->cache_info.valid;

(Or equivalent code, in case cache_info is changed to be a
pointer)

This way, only EPYC will have legacy-cache=false by now, making
it easier to write compatibility code for other CPU models in the
future.


>  
>      /*
>       * From "Requirements for Implementing the Microsoft
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1213bb7..852586a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1395,6 +1395,11 @@ struct X86CPU {
>       */
>      bool enable_l3_cache;
>  
> +    /* Compatibility bits for old machine types.
> +     * If true present the old cache topology information
> +     */
> +    bool legacy_cache;
> +
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> -- 
> 2.7.4
> 

-- 
Eduardo
