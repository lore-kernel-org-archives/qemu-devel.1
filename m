Received: from eggs.gnu.org ([2001:4830:134:3::10]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gEwEh-0005g8-Qe
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gEwEg-0003e1-Tn
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:56:39 -0400
Date: Tue, 23 Oct 2018 08:56:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023085603-mutt-send-email-mst@kernel.org>
References: <20181012090752.31891-1-yuchenlin@synology.com>
	<d8051b2fc349d58dcd98cd383ae6bf32@synology.com>
	<75b2d7f3-88d3-b79c-e808-c21dcf661174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <75b2d7f3-88d3-b79c-e808-c21dcf661174@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-scsi: prevent using uninitialized vqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: yuchenlin <yuchenlin@synology.com>, Forrest Liu <forrestl@synology.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, Oct 23, 2018 at 01:49:16AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 22/10/18 4:17, yuchenlin via Qemu-devel wrote:
> > Ping?
> >=20
> > On 2018-10-12 17:07, yuchenlin@synology.com wrote:
> > > From: yuchenlin <yuchenlin@synology.com>
> > >=20
> > > There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device=
,
> > > but seabios will only set the physical address for the 3rd one (cmd=
).
> > > Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr()
> > > will be 0 for ctrl and event vq.
> > >=20
> > > In this case, ctrl and event vq are not initialized.
> > > vhost_verify_ring_mappings may use uninitialized vhost_virtqueue
> > > such that vhost_verify_ring_part_mapping returns ENOMEM.
> > >=20
> > > When encountered this problem, we got the following logs:
> > >=20
> > > =A0=A0=A0 qemu-system-x86_64: Unable to map available ring for ring=
 0
> > > =A0=A0=A0 qemu-system-x86_64: Verify ring failure on region 0
> > >=20
> > > Signed-off-by: Forrest Liu <forrestl@synology.com>
> > > Signed-off-by: yuchenlin <yuchenlin@synology.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks I will queue this.

> > > ---
> > > =A0hw/scsi/vhost-scsi.c | 2 +-
> > > =A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > > index becf550085..7f21b4f9d6 100644
> > > --- a/hw/scsi/vhost-scsi.c
> > > +++ b/hw/scsi/vhost-scsi.c
> > > @@ -183,7 +183,7 @@ static void vhost_scsi_realize(DeviceState *dev=
,
> > > Error **errp)
> > > =A0=A0=A0=A0 }
> > >=20
> > > =A0=A0=A0=A0 vsc->dev.nvqs =3D VHOST_SCSI_VQ_NUM_FIXED + vs->conf.n=
um_queues;
> > > -=A0=A0=A0 vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.=
nvqs);
> > > +=A0=A0=A0 vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev=
.nvqs);
> > > =A0=A0=A0=A0 vsc->dev.vq_index =3D 0;
> > > =A0=A0=A0=A0 vsc->dev.backend_features =3D 0;
> >=20
> >=20
