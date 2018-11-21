Received: from eggs.gnu.org ([2001:4830:134:3::10]:40025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOrE-0001YR-8l
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOrA-00074n-0l
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:31:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gPOr9-00073L-O3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:31:35 -0500
Date: Wed, 21 Nov 2018 09:31:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181121093131.GG26577@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181119135903.11729-1-berrange@redhat.com>
	<87lg5naa2o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lg5naa2o.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Tue, Nov 20, 2018 at 07:16:31PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > When debugging QEMU it is often useful to put a breakpoint on the
> > error_setg_internal method impl.
> >
> > Unfortunately the object_property_add / object_class_property_add
> > methods call object_property_find / object_class_property_find method=
s
> > to check if a property exists already before adding the new property.
> >
> > As a result there are a huge number of calls to error_setg_internal
> > on startup of most QEMU commands, making it very painful to set a
> > breakpoint on this method.
> >
> > This puts a minor optimization on the code so that we avoid calling
> > error_setg() when errp is NULL. Functionally there's no difference
> > since error_setg() is a no-op when errp is NULL, but this lets us
> > use breakpoints in GDB in a practical way.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  qom/object.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 547dcf97c3..ddd5e7a30e 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -1087,7 +1087,12 @@ ObjectProperty *object_property_find(Object *o=
bj, const char *name,
> >          return prop;
> >      }
> > =20
> > -    error_setg(errp, "Property '.%s' not found", name);
> > +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> > +     * otherwise every property add call hits error_setg
> > +     * making it impratical to set breakpoints in GDB */
> > +    if (errp) {
> > +        error_setg(errp, "Property '.%s' not found", name);
> > +    }
> >      return NULL;
> >  }
> > =20
>=20
> In my opinion, this function's design is awkward.  Stress on *opinion*.
>=20
> On success, it returns a (non-null) pointer.
>=20
> On failure, it sets an error and returns null.  Note that it has just
> one failure mode: "Property '.%s' not found".  Setting an error is just
> a convenience for those callers that want to propagate exactly this
> error to their callers.
>=20
> I count 30 callers.  Only six pass a non-NULL argument to @errp.
>=20
> I'd rather have a pair of functions similar to how Python has both
> .get() and .__getitem__(): the former doesn't fail, but returns None
> instead, and the latter does fail, throwing KeyError.  In QEMU, we can'=
t
> throw, so we set an error.  Here's the obvious code:
>=20
>     ObjectProperty *object_property_find(Object *obj, const char *name)
>     {
>         ObjectProperty *prop;
>         ObjectClass *klass =3D object_get_class(obj);
>=20
>         prop =3D object_class_property_find(klass, name, NULL);
>         if (prop) {
>             return prop;
>         }
>=20
>         prop =3D g_hash_table_lookup(obj->properties, name);
>         if (prop) {
>             return prop;
>         }
>=20
>         return NULL;
>     }
>=20
>     ObjectProperty *object_property_find_err(Object *obj, const char *n=
ame,
>                                              Error **errp)
>     {
>         ObjectProperty *prop =3D object_property_find(obj, name);
>=20
>         if (!prop) {
>             error_setg(errp, "Property '.%s' not found", name);
>         }
>         return prop;
>     }

Yes, I'd be happy with this approach as I think it is more useful in
general


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
