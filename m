Received: from eggs.gnu.org ([2001:4830:134:3::10]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZtIn-0003ib-9G
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 00:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZtIk-0000fq-4f
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 00:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cZtIj-0000eh-Ut
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 00:54:22 -0500
References: <20170202104624.13948-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <be626b70-32bc-dcac-a95f-a33820e38cd4@redhat.com>
Date: Sat, 4 Feb 2017 13:54:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170202104624.13948-1-ppandit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] net: imx: limit buffer descriptor count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>



On 2017=E5=B9=B402=E6=9C=8802=E6=97=A5 18:46, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> i.MX Fast Ethernet Controller uses buffer descriptors to manage
> data flow to/fro receive & transmit queues. While transmitting
> packets, it could continue to read buffer descriptors if a buffer
> descriptor has length of zero and has crafted values in bd.flags.
> Set an upper limit to number of buffer descriptors.
>
> Reported-by: Li Qiang <liqiang6-s@360.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/net/imx_fec.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> Patch v2
>    -> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg05554.ht=
ml
>    - Restrict loop in 'imx_enet_do_tx' to IMX_MAX_DESC descriptors.

Applied, thanks.

>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 50c7564..90e6ee3 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -55,6 +55,8 @@
>           } \
>       } while (0)
>  =20
> +#define IMX_MAX_DESC    1024
> +
>   static const char *imx_default_reg_name(IMXFECState *s, uint32_t inde=
x)
>   {
>       static char tmp[20];
> @@ -402,12 +404,12 @@ static void imx_eth_update(IMXFECState *s)
>  =20
>   static void imx_fec_do_tx(IMXFECState *s)
>   {
> -    int frame_size =3D 0;
> +    int frame_size =3D 0, descnt =3D 0;
>       uint8_t frame[ENET_MAX_FRAME_SIZE];
>       uint8_t *ptr =3D frame;
>       uint32_t addr =3D s->tx_descriptor;
>  =20
> -    while (1) {
> +    while (descnt++ < IMX_MAX_DESC) {
>           IMXFECBufDesc bd;
>           int len;
>  =20
> @@ -453,12 +455,12 @@ static void imx_fec_do_tx(IMXFECState *s)
>  =20
>   static void imx_enet_do_tx(IMXFECState *s)
>   {
> -    int frame_size =3D 0;
> +    int frame_size =3D 0, descnt =3D 0;
>       uint8_t frame[ENET_MAX_FRAME_SIZE];
>       uint8_t *ptr =3D frame;
>       uint32_t addr =3D s->tx_descriptor;
>  =20
> -    while (1) {
> +    while (descnt++ < IMX_MAX_DESC) {
>           IMXENETBufDesc bd;
>           int len;
>  =20
