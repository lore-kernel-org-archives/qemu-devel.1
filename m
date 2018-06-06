Received: from eggs.gnu.org ([2001:4830:134:3::10]:35178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQdYe-0005d8-KJ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQdYa-0001K4-M8
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:53:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQdYa-0001Jp-GS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:53:16 -0400
Date: Wed, 6 Jun 2018 21:53:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180606214728-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
	<8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
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
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org, laine@redhat.com, libvir-list@redhat.com

On Wed, Jun 06, 2018 at 11:17:36AM -0700, Samudrala, Sridhar wrote:
> On 6/4/2018 7:06 PM, Jason Wang wrote:
> >=20
> >=20
> > On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 09:41, Samudrala, Sridhar wrot=
e:
> > > Ping on this patch now that the kernel patches are accepted into
> > > davem's net-next tree.
> > > https://patchwork.ozlabs.org/cover/920005/
> > >=20
> > >=20
> > > On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> > > > This feature bit can be used by hypervisor to indicate
> > > > virtio_net device to
> > > > act as a standby for another device with the same MAC address.
> > > >=20
> > > > I tested this with a small change to the patch to mark the
> > > > STANDBY feature 'true'
> > > > by default as i am using libvirt to start the VMs.
> > > > Is there a way to pass the newly added feature bit 'standby' to
> > > > qemu via libvirt
> > > > XML file?
> > > >=20
> >=20
> > Maybe you can try qemu command line passthrough:
> >=20
> > https://libvirt.org/drvqemu.html#qemucommand
>=20
> It looks like this can be used to pass command line arguments to qemu.
> Is it possible to specify a virtio specific attribute via this method?
>=20
> For ex: to say mrg_rxbuf is off we can add the following line to virtio
> section of the domain xml file.
>   <host mrg_rxbuf=3D'off'/>
>=20
> I think libvirt needs to be extended to to support the new 'standby' at=
tribute
> via this mechanism.
> Adding Liane Stump and libvirt to the CC list.
>=20
> Michael,
> Can we start with getting this patch into Qemu and an update to libvirt=
 to
> support the 'standby' feature so that this feature can be enabled via
> some scripts/orchestration layer for now.

Unfortunately we don't give the hypothetical orchestration layer
enough info about driver being bound, so it does not know
when is it safe to add a primary.  And a similar issue around reset.

We could add events for that which would be a small patch,
but the issue then is that guest can trigger a storm of
these events.

> We could improve this solution by enhancing Qemu to do automatic manage=
ment of the
> addition/deletion of the primary device based on feature negotiation as=
 a later patch.

I'm not sure what the point of the back and forth would be though.
Typically after people invest in a specific config and get it working,
it's very hard to move them to another solution.

>=20
> >=20
> > The patch looks good to me. Let's see if Michael have any comment.
> >=20
> > Thanks
> >=20
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > ---
> > > > =C2=A0 hw/net/virtio-net.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > > > =C2=A0 include/standard-headers/linux/virtio_net.h | 3 +++
> > > > =C2=A0 2 files changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 90502fca7c..38b3140670 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D=
 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_INT32("speed", VirtION=
et, net_conf.speed,
> > > > SPEED_UNKNOWN),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_STRING("duplex", VirtI=
ONet, net_conf.duplex_str),
> > > > +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT64("standby", VirtIONet, host_=
features,
> > > > VIRTIO_NET_F_STANDBY,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
> > > > =C2=A0 };
> > > > =C2=A0 diff --git a/include/standard-headers/linux/virtio_net.h
> > > > b/include/standard-headers/linux/virtio_net.h
> > > > index e9f255ea3f..01ec09684c 100644
> > > > --- a/include/standard-headers/linux/virtio_net.h
> > > > +++ b/include/standard-headers/linux/virtio_net.h
> > > > @@ -57,6 +57,9 @@
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Stee=
ring */
> > > > =C2=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0=C2=A0=C2=A0 /*=
 Set MAC address */
> > > > =C2=A0 +#define VIRTIO_NET_F_STANDBY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 62=C2=A0=C2=A0=C2=A0 /* Act as standby for
> > > > another device
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * with the same MAC.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > =C2=A0 #define VIRTIO_NET_F_SPEED_DUPLEX 63=C2=A0=C2=A0=C2=A0 /* =
Device set
> > > > linkspeed and duplex */
> > > > =C2=A0 =C2=A0 #ifndef VIRTIO_NET_NO_LEGACY
> > >=20
> >=20
