Received: from eggs.gnu.org ([2001:4830:134:3::10]:42140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGVFc-000511-Oz
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGVFb-0004oX-PU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGVFb-0004oQ-Il
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:22:59 -0500
Date: Mon, 12 Dec 2016 16:22:56 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212182256.GA29949@thinpad.lan.raisama.net>
References: <1481306777-5441-1-git-send-email-ehabkost@redhat.com>
	<6b1269fd-762f-9971-7114-868cd425de3d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6b1269fd-762f-9971-7114-868cd425de3d@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lin Ma <lma@suse.com>

On Mon, Dec 12, 2016 at 03:04:25PM +0100, Andreas F=E4rber wrote:
> Am 09.12.2016 um 19:06 schrieb Eduardo Habkost:
> > "qom-list-types abstract=3Dfalse" currently returns all interface
> > types, as if they were not abstract. Fix this by making sure all
> > interface types are abstract.
> >=20
> > All interface types have instance_size =3D=3D 0, so we can use
> > it to set abstract=3Dtrue on
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qom/object.c                   |  4 +++
> >  tests/device-introspect-test.c | 61 ++++++++++++++++++++++++++++++++=
+++++++---
> >  2 files changed, 62 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/qom/object.c b/qom/object.c
> > index 7a05e35..3870c1b 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -272,6 +272,10 @@ static void type_initialize(TypeImpl *ti)
> > =20
> >      ti->class_size =3D type_class_get_size(ti);
> >      ti->instance_size =3D type_object_get_size(ti);
> > +    /* Any type with zero instance_size is implicitly abstract.
> > +     * This means interface types are all abstract.
> > +     */
> > +    ti->abstract |=3D ti->instance_size =3D=3D 0;
>=20
> IIRC this is a bool field, so I would prefer to avoid |=3D by using an
> old-fashioned if statement.

I was going to use an if statement, but then I tried to make it
simpler using "|=3D". I will add it back in v2.

>=20
> The ->abstract =3D false for interfaces itself makes sense to me, but I=
'd
> appreciate confirmation from Paolo or some other interface expert.

Thanks!

[...]
> >  int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > @@ -119,5 +172,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("device/introspect/abstract", test_device_intro_a=
bstract);
> >      qtest_add_func("device/introspect/concrete", test_device_intro_c=
oncrete);
> > =20
> > +    qtest_add_func("qom/introspect/abstract-interfaces", test_abstra=
ct_interfaces);
>=20
> I see why you combine the two for reuse, but this path looks odd, it's
> supposed to indicate which testsuite the test comes from.
> "device/introspect/abstract-qom-interfaces" maybe?

I was unsure if I should keep the existing path prefix, or change
to a new one to indicate we are not testing anything specific
about devices. If you prefer to keep using "device/introspect", I
will change it in v2.

>=20
> > +
> >      return g_test_run();
> >  }

--=20
Eduardo
