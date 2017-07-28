Received: from eggs.gnu.org ([2001:4830:134:3::10]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db2cp-0004TP-Ls
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db2cm-00015v-Vf
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db2cm-00011P-MF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:36:04 -0400
Date: Fri, 28 Jul 2017 11:35:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170728103557.GB11097@stefanha-x1.localdomain>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
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
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 10:08:49AM +0000, Liu, Changpeng wrote:
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Thursday, July 27, 2017 5:49 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> > mst@redhat.com
> > Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-blk=
 host
> > device
> >=20
> > On Thu, Jul 27, 2017 at 12:29:45AM +0000, Liu, Changpeng wrote:
> > > > > +    .fields =3D (VMStateField[]) {
> > > > > +        VMSTATE_VIRTIO_DEVICE,
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    },
> > > > > +};
> > > > > +
> > > > > +static Property vhost_user_blk_properties[] =3D {
> > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),
> > > >
> > > > DEFINE_BLOCK_PROPERTIES cannot be used directly because it includes=
 the
> > > > 'drive' (blkcfg.blk) parameter.  The command-line should not allow a
> > > > drive=3D parameter.
> > > >
> > > > Also, parameters like the discard granularity, optimal I/O size, lo=
gical
> > > > block size, etc can be initialized to sensible defaults by QEMU's b=
lock
> > > > layer when drive=3D is used.  Since you are bypassing QEMU's block =
layer
> > > > there is no way for QEMU to set good defaults.
> > > >
> > > > Are you relying on the managment tools populating these parameters =
with
> > > > the correct values from the vhost-user-blk process?  Or did you have
> > > > some other mechanism in mind?
> > > Actually for this part and your comments about block resize, I think =
maybe add
> > several
> > > additional vhost user messages such like:
> > VHOST_USER_GET_BLK_CFG/VHOST_USER_SET_BLK_CFG
> > > makes the code more clear, I'm okay to add such messages.
> >=20
> > New messages for virtio config space read/write might be useful for
> > other devices besides virtio-blk.
> I mean all the block device information like: block_size/capacity are sto=
red in another process,=20
> so add a new vhost user message to Qemu vhost-user-blk can get those info=
rmation when Qemu get
> started, once those messages stored to virtio_pci config space, we will n=
ot change it.

No, I think updates are necessary:

The virtio block device can do online disk resize, so it will be
necessary to change the capacity field from the vhost-user-blk process
at runtime and raise a config change notification interrupt.

The virtio block device also has a config space field ("wce") that is
writable by the guest.  Supporting this feature also requires virtio
config space support in vhost-user.

If you focus on adding generic virtio config space messages to
vhost-user then these virtio block features can be supported by
vhost-user-blk.

Regarding the two approaches of adding "block device information" as you
have suggested versus adding generic virtio config space support as I'm
suggesting, from a protocol design perspective it's nicer to have
generic messages that are usable by all device types.  I'm not aware of
a reason why high-level "block device information" is needed since QEMU
will just put that into the config space but otherwise does not
interpret the information.

> > It's worth checking how virtio config space is live migrated and how to
> > do that consistently if the vhost-user process is involved.
> Virtio will config spaces for virtio_blk, and even the config space migra=
ted to another machine, it should be
> same with the another I/O process, did I get your comments ? Thanks.=20

The guest-writable "wce" config space field is an example that shows the
vhost-user-blk process on the destination host does not have all the
state necessary.  QEMU needs to migrate the config space and send it to
the vhost-user-blk process on the destination.

Stefan

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZexONAAoJEJykq7OBq3PIkwEH/RERzrdDzZab8VVHxEuB5ep8
5jvE7QzuPuPauVpMdS0QMxbfLtG0v+eOTxoEnNF+gb6a6mxEjEUPgSpcaLtJoVEY
RVxuT/JephSvUNr02O+ea3un3IXb6Y9ATHi4nuKi16aH5vRJa6IPyjrjyC78viMm
Hqj2W4bis0CMpoRxlON5xoZ8NbzlOLBms1cvtM1IdgAX9Z9LxLY2bWTIzJZBUHCb
gwGYuVaRWi5c645wKbfJLh3AROWtEmUTOevA6aUTNWp84QGqb6QucagtdjkoyAKq
DrG5UnhyJBN6oH7BoIiSUhlYAoTSnklyN9eNPOho58piBaY9CLZOxFzoAXeO56g=
=+NxV
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
