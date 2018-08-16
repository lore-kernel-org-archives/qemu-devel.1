Received: from eggs.gnu.org ([2001:4830:134:3::10]:50603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqONV-0001Iq-Ib
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqONU-0006Tg-OJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:56:17 -0400
References: <2e8b4754-2f83-d263-f562-b753aea90d42@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5e88645-e43f-1d3c-6dd1-e20e04733d4f@redhat.com>
Date: Thu, 16 Aug 2018 14:56:10 -0500
MIME-Version: 1.0
In-Reply-To: <2e8b4754-2f83-d263-f562-b753aea90d42@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] nbd oldstyle negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 08/16/2018 02:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi Eric!
>=20
> There is a small problem with our qemu-nbd cmdline interface: people=20
> forget to use option -x or don't know about it and face into problems=20
> with old protocol version. One of may colleagues after such situation=20
> (because of this option, he could not use utility nbd-client, which=20
> doesn't support old version) asked me to add comments about version=20
> selection by -x option into --help of qemu-nbd. And really, it's not an=
=20
> obvious interface solution...
>=20
> Now I think, should not we use new version by default? Or, even drop ol=
d=20
> version support at all? Anybody uses it?

nbdkit 1.3 switched its default to newstyle (Jan 2018):
https://github.com/libguestfs/nbdkit/commit/b2a8aecc
https://github.com/libguestfs/nbdkit/commit/8158e773

and you are correct that nbd 3.10 dropped oldstyle long ago (Mar 2015):
https://github.com/NetworkBlockDevice/nbd/commit/36940193

oldstyle is severely lacking in features (it can't do TLS or efficient=20
sparse file handling, for example).  Do we need a formal qemu=20
deprecation period (where you still get oldstyle if -x was not used, but=20
a nice big warning) before flipping the default in 3.2/3.3 [1], or are=20
we okay flipping it in 3.1?

[1] Okay, I know that our new equally-arbitrary policy on when to bump=20
qemu version number components means that we'll probably see 3.1 in 2018=20
then 4.0 in 2019, rather than 3.2.

And, if we switch the default now (which I am in favor of), do we want=20
to add a -o switch to still make it possible to select oldstyle for a=20
couple more releases in case someone was relying on it?  Then again, if=20
you have to amend your script to use -o to keep things from breaking,=20
why not just amend your setup to use newstyle?

My personal preference: completely drop oldstyle support from qemu, for=20
3.1, with no deprecation period. Do so by making '-x ""' the default for=20
any qemu-nbd command line that did not otherwise specify an export name.=20
  If someone still needs interoperability, they can use nbdkit in the=20
middle, which will still support oldstyle, and provides a plugin for=20
connecting:

newstyle client =3D> nbdkit nbd plugin =3D> oldstyle server
oldstyle client =3D> nbdkit nbd plugin =3D> newstyle server

(well, that plugin could be enhanced to support IP addresses, rather=20
than just Unix sockets, but that's a topic for another mailing list)

But I'm open to counter opinions on whether we need to be more=20
conservative, and will not rip things out without at least getting=20
opinions from others on how aggressive or conservative the switchover=20
should be.

>=20
> from nbd spec:
>  =C2=A0... the old style negotiation is now no longer developed; starti=
ng=20
> with version 3.10 of the reference implementation, it is also no longer=
=20
> supported.
>=20
> it's unsupported, I think it's ok to drop it. I can create patches, if=20
> you agree.

If you want to create patches, that's also fine by me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
