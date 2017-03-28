Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNq-0008O2-NC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNp-0000Pl-IY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:30 -0400
Date: Tue, 28 Mar 2017 15:55:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328045518.GH21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-19-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-19-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 18/23] numa: remove no longer need
 numa_post_machine_init()
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


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:43PM +0100, Igor Mammedov wrote:
> CPUState::numa_node is still in use but now it's set by
> board when it creates CPU objects. So there isn't any
> need to set it again after all CPU's are created,
> since it's been already set.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/sysemu/numa.h |  1 -
>  numa.c                | 15 ---------------
>  vl.c                  |  2 --
>  3 files changed, 18 deletions(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index c67763a..345bb94 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -25,7 +25,6 @@ typedef struct node_info {
> =20
>  extern NodeInfo numa_info[MAX_NODES];
>  void parse_numa_opts(MachineState *ms);
> -void numa_post_machine_init(void);
>  void query_numa_node_mem(uint64_t node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
>  void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
> diff --git a/numa.c b/numa.c
> index 187c93f..8461c96 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -418,21 +418,6 @@ void parse_numa_opts(MachineState *ms)
>      }
>  }
> =20
> -void numa_post_machine_init(void)
> -{
> -    CPUState *cpu;
> -    int i;
> -
> -    CPU_FOREACH(cpu) {
> -        for (i =3D 0; i < nb_numa_nodes; i++) {
> -            assert(cpu->cpu_index < max_cpus);
> -            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
> -                cpu->numa_node =3D i;
> -            }
> -        }
> -    }
> -}
> -
>  static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *own=
er,
>                                             const char *name,
>                                             uint64_t ram_size)
> diff --git a/vl.c b/vl.c
> index 5ffb9c3..e5c1620 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4587,8 +4587,6 @@ int main(int argc, char **argv, char **envp)
> =20
>      cpu_synchronize_all_post_init();
> =20
> -    numa_post_machine_init();
> -
>      rom_reset_order_override();
> =20
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2ey2AAoJEGw4ysog2bOSkskQAJ2rSxN07Napljq3cYmxPGEl
e6Lv214KlCKnOhIJW/BB3gSx6z+QwAdY+7Y30h5+/Rp+ATY59FMdDR6UgURfSLkb
O4d+Rzxc1r0J2KPXqP0nGu68vMSPJhmFjDH6VfJ9zUigqTsmlC9Ti13osfm463ij
nDAzu7Z0yoJLtbUkSYxuJA/od99hDyN8wrhZ6O9gfTzWciOFo7xe7M+n3dFq2siV
FMEvZGdnt2syx4SrwM838s68WHMcUcYZK/nzMtskSX/P0Zlb/dxirEf4yX55bjD7
nTRhvBt5XlZ2th8BryREEvktM+EMDjJ4zzuVIK9E1r0aBogymVRBzUbwy4ZImPT3
lxCdDLNN5JL8auI03ylBgcuatIC+UOHIiFPFn58/SrDO7qOqETY5N0/i4FkXppaC
tzXDN0DWG3pFq5dSXme77e6/n4v0SThzpEGJG4rNRAVNF78DmHgK4Bbew91GFjXH
DMg8DgTJsdeOh6AtiC9jtEZOiQSBHK9qdFVUMasp4jAxt6q6MPx1xQyqaTJwOiT8
H21nf4Dkhgv4AFHyOdgC5t+7AedQSWofgjsGNZxw/22QOpw0hkJBi/X2lCcYZHvF
UGeJwFK2NYIGBUBUHq2i7AEsKOE8oALHnb7/U7uYu49a9N9EkX5TGWLkNv7fRFOt
Sv3ZhAhXxMuLWZxh/bFR
=Np6X
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
