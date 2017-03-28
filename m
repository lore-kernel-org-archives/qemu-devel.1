Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNr-0008Oq-4y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNp-0000Pr-P4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:31 -0400
Date: Tue, 28 Mar 2017 15:46:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328044633.GF21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 11/23] numa: do default mapping
 based on possible_cpus instead of node_cpu bitmaps
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


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:36PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  numa.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/numa.c b/numa.c
> index 44057f1..ab41776 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -309,6 +309,7 @@ static void validate_numa_cpus(void)
>  void parse_numa_opts(MachineState *ms)
>  {
>      int i;
> +    const CPUArchIdList *possible_cpus;
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
>      for (i =3D 0; i < MAX_NODES; i++) {
> @@ -379,11 +380,6 @@ void parse_numa_opts(MachineState *ms)
> =20
>          numa_set_mem_ranges();
> =20
> -        for (i =3D 0; i < nb_numa_nodes; i++) {
> -            if (!bitmap_empty(numa_info[i].node_cpu, max_cpus)) {
> -                break;
> -            }
> -        }
>          /* Historically VCPUs were assigned in round-robin order to NUMA
>           * nodes. However it causes issues with guest not handling it ni=
ce
>           * in case where cores/threads from a multicore CPU appear on
> @@ -391,11 +387,20 @@ void parse_numa_opts(MachineState *ms)
>           * rule grouping VCPUs by socket so that VCPUs from the same soc=
ket
>           * would be on the same node.
>           */
> -        if (!mc->cpu_index_to_instance_props) {
> +        if (!mc->cpu_index_to_instance_props || !mc->possible_cpu_arch_i=
ds) {
>              error_report("default CPUs to NUMA node mapping isn't suppor=
ted");
>              exit(1);
>          }
> -        if (i =3D=3D nb_numa_nodes) {
> +
> +        possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> +        for (i =3D 0; i < possible_cpus->len; i++) {
> +            if (possible_cpus->cpus[i].props.has_node_id) {
> +                break;
> +            }
> +        }
> +
> +        /* no CPUs are assigned to NUMA nodes */
> +        if (i =3D=3D possible_cpus->len) {
>              for (i =3D 0; i < max_cpus; i++) {
>                  CpuInstanceProperties props;
>                  /* fetch default mapping from board and enable it */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2eqpAAoJEGw4ysog2bOSFzMP/25zmgP8Hm+XB1cCMJyzR/k1
NhQDzE3EMWwhul/kaUBKRRxodv9vpqZMG9gBNkJpcw4NhFO5ZtbrxrNqUWg/XUeJ
EqMM7zIDfY0GQ9+UyBhAGebGnZ6rLW+lzPs+4Ri4kvJha5x/cQiid7AAbAR9bmu1
PH4fazs7nUSJRYmhcQ+QPhnnXM60RZaozpZvNf3KD1C7WiLsno1SHhXdPDvxh8be
R72JB52r+nvJJEYxa0Z7bsyLILm8oeDO4DiiyOO8mdCXVFMMz2IFI50pcn9oSIQw
QoLljRia82DL2GzfqBCebztOlgUxsv0z1dU0ZfFZ0kehnp4wuHqtmSNr3m1lr2ZB
eYaHOeGH0JC3Q+6cs6rydKtsDwLnXECPbXqp8EI7hAZUoJT77CI3tTWywyWCFAx3
+s9xf3JLjIDO1oCc41DXYYJVYrnuzWcn8btSUU7lWicAHNzb2AD8w9h7YYD0kVbz
sVR0IdkaU+ZeKilykgUg8ysGq3c/0mSRUaTi//bQlmbrZMM6aaaq2gKNU0bmAe5C
BBVbvTAZoe2sZvTG1lL6TblaZkVmvmYqOKIBS2v+MytrauY+y3qDhsIiLFNPFWrI
b6bYRU0Hkrc82ZRTFbFVtB3lE7i7V7jIhWADBtnkpovGfgByDeE7saB94TwupA1f
CONXsWCosDb6O+oUJrWk
=JOY2
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
