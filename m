Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4B5-0005kX-Hy
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4B4-0005Aa-8P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:42:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO4B4-0005AD-2z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:42:22 -0400
References: <20180530071757.9112-1-aik@ozlabs.ru>
	<20180530071757.9112-2-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67407aaf-29d1-324d-8c68-3ea82f93822b@redhat.com>
Date: Wed, 30 May 2018 18:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180530071757.9112-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/2] object: Handle objects with no
 parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 30/05/2018 09:17, Alexey Kardashevskiy wrote:
> At the moment object_get_canonical_path() crashes if the object or one
> of its parents does not have a parent, for example, a KVM accelerator
> object.
>=20
> This adds a check for obj!=3DNULL in a loop to prevent the crash.
> In order not to return a wrong path, this checks for currently resolved
> partial path and does not add a leading slash to tell the reader that
> the path is partial as the owner object is detached.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> I have not tested the case with obj=3D=3DNULL and path!=3DNULL as this =
is
> for objects which have parents which are not attached to the root
> and we do not have such objects in current QEMU afaict but I kept it
> just in case.
>=20
> ---
> Changes:
> v3:
> * do not check for obj->parent
> * return NULL or incomplete path depending on the situation
> ---
>  qom/object.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 0fc9720..05138ba 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1669,7 +1669,7 @@ gchar *object_get_canonical_path(Object *obj)
>      Object *root =3D object_get_root();
>      char *newpath, *path =3D NULL;
> =20
> -    while (obj !=3D root) {
> +    while (obj && obj !=3D root) {
>          char *component =3D object_get_canonical_path_component(obj);
> =20
>          if (path) {
> @@ -1684,7 +1684,13 @@ gchar *object_get_canonical_path(Object *obj)
>          obj =3D obj->parent;
>      }
> =20
> -    newpath =3D g_strdup_printf("/%s", path ? path : "");
> +    if (obj && path) {
> +        newpath =3D g_strdup_printf("/%s", path);
> +    } else if (path) {
> +        newpath =3D g_strdup(path);
> +    } else {
> +        newpath =3D NULL;
> +    }
>      g_free(path);
> =20
>      return newpath;

I think this is still wrong, as you wouldn't be able to get back these
objects later (e.g. by assigning the result to a link<> property).  I've
posted an alternative patch.

Paolo
