Received: from eggs.gnu.org ([2001:4830:134:3::10]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csnuA-0000RB-JP
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csnu9-000844-AY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:59:10 -0400
Date: Tue, 28 Mar 2017 16:13:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328051341.GJ21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-22-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-22-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 21/23] numa: remove node_cpu
 bitmaps as they are no longer used
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


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:46PM +0100, Igor Mammedov wrote:
> Postfactum "CPU(s) present in multiple NUMA nodes" check
> was the last user of node_cpu bitmaps, but it's not need
> as machine_set_cpu_numa_node() does the similar check at
> the time mapping is set for cpus (i.e. when -numa cpus=3D
> is parsed) and ensures that cpu can be mapped only to
> one node.
>=20
> Remove duplicate check based on node_cpu bitmaps and
> since the last user is gone remove node_cpu as well,
> which completes internal transition from legacy bitmap
> based mapping storage to possible_cpus storage.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/sysemu/numa.h |  1 -
>  numa.c                | 42 ------------------------------------------
>  2 files changed, 43 deletions(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 345bb94..796ee94 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -17,7 +17,6 @@ struct numa_addr_range {
> =20
>  typedef struct node_info {
>      uint64_t node_mem;
> -    unsigned long *node_cpu;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
>      QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges =
*/
> diff --git a/numa.c b/numa.c
> index 523558f..088fae3 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -177,7 +177,6 @@ static void numa_node_parse(MachineState *ms, NumaNod=
eOptions *node,
>                         cpus->value, max_cpus);
>              return;
>          }
> -        bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
>          props =3D mc->cpu_index_to_instance_props(ms, cpus->value);
>          props.node_id =3D nodenr;
>          props.has_node_id =3D true;
> @@ -261,51 +260,12 @@ end:
>      return 0;
>  }
> =20
> -static char *enumerate_cpus(unsigned long *cpus, int max_cpus)
> -{
> -    int cpu;
> -    bool first =3D true;
> -    GString *s =3D g_string_new(NULL);
> -
> -    for (cpu =3D find_first_bit(cpus, max_cpus);
> -        cpu < max_cpus;
> -        cpu =3D find_next_bit(cpus, max_cpus, cpu + 1)) {
> -        g_string_append_printf(s, "%s%d", first ? "" : " ", cpu);
> -        first =3D false;
> -    }
> -    return g_string_free(s, FALSE);
> -}
> -
> -static void validate_numa_cpus(void)
> -{
> -    int i;
> -    unsigned long *seen_cpus =3D bitmap_new(max_cpus);
> -
> -    for (i =3D 0; i < nb_numa_nodes; i++) {
> -        if (bitmap_intersects(seen_cpus, numa_info[i].node_cpu, max_cpus=
)) {
> -            bitmap_and(seen_cpus, seen_cpus,
> -                       numa_info[i].node_cpu, max_cpus);
> -            error_report("CPU(s) present in multiple NUMA nodes: %s",
> -                         enumerate_cpus(seen_cpus, max_cpus));
> -            g_free(seen_cpus);
> -            exit(EXIT_FAILURE);
> -        }
> -        bitmap_or(seen_cpus, seen_cpus,
> -                  numa_info[i].node_cpu, max_cpus);
> -    }
> -    g_free(seen_cpus);
> -}
> -
>  void parse_numa_opts(MachineState *ms)
>  {
>      int i;
>      const CPUArchIdList *possible_cpus;
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
> -    for (i =3D 0; i < MAX_NODES; i++) {
> -        numa_info[i].node_cpu =3D bitmap_new(max_cpus);
> -    }
> -
>      if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL))=
 {
>          exit(1);
>      }
> @@ -397,12 +357,10 @@ void parse_numa_opts(MachineState *ms)
>                  props =3D mc->cpu_index_to_instance_props(ms, i);
>                  props.has_node_id =3D true;
> =20
> -                set_bit(i, numa_info[props.node_id].node_cpu);
>                  machine_set_cpu_numa_node(ms, &props, &error_fatal);
>              }
>          }
> =20
> -        validate_numa_cpus();
>      } else {
>          numa_set_mem_node_id(0, ram_size, 0);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2fEFAAoJEGw4ysog2bOSQYEP/2D2d6yQfOBNK29wLEcYcjW0
CNA9t81yuc+DvACFI3HSmYlxJdwbk+4KGtCNCblByonv252mxDAGZxHLMQbTRpqf
6Oi0NXwMAmbQkCwsTiMvrYabb8aTtqcBjnWynFHHWJ3q82FkR8cr9erZo1/n6l2l
6fwq7g4zt0/tWtE6WumLfAGYq6CiQZ571GtVG9BU2xRSps97eXyvkD/jqOJfEoLb
YJknmzf7tK/B6jFIwvRKCG9bz/EbPSmdEXo+rINPUstk/zwo2h52WPN+M2I4vKsf
aPn2v72zmibna5WTJgTxI8j8Y0XOr3jcdeIPmMuyJf11yPSBiBK8Og9b8aKQkiYm
nknds05/pSlZlM8xHRLeWXwOFfyE49IaT+BYlF3D2dwXmeCzw77wm/w5RZ2oFr1O
jjJ+jiRUT3e10Jxtwq0j8Av2hiVdtyoZ/ZNFsvsMJ8jIttdOT/5uBFOQRNtET4Yr
Ycq9TFYQoMIOnhWhkTcHxlcHUfE2tcNIwcNoJ19axpEwtBHXdlVRyjXLHcrswksw
ral+pC2rMz6TLLRJsCreLpsfniS1e2xZTpqyVq+DvkLIf65N0XaNXnRzUeP8Aqkx
H4UyHeseLNZjCEFabPzAfp5nhZZ8c2WJW4wQMiUIIrTTWttLZdxxZhWKryWZJHtC
Xn+RoYh+d4moq7AwSOhq
=xJ6M
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
