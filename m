Received: from eggs.gnu.org ([2001:4830:134:3::10]:40234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOs-0002lO-68
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOq-0002Ne-UD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:10 -0400
Date: Tue, 12 Jun 2018 10:49:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612004935.GM2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 04/11] hostmem: drop error variable from
 host_memory_backend_get_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:48PM +0200, David Hildenbrand wrote:
> Unused, so let's remove it.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  backends/hostmem.c       | 3 +--
>  hw/mem/nvdimm.c          | 4 ++--
>  hw/mem/pc-dimm.c         | 4 ++--
>  hw/misc/ivshmem.c        | 3 +--
>  include/sysemu/hostmem.h | 3 +--
>  numa.c                   | 3 +--
>  6 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 3627e61584..4908946cd3 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -247,8 +247,7 @@ bool host_memory_backend_mr_inited(HostMemoryBackend =
*backend)
>      return memory_region_size(&backend->mr) !=3D 0;
>  }
> =20
> -MemoryRegion *
> -host_memory_backend_get_memory(HostMemoryBackend *backend, Error **errp)
> +MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend)
>  {
>      return host_memory_backend_mr_inited(backend) ? &backend->mr : NULL;
>  }
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index f974accbdd..df9716231f 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -105,7 +105,7 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMD=
evice *dimm, Error **errp)
> =20
>  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>  {
> -    MemoryRegion *mr =3D host_memory_backend_get_memory(dimm->hostmem, e=
rrp);
> +    MemoryRegion *mr =3D host_memory_backend_get_memory(dimm->hostmem);
>      NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
>      uint64_t align, pmem_size, size =3D memory_region_size(mr);
> =20
> @@ -161,7 +161,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvd=
imm, const void *buf,
> =20
>      memcpy(nvdimm->label_data + offset, buf, size);
> =20
> -    mr =3D host_memory_backend_get_memory(dimm->hostmem, &error_abort);
> +    mr =3D host_memory_backend_get_memory(dimm->hostmem);
>      backend_offset =3D memory_region_size(mr) - nvdimm->label_size + off=
set;
>      memory_region_set_dirty(mr, backend_offset, size);
>  }
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 62b34a992e..86fbcf2d0c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -224,12 +224,12 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDI=
MMDevice *dimm, Error **errp)
>          return NULL;
>      }
> =20
> -    return host_memory_backend_get_memory(dimm->hostmem, errp);
> +    return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
>  static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dim=
m)
>  {
> -    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
> +    return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 16f03701b7..ee01c5e66b 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -909,8 +909,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)
>      if (s->hostmem !=3D NULL) {
>          IVSHMEM_DPRINTF("using hostmem\n");
> =20
> -        s->ivshmem_bar2 =3D host_memory_backend_get_memory(s->hostmem,
> -                                                         &error_abort);
> +        s->ivshmem_bar2 =3D host_memory_backend_get_memory(s->hostmem);
>      } else {
>          Chardev *chr =3D qemu_chr_fe_get_driver(&s->server_chr);
>          assert(chr);
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 5beb0ef8ab..6e6bd2c1cb 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -62,8 +62,7 @@ struct HostMemoryBackend {
>  };
> =20
>  bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
> -MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
> -                                             Error **errp);
> +MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend);
> =20
>  void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool map=
ped);
>  bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
> diff --git a/numa.c b/numa.c
> index 33572bfa74..94f758c757 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -523,8 +523,7 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, Object *owner,
>          if (!backend) {
>              continue;
>          }
> -        MemoryRegion *seg =3D host_memory_backend_get_memory(backend,
> -                                                           &error_fatal);
> +        MemoryRegion *seg =3D host_memory_backend_get_memory(backend);
> =20
>          if (memory_region_is_mapped(seg)) {
>              char *path =3D object_get_canonical_path_component(OBJECT(ba=
ckend));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfGJ0ACgkQbDjKyiDZ
s5Ialg/+M+DOvavK8cqIQ6snU8PJZn2NBJJo/Obspa6eiC6cYspASchua8j4qpx/
/dbw/vuc9I/iOsTPHhRcsOzhoqyWv0K20/ky2xW5YAhmprWbTHlerSMty3CCeyoB
PZYwUqCRzjeHf35vcmyKkTmn+d0A2dGl8QqPL4A/b3KXt1sXEh9J5/G8Sfz8gHR/
DXjqst7IHYDfNbTYdLDoAtH+md0DOSGaYnv7bRBLvE9vzu2lqUcoajHv4W0EGCSH
4ZAjN9prMlIxr0YEbIrfWjckgDpxg+GhVjRuzy7chy8giBpyQJ87vbDno6QTIvME
PhX0EoLFO1mXaCUcMAFwSvmhFLefhY5kAS09WQkr28KUlHSNrPlnN60BO+Mx1OdU
1IlJpidg+1XcQSazJhVF7m5CiZZ5M5X3Z7+LBOFalxaznq4efgFvDJ7AYDzT2oSi
GgTbtYu00sq0cM1f4hn6vFYdkNw4ChIDv7lacxbnz5UlJBS1D7gDUZ85aOJ/T1H2
zMsEYnRq2bd0TlGwrN59AnQ5Em+rmmo2nxK4b/evGGFogPvCDfo/x+W0T9TZjZCe
gwcNJdjo5DodLc1hFslTPVQYH009RzY1+zfPxvmEkstan2nzmyczxr+xuYJz1tp8
soP06WFS/aFm2VpqrkLcg9+QmG59+6VxMxXM04eO7m6XilEJCj0=
=8W23
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--
