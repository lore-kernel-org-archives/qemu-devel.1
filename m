Received: from eggs.gnu.org ([2001:4830:134:3::10]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eHLEa-00079C-Bi
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eHLEX-0004x9-6G
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:57:56 -0500
Received: from [134.134.136.65] (port=53596 helo=mga03.intel.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eHLEW-0004wn-Sj
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:57:53 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 22 Nov 2017 02:28:31 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5DFC1B@SHSMSX103.ccr.corp.intel.com>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
	<20171120162631.GK4516@stefanha-x1.localdomain>
	<20171120224001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171120224001-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, November 21, 2017 4:45 AM
> To: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Liu, Changpeng <changpeng.liu@intel.com>; qemu-devel@nongnu.org;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; felipe@nutanix.com;
> Harris, James R <james.r.harris@intel.com>
> Subject: Re: [PATCH v5 1/4] vhost-user: add new vhost user messages to su=
pport
> virtio config space
>=20
> On Mon, Nov 20, 2017 at 04:26:31PM +0000, Stefan Hajnoczi wrote:
> > On Fri, Nov 17, 2017 at 04:44:37AM +0800, Changpeng Liu wrote:
> > > Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which
> can be
> > > used for live migration of vhost user devices, also vhost user device=
s
> > > can benefit from the messages to get/set virtio config space from/to =
the
> > > I/O target. For the purpose to support virtio config space change,
> > > VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> > > in case virtio config space change in the I/O target.
> > >
> > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > ---
> > >  docs/interop/vhost-user.txt       | 39 ++++++++++++++++
> > >  hw/virtio/vhost-user.c            | 98
> +++++++++++++++++++++++++++++++++++++++
> > >  hw/virtio/vhost.c                 | 63 +++++++++++++++++++++++++
> > >  include/hw/virtio/vhost-backend.h |  8 ++++
> > >  include/hw/virtio/vhost.h         | 16 +++++++
> > >  5 files changed, 224 insertions(+)
> > >
> > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
> > > index 954771d..1b98388 100644
> > > --- a/docs/interop/vhost-user.txt
> > > +++ b/docs/interop/vhost-user.txt
> > > @@ -116,6 +116,16 @@ Depending on the request type, payload can be:
> > >      - 3: IOTLB invalidate
> > >      - 4: IOTLB access fail
> > >
> > > + * Virtio device config space
> > > +   ---------------------------
> > > +   | offset | size | payload |
> > > +   ---------------------------
> > > +
> > > +   Offset: a 32-bit offset of virtio device's configuration space
> >
> > s/of/in the/
> >
> > > +   Size: a 32-bit size of configuration space that master wanted to =
change
> >
> > Is this also used for GET_CONFIG?  If yes, I suggest "a 32-bit
> > configuration space access size in bytes".
> >
> > Please mention that Size must be <=3D 256 bytes.
> >
> > > +   Payload: a 256-bytes array holding the contents of the virtio
> > > +       device's configuration space
> >
> > What about bytes outside the [offset, offset+size) range?  I guess they
> > must be 0 and are ignored by the master/slave.
> >
> > Would it be cleaner to make Payload a variable-sized field with Size
> > bytes?  That way it's not necessary to transfer 0s and memcpy() a subse=
t
> > of the payload array.
> >
> > > +
> > >  In QEMU the vhost-user message is implemented with the following str=
uct:
> > >
> > >  typedef struct VhostUserMsg {
> > > @@ -129,6 +139,7 @@ typedef struct VhostUserMsg {
> > >          VhostUserMemory memory;
> > >          VhostUserLog log;
> > >          struct vhost_iotlb_msg iotlb;
> > > +        VhostUserConfig config;
> > >      };
> > >  } QEMU_PACKED VhostUserMsg;
> > >
> > > @@ -596,6 +607,34 @@ Master message types
> > >        and expect this message once (per VQ) during device configurat=
ion
> > >        (ie. before the master starts the VQ).
> > >
> > > + * VHOST_USER_GET_CONFIG
> > > +      Id: 24
> > > +      Equivalent ioctl: N/A
> > > +      Master payload: virtio device config space
> > > +
> > > +      Submitted by the vhost-user master to fetch the contents of th=
e virtio
> > > +      device configuration space. The vhost-user master may cache th=
e contents
> > > +      to avoid repeated VHOST_USER_GET_CONFIG calls.
> > > +
> > > +* VHOST_USER_SET_CONFIG
> > > +      Id: 25
> > > +      Equivalent ioctl: N/A
> > > +      Master payload: virtio device config space
> > > +
> > > +      Submitted by the vhost-user master when the Guest changes the =
virtio
> > > +      device configuration space and also can be used for live migra=
tion
> > > +      on the destination host.
> >
> > There might be security issues if the vhost slave cannot tell whether
> > SET_CONFIG is coming from the guest driver or from the master process
> > (live migration).  Typically certain fields are read-only for the guest
> > driver.  Maybe those fields need to be set by the master after live
> > migration.
> >
> > One way to solve this is adding a flags field to the message.  A specia=
l
> > flag can be used for live migration so the slave knows that this
> > SET_CONFIG message is allowed to write to read-only fields.
> >
> > It's also worth documenting that slaves MUST NOT accept SET_CONFIG for
> > read-only configuration space fields unless the live migration bit is
> > set.  Hopefully this will remind implementors to think through the
> > security issues.
>=20
> Live migrations is supposed to be migrating guest writeable state too.
> If you mean migrating RO fields like size, then
> I don't think it's a good idea to reuse SET_CONFIG for that.
> SET_CONFIG should obey exactly the virtio semantics.
>=20
> And I agree, it should say that slave must treat it as a write,
> and get config as a read according to virtio semantics.
>=20
> If someone needs to pass configuration from qemu to
> slave, let's add specific messages with precisely defined semantics.
>=20
> Which reminds me.
>=20
> virtio 1 changed endian-ness for config.
>=20
> I think we should specify it's all virtio 1 format, and
> just disallow vhost blk for virtio 0 guests.
Will add the limitation to this txt file.
>=20
> --
> MST
