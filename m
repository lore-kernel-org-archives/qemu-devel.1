Received: from eggs.gnu.org ([2001:4830:134:3::10]:39750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cH9vK-0006F9-9P
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cH9vI-0001jo-Ng
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cH9vI-0001jb-FY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:48:44 -0500
Date: Wed, 14 Dec 2016 11:48:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161214134841.GG3808@thinpad.lan.raisama.net>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
	<87zijyfyq5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87zijyfyq5.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>

On Wed, Dec 14, 2016 at 02:04:50PM +0100, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > "qom-list-types abstract=3Dfalse" currently returns all interface
> > types, as if they were not abstract. Fix this by making sure all
> > interface types are abstract.
> >
> > All interface types have instance_size =3D=3D 0, so we can use
> > it to set abstract=3Dtrue on type_initialize().
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Use old-fashioned if statement instead of "|=3D" on bool field
> >   Suggested-by: Andreas F=E4rber <afaerber@suse.de>
> > * Keep "device/introspect" path prefix on unit test
> >   * Suggested-by: Andreas F=E4rber <afaerber@suse.de>
> > ---
> >  qom/object.c                   |  6 +++++
> >  tests/device-introspect-test.c | 60 ++++++++++++++++++++++++++++++++=
+++++++---
> >  2 files changed, 63 insertions(+), 3 deletions(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 7a05e35..760fafb 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -272,6 +272,12 @@ static void type_initialize(TypeImpl *ti)
> > =20
> >      ti->class_size =3D type_class_get_size(ti);
> >      ti->instance_size =3D type_object_get_size(ti);
> > +    /* Any type with zero instance_size is implicitly abstract.
> > +     * This means interface types are all abstract.
> > +     */
> > +    if (ti->instance_size =3D=3D 0) {
> > +        ti->abstract =3D true;
> > +    }
> > =20
> >      ti->class =3D g_malloc0(ti->class_size);
> > =20
>=20
> Letting zero instance_size imply abstract works (I guess), but is it
> wise to imply?  Is requiring explicit .abstract =3D true really too muc=
h
> trouble?
>=20
> Consider:
>=20
>     static const TypeInfo uc_interface_info =3D {
>         .name          =3D TYPE_USER_CREATABLE,
>         .parent        =3D TYPE_INTERFACE,
>         .class_size =3D sizeof(UserCreatableClass),
>     };
>=20
> Is this abstract?  Yes, because there's no .instance_size =3D ...,
> therefore .instance_size remains zero, and .abstract defaults to true.
>=20
>     static const TypeInfo memory_region_info =3D {
>         .parent             =3D TYPE_OBJECT,
>         .name               =3D TYPE_MEMORY_REGION,
>         .instance_size      =3D sizeof(MemoryRegion),
>         .instance_init      =3D memory_region_initfn,
>         .instance_finalize  =3D memory_region_finalize,
>     };
>=20
> Is this abstract?  No, because with .instance_size =3D
> sizeof(MemoryRegion), which known to be non-zero, .abstract defaults to
> false.

Let's make it worse:

static const TypeInfo palmetto_bmc_type =3D {
    .name =3D MACHINE_TYPE_NAME("palmetto-bmc"),
    .parent =3D TYPE_MACHINE,
    .class_init =3D palmetto_bmc_class_init,
};

Is this abstract? No, because instance_size from the parent type is used,=
 and
it is not zero.

>=20
> Is such a complex default a good idea?
>=20
>    static const TypeInfo rng_backend_info =3D {
>        .name =3D TYPE_RNG_BACKEND,
>        .parent =3D TYPE_OBJECT,
>        .instance_size =3D sizeof(RngBackend),
>        .instance_init =3D rng_backend_init,
>        .instance_finalize =3D rng_backend_finalize,
>        .class_size =3D sizeof(RngBackendClass),
>        .class_init =3D rng_backend_class_init,
>        .abstract =3D true,
>        .interfaces =3D (InterfaceInfo[]) {
>            { TYPE_USER_CREATABLE },
>            { }
>        }
>    };
>=20
> Is this abstract?  Yes, because with .abstract =3D true, the default
> doesn't matter.
>=20
> How do you find all abstract TypeInfo in the source?  The uninitiated
> might grep for .abstract =3D true, and be misled.  The initiated will b=
e
> annoyed instead, because grepping for *absence* of .instance_size =3D i=
s
> bothersome.
>=20
> I suspect life could be easier going forward if we instead required
> .abstract =3D true for interfaces, and enforced it with
> assert(ti->instance_size || ti->abstract) here.

I was doing that before deciding to change type_initialize(). I
think I still have the commit in my git reflog, I will recover it
and submit it as v3.

[...]
> > +static void test_abstract_interfaces(void)
> > +{
> > +    QList *all_types;
> > +    QList *obj_types;
> > +    QListEntry *ae;
> > +
> > +    qtest_start(common_args);
> > +    /* qom-list-types implements=3Dinterface would return any type
> > +     * that implements _any_ interface (not just interface types),
> > +     * so use a trick to find the interface type names:
> > +     * - list all object types
> > +     * - list all types, and look for items that are not
> > +     *   on the first list
> > +     */
> > +    all_types =3D qom_list_types(NULL, false);
> > +    obj_types =3D qom_list_types("object", false);
> > +
> > +    QLIST_FOREACH_ENTRY(all_types, ae) {
> > +        QDict *at =3D qobject_to_qdict(qlist_entry_obj(ae));
> > +        const char *aname =3D qdict_get_str(at, "name");
> > +        QListEntry *oe;
> > +        const char *found =3D NULL;
> > +
> > +        QLIST_FOREACH_ENTRY(obj_types, oe) {
> > +            QDict *ot =3D qobject_to_qdict(qlist_entry_obj(oe));
> > +            const char *oname =3D qdict_get_str(ot, "name");
> > +            if (!strcmp(aname, oname)) {
> > +                found =3D oname;
> > +                break;
> > +            }
> > +        }
> > +
> > +        /* Using g_assert_cmpstr() will give more useful failure
> > +         * messages than g_assert(found) */
>=20
> Sure this comment is worth having?

All we need to check here is if 'found' is not NULL. I think I
would be confused by the usage of g_assert_cmpstr() if I was
reading the code, so I decided to add the comment.

>=20
> > +        g_assert_cmpstr(aname, =3D=3D, found);
>=20
> I'm having a mental block...  what exactly is this loop nest testing?

It's implementing the trick described above:
1) list all object types
2) list all types, and look for items that are not on the first
   list.

In other words, checking if all items in all_types are present in
obj_types.

My first attempt was to just check if
  qom-list-types implements=3D"interface" abstract=3Dfalse
returned an empty list, but it failed because it returns all
object types that implement any interface.

--=20
Eduardo
