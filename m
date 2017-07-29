Received: from eggs.gnu.org ([2001:4830:134:3::10]:42304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dbIJm-0000Eo-7A
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 23:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dbIJi-0003dC-31
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 23:21:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:23386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1dbIJh-0003Z1-No
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 23:21:26 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Sat, 29 Jul 2017 03:21:16 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B59D340@SHSMSX103.ccr.corp.intel.com>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
	<20170728103557.GB11097@stefanha-x1.localdomain>
In-Reply-To: <20170728103557.GB11097@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Friday, July 28, 2017 6:36 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> mst@redhat.com
> Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-blk h=
ost device
>=20
> On Thu, Jul 27, 2017 at 10:08:49AM +0000, Liu, Changpeng wrote:
> > > -----Original Message-----
> > > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > > Sent: Thursday, July 27, 2017 5:49 PM
> > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> > > mst@redhat.com
> > > Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-b=
lk host
> > > device
> > >
> > > On Thu, Jul 27, 2017 at 12:29:45AM +0000, Liu, Changpeng wrote:
> > > > > > +    .fields =3D (VMStateField[]) {
> > > > > > +        VMSTATE_VIRTIO_DEVICE,
> > > > > > +        VMSTATE_END_OF_LIST()
> > > > > > +    },
> > > > > > +};
> > > > > > +
> > > > > > +static Property vhost_user_blk_properties[] =3D {
> > > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > > +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),
> > > > >
> > > > > DEFINE_BLOCK_PROPERTIES cannot be used directly because it includ=
es the
> > > > > 'drive' (blkcfg.blk) parameter.  The command-line should not allo=
w a
> > > > > drive=3D parameter.
> > > > >
> > > > > Also, parameters like the discard granularity, optimal I/O size, =
logical
> > > > > block size, etc can be initialized to sensible defaults by QEMU's=
 block
> > > > > layer when drive=3D is used.  Since you are bypassing QEMU's bloc=
k layer
> > > > > there is no way for QEMU to set good defaults.
> > > > >
> > > > > Are you relying on the managment tools populating these parameter=
s with
> > > > > the correct values from the vhost-user-blk process?  Or did you h=
ave
> > > > > some other mechanism in mind?
> > > > Actually for this part and your comments about block resize, I thin=
k maybe
> add
> > > several
> > > > additional vhost user messages such like:
> > > VHOST_USER_GET_BLK_CFG/VHOST_USER_SET_BLK_CFG
> > > > makes the code more clear, I'm okay to add such messages.
> > >
> > > New messages for virtio config space read/write might be useful for
> > > other devices besides virtio-blk.
> > I mean all the block device information like: block_size/capacity are s=
tored in
> another process,
> > so add a new vhost user message to Qemu vhost-user-blk can get those
> information when Qemu get
> > started, once those messages stored to virtio_pci config space, we will=
 not
> change it.
>=20
> No, I think updates are necessary:
>=20
> The virtio block device can do online disk resize, so it will be
> necessary to change the capacity field from the vhost-user-blk process
> at runtime and raise a config change notification interrupt.
>=20
> The virtio block device also has a config space field ("wce") that is
> writable by the guest.  Supporting this feature also requires virtio
> config space support in vhost-user.
>=20
> If you focus on adding generic virtio config space messages to
> vhost-user then these virtio block features can be supported by
> vhost-user-blk.
>=20
> Regarding the two approaches of adding "block device information" as you
> have suggested versus adding generic virtio config space support as I'm
> suggesting, from a protocol design perspective it's nicer to have
> generic messages that are usable by all device types.  I'm not aware of
> a reason why high-level "block device information" is needed since QEMU
> will just put that into the config space but otherwise does not
> interpret the information.
Agreed, adding a vhost message  to get/set generic vitio_pci device config =
space=20
is clear to me now, it's better than only for vhost-user-blk messages.

Here I still have an concern about *resize* feature for vhost-user-blk, cur=
rently
Qemu vhost-user-blk is the client for vhost user messages, does this means
the I/O processing process must send a new vhost message back to Qemu
vhost-user-blk driver that the capacity of the block device is changed? Or =
you
have better idea to do this? Thanks.
>=20
> > > It's worth checking how virtio config space is live migrated and how =
to
> > > do that consistently if the vhost-user process is involved.
> > Virtio will config spaces for virtio_blk, and even the config space mig=
rated to
> another machine, it should be
> > same with the another I/O process, did I get your comments ? Thanks.
>=20
> The guest-writable "wce" config space field is an example that shows the
> vhost-user-blk process on the destination host does not have all the
> state necessary.  QEMU needs to migrate the config space and send it to
> the vhost-user-blk process on the destination.
>=20
> Stefan
