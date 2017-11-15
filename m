Received: from eggs.gnu.org ([2001:4830:134:3::10]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEnAO-0004Sq-EK
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEnAJ-0000jt-Fy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:11:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEnAJ-0000iB-9r
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:10:59 -0500
References: <1510701938-53743-1-git-send-email-eswierk@skyportsystems.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4853b107-0318-b4c0-a028-f104d10869aa@redhat.com>
Date: Wed, 15 Nov 2017 10:10:53 +0800
MIME-Version: 1.0
In-Reply-To: <1510701938-53743-1-git-send-email-eswierk@skyportsystems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Transmit zero UDP checksum as 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 07:25, Ed Swierk wrote:
> The checksum algorithm used by IPv4, TCP and UDP allows a zero value
> to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
> UDP checksum must be transmitted as 0xFFFF, as 0x0000 is a special
> value meaning no checksum.
>
> Substitute 0xFFFF whenever a checksum is computed as zero on a UDP
> datagram. Doing this on IPv4 packets and TCP segments is unnecessary
> but legal.
>
> (While it is tempting to make the substitution in
> net_checksum_finish(), that function is also used by receivers to
> verify checksums, and in that case the expected value is always
> 0x0000.)

Then looks like you'd better have an wrapper for net_checksum_finish()=20
and do things there.

>
> Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
> ---
>   hw/net/e1000.c      | 5 +++--
>   hw/net/net_rx_pkt.c | 3 +++
>   hw/net/net_tx_pkt.c | 6 ++++++
>   hw/net/vmxnet3.c    | 7 +++++--
>   4 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index d642314..97242a1 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -505,8 +505,9 @@ putsum(uint8_t *data, uint32_t n, uint32_t sloc, ui=
nt32_t css, uint32_t cse)
>       if (cse && cse < n)
>           n =3D cse + 1;
>       if (sloc < n-1) {
> -        sum =3D net_checksum_add(n-css, data+css);
> -        stw_be_p(data + sloc, net_checksum_finish(sum));
> +        sum =3D net_raw_checksum(data + css, n - css);
> +        /* For UDP, zero checksum must be sent as 0xFFFF */
> +        stw_be_p(data + sloc, sum ? sum : 0xffff);
>       }
>   }
>  =20
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 1019b50..e820132 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -588,6 +588,9 @@ bool net_rx_pkt_fix_l4_csum(struct NetRxPkt *pkt)
>  =20
>       /* Calculate L4 checksum */
>       csum =3D cpu_to_be16(_net_rx_pkt_calc_l4_csum(pkt));
> +    if (!csum) {
> +        csum =3D 0xFFFF; /* For UDP, zero checksum must be sent as 0xF=
FFF */
> +    }

I thought we should only do this for tx?

Thanks
