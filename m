Received: from eggs.gnu.org ([209.51.188.92]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvt-0003EU-N0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvr-0005BK-TJ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:01 -0500
Date: Wed, 13 Feb 2019 12:30:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213013037.GT1884@umbus.fritz.box>
References: <20190212214827.30543-1-lvivier@redhat.com>
	<20190212214827.30543-5-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wYXww9TlNKyqAMAe"
Content-Disposition: inline
In-Reply-To: <20190212214827.30543-5-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/4] numa: check threads of the same core are
 on the same node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--wYXww9TlNKyqAMAe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 10:48:27PM +0100, Laurent Vivier wrote:
> A core cannot be split between two nodes.
> To check if a thread of the same core has already been assigned to a node,
> this patch reverses the numa topology checking order and exits if the
> topology is not valid.

I'm not entirely sure if this makes sense to enforce generically.

It's certainly true for PAPR - we have no way to represent threads
with different NUMA nodes to the guest.

It probably makes sense for everything - the whole point of threading
is to take better advantage of latencies accessing memory, so it seems
implausible that the threads would have different paths to memory.

But... there are some pretty weird setups out there, so I'm not sure
it's a good idea to enforce a restriction generically that's not
actually inherent in the structure of the problem.

>=20
> Update test/numa-test accordingly.
>=20
> Fixes: 722387e78daf ("spapr: get numa node mapping from possible_cpus ins=
tead of numa_get_node_for_cpu()")
> Cc: imammedo@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/core/machine.c | 27 ++++++++++++++++++++++++---
>  tests/numa-test.c |  4 ++--
>  2 files changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a2c29692b55e..c0a556b0dce7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -602,6 +602,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      bool match =3D false;
>      int i;
> +    const CpuInstanceProperties *previous_props =3D NULL;
> =20
>      if (!mc->possible_cpu_arch_ids) {
>          error_setg(errp, "mapping of CPUs to NUMA node is not supported"=
);
> @@ -634,18 +635,38 @@ void machine_set_cpu_numa_node(MachineState *machin=
e,
>          }
> =20
>          /* skip slots with explicit mismatch */
> -        if (props->has_thread_id && props->thread_id !=3D slot->props.th=
read_id) {
> +        if (props->has_socket_id && props->socket_id !=3D slot->props.so=
cket_id) {
>                  continue;
>          }
> =20
> -        if (props->has_core_id && props->core_id !=3D slot->props.core_i=
d) {
> +        if (props->has_core_id) {
> +            if (props->core_id !=3D slot->props.core_id) {
>                  continue;
> +            }
> +            if (slot->props.has_node_id) {
> +                /* we have a node where our core is already assigned */
> +                previous_props =3D &slot->props;
> +            }
>          }
> =20
> -        if (props->has_socket_id && props->socket_id !=3D slot->props.so=
cket_id) {
> +        if (props->has_thread_id && props->thread_id !=3D slot->props.th=
read_id) {
>                  continue;
>          }
> =20
> +        /* check current thread matches node of the thread of the same c=
ore */
> +        if (previous_props && previous_props->has_node_id &&
> +            previous_props->node_id !=3D props->node_id) {
> +            char *cpu_str =3D cpu_props_to_string(props);
> +            char *node_str =3D cpu_props_to_string(previous_props);
> +            error_setg(errp,  "Invalid node-id=3D%"PRIu64" of [%s]: core=
-id "
> +                              "[%s] is already assigned to node-id %"PRI=
u64,
> +                              props->node_id, cpu_str,
> +                              node_str, previous_props->node_id);
> +            g_free(cpu_str);
> +            g_free(node_str);
> +            return;
> +        }
> +
>          /* reject assignment if slot is already assigned, for compatibil=
ity
>           * of legacy cpu_index mapping with SPAPR core based mapping do =
not
>           * error out if cpu thread and matched core have the same node-i=
d */
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 5280573fc992..a7c3c5b4dee8 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -112,7 +112,7 @@ static void pc_numa_cpu(const void *data)
>          "-numa cpu,node-id=3D1,socket-id=3D0 "
>          "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
>          "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 "
> -        "-numa cpu,node-id=3D1,socket-id=3D1,core-id=3D1,thread-id=3D1");
> +        "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D1");
>      qtest_start(cli);
>      cpus =3D get_cpus(&resp);
>      g_assert(cpus);
> @@ -141,7 +141,7 @@ static void pc_numa_cpu(const void *data)
>          } else if (socket =3D=3D 1 && core =3D=3D 1 && thread =3D=3D 0) {
>              g_assert_cmpint(node, =3D=3D, 0);
>          } else if (socket =3D=3D 1 && core =3D=3D 1 && thread =3D=3D 1) {
> -            g_assert_cmpint(node, =3D=3D, 1);
> +            g_assert_cmpint(node, =3D=3D, 0);
>          } else {
>              g_assert(false);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wYXww9TlNKyqAMAe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjcz0ACgkQbDjKyiDZ
s5L6kw/9EytTv20cZpl7Haa3pi/q5EcxyQ+wu23Sdy5I30sfoe9+Bbigoc5ETMHe
LUnP/qoOcbFhpabnNovaJED6cg02ykbpLEQcDrcZV+lYphYhMG88hoHIpwY/nOFA
X4lf7u2/ZiE/fAhXd8dn+yMS9g2utax+1PAJLPIH6jI7Lu6Xyo9jwvFjRlow1phU
g45E7Zx+6U6IoqpSmqZo2nfoulv4m1I2EK+Iq/tZOBuQBw/PhT/qRSUQv+gZvpNy
OPQpeiyvPzt+BLbBQGR1K6BX1TyCcX2/ugEZ3UVFBcPGCoUWgrCIdi4LygclhGl+
VJQNJmCsvA4bAVEIilO9Oq8a5eUqOdQdI463qCko6fnzmVDiv0BBfkN/RYYgpyZu
SOfMvrZ0w/Rfkayy/uTxYp/DTm7eKXCV3dEcirxZsSPSuMXAChzm1oZR83CChyAC
rlNAp8XqXRd5Sdddm0u/o4YIlITai4E3i6p7CikKXOSvIbU87d+qF4BGbNXeCrGs
rASubliisnXrvVU0YzKk/pNk1kzJ/0cWdt8FfHbjSD4/Xs6gRHzC70LYJ5+h5Z1O
hAiujhZpVCmajmdEkT+pJNSltKhWjMyVUhcnLvkziRRxMkWk015ROgpz9VDbeGe+
EU9fxgDIRF4kzDKVkUVHDtKuBNc6h+8ECa7HkO4DlUTy7zgnACs=
=XY6O
-----END PGP SIGNATURE-----

--wYXww9TlNKyqAMAe--
