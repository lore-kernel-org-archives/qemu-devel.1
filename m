Received: from eggs.gnu.org ([2001:4830:134:3::10]:46396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAw-0000GJ-B4
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAs-0004TX-3X
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:26 -0400
Received: from ozlabs.org ([103.22.144.67]:48569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e4LAr-0004Rj-8p
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:22 -0400
Date: Tue, 17 Oct 2017 16:49:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171017054950.GK2776@umbus.fritz.box>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+ARLBH93C7pgvpZY"
Content-Disposition: inline
In-Reply-To: <1508170976-96869-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/6] numa: postpone options post-processing
 till machine_run_board_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com


--+ARLBH93C7pgvpZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 06:22:51PM +0200, Igor Mammedov wrote:
> in preparation for numa options to being handled via QMP before
> machine_run_board_init(), move final numa configuration checks
> and processing to machine_run_board_init() so it could take into
> account both CLI (via parse_numa_opts()) and QMP input
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/sysemu/numa.h |  1 +
>  hw/core/machine.c     |  5 +++--
>  numa.c                | 13 ++++++++-----
>  3 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 5c6df28..c19e456 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -31,6 +31,7 @@ struct NumaNodeMem {
> =20
>  extern NodeInfo numa_info[MAX_NODES];
>  void parse_numa_opts(MachineState *ms);
> +void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
>  void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 80647ed..f482211 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -701,7 +701,7 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      return g_string_free(s, false);
>  }
> =20
> -static void machine_numa_finish_init(MachineState *machine)
> +static void machine_numa_finish_cpu_init(MachineState *machine)
>  {
>      int i;
>      bool default_mapping;
> @@ -756,7 +756,8 @@ void machine_run_board_init(MachineState *machine)
>      MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
> =20
>      if (nb_numa_nodes) {
> -        machine_numa_finish_init(machine);
> +        numa_complete_configuration(machine);
> +        machine_numa_finish_cpu_init(machine);
>      }
>      machine_class->init(machine);
>  }
> diff --git a/numa.c b/numa.c
> index 8d78d95..18af4ff 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -424,15 +424,11 @@ void numa_default_auto_assign_ram(MachineClass *mc,=
 NodeInfo *nodes,
>      nodes[i].node_mem =3D size - usedmem;
>  }
> =20
> -void parse_numa_opts(MachineState *ms)
> +void numa_complete_configuration(MachineState *ms)
>  {
>      int i;
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
> -    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL))=
 {
> -        exit(1);
> -    }
> -
>      assert(max_numa_nodeid <=3D MAX_NODES);
> =20
>      /* No support for sparse NUMA node IDs yet: */
> @@ -508,6 +504,13 @@ void parse_numa_opts(MachineState *ms)
>      }
>  }
> =20
> +void parse_numa_opts(MachineState *ms)
> +{
> +    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL))=
 {
> +        exit(1);
> +    }
> +}
> +
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **=
errp)
>  {
>      int node_id =3D object_property_get_int(OBJECT(dev), "node-id", &err=
or_abort);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+ARLBH93C7pgvpZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnlmf4ACgkQbDjKyiDZ
s5K3iA//bg+X7lfrcoFz1e8IIiO4ycKl7qeaaiGhqrj7/VCn+ykM7HmqB4NKT+Eu
TvehfvKC2MsErP9G3zt2lfWfMBoOkWshssT+wsLNjNrDTxnWAqXtW5qJrqsRxZY+
+z0+etlygjZiVDoRcdafiSvdu2UpRNJBPjTXzsT5ZgI7Mg3PRSx+NSKJTJaqIwL7
JRZfOWMH6SJNhlk6AdZpA67RwkEnHSxFBl08v8ctLK5rHp9qMSIOj1o4M80grM+/
qMNYd5OS/CaMYj9q3oYxY15elzVpQs681JyIxu5F4m22Hcp/iH+wauuvWvh9kqLM
k0auqh50UKlUX4gZUp8FHlbcCiNrQOR9Eb1iBk/s9PV53Qtp5nX+V/n0SvG4Gzch
+8EilfqPG4vsS+xlAUCni+54059+vdrnDs+7kBNEI5W9GP7M02Zp7IkZtwVXFtO4
YIUQjr/4rb8k1FL24JpYBCU2F7eI8Dt1iW4L1sth40QikC7HemMJnFR7UrapTd/t
PAIYEP9p1cVYXWlzBkAmX0o3gBRsfYoTFr1JhOjkdd3cFgiRonFTjyhwlBQe7HfW
923okMqnihrHhWfAON+CukdgXszoowl0MJJAuGVFq+B71EmnzEMJRC3l2ra5m3PG
sXPepmV/awxtFrj6LmkaQQy6W5Rwif9wSh+789wAFG3yR+qosBU=
=8xVz
-----END PGP SIGNATURE-----

--+ARLBH93C7pgvpZY--
