Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddBB2-0000gV-45
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddBB0-0001PB-Rv
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 04:08:16 -0400
Date: Thu, 3 Aug 2017 10:08:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803080801.GC4456@dhcp-200-186.str.redhat.com>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
	<20170802105704.m2jbxnivl32msbx6@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20170802105704.m2jbxnivl32msbx6@postretch>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.08.2017 um 12:57 hat Manos Pitsidianakis geschrieben:
> On Wed, Aug 02, 2017 at 11:39:22AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
> > > On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
> > > > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wrote:
> > > > > ThrottleGroup is converted to an object. This will allow the futu=
re
> > > > > throttle block filter drive easy creation and configuration of th=
rottle
> > > > > groups in QMP and cli.
> > > > >
> > > > > A new QAPI struct, ThrottleLimits, is introduced to provide a sha=
red
> > > > > struct for all throttle configuration needs in QMP.
> > > > >
> > > > > ThrottleGroups can be created via CLI as
> > > > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > > > where x-* are individual limit properties. Since we can't add non=
-scalar
> > > > > properties in -object this interface must be used instead. Howeve=
r,
> > > > > setting these properties must be disabled after initialization be=
cause
> > > > > certain combinations of limits are forbidden and thus configurati=
on
> > > > > changes should be done in one transaction. The individual propert=
ies
> > > > > will go away when support for non-scalar values in CLI is impleme=
nted
> > > > > and thus are marked as experimental.
> > > > >
> > > > > ThrottleGroup also has a `limits` property that uses the Throttle=
Limits
> > > > > struct.  It can be used to create ThrottleGroups or set the
> > > > > configuration in existing groups as follows:
> > > > >
> > > > > { "execute": "object-add",
> > > > >   "arguments": {
> > > > >     "qom-type": "throttle-group",
> > > > >     "id": "foo",
> > > > >     "props" : {
> > > > >       "limits": {
> > > > >           "iops-total": 100
> > > > >       }
> > > > >     }
> > > > >   }
> > > > > }
> > > > > { "execute" : "qom-set",
> > > > >     "arguments" : {
> > > > >         "path" : "foo",
> > > > >         "property" : "limits",
> > > > >         "value" : {
> > > > >             "iops-total" : 99
> > > > >         }
> > > > >     }
> > > > > }
> > > > >
> > > > > This also means a group's configuration can be fetched with qom-g=
et.
> > > > >
> > > > > ThrottleGroups can be anonymous which means they can't get access=
ed by
> > > > > other users ie they will always be units instead of group (Becaus=
e they
> > > > > have one ThrottleGroupMember).
> > > >
> > > > blockdev.c automatically assigns -drive id=3D to the group name if
> > > > throttling.group=3D wasn't given.  So who will use anonymous single=
-drive
> > > > mode?
> > >=20
> > > Manual filter nodes. It's possible to not pass a group name value and=
 the
> > > resulting group will be anonymous. Are you suggesting to move this ch=
ange to
> > > the throttle filter patch?
> >=20
> > What is the use case?  Human users will stick to the legacy syntax
> > because it's convenient.  Management tools will use the filter
> > explicitly in the future, and it's easy for them to choose a name.
> >=20
> > Unless there is a need for this case I'd prefer to make the group name
> > mandatory.  That way there are less code paths to worry about.
>=20
> I think Kevin requested this though I don't really remember the use case.

There is no legacy syntax for putting a throttle node anywhere but at
the root of a BlockBackend. If you want to throttle e.g. only a specific
backing file, you need to manually create a throttle node.

(We tend to forget this occasionally, but the work you're doing is not
only cleanup just for fun, but it's actually new features that enable
new use cases by making everything more flexible.)

Kevin

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgtnhAAoJEH8JsnLIjy/WuTIP/0YY8+0sxn3PCeTOHGZ0irOn
mE2666SQZ7pBz/13t4pVWHEvzTEkjCZiPD5KeOavVbJslqdrEM/PpMP9bs+qJRHK
0jSgHOgRN0DyykRvQjb3YfNqidvhnczjB4n4OZA/nBuvV8UAqZZpvl1t3idxsNp3
1lxdTDeN8p8NKbObkMwUTp3K/XzCl/bCvWXnNkFUuOGC98ZDqmiYJAY3gfxOQb05
dECnIMg46YozN+yDi9a3/K5jBWYaqJMxdn3xV2eJwqUaWU2Kxbmf9OEwezP1yrrU
+6jG+n0fFgcJl5wx05UYIztfMgG4nrW/IHc0Rfd6CGWCvZBuEfHaeSaC6WxKKqsa
2NdjGs7CCkKbSNj0dyLSQGffcmEz2VX5ynYNTZe/0WVRozrVGoNc55of3Y4v12Mf
1AsbqvuBfoakvsc4Kpk1sFQkJCQUxCHgFQEfOKt0TIiAajvoxMxZRLYkI6PXEPrf
z8F40npnTjBBRmXIAavqZAa6gjrMYUpb7HRT7la/tybK/SS1DKR/KGq75RAWhcge
BDbbvGDtOzFKa/TUeggyi4aE/DMlyDF+zQbOyjTmeMaEnhY32FEfOxweXEvcAYx9
nYHrD4plLRbzrCnyoD985PfDsZXqkkK0HYdFoTY58CQin5SVo52ShEBxKwKVsJSR
xIlQSTskJ3wtGdEJubA4
=MdK2
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
