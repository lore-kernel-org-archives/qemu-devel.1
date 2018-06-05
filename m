Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ1G5-0000jh-8T
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ1G2-00069P-44
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQ1G1-00069J-SA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:59:34 -0400
Date: Mon, 4 Jun 2018 22:59:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180605015928.GH3184@localhost.localdomain>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
	<1527176614-26271-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527176614-26271-3-git-send-email-babu.moger@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 2/5] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, May 24, 2018 at 11:43:31AM -0400, Babu Moger wrote:
> Add information for cpuid 0x8000001D leaf. Populate cache topology info=
rmation
> for different cache types (Data Cache, Instruction Cache, L2 and L3) su=
pported
> by 0x8000001D leaf. Please refer to the Processor Programming Reference=
 (PPR)
> for AMD Family 17h Model for more details.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  target/i386/kvm.c |  29 ++++++++++++--
>  2 files changed, 143 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5c9bdc9..0d423e5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -337,6 +337,99 @@ static void encode_cache_cpuid80000006(CPUCacheInf=
o *l2,
>  }
> =20
>  /*
> + * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
> + * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual =
Volume 3.
> + * Define the constants to build the cpu topology. Right now, TOPOEXT
> + * feature is enabled only on EPYC. So, these constants are based on
> + * EPYC supported configurations. We may need to handle the cases if
> + * these values change in future.
> + */
> +/* Maximum core complexes in a node */
> +#define MAX_CCX 2
> +/* Maximum cores in a core complex */
> +#define MAX_CORES_IN_CCX 4
> +/* Maximum cores in a node */
> +#define MAX_CORES_IN_NODE 8
> +/* Maximum nodes in a socket */
> +#define MAX_NODES_PER_SOCKET 4
> +
> +/*
> + * Figure out the number of nodes required to build this config.
> + * Max cores in a node is 4
> + */
> +static int nodes_in_socket(int nr_cores)
> +{
> +    int nodes;
> +
> +    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
> +
> +   /* Hardware does not support config with 3 nodes, return 4 in that =
case */
> +    return (nodes =3D=3D 3) ? 4 : nodes;
> +}
> +
> +/*
> + * Decide the number of cores in a core complex with the given nr_core=
s using
> + * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NOD=
E and
> + * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
> + * L3 cache is shared across all cores in a core complex. So, this wil=
l also
> + * tell us how many cores are sharing the L3 cache.
> + */
> +static int cores_in_core_complex(int nr_cores)
> +{
> +    int nodes;
> +
> +    /* Check if we can fit all the cores in one core complex */
> +    if (nr_cores <=3D MAX_CORES_IN_CCX) {
> +        return nr_cores;
> +    }
> +    /* Get the number of nodes required to build this config */
> +    nodes =3D nodes_in_socket(nr_cores);
> +
> +    /*
> +     * Divide the cores accros all the core complexes
> +     * Return rounded up value
> +     */
> +    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
> +}

It's nice that we try to figure out a good default even on weird
topologies:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

But I still worry about the complexity of compat code in the
future if we decide to change the results of this function a
little bit.  Maybe we should allow TOPOEXT to be enabled only on
cases where we really know how to fit the cores in a round number
of nodes/core-complexes?

Let's do this in a follow-up patch?

--=20
Eduardo
