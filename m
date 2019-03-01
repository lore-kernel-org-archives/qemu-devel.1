Received: from eggs.gnu.org ([209.51.188.92]:51940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzkQC-0007ak-Fd
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzkQ8-0001Gc-LO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:57 -0500
Date: Fri, 1 Mar 2019 15:49:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190301154947.GJ21251@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551454936-205218-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote:
> The parameter allows to configure fake NUMA topology where guest
> VM simulates NUMA topology but not actually getting a performance
> benefits from it. The same or better results could be achieved
> using 'memdev' parameter. In light of that any VM that uses NUMA
> to get its benefits should use 'memdev' and to allow transition
> initial RAM to device based model, deprecate 'mem' parameter as
> its ad-hoc partitioning of initial RAM MemoryRegion can't be
> translated to memdev based backend transparently to users and in
> compatible manner (migration wise).
> 
> That will also allow to clean up a bit our numa code, leaving only
> 'memdev' impl. in place and several boards that use node_mem
> to generate FDT/ACPI description from it.

Can you confirm that the  'mem' and 'memdev' parameters to -numa
are 100% live migration compatible in both directions ?  Libvirt
would need this to be the case in order to use the 'memdev' syntax
instead.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  numa.c               |  2 ++
>  qemu-deprecated.texi | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1e..2205773 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>  
>      if (node->has_mem) {
>          numa_info[nodenr].node_mem = node->mem;
> +        warn_report("Parameter -numa node,mem is deprecated,"
> +                    " use -numa node,memdev instead");
>      }
>      if (node->has_memdev) {
>          Object *o;
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 45c5795..73f99d4 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -60,6 +60,20 @@ Support for invalid topologies will be removed, the user must ensure
>  topologies described with -smp include all possible cpus, i.e.
>    @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
>  
> +@subsection -numa node,mem=@var{size} (since 4.0)
> +
> +The parameter @option{mem} of @option{-numa node} is used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> +size on the host side (like bind it to a host node, setting bind policy, ...),
> +so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA node
> +using parameter @option{memdev}, which does the same as @option{mem} and has
> +an ability to actualy manage node RAM on the host side. Use parameter
> +@option{memdev} with @var{memory-backend-ram} backend as an replacement for
> +parameter @option{mem} to achieve the same fake NUMA effect or a properly
> +configured @var{memory-backend-file} backend to actually benefit from NUMA
> +configuration.
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> -- 
> 2.7.4
> 
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
