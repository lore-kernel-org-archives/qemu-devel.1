Received: from eggs.gnu.org ([2001:4830:134:3::10]:51380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwhx4-000691-0P
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwhx0-0002wk-V3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwhx0-0002vw-Os
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:58:30 -0400
Date: Tue, 26 Sep 2017 12:58:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170926045824.GC31924@lemon.lan>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1506401532-25274-2-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, 09/26 12:52, Peter Xu wrote:
> We have object_get_objects_root() to keep user created objects, however
> no place for objects that will be used internally.  Create such a
> container for internal objects.
>=20
> CC: Andreas F=E4rber <afaerber@suse.de>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object.h | 10 ++++++++++
>  qom/object.c         | 11 +++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3e5cff..f567052 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
>  Object *object_get_objects_root(void);
> =20
>  /**
> + * object_get_internal_root:
> + *
> + * Get the container object that holds internally used object
> + * instances. This is the object at path "/internal-objects"

Does this comment need update?

> + *
> + * Returns: the internal object container
> + */
> +Object *object_get_internal_root(void);
> +
> +/**
>   * object_get_canonical_path_component:
>   *
>   * Returns: The final component in the object's canonical path.  The c=
anonical
> diff --git a/qom/object.c b/qom/object.c
> index 3e18537..6a7bd92 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1370,6 +1370,17 @@ Object *object_get_objects_root(void)
>      return container_get(object_get_root(), "/objects");
>  }
> =20
> +Object *object_get_internal_root(void)
> +{
> +    static Object *internal_root;
> +
> +    if (!internal_root) {
> +        internal_root =3D object_new("container");
> +    }
> +
> +    return internal_root;
> +}
> +
>  static void object_get_child_property(Object *obj, Visitor *v,
>                                        const char *name, void *opaque,
>                                        Error **errp)
> --=20
> 2.7.4
>=20

Fam
