Received: from eggs.gnu.org ([2001:4830:134:3::10]:39184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOzX-0007Q9-7x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOzW-00047I-D4
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWOzW-00043I-6K
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 784153082E53
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:05:09 +0000 (UTC)
Date: Mon, 10 Dec 2018 18:05:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181210180503.2cd631cf@Igors-MacBook-Pro.local>
In-Reply-To: <20181204142023.15982-13-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 12/19] qdev-props: convert
 global_props to GPtrArray
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On Tue,  4 Dec 2018 18:20:16 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> A step towards being able to call a common function,
> object_apply_global_props().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 43c30a57f4..3467e0485c 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1173,22 +1173,32 @@ void qdev_prop_set_ptr(DeviceState *dev, const ch=
ar *name, void *value)
>      *ptr =3D value;
>  }
> =20
> -static GList *global_props;
> +static GPtrArray *global_props(void)
> +{
> +    static GPtrArray *gp;
> +
> +    if (!gp) {
> +        gp =3D g_ptr_array_new();
one more leak?

> +    }
> +
> +    return gp;
> +}
> =20
>  void qdev_prop_register_global(GlobalProperty *prop)
>  {
> -    global_props =3D g_list_append(global_props, prop);
> +    g_ptr_array_add(global_props(), prop);
>  }
> =20
>  int qdev_prop_check_globals(void)
>  {
> -    GList *l;
> -    int ret =3D 0;
> +    int i, ret =3D 0;
> =20
> -    for (l =3D global_props; l; l =3D l->next) {
> -        GlobalProperty *prop =3D l->data;
> +    for (i =3D 0; i < global_props()->len; i++) {
> +        GlobalProperty *prop;
>          ObjectClass *oc;
>          DeviceClass *dc;
> +
> +        prop =3D g_ptr_array_index(global_props(), i);
>          if (prop->used) {
>              continue;
>          }
> @@ -1213,12 +1223,13 @@ int qdev_prop_check_globals(void)
> =20
>  void qdev_prop_set_globals(DeviceState *dev)
>  {
> -    GList *l;
> +    int i;
> =20
> -    for (l =3D global_props; l; l =3D l->next) {
> -        GlobalProperty *prop =3D l->data;
> +    for (i =3D 0; i < global_props()->len; i++) {
> +        GlobalProperty *prop;
>          Error *err =3D NULL;
> =20
> +        prop =3D g_ptr_array_index(global_props(), i);
>          if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) {
>              continue;
>          }
