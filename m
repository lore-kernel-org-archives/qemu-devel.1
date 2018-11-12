Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gM827-0008Ng-UO
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gM826-0001WZ-5G
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:23 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gM825-0001Vl-1d
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:21 -0500
Received: by mail-yb1-xb42.google.com with SMTP id u103-v6so3606108ybi.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181111215232-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 12 Nov 2018 10:57:06 +0200
Message-ID: <CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Nov 12, 2018 at 4:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri Benditovich wrote:
> >     > @@ -66,12 +143,16 @@ typedef struct VirtIONet {
> >     >      VirtIONetQueue *vqs;
> >     >      VirtQueue *ctrl_vq;
> >     >      NICState *nic;
> >     > +    QTAILQ_HEAD(, NetRscChain) rsc_chains;
> >
> >     what exactly happens with these chains on migration?
> >
> >
> > This feature (software implementation of RSC in QEMU) is intended to be
> used in
> > the environment of certification tests which never uses migration.
>
> Should this feature disable migration then?
>

IMO, this should not. But if you find it mandatory, please respond and I
will add the migration blocker.
In this case I'd prefer to disable the feature in case of vhost as in this
case the RX normally will not be
processed by QEMU and even if the feature by mistake enabled in command
line this will not have
any effect.


>
> > These chains
> > and accumulated segments (if any) are lost in case of migration. I'll
> add the
> > note about it
> > in commit's message.
> >
>
> If it's a functional limitation it belongs in a code comment
> not in the commit log.
>
> >
> >
> >     >      uint32_t tx_timeout;
> >     >      int32_t tx_burst;
> >     >      uint32_t has_vnet_hdr;
> >     >      size_t host_hdr_len;
> >     >      size_t guest_hdr_len;
> >     >      uint64_t host_features;
> >     > +    uint32_t rsc_timeout;
> >     > +    uint8_t rsc4_enabled;
> >     > +    uint8_t rsc6_enabled;
> >     >      uint8_t has_ufo;
> >     >      uint32_t mergeable_rx_bufs;
> >     >      uint8_t promisc;
> >     > diff --git a/include/net/eth.h b/include/net/eth.h
> >     > index e6dc8a7ba0..7f45c678e7 100644
> >     > --- a/include/net/eth.h
> >     > +++ b/include/net/eth.h
> >     > @@ -177,6 +177,8 @@ struct tcp_hdr {
> >     >  #define TH_PUSH 0x08
> >     >  #define TH_ACK  0x10
> >     >  #define TH_URG  0x20
> >     > +#define TH_ECE  0x40
> >     > +#define TH_CWR  0x80
> >     >      u_short th_win;      /* window */
> >     >      u_short th_sum;      /* checksum */
> >     >      u_short th_urp;      /* urgent pointer */
> >     > diff --git a/include/standard-headers/linux/virtio_net.h b/include/
> >     standard-headers/linux/virtio_net.h
> >     > index 260c3681d7..0d8658c06a 100644
> >     > --- a/include/standard-headers/linux/virtio_net.h
> >     > +++ b/include/standard-headers/linux/virtio_net.h
> >     > @@ -57,6 +57,10 @@
> >     >                                        * Steering */
> >     >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >     >
> >     > +#define VIRTIO_NET_F_RSC_EXT 38
> >
> >     Should it be VIRTIO_NET_F_GUEST_RSC_EXT ?
> >
> >
> > IMO, not. In the spec the name of the feature is VIRTIO_NET_F_RSC_EXT
> and it is
> > actually host feature
> > and its effect is how the host sets the fields in the header.
>
> Isn't the same true for GUEST_GSO?
>
>
I think GUEST_GSO is really guest feature ( it requires larger buffers on
guest side),
but this is question of terminology. If you find it necessary to rename the
feature,
please respond, I will do that in v3 of the patch. Just would like to
collect all the
requests.



> >
> >
> >     > +#define VIRTIO_NET_F_GUEST_RSC4_DONT_USE     41      /* reserved
> */
> >     > +#define VIRTIO_NET_F_GUEST_RSC6_DONT_USE     42      /* reserved
> */
> >     > +
> >     >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another
> >     device
> >     >                                        * with the same MAC.
> >     >                                        */
> >     > @@ -104,6 +108,7 @@ struct virtio_net_config {
> >     >  struct virtio_net_hdr_v1 {
> >     >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM  1       /* Use csum_start,
> >     csum_offset */
> >     >  #define VIRTIO_NET_HDR_F_DATA_VALID  2       /* Csum is valid */
> >     > +#define VIRTIO_NET_HDR_F_RSC_INFO    4       /* rsc_ext data in
> csum_
> >     fields */
> >     >       uint8_t flags;
> >     >  #define VIRTIO_NET_HDR_GSO_NONE              0       /* Not a GSO
> frame
> >     */
> >     >  #define VIRTIO_NET_HDR_GSO_TCPV4     1       /* GSO frame, IPv4
> TCP
> >     (TSO) */
> >     > @@ -118,6 +123,9 @@ struct virtio_net_hdr_v1 {
> >     >       __virtio16 num_buffers; /* Number of merged rx buffers */
> >     >  };
> >     >
> >     > +#define rsc_ext_num_packets          csum_start
> >     > +#define rsc_ext_num_dupacks          csum_offset
> >
> >     I would prefer an inline function to set the field, or a union.
> >
> >
> >     > +
> >     >  #ifndef VIRTIO_NET_NO_LEGACY
> >     >  /* This header comes first in the scatter-gather list.
> >     >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated,
> it must
> >
> >     This part needs to get into the Linux header. Pls post there.
> >     Until it does you can put it in virtio-net.c
> >
> >
> >     > --
> >     > 2.17.1
> >
>
