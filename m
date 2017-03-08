Received: from eggs.gnu.org ([2001:4830:134:3::10]:57917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clheR-0004m5-9B
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clheN-0004rk-B2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clheN-0004rY-2I
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:53:31 -0500
Date: Wed, 8 Mar 2017 16:53:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308195323.GJ4694@thinpad.lan.raisama.net>
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
	<20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
	<20170308185726.GH4694@thinpad.lan.raisama.net>
	<20170308190606.s7lthax42fndpyqx@kozik-lap>
	<20170308192201.GI4694@thinpad.lan.raisama.net>
	<20170308193419.qj7xfour4xql4xzi@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170308193419.qj7xfour4xql4xzi@kozik-lap>
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

On Wed, Mar 08, 2017 at 09:34:19PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Mar 08, 2017 at 04:22:01PM -0300, Eduardo Habkost wrote:
> > On Wed, Mar 08, 2017 at 09:06:06PM +0200, Krzysztof Kozlowski wrote:
> > > > > The object_property_set_str() takes data as pointer to const. I=
f data
> > > > > ends up as being non-const, then this is the mistake -
> > > > > object_property_set_str().
> > > >=20
> > > > I don't see the mistake. The whole purpose of:
> > > >   qdev_prop_set_chr(dev, "some-field", v)
> > > > is to end up doing this assignment internally:
> > > >   dev->some_field =3D v;
> > > > and on most (or all?) cases dev->some_field is not a const
> > > > pointer. The details are hidden behind the
> > > > object_property_set_str() call.
> > >=20
> > > If that would be the case, the object_property_set_str() cannot tak=
e a
> > > pinter to const. Not only because of the safety and logic but also =
C
> > > will prohibit it without a case.
> > >=20
> > > 	const char *c =3D "foo bar";
> > > 	char *v =3D c;
> > >=20
> > > 	/home/dev/qemu/qemu/qobject/qstring.c:67:15: error: initialization=
 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [-We=
rror=3Ddiscarded-qualifiers]
> > > 	     char *v =3D c;
> > >                ^
> >=20
> > The 'value' parameter to object_property_set_str() is const, and
> > that's correct. But the set_chr() setter will take care of the
> > 'dev->some_field =3D value' part.
>=20
> In current implementation (v2.8.0-2132-gb64842dee42d) the
> only thing qdev_prop_set_chr() does is to call
> object_property_set_str() for value->label.
>=20
> So the flow is:
>     qdev_prop_set_chr(char *value)

I assume you meant:
      qdev_prop_set_chr(Chardev *value)

>         const char *l =3D value->label
>         object_property_set_str(const char *l)

This is correct, but:

>             dev->some_field =3D copy_of(l);

This is not what object_property_set_str() does. It will end up
calling the set_chr() setter, which will end up getting 'value'
back as a non-const pointer, and doing 'dev->some_field =3D value'.

>=20
> The only non-const part of the flow is the first call. All of others ar=
e
> const.
>=20
> Of course the implementation might change and maybe that is the
> intention/plan - the qdev_prop_set_chr() should not commit to the calle=
r
> that it will not store the value itself.

I believe you got the point. Except that this is not a planned
implementation change, but the current and expected behavior of
qdev_prop_set_chr().

>=20
> Then I understand it.
>=20
> However if there are no such plans, then in current implementation the
> qdev_prop_set_chr() does not store any part of the 'value' itself but
> only a copy of it through object_property_set_str(). Thus it can provid=
e
> this hint to the caller: I will not store the 'value' directly so I am
> taking pointer to const.

The current implementation _will_ store 'value' in
dev->some_field (in a very convoluted way, through the set_chr()
setter), as this is its whole purpose.

>=20
> Anyway, this is a trivial, boring and correctness-like change. :) Not w=
orth
> all the talks so I do not mind resending without this (and others which
> were disapproved).

OK. Thanks!

>=20
> Best regards,
> Krzysztof
>=20

--=20
Eduardo
