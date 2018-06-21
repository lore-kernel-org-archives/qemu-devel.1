Received: from eggs.gnu.org ([2001:4830:134:3::10]:33544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fW46D-0001Xd-6N
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fW469-0002SG-VQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fW469-0002R3-PH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:14:21 -0400
Date: Thu, 21 Jun 2018 21:14:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180621211359-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
	<c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
	<ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com>
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

On Wed, Jun 13, 2018 at 01:40:59PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 12:24, Samudrala, Sridhar wrote:
> > On 6/12/2018 7:38 PM, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 19:54, Michael S. Tsirkin wr=
ote:
> > > > On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
> > > > >=20
> > > > > On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 20:33, Michael S. Tsirki=
n wrote:
> > > > > > I don't think this is sufficient.
> > > > > >=20
> > > > > > If both primary and standby devices are present, a
> > > > > > legacy guest without
> > > > > > support for the feature might see two devices with same mac a=
nd get
> > > > > > confused.
> > > > > >=20
> > > > > > I think that we should only make primary visible after
> > > > > > guest acked the
> > > > > > backup feature bit.
> > > > > I think we want exactly the reverse? E.g fail the
> > > > > negotiation when guest
> > > > > does not ack backup feature.
> > > > >=20
> > > > > Otherwise legacy guest won't even have the chance to see
> > > > > primary device in
> > > > > the guest.
> > > > That's by design.
> > >=20
> > > So management needs to know the capability of guest to set the
> > > backup feature. This looks a chicken or egg problem to me.
> >=20
> > I don't think so. If the tenant requests 'accelerated datapath featur=
e',
> > the management
> > will set 'standby' feature bit on virtio-net interface and if the gue=
st
> > virtio-net driver
> > supports this feature, then the tenant VM will get that capability vi=
a a
> > hot-plugged
> > primary device.
>=20
> Ok, I thought exactly the reverse because of the commit title is "enabl=
e
> virtio_net to act as a standby for a passthru device". But re-read the
> commit log content, I understand the case a little bit. Btw, VF is not
> necessarily faster than virtio-net, especially consider virtio-net may =
have
> a lot of queues.

Don't do that then, right?

> >=20
> >=20
> > >=20
> > > >=20
> > > > > > And on reset or when backup is cleared in some other way, unp=
lug the
> > > > > > primary.
> > > > > What if guest does not support hotplug?
> > > > It shouldn't ack the backup feature then and it's a good point.
> > > > We should both document this and check kernel config has
> > > > hotplug support. Sridhar could you take a look pls?
> > > >=20
> > > > > > Something like the below will do the job:
> > > > > >=20
> > > > > > Primary device is added with a special "primary-failover" fla=
g.
> > > > > > A virtual machine is then initialized with just a standby vir=
tio
> > > > > > device. Primary is not yet added.
> > > > > A question is how to do the matching? Qemu knows nothing about =
e.g mac
> > > > > address of a pass-through device I believe?
> > > > Supply a flag to the VFIO when it's added, this way QEMU will kno=
w.
> > > >=20
> > > > > > Later QEMU detects that guest driver device set DRIVER_OK.
> > > > > > It then exposes the primary device to the guest, and triggers
> > > > > > a device addition event (hot-plug event) for it.
> > > > > Do you mean we won't have primary device in the initial qemu cl=
i?
> > > > No, that's not what I mean.
> > > >=20
> > > > I mean management will supply a flag to VFIO and then
> > > >=20
> > > >=20
> > > > - VFIO defers exposing
> > > > primary to guest until guest acks the feature bit.
> > > > - When we see guest ack, initiate hotplug.
> > > > - On reboot, hide it again.
> > > > - On reset without reboot, request hot-unplug and on eject hide
> > > > it again.
> > >=20
> > > This sounds much like a kind of bonding in qemu.
> > >=20
> > > >=20
> > > > > > If QEMU detects guest driver removal, it initiates a
> > > > > > hot-unplug sequence
> > > > > > to remove the primary driver.=C2=A0 In particular, if QEMU de=
tects guest
> > > > > > re-initialization (e.g. by detecting guest reset) it
> > > > > > immediately removes
> > > > > > the primary device.
> > > > > I believe guest failover module should handle this gracefully?
> > > > It can't control enumeration order, if primary is enumerated befo=
re
> > > > standby then guest will load its driver and it's too late
> > > > when failover driver is loaded.
> > >=20
> > > Well, even if we can delay the visibility of primary until
> > > DRIVER_OK, there still be a race I think? And it looks to me it's
> > > still a bug of guest:
> > >=20
> > > E.g primary could be probed before failover_register() in guest.
> > > Then we will miss the enslaving of primary forever.
> >=20
> > That is not an issue. Even if the primary is probed before failover
> > driver, it will
> > enslave the primary via the call to failover_existing_slave_register(=
)
> > as part of
> > failover_register() routine.
>=20
> Aha I get it. So the enumeration order is not an issue.
>=20
> Consider primary may still be seen by guest kernel even if we delay its
> visibility, I wonder whether we can control the lifecycle of primary th=
rough
> driver but not qemu. This can simplify a lot of things.
>=20
> Thanks
>=20
> >=20
> > >=20
> > > Thanks
> > >=20
> > > >=20
> > > > > Thanks
> > > > >=20
> > > > > > We can move some of this code to management as well,
> > > > > > architecturally it
> > > > > > does not make too much sense but it might be easier
> > > > > > implementation-wise.
> > > > > >=20
> > > > > > HTH
> > > > > >=20
> > > > > > On Mon, Jun 04, 2018 at 06:41:48PM -0700, Samudrala, Sridhar =
wrote:
> > > > > > > Ping on this patch now that the kernel patches are
> > > > > > > accepted into davem's net-next tree.
> > > > > > > https://patchwork.ozlabs.org/cover/920005/
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> > > > > > > > This feature bit can be used by hypervisor to
> > > > > > > > indicate virtio_net device to
> > > > > > > > act as a standby for another device with the same MAC add=
ress.
> > > > > > > >=20
> > > > > > > > I tested this with a small change to the patch
> > > > > > > > to mark the STANDBY feature 'true'
> > > > > > > > by default as i am using libvirt to start the VMs.
> > > > > > > > Is there a way to pass the newly added feature
> > > > > > > > bit 'standby' to qemu via libvirt
> > > > > > > > XML file?
> > > > > > > >=20
> > > > > > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel=
.com>
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0=C2=A0 hw/net/virtio-net.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > > > > > > > =C2=A0=C2=A0=C2=A0 include/standard-headers/linux/virtio_=
net.h | 3 +++
> > > > > > > > =C2=A0=C2=A0=C2=A0 2 files changed, 5 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > > > > index 90502fca7c..38b3140670 100644
> > > > > > > > --- a/hw/net/virtio-net.c
> > > > > > > > +++ b/hw/net/virtio-net.c
> > > > > > > > @@ -2198,6 +2198,8 @@ static Property virtio_net_properti=
es[] =3D {
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 true),
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_IN=
T32("speed", VirtIONet,
> > > > > > > > net_conf.speed, SPEED_UNKNOWN),
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_ST=
RING("duplex", VirtIONet,
> > > > > > > > net_conf.duplex_str),
> > > > > > > > +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT64("standby", VirtIONe=
t,
> > > > > > > > host_features, VIRTIO_NET_F_STANDBY,
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fal=
se),
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_EN=
D_OF_LIST(),
> > > > > > > > =C2=A0=C2=A0=C2=A0 };
> > > > > > > > diff --git
> > > > > > > > a/include/standard-headers/linux/virtio_net.h
> > > > > > > > b/include/standard-headers/linux/virtio_net.h
> > > > > > > > index e9f255ea3f..01ec09684c 100644
> > > > > > > > --- a/include/standard-headers/linux/virtio_net.h
> > > > > > > > +++ b/include/standard-headers/linux/virtio_net.h
> > > > > > > > @@ -57,6 +57,9 @@
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Steering */
> > > > > > > > =C2=A0=C2=A0=C2=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=
=A0=C2=A0=C2=A0 /* Set MAC address */
> > > > > > > > +#define VIRTIO_NET_F_STANDBY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 62=C2=A0=C2=A0=C2=A0 /* Act
> > > > > > > > as standby for another device
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with the same MAC.
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > =C2=A0=C2=A0=C2=A0 #define VIRTIO_NET_F_SPEED_DUPLEX 63=C2=
=A0=C2=A0=C2=A0 /*
> > > > > > > > Device set linkspeed and duplex */
> > > > > > > > =C2=A0=C2=A0=C2=A0 #ifndef VIRTIO_NET_NO_LEGACY
> > >=20
> >=20
