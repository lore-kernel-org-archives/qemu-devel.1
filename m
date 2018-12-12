Received: from eggs.gnu.org ([2001:4830:134:3::10]:36179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX9ZW-0002TZ-68
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX9ZR-0003rC-H6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:49:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gX9ZK-0003ls-Qy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:49:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id c126so7072210wmh.0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-16-marcandre.lureau@redhat.com>
	<20181211170255.51dafe8d@redhat.com>
In-Reply-To: <20181211170255.51dafe8d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Dec 2018 22:48:58 +0400
Message-ID: <CAJ+F1CJ8sJEuUCKE=caOsz6-5f_RWAW4x8VGOhdY+rXxPvwx3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 15/19] qom: add
 object_class_get_class_data()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Tue, Dec 11, 2018 at 8:24 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue,  4 Dec 2018 18:20:19 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > Add a simple function to retrieve the associated class data.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qom/object.h | 9 +++++++++
> >  qom/object.c         | 5 +++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 5183c587f3..d5266405da 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -916,6 +916,15 @@ ObjectClass *object_class_dynamic_cast(ObjectClass=
 *klass,
> >   */
> >  ObjectClass *object_class_get_parent(ObjectClass *klass);
> >
> > +
> > +/**
> > + * object_class_get_class_data:
> > + * @klass: The class to obtain associated data.
> > + *
> > + * Returns: the class_data given when registering the type.
> > + */
> > +void *object_class_get_class_data(ObjectClass *klass);
> > +
> >  /**
> >   * object_class_get_name:
> >   * @klass: The class to obtain the QOM typename for.
> > diff --git a/qom/object.c b/qom/object.c
> > index aa6f3a2a71..bbc6fbbc01 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -867,6 +867,11 @@ const char *object_class_get_name(ObjectClass *kla=
ss)
> >      return klass->type->name;
> >  }
> >
> > +void *object_class_get_class_data(ObjectClass *klass)
> > +{
> > +    return klass->type->class_data;
> > +}
> > +
> >  ObjectClass *object_class_by_name(const char *typename)
> >  {
> >      TypeImpl *type =3D type_get_by_name(typename);
>
> alternatively to what's done in 16/19 which requires this helper
> you can drop it and use x86 cpu approach, see:
>
> static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> {
>     X86CPUDefinition *cpudef =3D data;
>     X86CPUClass *xcc =3D X86_CPU_CLASS(oc);
>
>     xcc->cpu_def =3D cpudef;
>     ...
>

Indeed, that's perhaps a better alternative. I'll update the patch.

--=20
Marc-Andr=C3=A9 Lureau
