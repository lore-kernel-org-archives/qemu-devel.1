Received: from eggs.gnu.org ([2001:4830:134:3::10]:52357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXgX-0000WM-MU
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXgS-0000dh-OP
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTXgS-0000d5-F2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:13:24 -0400
Date: Thu, 14 Jun 2018 16:13:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180614191317.GY7451@localhost.localdomain>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-6-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528939107-17193-6-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v14 5/6] i386: Disable TOPOEXT feature if
 it cannot be supported
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

On Wed, Jun 13, 2018 at 09:18:26PM -0400, Babu Moger wrote:
> Disable the TOPOEXT feature if it cannot be supported.
> We cannot support this feature with more than 2 nr_threads
> or more than 32 cores in a socket.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2eb26da..637d8eb 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4765,7 +4765,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
>      CPUX86State *env = &cpu->env;
>      Error *local_err = NULL;
> -    static bool ht_warned;
> +    static bool ht_warned, topo_warned;
>  
>      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
>          char *name = x86_cpu_class_get_model_name(xcc);
> @@ -4779,6 +4779,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /* Disable TOPOEXT if topology cannot be supported */
> +    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> +        if (!topology_supports_topoext(MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET,
> +                                      2)) {

I understand you stopped using cpu->nr_cores/cpu->nr_threads
because it was not filled yet.

But why exactly do you need to do this before calling
x86_cpu_expand_features()?

If you really need nr_cores and nr_threads to be available
earlier, we could simply move their initialization to
cpu_exec_initfn() instead of the solution you implemented in
patch 4/6.

> +            env->features[FEAT_8000_0001_ECX] &= !CPUID_EXT3_TOPOEXT;

!CPUID_EXT3_TOPOEXT is 0, this will clear all bits in
env->features[FEAT_8000_0001_ECX].  Did you mean
~CPUID_EXT3_TOPOEXT?


> +            if (!topo_warned) {
> +                error_report("TOPOEXT feature cannot be supported with more"
> +                             " than %d cores or more than 2 threads per socket."
> +                             " Disabling the feature.",
> +                             (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
> +                topo_warned = true;

This will print a warning for "-cpu EPYC -smp 64,cores=64".
We shouldn't.

I'm starting to believe we shouldn't add TOPOEXT to EPYC unless
we're ready to make the TOPOEXT CPUID leaves work for all valid
-smp configurations.  If the feature will work only on a few
specific cases, the feature should be enabled explicitly using
"-cpu ...,+topoext".

Is it really impossible to make CPUID return reasonable topology
data for larger nr_cores and nr_threads values?  It would make
everything much simpler.

-- 
Eduardo
