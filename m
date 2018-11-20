Received: from eggs.gnu.org ([2001:4830:134:3::10]:52907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2aj-00089w-Ux
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2ai-0002kG-QJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gP2ai-0002jd-Iu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:08 -0500
Date: Tue, 20 Nov 2018 09:45:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120094503.GC25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181119135903.11729-1-berrange@redhat.com>
	<CAJ+F1CKnNftoqOfQBX6mMtpX+Jq2K21VyP8s-w7-wq3hAgYd7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKnNftoqOfQBX6mMtpX+Jq2K21VyP8s-w7-wq3hAgYd7g@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Tue, Nov 20, 2018 at 09:45:23AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Nov 19, 2018 at 5:59 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
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
>=20
> Or maybe change the error_setg* macros? After all, if errp is NULL,
> it's an error qemu can handle.

That would mean that all callers would get short circuited which
I don't think it is desirable in general.=20

This QOM usage is special in that the calling code is using the
error scenario as a means to trigger different code flow. IOW
it doesn't consider it an error scenario at all.

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
> >
> > -    error_setg(errp, "Property '.%s' not found", name);
> > +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> > +     * otherwise every property add call hits error_setg
> > +     * making it impratical to set breakpoints in GDB */
> > +    if (errp) {
> > +        error_setg(errp, "Property '.%s' not found", name);
> > +    }
> >      return NULL;
> >  }
> >
> > @@ -1133,7 +1138,10 @@ ObjectProperty *object_class_property_find(Obj=
ectClass *klass, const char *name,
> >      }
> >
> >      prop =3D g_hash_table_lookup(klass->properties, name);
> > -    if (!prop) {
> > +    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
> > +     * otherwise every property add call hits error_setg
> > +     * making it impratical to set breakpoints in GDB */
> > +    if (!prop && errp) {
> >          error_setg(errp, "Property '.%s' not found", name);
> >      }
> >      return prop;
> > --
> > 2.19.1
> >
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
