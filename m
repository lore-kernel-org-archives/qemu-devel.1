Received: from eggs.gnu.org ([2001:4830:134:3::10]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gG5AQ-0004Lo-Hk
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gG5AN-00082m-DT
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:40:58 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:56918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gG5AN-00081H-5K
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:40:55 -0400
Received: from player714.ha.ovh.net (unknown [10.109.143.18])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BC38C1BC279
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 18:40:53 +0200 (CEST)
References: <20181026123358.2554-1-ppandit@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <997fe3c2-5af3-6aae-864a-8dced05bb2d8@kaod.org>
Date: Fri, 26 Oct 2018 18:40:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181026123358.2554-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Moguofang <moguofang@huawei.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 10/26/18 2:33 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> While performing PowerNV memory r/w operations, the access length
> 'sz' could exceed the data[4] buffer size. Add check to avoid OOB
> access.
>=20
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  hw/ppc/pnv_lpc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> Update v2: add error log message
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05750.htm=
l
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d7721320a2..172a915cfc 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -155,9 +155,15 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc,=
 uint64_t cmd)
>      /* XXX Check for magic bits at the top, addr size etc... */
>      unsigned int sz =3D (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
>      uint32_t opb_addr =3D cmd & ECCB_CTL_ADDR_MASK;
> -    uint8_t data[4];
> +    uint8_t data[8];
>      bool success;
> =20
> +    if (sz > sizeof(data)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "ECCB: invalid operation at @0x%08x size %d\n", opb_addr, =
sz);
> +        return;
> +    }
> +
>      if (cmd & ECCB_CTL_READ) {
>          success =3D opb_read(lpc, opb_addr, data, sz);
>          if (success) {
>=20
