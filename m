Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8ges-0007lj-I4
	for qemu-devel@nongnu.org; Thu, 11 May 2017 01:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8ger-0000jg-6B
	for qemu-devel@nongnu.org; Thu, 11 May 2017 01:29:02 -0400
Date: Thu, 11 May 2017 15:23:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511052332.GK14408@umbus.fritz.box>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
	<1494415802-227633-18-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Content-Disposition: inline
In-Reply-To: <1494415802-227633-18-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/18] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 01:30:01PM +0200, Igor Mammedov wrote:
> legacy cpu to node mapping is using cpu index values to map
> VCPU to node with help of '-numa node,nodeid=3Dnode,cpus=3Dx[-y]'
> option. However cpu index is internal concept and QEMU users
> have to guess /reimplement qemu's logic/ to map it to
> a concrete cpu socket/core/thread to make sane CPUs
> placement across numa nodes.
>=20
> This patch allows to map cpu objects to numa nodes using
> the same properties as used for cpus with -device/device_add
> (socket-id/core-id/thread-id/node-id).
>=20
> At present valid properties/values to address CPUs could be
> fetched using hotpluggable-cpus monitor/qmp command, it will
> require user to start qemu twice when creating domain to fetch
> possible CPUs for a machine type/-smp layout first and
> then the second time with numa explicit mapping for actual
> usage. The first step results could be saved and reused to
> set/change mapping later as far as machine type/-smp stays
> the same.
>=20
> Proposed impl. supports exact and wildcard matching to
> simplify CLI and allow to set mapping for a specific cpu
> or group of cpu objects specified by matched properties.
>=20
> For example:
>=20
>    # exact mapping x86
>    -numa cpu,node-id=3Dx,socket-id=3Dy,core-id=3Dz,thread-id=3Dn
>=20
>    # exact mapping SPAPR
>    -numa cpu,node-id=3Dx,core-id=3Dy
>=20
>    # wildcard mapping, all cpu objects that match socket-id=3Dy
>    # are mapped to node-id=3Dx
>    -numa cpu,node-id=3Dx,socket-id=3Dy
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v3:
>   - use qapi_NumaCpuOptions_base() instead of copying fields manually
>     (Eduardo)
> v2:
>   - use new NumaCpuOptions instead of CpuInstanceProperties in
>     NumaOptions, so that in future we could decouple both
>     if needed. (Eduardo Habkost <ehabkost@redhat.com>)
>   - clarify effect of NumaCpuOptions.node-id in qapi-schema.json
> ---
>  numa.c           | 15 +++++++++++++++
>  qapi-schema.json | 21 +++++++++++++++++++--
>  qemu-options.hx  | 20 ++++++++++++++++++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/numa.c b/numa.c
> index ca122cc..84ce2af 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -290,6 +290,21 @@ static int parse_numa(void *opaque, QemuOpts *opts, =
Error **errp)
>              goto end;
>          }
>          break;
> +    case NUMA_OPTIONS_TYPE_CPU:
> +        if (!object->u.cpu.has_node_id) {
> +            error_setg(&err, "Missing mandatory node-id property");
> +            goto end;
> +        }
> +        if (!numa_info[object->u.cpu.node_id].present) {
> +            error_setg(&err, "Invalid node-id=3D%" PRId64 ", NUMA node m=
ust be "
> +                "defined with -numa node,nodeid=3DID before it's used wi=
th "
> +                "-numa cpu,node-id=3DID", object->u.cpu.node_id);
> +            goto end;
> +        }
> +
> +        machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->=
u.cpu),
> +                                  &err);
> +        break;
>      default:
>          abort();
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f1bcebe..c9fdbc3 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5684,10 +5684,12 @@
>  #
>  # @dist: NUMA distance configuration (since 2.10)
>  #
> +# @cpu: property based CPU(s) to node mapping (Since: 2.10)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist' ] }
> +  'data': [ 'node', 'dist', 'cpu' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -5701,7 +5703,8 @@
>    'discriminator': 'type',
>    'data': {
>      'node': 'NumaNodeOptions',
> -    'dist': 'NumaDistOptions' }}
> +    'dist': 'NumaDistOptions',
> +    'cpu': 'NumaCpuOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -5751,6 +5754,20 @@
>     'val': 'uint8' }}
> =20
>  ##
> +# @NumaCpuOptions:
> +#
> +# Option "-numa cpu" overrides default cpu to node mapping.
> +# It accepts the same set of cpu properties as returned by
> +# query-hotpluggable-cpus[].props, where node-id could be used to
> +# override default node mapping.
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'NumaCpuOptions',
> +   'base': 'CpuInstanceProperties',
> +   'data' : {} }
> +
> +##
>  # @HostMemPolicy:
>  #
>  # Host memory policy types
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cfe4dc3..731f1bd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -145,10 +145,12 @@ STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}]
>  @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
> +@itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> =20
> +Legacy VCPU assignment uses @samp{cpus} option where
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>  @samp{cpus} option represent a contiguous range of CPU indexes
>  (or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
> @@ -162,6 +164,24 @@ a NUMA node:
>  -numa node,cpus=3D0-2,cpus=3D5
>  @end example
> =20
> +@samp{cpu} option is a new alternative to @samp{cpus} option
> +which uses @samp{socket-id|core-id|thread-id} properties to assign
> +CPU objects to a @var{node} using topology layout properties of CPU.
> +The set of properties is machine specific, and depends on used
> +machine type/@samp{smp} options. It could be queried with
> +@samp{hotpluggable-cpus} monitor command.
> +@samp{node-id} property specifies @var{node} to which CPU object
> +will be assigned, it's required for @var{node} to be declared
> +with @samp{node} option before it's used with @samp{cpu} option.
> +
> +For example:
> +@example
> +-M pc \
> +-smp 1,sockets=3D2,maxcpus=3D2 \
> +-numa node,nodeid=3D0 -numa node,nodeid=3D1 \
> +-numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D1
> +@end example
> +
>  @samp{mem} assigns a given RAM amount to a node. @samp{memdev}
>  assigns RAM from a given memory backend device to a node. If
>  @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE/VUAAoJEGw4ysog2bOSBWsP/RUTVPEOhe3ZvD3TvVctjLUD
ui6kjMASwxY0z0wTaTo3g8n6YkEpEtOBZiaqEauYyIudHWjP+V5T+89EoYL71UP+
3DoF9xqdsN2dmJyxwaPN78qPcOE+kxxBTbXN6NUVotfZ4oRwP8uZA3XiMjLqHBil
Q8rlzDVuikkStiX6Po/EK7i1NbNbvecSKzoqOyj83u98PMPQlgYkosWmpL+5lBZL
ILH9ETr6PU/20rXbXI4wfA8YdYPnOm44gP4uqzPWRGtKDFFv8sQ7k09ZUgxPaId9
ERy99PwZrtAesFn/G8MHGr4GVvwcy3t4yhTzi1TY3IiuHtL35NB/xuNNajZkvod/
6Tj7aEzx/TF5T3WYlZ9ITNeZn4w4+wOuSWF6C61oLCeANzHVbeWmQeIuEeK0nQWa
06Zyct9pkl4Asuq6eX5b6s10GZ++G7UG+7mXazrIoKpCs40d0Gtm//1k/nTYm1sm
NAaycsBMQVNEcwwvlTkIz+bCGgqRGK50F3bp+bIR94WFv+MzdHlrP4NaGbzG2nYU
zO9XoXiAB+uIOwktRGjfXwFd9bx+vkIAdkbuZdQpzTuvUHWBdXqkxQ90pkNVd3W1
ckjfQJEQzAmCBuEbdf0pMU14Ayk32IM2ALKYkufH087lzYmbuLBHMUXl+19aJodb
8FEF9sEmDpJ0B1XEn86R
=ZLg7
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--
