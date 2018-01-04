Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEXQ-0002nL-LC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEXN-0003z9-M7
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eXEXN-0003yK-9K
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:03:01 -0500
Date: Fri, 5 Jan 2018 01:02:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180105010246-mutt-send-email-mst@kernel.org>
References: <1515030814-4621-1-git-send-email-changpeng.liu@intel.com>
	<CAJ+F1CLgVdZ62TwuTame-=oASSUR0fhgssLPuC5yZhtD9UiNiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLgVdZ62TwuTame-=oASSUR0fhgssLPuC5yZhtD9UiNiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 0/4] Introduce a new vhost-user-blk
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, QEMU <qemu-devel@nongnu.org>, james.r.harris@intel.com, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

On Thu, Jan 04, 2018 at 12:07:39PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Jan 4, 2018 at 2:53 AM, Changpeng Liu <changpeng.liu@intel.com>=
 wrote:
> > Although virtio scsi specification was designed as a replacement for =
virtio_blk,
> > there are still many users using virtio_blk. QEMU 2.9 introduced a ne=
w device
> > vhost user scsi which can process I/O in user space for virtio_scsi, =
this commit
> > introduces a new vhost user block host device, which can support virt=
io_blk in
> > Guest OS, and I/O processing in another I/O target.
> >
> > Due to the limitation for virtio_blk specification, virtio_blk device=
 cannot get
> > block information such as capacity, block size etc via the specificat=
ion, several
> > new vhost user messages were added to deliver virtio config space
> > information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_=
USER_SET_CONFIG
> > messages used for get/set config space from/to I/O target, VHOST_USER=
_SLAVE_CONFIG_CHANGE_MSG
> > slave message was added for the event notifier in case the change of =
virtio config space. Also,
> > those messages can be used for vhost device live migration as well.
> >
> > CHANGES:
> > v10: fix the code style error.
> > v8-v9: Several small optimization and code cleanup according to the c=
omments.
> > v7-v8: Instead using an event file descriptor for event notifier in c=
ase of virtio
> > configuration space changed, while here used a new vhost-user slave m=
essage to deliver
> > such event. Several small optimizations to address the comments from =
v7.
> > v6-v7: change the parameter of set configuration function let it only=
 contain valid data buffer.
> > v5-v6: add header flags for vhost-user master so that the slave can k=
now the purpose for
> > set config, also vhost-user get/set messages' payload doesn't contain=
 invalid data buffers.
> > v4-v5: add header offset and size for virtio config space.
> > v3-v4: refactoring the vhost user block example patch based on new li=
bvhost-user library.
> > v2-v3: add new vhost user message to get/set virtio config space.
> >
> > Changpeng Liu (4):
> >   vhost-user: add new vhost user messages to support virtio config sp=
ace
> >   vhost-user-blk: introduce a new vhost-user-blk host device
> >   contrib/libvhost-user: enable virtio config space messages
> >   contrib/vhost-user-blk: introduce a vhost-user-blk sample applicati=
on
>=20
> Series:
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Michael, do you take it?
> thanks

Plan to.
Thanks,

MST

> >
> >  .gitignore                              |   1 +
> >  Makefile                                |   3 +
> >  Makefile.objs                           |   1 +
> >  contrib/libvhost-user/libvhost-user.c   |  42 +++
> >  contrib/libvhost-user/libvhost-user.h   |  33 ++
> >  contrib/vhost-user-blk/Makefile.objs    |   1 +
> >  contrib/vhost-user-blk/vhost-user-blk.c | 545 ++++++++++++++++++++++=
++++++++++
> >  default-configs/pci.mak                 |   1 +
> >  docs/interop/vhost-user.txt             |  55 ++++
> >  hw/block/Makefile.objs                  |   3 +
> >  hw/block/vhost-user-blk.c               | 359 +++++++++++++++++++++
> >  hw/virtio/vhost-user.c                  | 118 +++++++
> >  hw/virtio/vhost.c                       |  32 ++
> >  hw/virtio/virtio-pci.c                  |  55 ++++
> >  hw/virtio/virtio-pci.h                  |  18 ++
> >  include/hw/virtio/vhost-backend.h       |  12 +
> >  include/hw/virtio/vhost-user-blk.h      |  41 +++
> >  include/hw/virtio/vhost.h               |  15 +
> >  18 files changed, 1335 insertions(+)
> >  create mode 100644 contrib/vhost-user-blk/Makefile.objs
> >  create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
> >  create mode 100644 hw/block/vhost-user-blk.c
> >  create mode 100644 include/hw/virtio/vhost-user-blk.h
> >
> > --
> > 1.9.3
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
