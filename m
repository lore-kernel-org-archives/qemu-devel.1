Received: from eggs.gnu.org ([2001:4830:134:3::10]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eF7KS-0001wi-Fs
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eF7KR-00051t-Hg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:42:48 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:36369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eF7KR-00050u-D9
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:42:47 -0500
Received: by mail-io0-x22d.google.com with SMTP id n79so3410935ion.3
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 15:42:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510714675-84054-1-git-send-email-eswierk@skyportsystems.com>
References: <1510714675-84054-1-git-send-email-eswierk@skyportsystems.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 15 Nov 2017 15:42:05 -0800
Message-ID: <CAO_EM_mdceLwiv0MBfgEk+hxAhN+7uMQrJD1fW=K=FjJsqLznA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] net: Transmit zero UDP checksum as
 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>

On Tue, Nov 14, 2017 at 6:57 PM, Ed Swierk <eswierk@skyportsystems.com> wrote:
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 20b2549..dc95f12 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -126,12 +126,12 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
>
>          /* Calculate IP pseudo header checksum */
>          cntr = eth_calc_ip4_pseudo_hdr_csum(ip_hdr, pkt->payload_len, &cso);
> -        csum = cpu_to_be16(~net_checksum_finish(cntr));
> +        csum = cpu_to_be16(~net_checksum_finish_hdr(cntr));
>      } else if (gso_type == VIRTIO_NET_HDR_GSO_TCPV6) {
>          /* Calculate IP pseudo header checksum */
>          cntr = eth_calc_ip6_pseudo_hdr_csum(ip_hdr, pkt->payload_len,
>                                              IP_PROTO_TCP, &cso);
> -        csum = cpu_to_be16(~net_checksum_finish(cntr));
> +        csum = cpu_to_be16(~net_checksum_finish_hdr(cntr));
>      } else {
>          return;
>      }

Actually this change looks wrong. The checksum here is just the
partial sum of the IP pseudo-header fields, to be incorporated into
the actual UDP or TCP checksum (including the packet payload) at some
later stage. The partial sum should never be zero (if
net_rx_pkt_fix_l4_csum() is to be believed), but changing 0x0000 to
0xFFFF and then storing the complement ensures just that.

Unless someone with more of a clue says otherwise, I'll drop this change in v3.

--Ed
