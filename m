Received: from eggs.gnu.org ([2001:4830:134:3::10]:36654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gI8PG-0005HJ-B7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gI8PC-0004NM-4E
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:32:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gI8PB-0004M4-TL
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:32:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so20177536qtj.12
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<CAMxuvawbr3i5d6dfaobcfOD3gvFNnR_vEzws6kmGUG+GBaJaOg@mail.gmail.com>
	<20181012095554.GV16720@redhat.com>
	<CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
	<20181016121438.GD7995@redhat.com>
	<CAMxuvayaPxq1EJATVVsQUvA1bktUoUPZmez+-O4R2U81g-Vvfg@mail.gmail.com>
	<20181031160430.GN9625@redhat.com>
In-Reply-To: <20181031160430.GN9625@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 1 Nov 2018 12:32:27 +0400
Message-ID: <CAMxuvaxVAqo1X2-xrQZxkwsUNF6ArScQ-wF3VmS1r8xKzDx3AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, libvir-list <libvir-list@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Kaplansky,
	Victor" <victork@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

Hi

On Wed, Oct 31, 2018 at 8:05 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Oct 31, 2018 at 07:44:36PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Oct 16, 2018 at 4:14 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > > > It just reinvents the chardev unix socket syntax, but in a
> > > > > different adhoc manner, which is repeating the mistake we have
> > > > > made time & again in QEMU. Using QAPI we can directly accept
> > > > > the ChardevSocket syntax we already know about. Instead of
> > > > > having --socket-path and --fd and documenting that they are
> > > > > mutually exclusive ChardevSocket QAPI schema provides that
> > > > > representation in a well defined format which is discoverable
> > > > > and QEMU and mgmt apps already understand.
> > > >
> > > > That would require external vhost-user backends to implement QAPI/j=
son
> > > > parsing. Is this necessary for a vhost-user backend? I doubt it.
> > >
> > > They could, but would not be required, to implement QAPI/json parser.
> > >
> > > The QAPI schema defines a standard for how to model & interpret the
> > > non-scalar values for command line arguments. An external impl would
> > > need to ensure that whatever parsing it does for CLI args is semantic=
ally
> > > compatible with the parsing rules defined by the QEMU QAPI schema we
> > > define to ensure interoperability of its impl.
> >
> > So you would want to have something like?
> >
> > --chardev '{ "id" : "bar", "backend" : { "type" : "socket", "data" : {
> > "addr" : { "type": "unix", "path": "/tmp/foo.sock" }, "server":
> > "false"  } } }'
>
> I wasn't specificially suggesting json syntax. Just the flattened
> dot separate syntax, whose valid components are mapped to corresponding
> qapi schema defintions. eg closer to what we have already today
>
>   --chardev socket,id=3Dbar,path=3D/tmp/foo.sock,server
>

ok

> >
> > instead of:
> >
> > --socket-path=3D/tmp/foo.sock
> >
> > I don't really get what that will help with, for the vhost-user backend=
 case...
>
> It avoids presuming that we forever want to launch the backend with
> a single socket path and nothing else. Using the chardev, means we
> can choosen between client/server mode. We can choose whether to
> pass an FD to the socket, instead of the socket path. Whether the
> reconnect flag is set or not, and all the other aspects of a chardev
> you can define.
>

We are trying to define a common specification for vhost-user
backends. Where do we stop defining what --chardev should support?

> I don't think we should have to add more & more adhoc CLI args (--socket-=
path,
> --fd, --reconnect, etc) and then manually parse them & pack their values
> together into a chardev object.

The backends most likely won't use qemu chardev (nor qapi), and be
limited to unix socket.


>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
