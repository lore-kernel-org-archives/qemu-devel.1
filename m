Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRfPL-0006yT-N9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRfPI-0005Ce-4u
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:31:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRfPH-0005BG-R1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:31:40 -0500
Date: Wed, 20 Dec 2017 16:31:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220162927-mutt-send-email-mst@kernel.org>
References: <cover.1513278334.git.jbaron@akamai.com>
	<cover.1513278334.git.jbaron@akamai.com>
	<1513280073-27515-1-git-send-email-jbaron@akamai.com>
	<C5089512-91B2-439E-B22D-D7D416BDD558@redhat.com>
	<9d600f3d-7e8d-153f-fd34-704c9975099b@akamai.com>
	<21A64922-D22E-4AE1-8B4C-B0D85357240C@redhat.com>
	<73e8811d-70fd-4920-1cb4-ad1809ebff82@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <73e8811d-70fd-4920-1cb4-ad1809ebff82@akamai.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu: add linkspeed and duplex setting
 to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 11:52:39AM -0500, Jason Baron wrote:
>=20
>=20
> On 12/19/2017 04:19 AM, Yan Vugenfirer wrote:
> >=20
> >> On 18 Dec 2017, at 18:04, Jason Baron via Qemu-devel
> >> <qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>> wrote:
> >>
> >>
> >>
> >> On 12/18/2017 06:34 AM, Yan Vugenfirer wrote:
> >>>
> >>>> On 14 Dec 2017, at 21:33, Jason Baron via Qemu-devel
> >>>> <qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>> wrote:
> >>>>
> >>>> Although they can be currently set in linux via 'ethtool -s', this
> >>>> requires
> >>>> guest changes, and thus it would be nice to extend this
> >>>> functionality such
> >>>> that it can be configured automatically from the host (as other ne=
twork
> >>>> do).
> >>>>
> >>>> Linkspeed and duplex settings can be set as:
> >>>> '-device virtio-net,speed=3D10000,duplex=3Dfull'
> >>>>
> >>>> where speed is [-1...INT_MAX], and duplex is ["half"|"full"].
> >>>>
> >>>> Signed-off-by: Jason Baron <jbaron@akamai.com
> >>>> <mailto:jbaron@akamai.com>>
> >>>> Cc: "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>>
> >>>> Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
> >>>> ---
> >>>> hw/net/virtio-net.c =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0| 29
> >>>> +++++++++++++++++++++++++++++
> >>>> include/hw/virtio/virtio-net.h =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0| =A03 +++
> >>>> include/standard-headers/linux/virtio_net.h | =A04 ++++
> >>>> 3 files changed, 36 insertions(+)
> >>>>
> >>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>> index 38674b0..d63e790 100644
> >>>> --- a/hw/net/virtio-net.c
> >>>> +++ b/hw/net/virtio-net.c
> >>>> @@ -40,6 +40,12 @@
> >>>> #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_S=
IZE
> >>>> #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_S=
IZE
> >>>>
> >>>> +/* duplex and speed defines */
> >>>> +#define DUPLEX_UNKNOWN =A0=A0=A0=A0=A0=A0=A0=A0=A00xff
> >>>> +#define DUPLEX_HALF =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00
> >>>> +#define DUPLEX_FULL =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x01
> >>>> +#define SPEED_UNKNOWN =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-1
> >>>> +
> >>>> /*
> >>>> * Calculate the number of bytes up to and including the given 'fie=
ld' of
> >>>> * 'container'.
> >>>> @@ -61,6 +67,8 @@ static VirtIOFeature feature_sizes[] =3D {
> >>>> =A0=A0=A0=A0.end =3D endof(struct virtio_net_config, max_virtqueue=
_pairs)},
> >>>> =A0=A0=A0{.flags =3D 1 << VIRTIO_NET_F_MTU,
> >>>> =A0=A0=A0=A0.end =3D endof(struct virtio_net_config, mtu)},
> >>>> + =A0=A0=A0{.flags =3D 1 << VIRTIO_NET_F_SPEED_DUPLEX,
> >>>> + =A0=A0=A0=A0.end =3D endof(struct virtio_net_config, duplex)},
> >>>> =A0=A0=A0{}
> >>>> };
> >>>>
> >>>> @@ -88,6 +96,8 @@ static void virtio_net_get_config(VirtIODevice
> >>>> *vdev, uint8_t *config)
> >>>> =A0=A0=A0virtio_stw_p(vdev, &netcfg.status, n->status);
> >>>> =A0=A0=A0virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_qu=
eues);
> >>>> =A0=A0=A0virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> >>>> + =A0=A0=A0virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
> >>>> + =A0=A0=A0netcfg.duplex =3D n->net_conf.duplex;
> >>>> =A0=A0=A0memcpy(netcfg.mac, n->mac, ETH_ALEN);
> >>>> =A0=A0=A0memcpy(config, &netcfg, n->config_size);
> >>>> }
> >>>> @@ -1941,6 +1951,23 @@ static void
> >>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >>>> =A0=A0=A0=A0=A0=A0=A0n->host_features |=3D (0x1 << VIRTIO_NET_F_MT=
U);
> >>>> =A0=A0=A0}
> >>>>
> >>>> + =A0=A0=A0n->host_features |=3D (0x1 << VIRTIO_NET_F_SPEED_DUPLEX=
);
> >>>> + =A0=A0=A0if (n->net_conf.duplex_str) {
> >>>> + =A0=A0=A0=A0=A0=A0=A0if (strncmp(n->net_conf.duplex_str, "half",=
 5) =3D=3D 0) {
> >>>> + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0n->net_conf.duplex =3D DUPLEX_H=
ALF;
> >>>> + =A0=A0=A0=A0=A0=A0=A0} else if (strncmp(n->net_conf.duplex_str, =
"full", 5) =3D=3D 0) {
> >>>> + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0n->net_conf.duplex =3D DUPLEX_F=
ULL;
> >>>> + =A0=A0=A0=A0=A0=A0=A0} else {
> >>>> + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_setg(errp, "'duplex' must=
 be 'half' or 'full'");
> >>>> + =A0=A0=A0=A0=A0=A0=A0}
> >>>> + =A0=A0=A0} else {
> >>>> + =A0=A0=A0=A0=A0=A0=A0n->net_conf.duplex =3D DUPLEX_UNKNOWN;
> >>>> + =A0=A0=A0}
> >>>> + =A0=A0=A0if (n->net_conf.speed < SPEED_UNKNOWN) {
> >>>> + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_setg(errp, "'speed' must =
be between -1
> >>>> (SPEED_UNKOWN) and "
> >>>> + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
"INT_MAX");
> >>>> + =A0=A0=A0}
> >>>> +
> >>>> =A0=A0=A0virtio_net_set_config_size(n, n->host_features);
> >>>> =A0=A0=A0virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_=
size);
> >>>>
> >>>> @@ -2160,6 +2187,8 @@ static Property virtio_net_properties[] =3D =
{
> >>>> =A0=A0=A0DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0=
),
> >>>> =A0=A0=A0DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet,
> >>>> mtu_bypass_backend,
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0true),
> >>>> + =A0=A0=A0DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed,
> >>>> SPEED_UNKNOWN),
> >>>
> >>> From Windows guest perspective I prefer to have some reasonable
> >>> default (10G for example).=A0
> >>
> >>
> >> hmmm, I didn't want to change/set the default here in case it broke
> >> something, but I'm ok setting it to some 'reasonable' value - (10G a=
nd
> >> duplex?), if the consensus is that that would be safe.
> >=20
> > OK from my side.
> > Thanks.
>=20
> I presume your speaking for windows - i'm wondering if under linux the
> virtio device suddenly start showing up as duplex, 10Gbps, will that
> break anything? I can speak for the use-cases we have here and that
> would certainly be fine for us, but i'm really not sure if that is ok
> more generally.
>=20
> Thanks,
>=20
> -Jason

How about not enabling the flag unless the user specified the speed?
This way we also do not need an "unknown" value.

> >=20
> >>
> >> Thanks,
> >>
> >> -Jason
> >>
> >>>
> >>> Thanks,
> >>> Yan.
> >>>
> >>>> + =A0=A0=A0DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex=
_str),
> >>>> =A0=A0=A0DEFINE_PROP_END_OF_LIST(),
> >>>> };
> >>>>
> >>>> diff --git a/include/hw/virtio/virtio-net.h
> >>>> b/include/hw/virtio/virtio-net.h
> >>>> index b81b6a4..af74a94 100644
> >>>> --- a/include/hw/virtio/virtio-net.h
> >>>> +++ b/include/hw/virtio/virtio-net.h
> >>>> @@ -38,6 +38,9 @@ typedef struct virtio_net_conf
> >>>> =A0=A0=A0uint16_t rx_queue_size;
> >>>> =A0=A0=A0uint16_t tx_queue_size;
> >>>> =A0=A0=A0uint16_t mtu;
> >>>> + =A0=A0=A0int32_t speed;
> >>>> + =A0=A0=A0char *duplex_str;
> >>>> + =A0=A0=A0uint8_t duplex;
> >>>> } virtio_net_conf;
> >>>>
> >>>> /* Maximum packet size we can receive from tap device: header + 64=
k */
> >>>> diff --git a/include/standard-headers/linux/virtio_net.h
> >>>> b/include/standard-headers/linux/virtio_net.h
> >>>> index 30ff249..0ff1447 100644
> >>>> --- a/include/standard-headers/linux/virtio_net.h
> >>>> +++ b/include/standard-headers/linux/virtio_net.h
> >>>> @@ -36,6 +36,7 @@
> >>>> #define VIRTIO_NET_F_GUEST_CSUM1/* Guest handles pkts w/ partial c=
sum */
> >>>> #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload
> >>>> configuration. */
> >>>> #define VIRTIO_NET_F_MTU3/* Initial MTU advice */
> >>>> +#define VIRTIO_NET_F_SPEED_DUPLEX 4/* Host set linkspeed and dupl=
ex */
> >>>> #define VIRTIO_NET_F_MAC5/* Host has given MAC address. */
> >>>> #define VIRTIO_NET_F_GUEST_TSO47/* Guest can handle TSOv4 in. */
> >>>> #define VIRTIO_NET_F_GUEST_TSO68/* Guest can handle TSOv6 in. */
> >>>> @@ -76,6 +77,9 @@ struct virtio_net_config {
> >>>> uint16_t max_virtqueue_pairs;
> >>>> /* Default maximum transmit unit advice */
> >>>> uint16_t mtu;
> >>>> +/* Host exported linkspeed and duplex */
> >>>> +uint32_t speed;
> >>>> +uint8_t duplex;
> >>>> } QEMU_PACKED;
> >>>>
> >>>> /*
> >>>> --=A0
> >>>> 2.6.1
> >=20
