Received: from eggs.gnu.org ([2001:4830:134:3::10]:48490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQgYo-0000Tk-Dc
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQgYj-000585-Df
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:05:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQgYj-00057W-5O
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:05:37 -0400
Date: Wed, 6 Jun 2018 19:05:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606220531.GC7451@localhost.localdomain>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528295806-90593-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/4] i386: Verify if topoext feature
 can be supported
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

On Wed, Jun 06, 2018 at 10:36:44AM -0400, Babu Moger wrote:
> topoext feature cannot be supported in certain cases
> with large number of cores or threads. Add the check.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 86fb1a4..fc5c66d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -509,6 +509,20 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>  }
>  
>  /*
> + * Check if we can support this topology
> + * Fail if number of cores are beyond the supported config
> + * or nr_threads is more than 2
> + */
> +static int topology_supports_topoext(int nr_cores, int nr_threads)
> +{
> +    if ((nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET)) ||
> +        (nr_threads > 2)) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
> +/*
>   * Definitions of the hardcoded cache entries we expose:
>   * These are legacy cache values. If there is a need to change any
>   * of these values please use builtin_x86_defs
> @@ -4941,6 +4955,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      qemu_init_vcpu(cs);
>  
> +    /* On AMD systems, check if we can support topoext feature */
> +    if (IS_AMD_CPU(env) &&
> +        (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
> +        if (!topology_supports_topoext(cs->nr_cores, cs->nr_threads)) {
> +                /* Cannot support topoext */
> +                error_setg(errp, "CPU model does not support topoext feature "
> +                                 "with number of cores(%d) and threads(%d). "
> +                                 "Please configure -smp options properly.",
> +                                 cs->nr_cores, cs->nr_threads);

See error.h documentation:

 * Error reporting system loosely patterned after Glib's GError.
 *
 * Create an error:
 *     error_setg(&err, "situation normal, all fouled up");
 *
 * Create an error and add additional explanation:
 *     error_setg(&err, "invalid quark");
 *     error_append_hint(&err, "Valid quarks are up, down, strange, "
 *                       "charm, top, bottom.\n");
 *
 * Do *not* contract this to
 *     error_setg(&err, "invalid quark\n"
 *                "Valid quarks are up, down, strange, charm, top, bottom.");
 *

I suggest something like this:

static bool topology_supports_topoext(int nr_cores, int nr_threads, Error **errp)
{
    if (nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET))) {
        error_setg(errp, "TOPOEXT unsupported with %d cores per socket", nr_cores);
        error_append_hint(errp, "TOPOEXT supports only up to %d cores per socket",
                          (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
        return false;
    }
    if (nr_threads > 2) {
        error_setg(errp, "TOPOEXT unsupported with %d threads per core", nr_threads);
        error_append_hint(errp, "TOPOEXT supports only up to 2 threads per core");
                          (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
        return false;
    }
    return true;
}

static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
{
    /* ... */
    if (IS_AMD_CPU(env) &&
        (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
        !topology_supports_topoext(cs->nr_cores, cs->nr_threads, errp)) {
            return;
    }
    /* ... */
}

-- 
Eduardo
