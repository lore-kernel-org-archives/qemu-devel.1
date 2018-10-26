Received: from eggs.gnu.org ([2001:4830:134:3::10]:59943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gFxTP-0000LS-IV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gFxRD-0000sH-Ua
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:25:51 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:51476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gFxRD-0000pj-OA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:25:47 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.5])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1AFE416FF0E
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 10:25:38 +0200 (CEST)
References: <20181022121907.13635-1-ppandit@redhat.com>
	<20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
	<679f5ba4-749b-72ee-62a0-40e5efc178e0@kaod.org>
	<nycvar.YSQ.7.76.1810251204450.11480@xnncv>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <987110b6-9f7d-d82a-69b7-dcd78094c1a6@kaod.org>
Date: Fri, 26 Oct 2018 10:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810251204450.11480@xnncv>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Qemu Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hello Prasad,

On 10/25/18 8:45 AM, P J P wrote:
>   Hello Cedric,
>=20
> +-- On Wed, 24 Oct 2018, C=E9dric Le Goater wrote --+
> | I think using a data[8] would be more appropriate. It would make the=20
> | pnv_lpc_do_eccb() routine a little more complex. I tried to rewrite i=
t to=20
> | have a common one with the P9 LPC model but could not find a common p=
attern.=20
> | P9 is purely MMIO based. Something on the TODO list.
> |=20
> | 8 bytes accesses will then fail anyhow because all MemoryRegionOps ha=
ve a=20
> | max_access_size =3D 4.
>=20
> Thank you for these inputs, appreciate it. To confirm,
>=20
>  - You plan to send a v2 patch to fix the OOB access issue along with=20
>    refactoring pnv_lpc_do_eccb?=20

we might improve pnv_lpc_do_eccb() when the P9 LPC model is sent. I am no=
t
sure of that as this is for P8 only.

> If yes, kindly include me in CC please.

yes sure. =20

> OR
>=20
>  - While we refactor the routine for better, a patch below seem okay to=
 fix=20
>    the OOB access issue?

I think it is fine. Please add something like : =20

	qemu_log_mask(LOG_GUEST_ERROR, "ECCB: invalid operation at @0x%08x"=20
			" size %d\n", opb_addr, sz);


Thanks,

C.

> =3D=3D=3D
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d7721320a2..655d5f3d07 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -155,9 +155,13 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc,=
=20
> uint64_t cmd)
>      /* XXX Check for magic bits at the top, addr size etc... */
>      unsigned int sz =3D (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
>      uint32_t opb_addr =3D cmd & ECCB_CTL_ADDR_MASK;
> -    uint8_t data[4];
> +    uint8_t data[8];
>      bool success;
> =20
> +    if (sz > sizeof(data)) {
> +        return;
> +    }
> +
>      if (cmd & ECCB_CTL_READ) {
>          success =3D opb_read(lpc, opb_addr, data, sz);
>          if (success) {
> =3D=3D=3D
>=20
>=20
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
>=20
