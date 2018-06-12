Received: from eggs.gnu.org ([2001:4830:134:3::10]:45834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSYsH-0005lR-59
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSYsD-0002qe-TH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:17:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSYsD-0002oa-NV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:17:29 -0400
Date: Tue, 12 Jun 2018 05:17:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612051432-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com

On Tue, Jun 12, 2018 at 09:54:44AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 01:26, Michael S. Tsirkin wrote:
> > On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:
> > > This feature bit can be used by hypervisor to indicate virtio_net d=
evice to
> > > act as a standby for another device with the same MAC address.
> > >=20
> > > I tested this with a small change to the patch to mark the STANDBY =
feature 'true'
> > > by default as i am using libvirt to start the VMs.
> > > Is there a way to pass the newly added feature bit 'standby' to qem=
u via libvirt
> > > XML file?
> > >=20
> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > So I do not think we can commit to this interface: we
> > really need to control visibility of the primary device.
>=20
> The problem is legacy guest won't use primary device at all if we do th=
is.

And that's by design - I think it's the only way to ensure the
legacy guest isn't confused.

> How about control the visibility of standby device?
>=20
> Thanks

standy the always there to guarantee no downtime.

> > However just for testing purposes, we could add a non-stable
> > interface "x-standby" with the understanding that as any
> > x- prefix it's unstable and will be changed down the road,
> > likely in the next release.
> >=20
> >=20
> > > ---
> > >   hw/net/virtio-net.c                         | 2 ++
> > >   include/standard-headers/linux/virtio_net.h | 3 +++
> > >   2 files changed, 5 insertions(+)
> > >=20
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 90502fca7c..38b3140670 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D {
> > >                        true),
> > >       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_U=
NKNOWN),
> > >       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> > > +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_=
NET_F_STANDBY,
> > > +                      false),
> > >       DEFINE_PROP_END_OF_LIST(),
> > >   };
> > > diff --git a/include/standard-headers/linux/virtio_net.h b/include/=
standard-headers/linux/virtio_net.h
> > > index e9f255ea3f..01ec09684c 100644
> > > --- a/include/standard-headers/linux/virtio_net.h
> > > +++ b/include/standard-headers/linux/virtio_net.h
> > > @@ -57,6 +57,9 @@
> > >   					 * Steering */
> > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > > +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for anot=
her device
> > > +                                         * with the same MAC.
> > > +                                         */
> > >   #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and =
duplex */
> > >   #ifndef VIRTIO_NET_NO_LEGACY
> > > --=20
> > > 2.14.3
