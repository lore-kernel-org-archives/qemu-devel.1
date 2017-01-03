Received: from eggs.gnu.org ([2001:4830:134:3::10]:34884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOFv7-0001wR-9X
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOFv2-00085K-AU
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:37:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cOFv2-000859-4b
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:37:48 -0500
References: <1483311635-27905-1-git-send-email-laurent@vivier.eu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8ab579b1-22ab-25d9-24af-1dd8f8849edc@redhat.com>
Date: Tue, 3 Jan 2017 11:37:40 +0800
MIME-Version: 1.0
In-Reply-To: <1483311635-27905-1-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dp8393x: fix dp8393x_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>



On 2017=E5=B9=B401=E6=9C=8802=E6=97=A5 07:00, Laurent Vivier wrote:
> address_space_rw() access size must be multiplied by width.
> dp8393x_receive() must return the number of bytes read, not the length
> of the last memory access.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 17f0338..3506bca 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -766,10 +766,11 @@ static ssize_t dp8393x_receive(NetClientState *nc=
, const uint8_t * buf,
>           /* EOL detected */
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
>       } else {
> +        size =3D sizeof(uint16_t) * width;
>           data[0 * width] =3D 0; /* in_use */
>           address_space_rw(&s->as,
>               ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) + siz=
eof(uint16_t) * 6 * width,
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t),=
 1);
> +            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);

I think patch makes different only when width is 2. But if we just want=20
to tag in_use flag, sizeof(uint16_t) should be sufficient?

Thanks

>           s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->=
regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
> @@ -783,7 +784,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       /* Done */
>       dp8393x_update_irq(s);
>  =20
> -    return size;
> +    return rx_len;
>   }
>  =20
>   static void dp8393x_reset(DeviceState *dev)
