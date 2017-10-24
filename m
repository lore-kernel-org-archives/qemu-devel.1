Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e6nSQ-0002Qh-1V
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e6nSM-00058L-3I
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:52:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:35175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1e6nSL-00057Y-Nf
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:52:33 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 24 Oct 2017 00:52:28 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5D9216@SHSMSX103.ccr.corp.intel.com>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-2-git-send-email-changpeng.liu@intel.com>
	<20171019140935.GG6205@stefanha-x1.localdomain>
	<20171019183147-mutt-send-email-mst@kernel.org>
	<20171020100051.GE21393@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8ED5@SHSMSX103.ccr.corp.intel.com>
	<20171023172611.GC15029@stefanha-x1.localdomain>
In-Reply-To: <20171023172611.GC15029@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Tuesday, October 24, 2017 1:26 AM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>; qemu-devel@nongnu.org;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; felipe@nutanix.com;
> Harris, James R <james.r.harris@intel.com>
> Subject: Re: [PATCH v4 1/4] vhost-user: add new vhost user messages to su=
pport
> virtio config space
>=20
> On Mon, Oct 23, 2017 at 04:47:00AM +0000, Liu, Changpeng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > > Sent: Friday, October 20, 2017 6:01 PM
> > > To: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Liu, Changpeng <changpeng.liu@intel.com>; qemu-devel@nongnu.org;
> > > pbonzini@redhat.com; marcandre.lureau@redhat.com; felipe@nutanix.com;
> > > Harris, James R <james.r.harris@intel.com>
> > > Subject: Re: [PATCH v4 1/4] vhost-user: add new vhost user messages t=
o
> support
> > > virtio config space
> > >
> > > On Thu, Oct 19, 2017 at 06:36:00PM +0300, Michael S. Tsirkin wrote:
> > > > On Thu, Oct 19, 2017 at 04:09:35PM +0200, Stefan Hajnoczi wrote:
> > > > > On Thu, Oct 19, 2017 at 01:24:07PM +0800, Changpeng Liu wrote:
> > > > > > @@ -922,6 +931,91 @@ static void vhost_user_set_iotlb_callback(=
struct
> > > vhost_dev *dev, int enabled)
> > > > > >      /* No-op as the receive channel is not dedicated to IOTLB =
messages.
> */
> > > > > >  }
> > > > > >
> > > > > > +static int vhost_user_get_config(struct vhost_dev *dev, uint8_=
t *config,
> > > > > > +                                 size_t config_len)
> > > > > > +{
> > > > > > +    VhostUserMsg msg =3D {
> > > > > > +        .request =3D VHOST_USER_GET_CONFIG,
> > > > > > +        .flags =3D VHOST_USER_VERSION,
> > > > > > +        .size =3D config_len,
> > > > > > +    };
> > > > > > +
> > > > > > +    if (config_len =3D=3D 0 || config_len > VHOST_USER_PAYLOAD=
_SIZE) {
> > > > >
> > > > > config_len should be limited to 256 bytes:
> > > > >
> > > > >   if (config_len =3D=3D 0 || config_len > sizeof(msg.payload.conf=
ig) {
> > > >
> > > > I would just limit it to a reasonable value, acceptable to
> > > > both master and slave, not fail if it's bigger.
> > > >
> > > >
> > > > > > +        error_report("bad config length");
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (vhost_user_read(dev, &msg) < 0) {
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (msg.request !=3D VHOST_USER_GET_CONFIG) {
> > > > > > +        error_report("Received unexpected msg type. Expected %=
d
> > > received %d",
> > > > > > +                     VHOST_USER_GET_CONFIG, msg.request);
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (msg.size !=3D config_len) {
> > > > > > +        error_report("Received bad msg size.");
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +
> > > > > > +    memcpy(config, &msg.payload.config, config_len);
> > > > >
> > > > > There is some complexity here: different virtio devices use diffe=
rent
> > > > > amounts of config space.  Devices may append new fields to the co=
nfig
> > > > > space to support new features.
> > > > >
> > > > > Therefore I think the simplest protocol is to always fetch the fu=
ll
> > > > > 256-byte configuration space.  This way the vhost-user slave proc=
ess can
> > > > > implement feature bits that the master process does not know abou=
t.
> > > > >
> > > > > In other words, I don't think the master process knows how much o=
f the
> > > > > config space is used so it should always request 256 bytes.
> > > >
> > > > Each device knows the max config space size.
> > > >
> > > >     vdev->config_len =3D config_size;
> > >
> > > I see you're referring to the field that is set in:
> > >
> > >   void virtio_init(VirtIODevice *vdev, const char *name,
> > >                    uint16_t device_id, size_t config_size)
> > >
> > > How does this work for vhost-user where different slave programs may
> > > offer different config sizes?
> > Each Qemu vhost controller e.g: vhost-user-scsi-pci and vhost-user-blk-=
pci
> should has different char devices,
> > so vhost-slave knows those messages are from vhost-scsi or vhost-blk, o=
f
> course, each UNIX domain socket
> > should be assigned by users with types: vhsot-scsi or vhost-blk.
>=20
> We're talking about different things.  Here is an example illustrating
> my question:
>=20
> vhost-user-blk slave A only knows about struct virtio_blk_config fields
> up to wce (VIRTIO 1.0).  See
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#=
x1-
> 2070004.
>=20
> vhost-user-blk slave B implements struct virtio_blk_config with the new
> num_queues field.  See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/u
> api/linux/virtio_blk.h#n56.
>=20
> Slaves A and B use different struct virtio_blk_config sizes!
>=20
> Which config size should the vhost-master use?  There is currently no
> way to query the size from the slave.
>=20
> What should slave programs do when the master requests configuration
> space data that is the wrong size?
>=20
> I think the simplest answer is that the master always uses 256 bytes.
> Slaves also keep the full 256 bytes stored but their device
> implementation may access fewer bytes.
Yes, clear now. How about the following configuration:
struct vhost_dev_config {
    unsigned int offset;
    unsigned int size;
    uint8_t    config[256];
};
The master always uses 256 Bytes, but with additional 2 parameters to locat=
e detailed configuration fields, I think this combined
Michael and your comments about this patch.=20
>=20
> > > The QEMU master process does not know the correct size ahead of time.
> > > The size depends on the vhost-user slave process.  This is why I sugg=
est
> > > using the full 256 bytes that the VIRTIO spec defines.
