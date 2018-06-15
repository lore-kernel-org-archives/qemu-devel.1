Received: from eggs.gnu.org ([2001:4830:134:3::10]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTo0t-0003IP-S8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTo0p-0001j2-Pg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:39:34 -0400
Date: Fri, 15 Jun 2018 14:39:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615143923.1babac86@redhat.com>
In-Reply-To: <20180615112500.19854-7-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/12] hostmem: drop error variable from
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 15 Jun 2018 13:24:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> Unused, so let's remove it.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
breaks compilation with

 hw/mem/nvdimm.c:171:5: error: too many arguments to function =E2=80=98host=
_memory_backend_get_memory=E2=80=99
     return host_memory_backend_get_memory(dimm->hostmem, &error_abort);


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
> index 4087aca25e..37e19044d6 100644
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
> index 7387963cf1..73f0eee4c7 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -226,12 +226,12 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDI=
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
