Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gM2O1-00052U-U1
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 21:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gM2Ns-0004IP-HA
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 21:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gM2Ng-0002Ve-3n
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 21:55:24 -0500
Date: Sun, 11 Nov 2018 21:54:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181111215232-mutt-send-email-mst@kernel.org>
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: support RSC v4/v6 tcp traffic
 for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri Benditovich wrote:
>     > @@ -66,12 +143,16 @@ typedef struct VirtIONet {
>     >=A0 =A0 =A0 VirtIONetQueue *vqs;
>     >=A0 =A0 =A0 VirtQueue *ctrl_vq;
>     >=A0 =A0 =A0 NICState *nic;
>     > +=A0 =A0 QTAILQ_HEAD(, NetRscChain) rsc_chains;
>=20
>     what exactly happens with these chains on migration?
>=20
>=20
> This feature (software implementation of RSC in QEMU) is intended to be=
 used in
> the environment of certification tests which never uses migration.

Should this feature disable migration then?

> These chains
> and accumulated segments (if any) are lost in case of migration. I'll a=
dd the
> note about it
> in commit's message.
>=20

If it's a functional limitation it belongs in a code comment
not in the commit log.

>=20
>=20
>     >=A0 =A0 =A0 uint32_t tx_timeout;
>     >=A0 =A0 =A0 int32_t tx_burst;
>     >=A0 =A0 =A0 uint32_t has_vnet_hdr;
>     >=A0 =A0 =A0 size_t host_hdr_len;
>     >=A0 =A0 =A0 size_t guest_hdr_len;
>     >=A0 =A0 =A0 uint64_t host_features;
>     > +=A0 =A0 uint32_t rsc_timeout;
>     > +=A0 =A0 uint8_t rsc4_enabled;
>     > +=A0 =A0 uint8_t rsc6_enabled;
>     >=A0 =A0 =A0 uint8_t has_ufo;
>     >=A0 =A0 =A0 uint32_t mergeable_rx_bufs;
>     >=A0 =A0 =A0 uint8_t promisc;
>     > diff --git a/include/net/eth.h b/include/net/eth.h
>     > index e6dc8a7ba0..7f45c678e7 100644
>     > --- a/include/net/eth.h
>     > +++ b/include/net/eth.h
>     > @@ -177,6 +177,8 @@ struct tcp_hdr {
>     >=A0 #define TH_PUSH 0x08
>     >=A0 #define TH_ACK=A0 0x10
>     >=A0 #define TH_URG=A0 0x20
>     > +#define TH_ECE=A0 0x40
>     > +#define TH_CWR=A0 0x80
>     >=A0 =A0 =A0 u_short th_win;=A0 =A0 =A0 /* window */
>     >=A0 =A0 =A0 u_short th_sum;=A0 =A0 =A0 /* checksum */
>     >=A0 =A0 =A0 u_short th_urp;=A0 =A0 =A0 /* urgent pointer */
>     > diff --git a/include/standard-headers/linux/virtio_net.h b/includ=
e/
>     standard-headers/linux/virtio_net.h
>     > index 260c3681d7..0d8658c06a 100644
>     > --- a/include/standard-headers/linux/virtio_net.h
>     > +++ b/include/standard-headers/linux/virtio_net.h
>     > @@ -57,6 +57,10 @@
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 * Steering */
>     >=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=A0 =A0 =A0 =A0 /* Set MA=
C address */
>     >=A0
>     > +#define VIRTIO_NET_F_RSC_EXT 38
>=20
>     Should it be VIRTIO_NET_F_GUEST_RSC_EXT ?
>=20
>=20
> IMO, not. In the spec the name of the feature is=A0VIRTIO_NET_F_RSC_EXT=
 and it is
> actually host feature
> and its effect is how the host sets the fields in the header.

Isn't the same true for GUEST_GSO?

>=20
>=20
>     > +#define VIRTIO_NET_F_GUEST_RSC4_DONT_USE=A0 =A0 =A041=A0 =A0 =A0=
 /* reserved */
>     > +#define VIRTIO_NET_F_GUEST_RSC6_DONT_USE=A0 =A0 =A042=A0 =A0 =A0=
 /* reserved */
>     > +
>     >=A0 #define VIRTIO_NET_F_STANDBY=A0 =A062=A0 =A0 /* Act as standby=
 for another
>     device
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 * with the same MAC.
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 */
>     > @@ -104,6 +108,7 @@ struct virtio_net_config {
>     >=A0 struct virtio_net_hdr_v1 {
>     >=A0 #define VIRTIO_NET_HDR_F_NEEDS_CSUM=A0 1=A0 =A0 =A0 =A0/* Use =
csum_start,
>     csum_offset */
>     >=A0 #define VIRTIO_NET_HDR_F_DATA_VALID=A0 2=A0 =A0 =A0 =A0/* Csum=
 is valid */
>     > +#define VIRTIO_NET_HDR_F_RSC_INFO=A0 =A0 4=A0 =A0 =A0 =A0/* rsc_=
ext data in csum_
>     fields */
>     >=A0 =A0 =A0 =A0uint8_t flags;
>     >=A0 #define VIRTIO_NET_HDR_GSO_NONE=A0 =A0 =A0 =A0 =A0 =A0 =A0 0=A0=
 =A0 =A0 =A0/* Not a GSO frame
>     */
>     >=A0 #define VIRTIO_NET_HDR_GSO_TCPV4=A0 =A0 =A01=A0 =A0 =A0 =A0/* =
GSO frame, IPv4 TCP
>     (TSO) */
>     > @@ -118,6 +123,9 @@ struct virtio_net_hdr_v1 {
>     >=A0 =A0 =A0 =A0__virtio16 num_buffers; /* Number of merged rx buff=
ers */
>     >=A0 };
>     >=A0
>     > +#define rsc_ext_num_packets=A0 =A0 =A0 =A0 =A0 csum_start
>     > +#define rsc_ext_num_dupacks=A0 =A0 =A0 =A0 =A0 csum_offset
>=20
>     I would prefer an inline function to set the field, or a union.
>=20
>=20
>     > +
>     >=A0 #ifndef VIRTIO_NET_NO_LEGACY
>     >=A0 /* This header comes first in the scatter-gather list.
>     >=A0 =A0* For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiat=
ed, it must
>=20
>     This part needs to get into the Linux header. Pls post there.
>     Until it does you can put it in virtio-net.c
>=20
>=20
>     > --
>     > 2.17.1
>=20
