Received: from eggs.gnu.org ([2001:4830:134:3::10]:55782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gH4IJ-0001Ut-IU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gH4IF-00080v-I1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gH4IF-00080L-59
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:57:07 -0400
Date: Mon, 29 Oct 2018 10:56:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181029105657.5106265f@redhat.com>
In-Reply-To: <20181026151321.GE3902@habkost.net>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-2-marcandre.lureau@redhat.com>
	<20181022153330.6996de15@igors-macbook-pro.local>
	<20181026151321.GE3902@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] qom/user-creatable: add a few helper
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Fri, 26 Oct 2018 12:13:21 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Oct 22, 2018 at 03:33:30PM +0100, Igor Mammedov wrote:
> > On Wed, 12 Sep 2018 16:55:23 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >  =20
> > > Improve a bit code readability.
> > >=20
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  include/qom/object_interfaces.h | 4 ++++
> > >  qom/object.c                    | 4 ++--
> > >  qom/object_interfaces.c         | 9 +++------
> > >  3 files changed, 9 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/include/qom/object_interfaces.h b/include/qom/object_int=
erfaces.h
> > > index 4d513fb329..46b0861457 100644
> > > --- a/include/qom/object_interfaces.h
> > > +++ b/include/qom/object_interfaces.h
> > > @@ -9,9 +9,13 @@
> > >  #define USER_CREATABLE_CLASS(klass) \
> > >       OBJECT_CLASS_CHECK(UserCreatableClass, (klass), \
> > >                          TYPE_USER_CREATABLE)
> > > +#define IS_USER_CREATABLE_CLASS(klass) \
> > > +    object_class_dynamic_cast(OBJECT_CLASS(oc), TYPE_USER_CREATABLE)
> > >  #define USER_CREATABLE_GET_CLASS(obj) \
> > >       OBJECT_GET_CLASS(UserCreatableClass, (obj), \
> > >                        TYPE_USER_CREATABLE)
> > > +#define IS_USER_CREATABLE(obj) \
> > > +    object_dynamic_cast(OBJECT(obj), TYPE_USER_CREATABLE)
> > >  #define USER_CREATABLE(obj) \
> > >       INTERFACE_CHECK(UserCreatable, (obj), \
> > >                       TYPE_USER_CREATABLE)
> > > diff --git a/qom/object.c b/qom/object.c
> > > index 75d1d48944..0703e8e4ff 100644
> > > --- a/qom/object.c
> > > +++ b/qom/object.c
> > > @@ -424,7 +424,7 @@ void object_initialize_childv(Object *parentobj, =
const char *propname,
> > >          goto out;
> > >      }
> > > =20
> > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > +    if (IS_USER_CREATABLE(obj)) {
> > >          user_creatable_complete(obj, &local_err);
> > >          if (local_err) {
> > >              object_unparent(obj);
> > > @@ -605,7 +605,7 @@ Object *object_new_with_propv(const char *typenam=
e,
> > >          goto error;
> > >      }
> > > =20
> > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > +    if (IS_USER_CREATABLE(obj)) {
> > >          user_creatable_complete(obj, &local_err);
> > >          if (local_err) {
> > >              object_unparent(obj);
> > > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > > index 72b97a8bed..e3084bc04a 100644
> > > --- a/qom/object_interfaces.c
> > > +++ b/qom/object_interfaces.c
> > > @@ -10,18 +10,15 @@
> > > =20
> > >  void user_creatable_complete(Object *obj, Error **errp)
> > >  {
> > > -
> > >      UserCreatableClass *ucc;
> > > -    UserCreatable *uc =3D
> > > -        (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABL=
E);
> > > =20
> > > -    if (!uc) {
> > > +    if (!IS_USER_CREATABLE(obj)) {
> > >          return;
> > >      }
> > > =20
> > > -    ucc =3D USER_CREATABLE_GET_CLASS(uc);
> > > +    ucc =3D USER_CREATABLE_GET_CLASS(obj);
> > >      if (ucc->complete) {
> > > -        ucc->complete(uc, errp);
> > > +        ucc->complete(USER_CREATABLE(obj), errp); =20
> >                          ^^^
> > even though function becomes more concise,
> > this will call expensive dynamic cast 2nd time (IS_USER_CREATABLE was t=
he 1st and discarded)
> > so I'm not sure is a good idea to regress startup time for readability.=
  =20
>=20
> (INTERFACE_CHECK is a nop if CONFIG_QOM_CAST_DEBUG is not
> enabled, so I don't understand how it would regress startup time.
Isn't it enabled by default though?
Maybe we should flip default to disabled then cast should be ok and enable =
it
when generic '--debug' is enabled.
