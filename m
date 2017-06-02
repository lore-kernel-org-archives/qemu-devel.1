Received: from eggs.gnu.org ([2001:4830:134:3::10]:48380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGnCg-0003HJ-IZ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGnCc-0007H8-IP
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGnCc-0007Gr-9T
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:05:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B8AC79704
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:05:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-21-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 16:05:07 +0200
In-Reply-To: <20170531135709.345-21-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:44 +0400")
Message-ID: <87shjibi3w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/45] apic-common: make "id" property a
 uint32
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

> Change suggested by Markus Armbruster:
>
> This one's a bit of a mess.

Drop these two lines, and append
Suggested-by: Markus Armbruster <armbru@redhat.com>

> The getter and setter of TYPE_APIC_COMMON property "id" are
> apic_common_get_id() and apic_common_set_id().
>
> apic_common_get_id() reads either APICCommonState member uint32_t
> initial_apic_id or uint8_t id into an int64_t local variable.  It then
> passes this variable to visit_type_int().
>
> apic_common_set_id() uses visit_type_int() to read the value into a
> local variable, which it then assigns both to initial_apic_id and id.
>
> While the state backing the property is two unsigned members, 8 and 32
> bits wide, the actual visitor is 64 bits signed.
>
> cpu->apic_id is uint32_t.
>
> qdev_prop_set_uint32() isn't really wrong, because any uint32_t value is
> also a valid int64_t value.
>
> qdev_prop_set_int32() implicitly converts cpu->apic_id from uint32_t
> to int32_t.  Perhaps that's even okay, but I don't care, I want this
> mess cleaned up

I think the previous three paragraphs only apply to your PATCH v1 13/17,
not here.  Drop?

> Change getter and setter to use visit_type_uint32().  Then everything's
> uint32_t, except for @id.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/intc/apic_common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 1ef56f8d10..e1ac33042f 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -450,10 +450,10 @@ static void apic_common_get_id(Object *obj, Visitor=
 *v, const char *name,
>                                 void *opaque, Error **errp)
>  {
>      APICCommonState *s =3D APIC_COMMON(obj);
> -    int64_t value;
> +    uint32_t value;
>=20=20
>      value =3D s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id =
: s->id;
> -    visit_type_int(v, name, &value, errp);
> +    visit_type_uint32(v, name, &value, errp);
>  }
>=20=20
>  static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
> @@ -462,14 +462,14 @@ static void apic_common_set_id(Object *obj, Visitor=
 *v, const char *name,
>      APICCommonState *s =3D APIC_COMMON(obj);
>      DeviceState *dev =3D DEVICE(obj);
>      Error *local_err =3D NULL;
> -    int64_t value;
> +    uint32_t value;
>=20=20
>      if (dev->realized) {
>          qdev_prop_set_after_realize(dev, name, errp);
>          return;
>      }
>=20=20
> -    visit_type_int(v, name, &value, &local_err);
> +    visit_type_uint32(v, name, &value, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -484,7 +484,7 @@ static void apic_common_initfn(Object *obj)
>      APICCommonState *s =3D APIC_COMMON(obj);
>=20=20
>      s->id =3D s->initial_apic_id =3D -1;
> -    object_property_add(obj, "id", "int",
> +    object_property_add(obj, "id", "uint32",
>                          apic_common_get_id,
>                          apic_common_set_id, NULL, NULL, NULL);
>  }
