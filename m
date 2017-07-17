Received: from eggs.gnu.org ([2001:4830:134:3::10]:48462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXALi-0005NL-Nj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXALe-00078x-MO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXALe-00078Y-G2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:02:22 -0400
Date: Mon, 17 Jul 2017 15:02:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717180213.GY6020@localhost.localdomain>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1500279971-13875-5-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/11] qom: call parent first on
 post_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Jul 17, 2017 at 04:26:04PM +0800, Peter Xu wrote:
> It makes more sense to call the post_init() hook of the parent first
> then the child, just like what we do in the rest of the hooks.

I suggest documenting the existing instance_post_init users in
the commit message (TYPE_DEVICE and TYPE_ARM_CPU, as far as I can
see), and explain why they won't be affected (or if they are
affected, why the new behavior is better).

Also, can you please update the @instance_post_init documentation
in qom/object.h to mention the new ordering?

Maybe something like:

- * @instance_post_init: This function is called to finish initialization=
 of
- *   an object, after all @instance_init functions were called.
+ * @instance_post_init: Finish initialization of an object.  This
+ *   function is called after the @instance_init functions for
+ *   all subclasses were called, but before the @instance_post_init
+ *   function for the subclasses are called.


>=20
> CC: Andreas F=E4rber <afaerber@suse.de>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qom/object.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index dfdbd50..e2c9c4a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -347,13 +347,13 @@ static void object_init_with_type(Object *obj, Ty=
peImpl *ti)
> =20
>  static void object_post_init_with_type(Object *obj, TypeImpl *ti)
>  {
> -    if (ti->instance_post_init) {
> -        ti->instance_post_init(obj);
> -    }
> -
>      if (type_has_parent(ti)) {
>          object_post_init_with_type(obj, type_get_parent(ti));
>      }
> +
> +    if (ti->instance_post_init) {
> +        ti->instance_post_init(obj);
> +    }
>  }
> =20
>  static void object_initialize_with_type(void *data, size_t size, TypeI=
mpl *type)
> --=20
> 2.7.4
>=20

--=20
Eduardo
