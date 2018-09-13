Received: from eggs.gnu.org ([2001:4830:134:3::10]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0Oik-0003RL-Eh
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0Oih-0003ds-3c
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g0Oig-0003cw-Qo
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:19:31 -0400
Date: Thu, 13 Sep 2018 11:19:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180913101916.GA2586@work-vm>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180912125531.32131-10-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 9/9] hostmem-ram: use whole path for memory
 region name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> hostmem-file and hostmem-memfd use the whole object path for the
> memory region name, but hostname-ram uses only the path component (the
> basename):
>=20
> qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa node,m=
emdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>                      mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D=
/tmp/foo -numa node,memdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa node=
,memdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> Use the whole path name with >=3D 3.1. Having a consistent naming allow
> to migrate to different hostmem backends.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/compat.h    |  6 +++++-
>  backends/hostmem-ram.c | 47 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 48 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 6f4d5fc647..8ce7a7057b 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,11 @@
>  #define HW_COMPAT_H
> =20
>  #define HW_COMPAT_3_0 \
> -    /* empty */
> +    {\
> +        .driver   =3D "memory-backend-ram",\
> +        .property =3D "x-component-name",\
> +        .value    =3D "true",\
> +    },

I don't think this needs to be an 'x-' - I think we originally used
those just for eXperimental things.

However, that's a minor nit, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  #define HW_COMPAT_2_12 \
>      {\
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 7ddd08d370..a9eb99cf1b 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -16,21 +16,56 @@
> =20
>  #define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> =20
> +typedef struct RamMemoryBackend {
> +    HostMemoryBackend parent;
> +
> +    bool component_name;
> +} RamMemoryBackend;
> +
> +#define RAM_BACKEND(obj) \
> +    OBJECT_CHECK(RamMemoryBackend, (obj), TYPE_MEMORY_BACKEND_RAM)
> +
> +static char *
> +ram_backend_get_name(RamMemoryBackend *self)
> +{
> +    /* < 3.1 use the component as memory region name */
> +    if (self->component_name) {
> +        return object_get_canonical_path_component(OBJECT(self));
> +    }
> +
> +    return object_get_canonical_path(OBJECT(self));
> +}
> =20
>  static void
>  ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  {
> -    char *path;
> +    char *name;
> =20
>      if (!backend->size) {
>          error_setg(errp, "can't create backend with size 0");
>          return;
>      }
> =20
> -    path =3D object_get_canonical_path_component(OBJECT(backend));
> -    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backe=
nd), path,
> +    name =3D ram_backend_get_name(RAM_BACKEND(backend));
> +    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backe=
nd), name,
>                             backend->size, backend->share, errp);
> -    g_free(path);
> +    g_free(name);
> +}
> +
> +static bool
> +ram_backend_get_component_name(Object *obj, Error **errp)
> +{
> +    RamMemoryBackend *self =3D RAM_BACKEND(obj);
> +
> +    return self->component_name;
> +}
> +
> +static void
> +ram_backend_set_component_name(Object *obj, bool value, Error **errp)
> +{
> +    RamMemoryBackend *self =3D RAM_BACKEND(obj);
> +
> +    self->component_name =3D value;
>  }
> =20
>  static void
> @@ -39,11 +74,15 @@ ram_backend_class_init(ObjectClass *oc, void *data)
>      HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
> =20
>      bc->alloc =3D ram_backend_memory_alloc;
> +    object_class_property_add_bool(oc, "x-component-name",
> +        ram_backend_get_component_name,
> +        ram_backend_set_component_name, &error_abort);
>  }
> =20
>  static const TypeInfo ram_backend_info =3D {
>      .name =3D TYPE_MEMORY_BACKEND_RAM,
>      .parent =3D TYPE_MEMORY_BACKEND,
> +    .instance_size =3D sizeof(RamMemoryBackend),
>      .class_init =3D ram_backend_class_init,
>  };
> =20
> --=20
> 2.19.0.rc1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
