Received: from eggs.gnu.org ([2001:4830:134:3::10]:32977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gH9I7-00054Y-Tj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gH9Hx-0000zA-4k
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gH9Hv-0000ss-8z
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:17:07 -0400
Date: Mon, 29 Oct 2018 16:16:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181029140003.328c7f01@redhat.com>
In-Reply-To: <20180912125531.32131-10-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, 12 Sep 2018 16:55:31 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> hostmem-file and hostmem-memfd use the whole object path

maybe add something along the lines:

consisting from user supplied 'id' and ...

> for the
> memory region name, but hostname-ram uses only the path component (the
> basename):

so path component would mean a concrete thing.

>=20
> qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa node,mem=
dev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Used =
             Total
>                      mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/t=
mp/foo -numa node,memdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Used =
             Total
>             /objects/mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa node,m=
emdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Used =
             Total
>             /objects/mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000
>=20
> Use the whole path name with >=3D 3.1. Having a consistent naming allow
> to migrate to different hostmem backends.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
> =20
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
I'd drop comment here, it belongs more to HW_COMPAT_...

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
> -    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend=
), path,
> +    name =3D ram_backend_get_name(RAM_BACKEND(backend));
> +    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend=
), name,
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
If we would convert initial RAM to backend/frontend model,
we would actually need to keep current ramblock naming scheme for=20
ram_backend and even do this /i.e. non path variant/ for other
backends to keep migration stream compatible.

How about adding this property to generic memory-backend and
naming it something like 'x-use-canonical-path-for-ramblock-id'

I wonder if there is a point to use path for ramblock at all,
considering that it is single name space for all backends anyways.
Maybe by default we should just use 'id' everywhere?

> +        ram_backend_get_component_name,
> +        ram_backend_set_component_name, &error_abort);

 + object_class_property_set_description(...)

>  }
> =20
>  static const TypeInfo ram_backend_info =3D {
>      .name =3D TYPE_MEMORY_BACKEND_RAM,
>      .parent =3D TYPE_MEMORY_BACKEND,
> +    .instance_size =3D sizeof(RamMemoryBackend),
>      .class_init =3D ram_backend_class_init,
>  };
> =20
