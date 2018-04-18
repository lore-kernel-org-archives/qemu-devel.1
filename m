Received: from eggs.gnu.org ([2001:4830:134:3::10]:42084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8qW6-00046A-UH
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8qW5-0006zh-Q8
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:05:10 -0400
Date: Wed, 18 Apr 2018 18:04:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418170457.GC27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<20180418163458.GB27579@redhat.com>
	<20180418165208.GI4971@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418165208.GI4971@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com

On Wed, Apr 18, 2018 at 06:52:08PM +0200, Kevin Wolf wrote:
> Am 18.04.2018 um 18:34 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Wed, Apr 18, 2018 at 06:28:23PM +0200, Kevin Wolf wrote:
> > > Am 18.04.2018 um 17:06 hat Markus Armbruster geschrieben:
> >=20
> > > >     Note that users can still configure authentication methods wi=
th a
> > > >     configuration file.  They probably do that anyway if they use=
 Ceph
> > > >     outside QEMU as well.
> > >=20
> > > This solution that we originally intended to offer was dismissed by
> > > libvirt as unpractical: libvirt allows the user to specify both a c=
onfig
> > > file and a key, and if it wanted to use a config file to pass the k=
ey,
> > > it would have to create a merged config file and keep it sync with =
the
> > > user config file at all times. Understandable that they want to avo=
id
> > > this.
> >=20
> > Even if the config file does have auth info setup, we can't assume th=
at
> > the QEMU VMs are supposed to use the same auth info. In fact to prope=
rly
> > protect against compromised QEMU, ideally every QEMU would use a comp=
letely
> > separate RBD user+password, so that compromised QEMU can't then acces=
s
> > RBD disks belonging to a different user.
> >=20
> > So from libvirt POV we want to pretend the config file does not exist=
 at
> > all and explicitly pass everything that is needed via normal per-disk
> > setup for blockdev.
>=20
> From the rbd driver:
>=20
>  * The "conf" option specifies a Ceph configuration file to read.  If
>  * it is not specified, we will read from the default Ceph locations
>  * (e.g., /etc/ceph/ceph.conf).  To avoid reading _any_ configuration
>  * file, specify conf=3D/dev/null.
>=20
> So what we actually expected libvirt to do is to create a config file
> for each rbd image and pass that to qemu. However, libvirt allows the
> user to specify their own config file and passes that, and therefore
> doesn't want to create its own config file. If the user doesn't specify
> a config file, libvirt should probably indeed use /dev/null at least.

Yeah this is a mess - I wish we had never allowed users to pass a config
file, and had used /dev/null all the time. Unfortunately changing either
of these aspects would cause backcompat problems for existing deployments
now :-( So we just have to accept that the global config file is always
in present, but none the less libvirt should try to specify things as
fully as possible.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
