Received: from eggs.gnu.org ([2001:4830:134:3::10]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLhq-0005PN-5M
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLhm-00070u-9H
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRLhm-00070i-2q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:42 -0400
Date: Fri, 8 Jun 2018 15:01:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180608180139.GM7451@localhost.localdomain>
References: <20180606192731.6910-1-f4bug@amsat.org>
	<20180606200513.GY7451@localhost.localdomain>
	<6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
	<ff4501f9-f45e-dc96-9f02-861458fee39b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff4501f9-f45e-dc96-9f02-861458fee39b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2] qmp.py: Fix exception parsing
 partial JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Fri, Jun 08, 2018 at 07:57:55PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Hello guys,
>=20
> Dne 7.6.2018 v 01:06 Philippe Mathieu-Daud=C3=A9 napsal(a):
> > On 06/06/2018 05:05 PM, Eduardo Habkost wrote:
> >> On Wed, Jun 06, 2018 at 04:27:31PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >>> The readline() call returns partial data.
> >>
> >> How can this be reproduced?  Despite not being forbidden by the
> >> QMP specification, QEMU normally doesn't break QMP replies in
> >> multiple lines, and readline() is not supposed to return a
> >> partial line unless it encounters EOF.
> >=20
> > $ git rev-parse HEAD
> > c1c2a435905ae76b159c573b0c0d6f095b45ebc6
> >=20
> > config copy/pasted from:
> > https://wiki.qemu.org/index.php/Documentation/QMP#Trying_it
> > (now looking at it, it seems I'm mixing configs...)
> >=20
> > $ cat qmp.conf
> > [chardev "qmp"]
> >   backend =3D "socket"
> >   path =3D "/tmp/qmp.sock"
> >   server =3D "on"
> >   wait =3D "off"
> > [mon "qmp"]
> >   mode =3D "control"
> >   chardev =3D "qmp"
> >   pretty =3D "on"
> >=20
>=20
> nice, pretty printing..., didn't expected that.

Oh, so *that*'s the root cause.  Thanks, I stared at this
configuration for a while and I couldn't see what could cause
extra newlines to appear in the output.  :)

[...]
> >>> I'm sure there is a nicer/more pythonic way to do this, but this wo=
rks for me,
> >>> sorry :)
> >>
> >> It looks like there's no elegant solution for this:
> >> https://stackoverflow.com/a/21709058
> >>
>=20
> Yep, that looks nicer, but even the original solution should
> not be that bad as it should be rarely used. What troubles me
> more is the possible infinite loop. Would you mind adding a
> timeout?

We already have a socket timeout, so I assume this is alrady
covered?

--=20
Eduardo
