Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f9WVw-0006nq-7N
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f9WVu-0007EZ-NS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:55:48 -0400
Date: Fri, 20 Apr 2018 14:55:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180420135529.GL21035@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<20180418163458.GB27579@redhat.com>
	<20180418165208.GI4971@localhost.localdomain>
	<20180418170457.GC27579@redhat.com>
	<87y3hixaql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3hixaql.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jdurgin@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Fri, Apr 20, 2018 at 03:34:26PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Apr 18, 2018 at 06:52:08PM +0200, Kevin Wolf wrote:
> >> Am 18.04.2018 um 18:34 hat Daniel P. Berrang=C3=A9 geschrieben:
> >> > On Wed, Apr 18, 2018 at 06:28:23PM +0200, Kevin Wolf wrote:
> >> > > Am 18.04.2018 um 17:06 hat Markus Armbruster geschrieben:
> >> >=20
> >> > > >     Note that users can still configure authentication methods=
 with a
> >> > > >     configuration file.  They probably do that anyway if they =
use Ceph
> >> > > >     outside QEMU as well.
> >> > >=20
> >> > > This solution that we originally intended to offer was dismissed=
 by
> >> > > libvirt as unpractical: libvirt allows the user to specify both =
a config
> >> > > file and a key, and if it wanted to use a config file to pass th=
e key,
> >> > > it would have to create a merged config file and keep it sync wi=
th the
> >> > > user config file at all times. Understandable that they want to =
avoid
> >> > > this.
>=20
> Yes.
>=20
> >> > Even if the config file does have auth info setup, we can't assume=
 that
> >> > the QEMU VMs are supposed to use the same auth info.
>=20
> If the user tells you to use this config file, you better assume that's
> what he wants.
>=20
> >> >                                                      In fact to pr=
operly
> >> > protect against compromised QEMU, ideally every QEMU would use a c=
ompletely
> >> > separate RBD user+password, so that compromised QEMU can't then ac=
cess
> >> > RBD disks belonging to a different user.
>=20
> Yes, unless the user tells you otherwise.
>=20
> >> > So from libvirt POV we want to pretend the config file does not ex=
ist at
> >> > all and explicitly pass everything that is needed via normal per-d=
isk
> >> > setup for blockdev.
> >>=20
> >> From the rbd driver:
> >>=20
> >>  * The "conf" option specifies a Ceph configuration file to read.  I=
f
> >>  * it is not specified, we will read from the default Ceph locations
> >>  * (e.g., /etc/ceph/ceph.conf).  To avoid reading _any_ configuratio=
n
> >>  * file, specify conf=3D/dev/null.
> >>=20
> >> So what we actually expected libvirt to do is to create a config fil=
e
> >> for each rbd image and pass that to qemu. However, libvirt allows th=
e
> >> user to specify their own config file and passes that, and therefore
> >> doesn't want to create its own config file. If the user doesn't spec=
ify
> >> a config file, libvirt should probably indeed use /dev/null at least=
.
> >
> > Yeah this is a mess - I wish we had never allowed users to pass a con=
fig
> > file, and had used /dev/null all the time. Unfortunately changing eit=
her
> > of these aspects would cause backcompat problems for existing deploym=
ents
> > now :-( So we just have to accept that the global config file is alwa=
ys
> > in present, but none the less libvirt should try to specify things as
> > fully as possible.
>=20
> I'm afraid you get backward compatibility problems no matter what.
> Whenever you extend libvirt to pass configuration C "via normal per-dis=
k
> setup for blockdev", it breaks user config files containing C, doesn't
> it?

That's not actually a problem here. We are only passing things to QEMU
that the user already provided us in the XML file. If we gain support
for passing a new item via the blockdev schema, then we'd only be
passing that to QEMU if the user actually provided that item in the
XML too.  We're not likely to pass a new config field without the
user having asked us to first.

In this specific case of passwords, historically the user providd
the password in the XML, and we passed that to QEMU using the URI
format. We want to change to the blockdev schema instead of URI
so we can use secrets.

IOW, if the user has been relying on the global config file to
provide passwords QEMU needed, we would never have been setting
a password in the URI in the past,  and we would also not set
a password secret in the blockdev schema either. So there's no
compat problem here.

> <heresy>If you're going to break config files on every new feature
> anyway, why not break them once and for all, then use them the way we
> actually expected libvirt to do.</heresy>

We're not breaking it, so there's no issue here.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
