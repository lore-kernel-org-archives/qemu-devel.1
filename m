Received: from eggs.gnu.org ([2001:4830:134:3::10]:35326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fShso-0001jy-1Z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fShsj-0003KB-Oy
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:54:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fShsj-0003Ja-IR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:54:37 -0400
Date: Tue, 12 Jun 2018 14:54:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612144743-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
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
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org

On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 20:33, Michael S. Tsirkin wrote:
> > I don't think this is sufficient.
> >=20
> > If both primary and standby devices are present, a legacy guest witho=
ut
> > support for the feature might see two devices with same mac and get
> > confused.
> >=20
> > I think that we should only make primary visible after guest acked th=
e
> > backup feature bit.
>=20
> I think we want exactly the reverse? E.g fail the negotiation when gues=
t
> does not ack backup feature.
>=20
> Otherwise legacy guest won't even have the chance to see primary device=
 in
> the guest.

That's by design.

> >=20
> > And on reset or when backup is cleared in some other way, unplug the
> > primary.
>=20
> What if guest does not support hotplug?

It shouldn't ack the backup feature then and it's a good point.
We should both document this and check kernel config has
hotplug support. Sridhar could you take a look pls?

> >=20
> > Something like the below will do the job:
> >=20
> > Primary device is added with a special "primary-failover" flag.
> > A virtual machine is then initialized with just a standby virtio
> > device. Primary is not yet added.
>=20
> A question is how to do the matching? Qemu knows nothing about e.g mac
> address of a pass-through device I believe?

Supply a flag to the VFIO when it's added, this way QEMU will know.

> >=20
> > Later QEMU detects that guest driver device set DRIVER_OK.
> > It then exposes the primary device to the guest, and triggers
> > a device addition event (hot-plug event) for it.
>=20
> Do you mean we won't have primary device in the initial qemu cli?

No, that's not what I mean.

I mean management will supply a flag to VFIO and then


- VFIO defers exposing
primary to guest until guest acks the feature bit.
- When we see guest ack, initiate hotplug.
- On reboot, hide it again.
- On reset without reboot, request hot-unplug and on eject hide it again.


> >=20
> > If QEMU detects guest driver removal, it initiates a hot-unplug seque=
nce
> > to remove the primary driver.  In particular, if QEMU detects guest
> > re-initialization (e.g. by detecting guest reset) it immediately remo=
ves
> > the primary device.
>=20
> I believe guest failover module should handle this gracefully?

It can't control enumeration order, if primary is enumerated before
standby then guest will load its driver and it's too late
when failover driver is loaded.

> Thanks
>=20
> >=20
> > We can move some of this code to management as well, architecturally =
it
> > does not make too much sense but it might be easier implementation-wi=
se.
> >=20
> > HTH
> >=20
> > On Mon, Jun 04, 2018 at 06:41:48PM -0700, Samudrala, Sridhar wrote:
> > > Ping on this patch now that the kernel patches are accepted into da=
vem's net-next tree.
> > > https://patchwork.ozlabs.org/cover/920005/
> > >=20
> > >=20
> > > On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> > > > This feature bit can be used by hypervisor to indicate virtio_net=
 device to
> > > > act as a standby for another device with the same MAC address.
> > > >=20
> > > > I tested this with a small change to the patch to mark the STANDB=
Y feature 'true'
> > > > by default as i am using libvirt to start the VMs.
> > > > Is there a way to pass the newly added feature bit 'standby' to q=
emu via libvirt
> > > > XML file?
> > > >=20
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > ---
> > > >    hw/net/virtio-net.c                         | 2 ++
> > > >    include/standard-headers/linux/virtio_net.h | 3 +++
> > > >    2 files changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 90502fca7c..38b3140670 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D=
 {
> > > >                         true),
> > > >        DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEE=
D_UNKNOWN),
> > > >        DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_st=
r),
> > > > +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTI=
O_NET_F_STANDBY,
> > > > +                      false),
> > > >        DEFINE_PROP_END_OF_LIST(),
> > > >    };
> > > > diff --git a/include/standard-headers/linux/virtio_net.h b/includ=
e/standard-headers/linux/virtio_net.h
> > > > index e9f255ea3f..01ec09684c 100644
> > > > --- a/include/standard-headers/linux/virtio_net.h
> > > > +++ b/include/standard-headers/linux/virtio_net.h
> > > > @@ -57,6 +57,9 @@
> > > >    					 * Steering */
> > > >    #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > > > +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for an=
other device
> > > > +                                         * with the same MAC.
> > > > +                                         */
> > > >    #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed a=
nd duplex */
> > > >    #ifndef VIRTIO_NET_NO_LEGACY
