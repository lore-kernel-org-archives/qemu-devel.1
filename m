Received: from eggs.gnu.org ([2001:4830:134:3::10]:59323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAudt-0001r0-Az
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAudq-0006RU-44
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAudp-0006R8-RC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AF753B54C
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 08:49:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-12-marcandre.lureau@redhat.com>
Date: Wed, 17 May 2017 10:49:04 +0200
In-Reply-To: <20170509173559.31598-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 May 2017
	20:35:53 +0300")
Message-ID: <87inkz50n3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/17] object: use more specific property
 type names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Use the actual unsigned integer type name (this should't break since
> property type aren't directly accessed from outside it seems).

I'm not sure I understand the parenthesis.  Do you mean changing the
type names is safe because they're used only in a certain way?  Which
way?

How did you find the names that need fixing?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/cryptodev.c |  2 +-
>  hw/pci-host/piix.c   |  8 ++++----
>  hw/pci-host/q35.c    | 10 +++++-----
>  hw/ppc/pnv.c         |  2 +-
>  net/dump.c           |  2 +-
>  net/filter-buffer.c  |  2 +-
>  6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 832f056266..1764c179fe 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -222,7 +222,7 @@ cryptodev_backend_can_be_deleted(UserCreatable *uc, E=
rror **errp)
>=20=20
>  static void cryptodev_backend_instance_init(Object *obj)
>  {
> -    object_property_add(obj, "queues", "int",
> +    object_property_add(obj, "queues", "uint32",
>                            cryptodev_backend_get_queues,
>                            cryptodev_backend_set_queues,
>                            NULL, NULL, NULL);

Correct, because the callbacks access struct CryptoDevBackendPeers
member queues, which is uint32_t.

The callbacks pass a local variable instead of the struct member to the
visitor.  Problematic, because it weakens the type checking we get from
the compiler.  Let's tighten it up:

   static void
   cryptodev_backend_get_queues(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
   {
       CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(obj);
  -    uint32_t value =3D backend->conf.peers.queues;

  -    visit_type_uint32(v, name, &value, errp);
  +    visit_type_uint32(v, name, &backend->conf.peers.queues, errp);
   }

   static void
   cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
   {
       CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(obj);
       Error *local_err =3D NULL;
  -    uint32_t value;

  -    visit_type_uint32(v, name, &value, &local_err);
  +    visit_type_uint32(v, name, &backend->conf.peers.queues, &local_err);
       if (local_err) {
           goto out;
       }
  -    if (!value) {
  +    if (!backend->conf.peers.queues) {
           error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
  -                   PRIu32 "'", object_get_typename(obj), name, value);
  +                   PRIu32 "'", object_get_typename(obj), name,
  +                   backend->conf.peers.queues);
  -        goto out;
       }
  -    backend->conf.peers.queues =3D value;
  -out:
       error_propagate(errp, local_err);
   }

If we need to preserve backend->conf.peers.queue on an attempt to set it
to zero, things get a bit more complicated.  But having the compiler
enforce the visitor matches the member type exactly is worth it, in my
opinion.

Separate patch, not necessarily in this series.

> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index f9218aa952..9aed6225bf 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -279,19 +279,19 @@ static void i440fx_pcihost_initfn(Object *obj)
>      memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
>                            "pci-conf-data", 4);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
>                          i440fx_pcihost_get_pci_hole_start,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
>                          i440fx_pcihost_get_pci_hole_end,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
>                          i440fx_pcihost_get_pci_hole64_start,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
>                          i440fx_pcihost_get_pci_hole64_end,
>                          NULL, NULL, NULL, NULL);
>  }

These look good.  The underlying values are 64 bits, but the 32 bit
callbacks assert they fit into 32.

> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 344f77b10c..5438be8253 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -176,23 +176,23 @@ static void q35_host_initfn(Object *obj)
>      qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
>                          q35_host_get_pci_hole_start,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
>                          q35_host_get_pci_hole_end,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
>                          q35_host_get_pci_hole64_start,
>                          NULL, NULL, NULL, NULL);
>=20=20
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
> +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
>                          q35_host_get_pci_hole64_end,
>                          NULL, NULL, NULL, NULL);

Likewise.

>=20=20
> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "int",
> +    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint32",
>                          q35_host_get_mmcfg_size,
>                          NULL, NULL, NULL, NULL);

This one leads to a bug, I think:

   static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char =
*name,
                                       void *opaque, Error **errp)
   {
       PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
       uint32_t value =3D e->size;

       visit_type_uint32(v, name, &value, errp);
   }

e->size is hwaddr, i.e. uint64_t.  We silently truncate.

Demonstrates that the detour through a separate variable breeds bugs and
should be avoided.

Suggested fix:

   static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char =
*name,
                                       void *opaque, Error **errp)
   {
       PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
  -    uint32_t value =3D e->size;

  -    visit_type_uint64(v, name, &value, errp);
  +    visit_type_uint64(v, name, &e->size, errp);
   }

You then have to change the type name to "uint64" instead of "uint32",
of course.

>=20=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d4bcdb027f..a964354081 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1110,7 +1110,7 @@ static void powernv_machine_initfn(Object *obj)
>=20=20
>  static void powernv_machine_class_props_init(ObjectClass *oc)
>  {
> -    object_class_property_add(oc, "num-chips", "uint32_t",
> +    object_class_property_add(oc, "num-chips", "uint32",
>                                pnv_get_num_chips, pnv_set_num_chips,
>                                NULL, NULL, NULL);
>      object_class_property_set_description(oc, "num-chips",

Looks good.

> diff --git a/net/dump.c b/net/dump.c
> index 89a149b5dd..7f4d3fda52 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -325,7 +325,7 @@ static void filter_dump_instance_init(Object *obj)
>=20=20
>      nfds->maxlen =3D 65536;
>=20=20
> -    object_property_add(obj, "maxlen", "int", filter_dump_get_maxlen,
> +    object_property_add(obj, "maxlen", "uint32", filter_dump_get_maxlen,
>                          filter_dump_set_maxlen, NULL, NULL, NULL);
>      object_property_add_str(obj, "file", file_dump_get_filename,
>                              file_dump_set_filename, NULL);

Same type checking weakness as in cryptodev.c.

> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index cc6bd94445..9ce96aaa35 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -191,7 +191,7 @@ out:
>=20=20
>  static void filter_buffer_init(Object *obj)
>  {
> -    object_property_add(obj, "interval", "int",
> +    object_property_add(obj, "interval", "uint32",
>                          filter_buffer_get_interval,
>                          filter_buffer_set_interval, NULL, NULL, NULL);
>  }

Likeise.

Aside: I dislike having to define setters and getters for everything in
QOM.  It's flexible, but verbose and error-prone when the flexibility
isn't actually needed.
