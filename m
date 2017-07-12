Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF4Y-0007Hj-Ks
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF4U-0002PC-OB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVF4U-0002OU-EL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 016853B702
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:40:41 +0000 (UTC)
Date: Wed, 12 Jul 2017 11:40:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712104037.GH6923@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170711141543.GW17792@stefanha-x1.localdomain>
	<20170711151421.GA7449@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <20170711151421.GA7449@lemon>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 11:14:21PM +0800, Fam Zheng wrote:
> On Tue, 07/11 15:15, Stefan Hajnoczi wrote:
> > On Mon, Jul 10, 2017 at 03:20:22PM +0800, Fam Zheng wrote:
> > > Last time we've looked at "-object iothread,spawns=3DN" but it was a =
bit abusive.
> > > A dedicated "iothread-group" class is cleaner from the interface poin=
t of view.
> > > This series does that.
> > >=20
> > > It has the same set of poll parameters as the existing "iothread" obj=
ect, plus
> > > a "size" option to specify how many threads to start. Using iothread-=
group
> > > doesn't require the user to explicitly create the contained IOThreads=
=2E The
> > > IOThreads are created by the group object.
> > >=20
> > > Internally, IOThreads share one AioContext.  This is to make it easie=
r to adapt
> > > this to the current data plane code (see the last patch). But it is an
> > > implementation detail, and will change depending on the block layer m=
ultiqueue
> > > needs.
> > >=20
> > > TODO:
> > >=20
> > > - qmp_query_iothread_groups, in addition to proper QOM @child propert=
y from
> > >   IOThreadGroup to its IOThread instances.
> > > - Add virtio-scsi.
> > > - Variant of iothread_stop_all().
> > >=20
> > > Fam Zheng (5):
> > >   aio: Wrap poll parameters into AioContextPollParams
> > >   iothread: Don't error on windows
> > >   iothread: Extract iothread_start
> > >   Introduce iothread-group
> > >   virtio-blk: Add iothread-group property
> >=20
> > From your TODO note above it looks like you plan to duplicate IOThread
> > interfaces for IOThreadGroup?  This means existing query-iothreads users
> > no longer see the full view of all IOThreads.
> >=20
> > I think it would be cleaner to define and query IOThreads like they are
> > today but change virtio-blk/virtio-scsi to accept a list of IOThreads.
>=20
> That way the groups are formed passively and I'm not sure if it is better=
 for
> users/tools to manage in the long run. Consider this syntax:
>=20
>     -object iothread,id=3Diot0 \
>     -object iothread,id=3Diot1 \
>     -object iothread,id=3Diot2 \
>     -device virtio-blk-pci,id=3Dvblk0,iothread.0=3Diot0,iothread.1=3Diot1=
 \
>     -device virtio-blk-pci,id=3Dvblk1,iothread.0=3Diot1,iothread.1=3Diot2
>=20
> where vblk0 uses iot0 and iot1 and vblk1 uses iot1 and iot2. There is a
> intersection between the two groups. IMO it is less clean compared to the
> rule set by an explicit syntax:
>=20
>     -object iothread-group,id=3Diotg0,size=3D4 \
>     -object iothread-group,id=3Diotg1,size=3D4 \
>     -device virtio-blk-pci,id=3Dvblk0,iothread-group=3Diotg0 \
>     -device virtio-blk-pci,id=3Dvblk1,iothread-group=3Diotg1 \
>=20
>=20
> Also I have not idea how easy it is to add a "list of links" qdev propert=
y. I
> remember there was some related work in progress, but I've lost the point=
ers.
>=20
> > That way existing management tool functionality can be used and the only
> > tweak is that devices can now be added to multiple IOThreads.
>=20
> Another way could be to still include any IOThreads created by IOThreadGr=
oup in
> "query-iothreads" output, and add a "group name" property so users know t=
he
> groupings.
>=20
> >=20
> > It would be nice to express the group relationship in QOM instead of
> > open coding a new group object.  The majority of the RFC code creates a
> > child/link list relationship that QOM should support for any type, not
> > just IOThread.
>=20
> Sounds fine, but I'm not sure what exactly you have in mind (I think it is
> extending QOM). Can you elaborate?

I thought about it after sending this email.  Here is a follow-up that
gets into the QOM details:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02799.html

Stefan

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZfylAAoJEJykq7OBq3PIl8IH/R5b6iKMEbqVrnQlIrBzOKqc
R1OALsWmI9lgSwpeBe9ucmIlGmVlDXL3jkTtESYADobncGgYepVL1fTJ8/xE1WTM
hjh+q0Klh/w/5AGu5C/wwrSXvMv0g1NWd9AW5bUjmKSPKXsQp8Ugepc4Vm8a8uZf
NLsboj5jwnA2fwXQooZXLOXsEx8NFEZ6FKAQsg7f7MUe0znbcDTtR1DmqVWCe5s9
evqDh3uv0TPnHdJiw4v0kblSYKoRsyQLjPvjyR3y8WL9kQTWJUfWerDqoggWqyMZ
kdAGCtw8+/86LF93OnRi2qLcM/CW8Ta1QwUOa3Ym9+GjDgUCt23bUne20klOesU=
=KAgu
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
