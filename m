Received: from eggs.gnu.org ([2001:4830:134:3::10]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clhA1-00077U-66
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clh9x-0002X1-VT
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clh9x-0002Wo-Mq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:22:05 -0500
Date: Wed, 8 Mar 2017 16:22:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308192201.GI4694@thinpad.lan.raisama.net>
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
	<20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
	<20170308185726.GH4694@thinpad.lan.raisama.net>
	<20170308190606.s7lthax42fndpyqx@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170308190606.s7lthax42fndpyqx@kozik-lap>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qdev: Constify data pointed by few
 arguments and local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 08, 2017 at 09:06:06PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Mar 08, 2017 at 03:57:26PM -0300, Eduardo Habkost wrote:
> > On Wed, Mar 08, 2017 at 06:22:13PM +0200, Krzysztof Kozlowski wrote:
> > > On Mon, Mar 06, 2017 at 09:09:48AM -0300, Eduardo Habkost wrote:
> > > > Hi,
> > > >=20
> > > >=20
> > > > On Sun, Mar 05, 2017 at 11:46:33PM +0200, Krzysztof Kozlowski wro=
te:
> > > > > In few places the function arguments and local variables are no=
t
> > > > > modifying data passed through pointers so this can be made cons=
t for
> > > > > code safeness.
> > > > >=20
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >=20
> > > > I believe most changes below are misleading to users of the API,
> > > > and make the code less safe. Most of the pointers passed as
> > > > argument to those functions will be stored at non-const pointer
> > > > fields inside the objects.
> > > >=20
> > > > > ---
> > > > >  hw/core/qdev-properties-system.c |  6 +++---
> > > > >  hw/core/qdev-properties.c        |  7 ++++---
> > > > >  include/hw/qdev-properties.h     | 11 +++++++----
> > > > >  3 files changed, 14 insertions(+), 10 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-pr=
operties-system.c
> > > > > index c34be1c1bace..abbf3ef754d8 100644
> > > > > --- a/hw/core/qdev-properties-system.c
> > > > > +++ b/hw/core/qdev-properties-system.c
> > > > > @@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, =
const char *name,
> > > > >      if (value) {
> > > > >          ref =3D blk_name(value);
> > > > >          if (!*ref) {
> > > > > -            BlockDriverState *bs =3D blk_bs(value);
> > > > > +            const BlockDriverState *bs =3D blk_bs(value);
> > > > >              if (bs) {
> > > > >                  ref =3D bdrv_get_node_name(bs);
> > > > >              }
> > > >=20
> > > > This part looks safe, but still misleading: the
> > > > object_property_set_str() call will end up changing a non-const
> > > > pointer field in the object. I'm not sure what's the benefit of
> > > > this change.
> > >=20
> > > I might be missing something... but I am touching only the 'bs' and=
 it
> > > is passed to bdrv_get_node_name() also as const. The
> > > bdrv_get_node_name() just accepts pointer to const.
> > >=20
> > > I am not sure why are you referring to object_property_set_str(). T=
he
> > > value returned by bdrv_get_node_name() is pointer to const.
> > > object_property_set_str() also takes pointer to const.
> > >=20
> > > So entire path, starting from 'bs' uses pointer to const... thus I
> > > find misleading that 'bs' is not pointing to const data. It should.
> >=20
> > This code path is correct, yes. That's why I don't mind either
> > way. What I find misleading is that the object_property_set_str()
> > call will end up setting a pointer inside the object to 'bs', and
> > that pointer is not const.
>=20
> No, I believe it won't. The qstring_from_str() makes a copy of passed
> value. That is also the whole idea of pointer to const for input
> argument - a commitment that this data will not be stored for later.

It will set a non-const pointer to 'value' (take a look at
set_drive()). But I was wrong because I was talking about 'bs',
not 'value'. I see no problems in making 'bs' const.

>=20
> >=20
> > >=20
> > > >=20
> > > > > @@ -416,7 +416,7 @@ void qdev_prop_set_drive(DeviceState *dev, =
const char *name,
> > > > >  }
> > > > > =20
> > > > >  void qdev_prop_set_chr(DeviceState *dev, const char *name,
> > > > > -                       Chardev *value)
> > > > > +                       const Chardev *value)
> > > >=20
> > > > This wrapper will end up storing 'value' in a non-const pointer
> > > > in the object (e.g. PL011State::chr). Declaring 'value' as const
> > > > is misleading.
> > >=20
> > > The object_property_set_str() takes data as pointer to const. If da=
ta
> > > ends up as being non-const, then this is the mistake -
> > > object_property_set_str().
> >=20
> > I don't see the mistake. The whole purpose of:
> >   qdev_prop_set_chr(dev, "some-field", v)
> > is to end up doing this assignment internally:
> >   dev->some_field =3D v;
> > and on most (or all?) cases dev->some_field is not a const
> > pointer. The details are hidden behind the
> > object_property_set_str() call.
>=20
> If that would be the case, the object_property_set_str() cannot take a
> pinter to const. Not only because of the safety and logic but also C
> will prohibit it without a case.
>=20
> 	const char *c =3D "foo bar";
> 	char *v =3D c;
>=20
> 	/home/dev/qemu/qemu/qobject/qstring.c:67:15: error: initialization dis=
cards =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=
=3Ddiscarded-qualifiers]
> 	     char *v =3D c;
>                ^

The 'value' parameter to object_property_set_str() is const, and
that's correct. But the set_chr() setter will take care of the
'dev->some_field =3D value' part.

--=20
Eduardo
