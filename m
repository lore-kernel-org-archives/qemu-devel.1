Received: from eggs.gnu.org ([2001:4830:134:3::10]:37178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dafjF-0000b2-Cx
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dafjB-0000GM-9D
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:09:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:63581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1dafjA-0000Au-W1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:09:09 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Thu, 27 Jul 2017 10:08:49 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
In-Reply-To: <20170727094836.GB10129@stefanha-x1.localdomain>
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
> Sent: Thursday, July 27, 2017 5:49 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> mst@redhat.com
> Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-blk h=
ost
> device
>=20
> On Thu, Jul 27, 2017 at 12:29:45AM +0000, Liu, Changpeng wrote:
> > > > +    .fields =3D (VMStateField[]) {
> > > > +        VMSTATE_VIRTIO_DEVICE,
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    },
> > > > +};
> > > > +
> > > > +static Property vhost_user_blk_properties[] =3D {
> > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),
> > >
> > > DEFINE_BLOCK_PROPERTIES cannot be used directly because it includes t=
he
> > > 'drive' (blkcfg.blk) parameter.  The command-line should not allow a
> > > drive=3D parameter.
> > >
> > > Also, parameters like the discard granularity, optimal I/O size, logi=
cal
> > > block size, etc can be initialized to sensible defaults by QEMU's blo=
ck
> > > layer when drive=3D is used.  Since you are bypassing QEMU's block la=
yer
> > > there is no way for QEMU to set good defaults.
> > >
> > > Are you relying on the managment tools populating these parameters wi=
th
> > > the correct values from the vhost-user-blk process?  Or did you have
> > > some other mechanism in mind?
> > Actually for this part and your comments about block resize, I think ma=
ybe add
> several
> > additional vhost user messages such like:
> VHOST_USER_GET_BLK_CFG/VHOST_USER_SET_BLK_CFG
> > makes the code more clear, I'm okay to add such messages.
>=20
> New messages for virtio config space read/write might be useful for
> other devices besides virtio-blk.
I mean all the block device information like: block_size/capacity are store=
d in another process,=20
so add a new vhost user message to Qemu vhost-user-blk can get those inform=
ation when Qemu get
started, once those messages stored to virtio_pci config space, we will not=
 change it.
>=20
> It's worth checking how virtio config space is live migrated and how to
> do that consistently if the vhost-user process is involved.
Virtio will config spaces for virtio_blk, and even the config space migrate=
d to another machine, it should be
same with the another I/O process, did I get your comments ? Thanks.=20
>=20
> Stefan
