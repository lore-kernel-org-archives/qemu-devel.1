Received: from eggs.gnu.org ([2001:4830:134:3::10]:50906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPApm-0004b0-HP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPApj-0007nJ-Bb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:33:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPAZf-0007jD-Sw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:16:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181119135903.11729-1-berrange@redhat.com>
Date: Tue, 20 Nov 2018 19:16:31 +0100
In-Reply-To: <20181119135903.11729-1-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 19 Nov 2018 13:59:03
	+0000")
Message-ID: <87lg5naa2o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom: avoid reporting errors for NULL error
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When debugging QEMU it is often useful to put a breakpoint on the
> error_setg_internal method impl.
>
> Unfortunately the object_property_add / object_class_property_add
> methods call object_property_find / object_class_property_find methods
> to check if a property exists already before adding the new property.
>
> As a result there are a huge number of calls to error_setg_internal
> on startup of most QEMU commands, making it very painful to set a
> breakpoint on this method.
>
> This puts a minor optimization on the code so that we avoid calling
> error_setg() when errp is NULL. Functionally there's no difference
> since error_setg() is a no-op when errp is NULL, but this lets us
> use breakpoints in GDB in a practical way.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qom/object.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 547dcf97c3..ddd5e7a30e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1087,7 +1087,12 @@ ObjectProperty *object_property_find(Object *obj, =
const char *name,
>          return prop;
>      }
>=20=20
> -    error_setg(errp, "Property '.%s' not found", name);
> +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> +     * otherwise every property add call hits error_setg
> +     * making it impratical to set breakpoints in GDB */
> +    if (errp) {
> +        error_setg(errp, "Property '.%s' not found", name);
> +    }
>      return NULL;
>  }
>=20=20

In my opinion, this function's design is awkward.  Stress on *opinion*.

On success, it returns a (non-null) pointer.

On failure, it sets an error and returns null.  Note that it has just
one failure mode: "Property '.%s' not found".  Setting an error is just
a convenience for those callers that want to propagate exactly this
error to their callers.

I count 30 callers.  Only six pass a non-NULL argument to @errp.

I'd rather have a pair of functions similar to how Python has both
.get() and .__getitem__(): the former doesn't fail, but returns None
instead, and the latter does fail, throwing KeyError.  In QEMU, we can't
throw, so we set an error.  Here's the obvious code:

    ObjectProperty *object_property_find(Object *obj, const char *name)
    {
        ObjectProperty *prop;
        ObjectClass *klass =3D object_get_class(obj);

        prop =3D object_class_property_find(klass, name, NULL);
        if (prop) {
            return prop;
        }

        prop =3D g_hash_table_lookup(obj->properties, name);
        if (prop) {
            return prop;
        }

        return NULL;
    }

    ObjectProperty *object_property_find_err(Object *obj, const char *name,
                                             Error **errp)
    {
        ObjectProperty *prop =3D object_property_find(obj, name);

        if (!prop) {
            error_setg(errp, "Property '.%s' not found", name);
        }
        return prop;
    }

> @@ -1133,7 +1138,10 @@ ObjectProperty *object_class_property_find(ObjectC=
lass *klass, const char *name,
>      }
>=20=20
>      prop =3D g_hash_table_lookup(klass->properties, name);
> -    if (!prop) {
> +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> +     * otherwise every property add call hits error_setg
> +     * making it impratical to set breakpoints in GDB */
> +    if (!prop && errp) {
>          error_setg(errp, "Property '.%s' not found", name);
>      }
>      return prop;

Likewise, just more so: callers passing non-NULL do not exist.
