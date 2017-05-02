Received: from eggs.gnu.org ([2001:4830:134:3::10]:57130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5ZGp-00054L-Qc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d5ZGm-00062R-D1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1d5ZGm-00060l-42
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E80FD23EC9E
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 14:59:14 +0000 (UTC)
Date: Tue, 2 May 2017 15:59:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170502145913.GF16511@redhat.com>
References: <20170502083500.GA27432@redhat.com>
	<87y3ufjpsr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3ufjpsr.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Writing a C library to generate qemu command lines
 and configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

On Tue, May 02, 2017 at 04:28:52PM +0200, Markus Armbruster wrote:
> > * Is comma-quoting (ie. doubling any commas) sufficient?  Or are ther=
e
> >   other forms of quoting?  A quick look at options parsing in qemu
> >   doesn't show any.
>=20
> A quick look at QemuOpts will at best confuse, and possibly deceive.
>=20
> The beginnings of its replacement in util/keyval.c comes with a *gasp*
> grammar.  It doesn't have all of QemuOpts bells & whistles, at least no=
t
> yet.  You might find it useful anyway.
>=20
> To answer your question: you have to double comma after '=3D', or else =
it
> terminates the value.  There is no other quoting.

Hmm, is that really right?  It seems to me that any comma must be
doubled.  For example:

$ qemu-system-x86_64 -name foo,bar -writeconfig - -hda die
qemu-system-x86_64: -name foo,bar: Invalid parameter 'bar'

$ qemu-system-x86_64 -name foo,,bar -writeconfig - -hda die
# qemu config file

[name]
  guest =3D "foo,bar"

qemu-system-x86_64: -hda die: Could not open 'die': No such file or direc=
tory

--- Or:

$ qemu-system-x86_64 -drive file=3Dfoo,,bar -writeconfig -=20
# qemu config file

[drive]
  file =3D "foo,bar"

qemu-system-x86_64: -drive file=3Dfoo,,bar: Could not open 'foo,bar': No =
such file or directory

> > * From the point of view of a client generating command lines, is the=
re
> >   any significance to dotted names (eg. =E2=80=98-drive file.driver=3D=
ssh,...=E2=80=99)
>=20
> Right now, you can still pretend dotted names are just names.
>=20
> But option arguments have really become trees.  We've shoehorned them
> into the existing command line syntax with dotted keys.  Design
> discussion, if you're interested:
>=20
>     Subject: Non-flat command line option argument syntax
>     Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> Implementation is the keyval.c mentioned above.
>=20
> I'm not sure baking "option argument is a list of (key, string) pairs,
> where both key and string are strings" into your library now is a good
> idea.  Perhaps it would be better to embrace "option argument is a tree=
"
> from the start.

OK, I'll think about that.

> In the longer run, I intend to make -readconfig (or its replacement)
> accept JSON, because it supports trees directly, and is less badly
> defined.

And JSON actually thinks about quoting too :-)

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
