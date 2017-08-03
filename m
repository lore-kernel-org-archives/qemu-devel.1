Received: from eggs.gnu.org ([2001:4830:134:3::10]:53124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddE7v-0005vE-M8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddE7u-0002P7-A5
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:17:15 -0400
Date: Thu, 3 Aug 2017 13:17:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803111701.GG4456@dhcp-200-186.str.redhat.com>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
	<20170802105704.m2jbxnivl32msbx6@postretch>
	<20170803080801.GC4456@dhcp-200-186.str.redhat.com>
	<20170803105359.GB22685@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20170803105359.GB22685@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.08.2017 um 12:53 hat Stefan Hajnoczi geschrieben:
> On Thu, Aug 03, 2017 at 10:08:01AM +0200, Kevin Wolf wrote:
> > Am 02.08.2017 um 12:57 hat Manos Pitsidianakis geschrieben:
> > > On Wed, Aug 02, 2017 at 11:39:22AM +0100, Stefan Hajnoczi wrote:
> > > > On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
> > > > > On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
> > > > > > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis w=
rote:
> > > > > > > ThrottleGroup is converted to an object. This will allow the =
future
> > > > > > > throttle block filter drive easy creation and configuration o=
f throttle
> > > > > > > groups in QMP and cli.
> > > > > > >
> > > > > > > A new QAPI struct, ThrottleLimits, is introduced to provide a=
 shared
> > > > > > > struct for all throttle configuration needs in QMP.
> > > > > > >
> > > > > > > ThrottleGroups can be created via CLI as
> > > > > > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > > > > > where x-* are individual limit properties. Since we can't add=
 non-scalar
> > > > > > > properties in -object this interface must be used instead. Ho=
wever,
> > > > > > > setting these properties must be disabled after initializatio=
n because
> > > > > > > certain combinations of limits are forbidden and thus configu=
ration
> > > > > > > changes should be done in one transaction. The individual pro=
perties
> > > > > > > will go away when support for non-scalar values in CLI is imp=
lemented
> > > > > > > and thus are marked as experimental.
> > > > > > >
> > > > > > > ThrottleGroup also has a `limits` property that uses the Thro=
ttleLimits
> > > > > > > struct.  It can be used to create ThrottleGroups or set the
> > > > > > > configuration in existing groups as follows:
> > > > > > >
> > > > > > > { "execute": "object-add",
> > > > > > >   "arguments": {
> > > > > > >     "qom-type": "throttle-group",
> > > > > > >     "id": "foo",
> > > > > > >     "props" : {
> > > > > > >       "limits": {
> > > > > > >           "iops-total": 100
> > > > > > >       }
> > > > > > >     }
> > > > > > >   }
> > > > > > > }
> > > > > > > { "execute" : "qom-set",
> > > > > > >     "arguments" : {
> > > > > > >         "path" : "foo",
> > > > > > >         "property" : "limits",
> > > > > > >         "value" : {
> > > > > > >             "iops-total" : 99
> > > > > > >         }
> > > > > > >     }
> > > > > > > }
> > > > > > >
> > > > > > > This also means a group's configuration can be fetched with q=
om-get.
> > > > > > >
> > > > > > > ThrottleGroups can be anonymous which means they can't get ac=
cessed by
> > > > > > > other users ie they will always be units instead of group (Be=
cause they
> > > > > > > have one ThrottleGroupMember).
> > > > > >
> > > > > > blockdev.c automatically assigns -drive id=3D to the group name=
 if
> > > > > > throttling.group=3D wasn't given.  So who will use anonymous si=
ngle-drive
> > > > > > mode?
> > > > >=20
> > > > > Manual filter nodes. It's possible to not pass a group name value=
 and the
> > > > > resulting group will be anonymous. Are you suggesting to move thi=
s change to
> > > > > the throttle filter patch?
> > > >=20
> > > > What is the use case?  Human users will stick to the legacy syntax
> > > > because it's convenient.  Management tools will use the filter
> > > > explicitly in the future, and it's easy for them to choose a name.
> > > >=20
> > > > Unless there is a need for this case I'd prefer to make the group n=
ame
> > > > mandatory.  That way there are less code paths to worry about.
> > >=20
> > > I think Kevin requested this though I don't really remember the use c=
ase.
> >=20
> > There is no legacy syntax for putting a throttle node anywhere but at
> > the root of a BlockBackend. If you want to throttle e.g. only a specific
> > backing file, you need to manually create a throttle node.
> >=20
> > (We tend to forget this occasionally, but the work you're doing is not
> > only cleanup just for fun, but it's actually new features that enable
> > new use cases by making everything more flexible.)
>=20
> It's not clear to me from your reply whether you support anonymous
> throttle groups or not.  It is possible to throttle arbitrary nodes in
> the graph either way.

I think it would be nice for human users to have them, but on second
thought you're right that it's just syntactic sugar for an explicit
-object, so if you think there is any difficulty with supporting
anonymous groups, feel free to drop them.

Hm, actually... Does this mean that then the whole 'limits' option in
the throttle driver could go away, with all of the parsing code, and the
group name becomes mandatory? That certainly does look tempting.

Kevin

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgwYtAAoJEH8JsnLIjy/W0qoQAKjX8dTicsrWWg3gQJVuxzWA
9hNH5i3a60medi+Z9kfdCs8hLb+qTRnIvNwHkfN1h43lw2opbCALvNtjm6nOR4Sh
XMcOsa+scukroKQuNySxNkepgHK13/OFkhSU0HeAShuKcSAzy7+MpvIxmYO4G2uK
iBxsIAM6yAupsfQBEiaCavE45wH8+EFoqGyj7xRdX/Wy82v6nyHxddB697IPEwmv
ITCsB35Xf14FOe+sjnP/e3zNP/FK2wZFtgds6+EZ55p2FK1vRADibYXU5q7hzi8X
X2L6ZzGg5YcllKQ4BtkenZ4CvC9by+8lUzLe0Ic+LaFJtcO6UNE3aIUoHp+f6a1+
/mSB51VyL09iuo1QB+qZEPL+cjFeposVlJfb5c2eGSZ7s9iBCjvmzUFUYRoDxHdm
ZWg2AcUMCtj1YgwzO6TbY/fA7lO/ngM/ReKAqIPYRwBWT7FR0Goo1QzMu/QASber
zz75HV1amFUfkZ3FzdmBLzCUkFBH+FoLpbjbKnWZUmUsMIVyRisBcuiVyIvp1sv1
HZs7rOk09oBW454mVeEqe8Y1OilwfIg9F/ckgvxUxCbha7sS8LRKmmGBN+2kb/TS
P8DvSC5vRz3pJq0f26yZ6KSHseaJ9uhYRF91phXaJNxfYLpyZLn3GRcLc5242hWD
fSsMQRmQWsTUMSZYzwbC
=AW8S
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
