Received: from eggs.gnu.org ([2001:4830:134:3::10]:60288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ccsUi-0002Al-VD
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 06:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ccsUf-0003Mf-Qq
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 06:39:04 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ccsUf-0003MA-GY
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 06:39:01 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so13925174wmv.0
	for <qemu-devel@nongnu.org>; Sun, 12 Feb 2017 03:38:59 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <45B33FB3-E4F3-4BAD-974D-B914B234E97C@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Sun, 12 Feb 2017 13:38:55 +0200
In-Reply-To: <1486693159-29029-1-git-send-email-liqiang6-s@360.cn>
References: <1486693159-29029-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> On 10 Feb 2017, at 04:19 AM, Li Qiang <liq3ea@gmail.com> wrote:
>=20
> This issue is like the issue in e1000 network card addressed in
> this commit:
> e1000: eliminate infinite loops on out-of-bounds transfer start.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>=20
> Change since v2:
> fix error in e1000e_ring_empty
> eliminate unnecessory detect code in loop
>=20
> Changes since v1:
> make wraparound detect in e1000e_ring_empty
>=20
> hw/net/e1000e_core.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2b11499..dc94188 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -806,7 +806,8 @@ typedef struct E1000E_RingInfo_st {
> static inline bool
> e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
> {
> -    return core->mac[r->dh] =3D=3D core->mac[r->dt];
> +    return core->mac[r->dh] =3D=3D core->mac[r->dt] ||
> +                core->mac[r->dt] >=3D core->mac[r->dlen] / =
E1000_RING_DESC_LEN;
> }
>=20
> static inline uint64_t
> @@ -1522,6 +1523,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>             desc_size =3D core->rx_desc_buf_size;
>         }
>=20
> +        if (e1000e_ring_empty(core, rxi)) {
> +            return;
> +        }
> +
>         base =3D e1000e_ring_head_descr(core, rxi);
>=20
>         pci_dma_read(d, base, &desc, core->rx_desc_len);
> --=20
> 1.8.3.1
>=20
