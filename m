Received: from eggs.gnu.org ([2001:4830:134:3::10]:42012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlWJ-0000tl-Vj
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlWF-00029p-CW
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFlWF-00028r-5M
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:09:55 -0400
Date: Mon, 7 May 2018 16:09:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507190946.GB13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/9] i386: Add cache information in
 X86CPUDefinition
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

On Thu, Apr 26, 2018 at 11:26:42AM -0500, Babu Moger wrote:
> Add cache information in X86CPUDefinition and CPUX86State.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  target/i386/cpu.h | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b6c1592..a518a0f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1105,6 +1105,7 @@ struct X86CPUDefinition {
>      int stepping;
>      FeatureWordArray features;
>      const char *model_id;
> +    CPUCaches cache_info;
>  };
>  
>  static X86CPUDefinition builtin_x86_defs[] = {
> @@ -3242,6 +3243,9 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>          env->features[w] = def->features[w];
>      }
>  
> +    /* Load Cache information from the X86CPUDefinition */
> +    memcpy(&env->cache_info, &def->cache_info, sizeof(CPUCaches));
> +
>      /* Special cases not set in the X86CPUDefinition structs: */
>      /* TODO: in-kernel irqchip for hvf */
>      if (kvm_enabled()) {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index fa03e2c..1213bb7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1096,6 +1096,13 @@ typedef struct CPUCacheInfo {
>  } CPUCacheInfo;
>  
>  
> +typedef struct CPUCaches {
> +        bool valid;
> +        CPUCacheInfo l1d_cache;
> +        CPUCacheInfo l1i_cache;
> +        CPUCacheInfo l2_cache;
> +        CPUCacheInfo l3_cache;
> +} CPUCaches;
>  
>  typedef struct CPUX86State {
>      /* standard registers */
> @@ -1282,6 +1289,7 @@ typedef struct CPUX86State {
>      /* Features that were explicitly enabled/disabled */
>      FeatureWordArray user_features;
>      uint32_t cpuid_model[12];
> +    CPUCaches cache_info;

Suggestion for a follow-up patch, or in case there's need to
respin this series: what about making both
X86CPUDefinition::cache_info and CPUX86State::cache_info pointers
instead of embedded structs?  This way you won't need the 'valid'
field (you can just check if the pointer is NULL), and won't need
the memcpy() above.

This shouldn't block the series, though:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
