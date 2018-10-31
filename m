Received: from eggs.gnu.org ([2001:4830:134:3::10]:36846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHszZ-00045C-Ii
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHszT-0006pA-Lm
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHszP-0006lk-SR
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:05 -0400
Date: Wed, 31 Oct 2018 16:04:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181031160430.GN9625@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<CAMxuvawbr3i5d6dfaobcfOD3gvFNnR_vEzws6kmGUG+GBaJaOg@mail.gmail.com>
	<20181012095554.GV16720@redhat.com>
	<CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
	<20181016121438.GD7995@redhat.com>
	<CAMxuvayaPxq1EJATVVsQUvA1bktUoUPZmez+-O4R2U81g-Vvfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayaPxq1EJATVVsQUvA1bktUoUPZmez+-O4R2U81g-Vvfg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, libvir-list <libvir-list@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Kaplansky, Victor" <victork@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On Wed, Oct 31, 2018 at 07:44:36PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Oct 16, 2018 at 4:14 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > > It just reinvents the chardev unix socket syntax, but in a
> > > > different adhoc manner, which is repeating the mistake we have
> > > > made time & again in QEMU. Using QAPI we can directly accept
> > > > the ChardevSocket syntax we already know about. Instead of
> > > > having --socket-path and --fd and documenting that they are
> > > > mutually exclusive ChardevSocket QAPI schema provides that
> > > > representation in a well defined format which is discoverable
> > > > and QEMU and mgmt apps already understand.
> > >
> > > That would require external vhost-user backends to implement QAPI/j=
son
> > > parsing. Is this necessary for a vhost-user backend? I doubt it.
> >
> > They could, but would not be required, to implement QAPI/json parser.
> >
> > The QAPI schema defines a standard for how to model & interpret the
> > non-scalar values for command line arguments. An external impl would
> > need to ensure that whatever parsing it does for CLI args is semantic=
ally
> > compatible with the parsing rules defined by the QEMU QAPI schema we
> > define to ensure interoperability of its impl.
>=20
> So you would want to have something like?
>=20
> --chardev '{ "id" : "bar", "backend" : { "type" : "socket", "data" : {
> "addr" : { "type": "unix", "path": "/tmp/foo.sock" }, "server":
> "false"  } } }'

I wasn't specificially suggesting json syntax. Just the flattened
dot separate syntax, whose valid components are mapped to corresponding
qapi schema defintions. eg closer to what we have already today

  --chardev socket,id=3Dbar,path=3D/tmp/foo.sock,server

>
> instead of:
>=20
> --socket-path=3D/tmp/foo.sock
>=20
> I don't really get what that will help with, for the vhost-user backend=
 case...

It avoids presuming that we forever want to launch the backend with
a single socket path and nothing else. Using the chardev, means we
can choosen between client/server mode. We can choose whether to
pass an FD to the socket, instead of the socket path. Whether the
reconnect flag is set or not, and all the other aspects of a chardev
you can define.

I don't think we should have to add more & more adhoc CLI args (--socket-=
path,
--fd, --reconnect, etc) and then manually parse them & pack their values
together into a chardev object.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
