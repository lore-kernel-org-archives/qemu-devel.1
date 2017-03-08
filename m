Received: from eggs.gnu.org ([2001:4830:134:3::10]:53965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1clhLy-0001UU-GG
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1clhLt-00077o-G9
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:34:30 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
	id 1clhLt-00077T-9o
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:34:25 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so5375614wrc.3
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 11:34:25 -0800 (PST)
Date: Wed, 8 Mar 2017 21:34:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170308193419.qj7xfour4xql4xzi@kozik-lap>
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
	<20170308162213.kcs3udn6ckvl7jd7@kozik-lap>
	<20170308185726.GH4694@thinpad.lan.raisama.net>
	<20170308190606.s7lthax42fndpyqx@kozik-lap>
	<20170308192201.GI4694@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170308192201.GI4694@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 08, 2017 at 04:22:01PM -0300, Eduardo Habkost wrote:
> On Wed, Mar 08, 2017 at 09:06:06PM +0200, Krzysztof Kozlowski wrote:
> > > > The object_property_set_str() takes data as pointer to const. If da=
ta
> > > > ends up as being non-const, then this is the mistake -
> > > > object_property_set_str().
> > >=20
> > > I don't see the mistake. The whole purpose of:
> > >   qdev_prop_set_chr(dev, "some-field", v)
> > > is to end up doing this assignment internally:
> > >   dev->some_field =3D v;
> > > and on most (or all?) cases dev->some_field is not a const
> > > pointer. The details are hidden behind the
> > > object_property_set_str() call.
> >=20
> > If that would be the case, the object_property_set_str() cannot take a
> > pinter to const. Not only because of the safety and logic but also C
> > will prohibit it without a case.
> >=20
> > 	const char *c =3D "foo bar";
> > 	char *v =3D c;
> >=20
> > 	/home/dev/qemu/qemu/qobject/qstring.c:67:15: error: initialization dis=
cards =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=
=3Ddiscarded-qualifiers]
> > 	     char *v =3D c;
> >                ^
>=20
> The 'value' parameter to object_property_set_str() is const, and
> that's correct. But the set_chr() setter will take care of the
> 'dev->some_field =3D value' part.

In current implementation (v2.8.0-2132-gb64842dee42d) the
only thing qdev_prop_set_chr() does is to call
object_property_set_str() for value->label.

So the flow is:
    qdev_prop_set_chr(char *value)
        const char *l =3D value->label
        object_property_set_str(const char *l)
            dev->some_field =3D copy_of(l);

The only non-const part of the flow is the first call. All of others are
const.

Of course the implementation might change and maybe that is the
intention/plan - the qdev_prop_set_chr() should not commit to the caller
that it will not store the value itself.

Then I understand it.

However if there are no such plans, then in current implementation the
qdev_prop_set_chr() does not store any part of the 'value' itself but
only a copy of it through object_property_set_str(). Thus it can provide
this hint to the caller: I will not store the 'value' directly so I am
taking pointer to const.

Anyway, this is a trivial, boring and correctness-like change. :) Not worth
all the talks so I do not mind resending without this (and others which
were disapproved).

Best regards,
Krzysztof
