Received: from eggs.gnu.org ([2001:4830:134:3::10]:60679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZgQz-0007rX-HD
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZgQv-0004ke-JF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZgQv-0004kH-9w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:19:01 -0500
Date: Wed, 19 Dec 2018 13:18:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219131256-mutt-send-email-mst@kernel.org>
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
	<CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
	<20181218152520.GB4807@redhat.com>
	<20181218104351-mutt-send-email-mst@kernel.org>
	<20181218160919.GD4807@redhat.com>
	<20181219105418-mutt-send-email-mst@kernel.org>
	<20181219160102.GL20465@redhat.com>
	<20181219114920-mutt-send-email-mst@kernel.org>
	<20181219170909.GO20465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181219170909.GO20465@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 1/7] chardev: Add disconnected
 option for chardev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, elohimes@gmail.com, zhangyu31@baidu.com, xieyongji@baidu.com, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, nixun@baidu.com

On Wed, Dec 19, 2018 at 05:09:09PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Dec 19, 2018 at 11:50:38AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 19, 2018 at 04:01:02PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Wed, Dec 19, 2018 at 10:55:09AM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 18, 2018 at 04:09:19PM +0000, Daniel P. Berrang=E9 wr=
ote:
> > > > > On Tue, Dec 18, 2018 at 11:02:46AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > On Tue, Dec 18, 2018 at 03:25:20PM +0000, Daniel P. Berrang=E9=
 wrote:
> > > > > > > On Tue, Dec 18, 2018 at 04:24:26PM +0400, Marc-Andr=E9 Lure=
au wrote:
> > > > > > > > Hi
> > > > > > > >=20
> > > > > > > > On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrot=
e:
> > > > > > > > >
> > > > > > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > > > > > >
> > > > > > > > > New option "disconnected" is added to init the chardev =
socket
> > > > > > > > > in disconnected state. Then we can use qemu_chr_fe_wait=
_connected()
> > > > > > > > > to connect when necessary. Now it would be used for uni=
x domain
> > > > > > > > > socket of vhost-user-blk device to support reconnect.
> > > > > > > >=20
> > > > > > > > What difference does that make if you wait for connection=
 in
> > > > > > > > qemu_chr_fe_wait_connected(), or during chardev setup?
> > > > > > > >=20
> > > > > > > > "disconnected" is misleading, would it be possible to reu=
se
> > > > > > > > "wait/nowait" instead?
> > > > > > >=20
> > > > > > > Currently we default to doing a blocking connect in foregro=
und,
> > > > > > > except if reconnect is non-zero, in which case we do a conn=
ect
> > > > > > > async in the background. This "disconnected" proposal effec=
tively
> > > > > > > does a blocking connect, but delayed to later in startup.
> > > > > > >=20
> > > > > > > IOW, this could already be achieved if "reconnect" were set=
 to
> > > > > > > non-zero. If the usage doesn't want reconnect though, I ten=
d
> > > > > > > to agree that we should use the exisiting wait/nowait optio=
ns
> > > > > > > to let it be controlled. I don't see that this "disconnecte=
d"
> > > > > > > option gives a compelling benefit over using wait/nowait.
> > > > > >=20
> > > > > > So the tricky thing is that we can not expose the
> > > > > > device to guest until we get a connection and can query
> > > > > > it for the first time. After that is completed,
> > > > > > we can reasonably support disconnected operation at least for=
 net.
> > > > >=20
> > > > > The device code would still use  qemu_chr_fe_wait_connected() i=
n my proposal,
> > > > > so that its no different to the situation with the proposed "di=
sconnected"
> > > > > flag.
> > > > >=20
> > > > > Regards,
> > > > > Daniel
> > > >=20
> > > > I guess so, but wouldn't it be confusing to users that one says
> > > > "nowait" and qemu still waits for a connection and does not
> > > > run the VM? That's different from how nowait behaves normally.
> > >=20
> > > Well "nowait" is only referring to the chardev behaviour which is
> > > still an accurate description.
> >=20
> > man page seems to say
> >=20
> >            nowait specifies that QEMU should not block waiting
> >            for a client to connect to a listening socket.
> >=20
> > if we do wait for a client to connect then how is it accurate?
>=20
> Well the manpage needs to be clarified that this applies to the
> initialization of the chardev.  What a downstream objet/device
> does with the chardev is outside the scope of chardev config
> options.
>=20
> Regards,
> Daniel

Practically qemu blocks. I suspect the distinction which object
within qemu does it will be lost on users.

And it's not exactly about waiting anyway.
It's about whether we should stop the VM on disconnect
which I feel is different.

So I think we need a new flag along the lines of
	disconnect=3Dignore/exit/stop

with proper documentation.

> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
