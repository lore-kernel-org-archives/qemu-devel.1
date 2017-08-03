Received: from eggs.gnu.org ([2001:4830:134:3::10]:51791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddDld-0005Y2-0H
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddDlb-0008Tc-Vc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:54:13 -0400
Date: Thu, 3 Aug 2017 11:53:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170803105359.GB22685@stefanha-x1.localdomain>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
	<20170802105704.m2jbxnivl32msbx6@postretch>
	<20170803080801.GC4456@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20170803080801.GC4456@dhcp-200-186.str.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 10:08:01AM +0200, Kevin Wolf wrote:
> Am 02.08.2017 um 12:57 hat Manos Pitsidianakis geschrieben:
> > On Wed, Aug 02, 2017 at 11:39:22AM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
> > > > On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
> > > > > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wro=
te:
> > > > > > ThrottleGroup is converted to an object. This will allow the fu=
ture
> > > > > > throttle block filter drive easy creation and configuration of =
throttle
> > > > > > groups in QMP and cli.
> > > > > >
> > > > > > A new QAPI struct, ThrottleLimits, is introduced to provide a s=
hared
> > > > > > struct for all throttle configuration needs in QMP.
> > > > > >
> > > > > > ThrottleGroups can be created via CLI as
> > > > > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > > > > where x-* are individual limit properties. Since we can't add n=
on-scalar
> > > > > > properties in -object this interface must be used instead. Howe=
ver,
> > > > > > setting these properties must be disabled after initialization =
because
> > > > > > certain combinations of limits are forbidden and thus configura=
tion
> > > > > > changes should be done in one transaction. The individual prope=
rties
> > > > > > will go away when support for non-scalar values in CLI is imple=
mented
> > > > > > and thus are marked as experimental.
> > > > > >
> > > > > > ThrottleGroup also has a `limits` property that uses the Thrott=
leLimits
> > > > > > struct.  It can be used to create ThrottleGroups or set the
> > > > > > configuration in existing groups as follows:
> > > > > >
> > > > > > { "execute": "object-add",
> > > > > >   "arguments": {
> > > > > >     "qom-type": "throttle-group",
> > > > > >     "id": "foo",
> > > > > >     "props" : {
> > > > > >       "limits": {
> > > > > >           "iops-total": 100
> > > > > >       }
> > > > > >     }
> > > > > >   }
> > > > > > }
> > > > > > { "execute" : "qom-set",
> > > > > >     "arguments" : {
> > > > > >         "path" : "foo",
> > > > > >         "property" : "limits",
> > > > > >         "value" : {
> > > > > >             "iops-total" : 99
> > > > > >         }
> > > > > >     }
> > > > > > }
> > > > > >
> > > > > > This also means a group's configuration can be fetched with qom=
-get.
> > > > > >
> > > > > > ThrottleGroups can be anonymous which means they can't get acce=
ssed by
> > > > > > other users ie they will always be units instead of group (Beca=
use they
> > > > > > have one ThrottleGroupMember).
> > > > >
> > > > > blockdev.c automatically assigns -drive id=3D to the group name if
> > > > > throttling.group=3D wasn't given.  So who will use anonymous sing=
le-drive
> > > > > mode?
> > > >=20
> > > > Manual filter nodes. It's possible to not pass a group name value a=
nd the
> > > > resulting group will be anonymous. Are you suggesting to move this =
change to
> > > > the throttle filter patch?
> > >=20
> > > What is the use case?  Human users will stick to the legacy syntax
> > > because it's convenient.  Management tools will use the filter
> > > explicitly in the future, and it's easy for them to choose a name.
> > >=20
> > > Unless there is a need for this case I'd prefer to make the group name
> > > mandatory.  That way there are less code paths to worry about.
> >=20
> > I think Kevin requested this though I don't really remember the use cas=
e.
>=20
> There is no legacy syntax for putting a throttle node anywhere but at
> the root of a BlockBackend. If you want to throttle e.g. only a specific
> backing file, you need to manually create a throttle node.
>=20
> (We tend to forget this occasionally, but the work you're doing is not
> only cleanup just for fun, but it's actually new features that enable
> new use cases by making everything more flexible.)

It's not clear to me from your reply whether you support anonymous
throttle groups or not.  It is possible to throttle arbitrary nodes in
the graph either way.

Stefan

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgwDHAAoJEJykq7OBq3PI5pcH/1mXBOizbv3qNVmhfxa27JKD
8NRGDiLiO/pRfdnyK6v/c+VynoVkYZSapRm+UIbJ/RHmq71X2heSuLiqMPBUfTQi
BJOFuXuC9iXaAipCp0VhpSnupb2dWz+yUrV5cYKLdJM7t3fv/bO8b+Y7m/uZZQCq
/M6uZjk20iG9sQBe2wb3fAD+0sI/P1taD3BToK/c+y16DFQDwWL42rvaWop+IOCD
lH/nhqbUmbCSfKeR2Fz7s7KrFah+ercNLNNkTLaz4hvjttmm2Wr1TPt0Tx8MgHuD
1Um6wwj5a60HJ6ZI+kmba3ab3FVAAxnbp1fTeayU7sPhwhzJEUfcUG1/d7SXh8k=
=J5tE
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
