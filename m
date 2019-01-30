Received: from eggs.gnu.org ([209.51.188.92]:56780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry.fleytman@janustech.com>) id 1golL1-0001wA-32
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry.fleytman@janustech.com>) id 1golL0-0006Us-8s
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:35:15 -0500
Received: from mail-eopbgr770139.outbound.protection.outlook.com
	([40.107.77.139]:20256
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dmitry.fleytman@janustech.com>)
	id 1golKz-0006Ub-V8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:35:14 -0500
From: Dmitry Fleytman <dmitry.fleytman@janustech.com>
Date: Wed, 30 Jan 2019 08:35:10 +0000
Message-ID: <A0DAA6D1-C6F0-4FCD-82BA-6FC0D4659019@janustech.com>
References: <20190128200444.5128-1-yuri.benditovich@janustech.com>
	<20190128200444.5128-2-yuri.benditovich@janustech.com>
In-Reply-To: <20190128200444.5128-2-yuri.benditovich@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EACD3B0F9D280E43B4247FD8B55CB275@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] usb: XHCI shall not halt isochronous
 endpoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@janustech.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 28 Jan 2019, at 22:05, Yuri Benditovich <yuri.benditovich@janustech.co=
m> wrote:
>=20
> According to the XHCI spec (4.10.2) the controller
> never halts isochronous endpoints. This commit prevent
> stop of isochronous streaming when sporadic errors
> status received from backends.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@janustech.com>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@janustech.com>

> ---
> hw/usb/hcd-xhci.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 8f1a01a..1a8fd96 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1571,6 +1571,11 @@ static void xhci_stall_ep(XHCITransfer *xfer)
>     uint32_t err;
>     XHCIStreamContext *sctx;
>=20
> +    if (epctx->type =3D=3D ET_ISO_IN || epctx->type =3D=3D ET_ISO_OUT) {
> +        /* never halt isoch endpoints, 4.10.2 */
> +        return;
> +    }
> +
>     if (epctx->nr_pstreams) {
>         sctx =3D xhci_find_stream(epctx, xfer->streamid, &err);
>         if (sctx =3D=3D NULL) {
> --=20
> 2.9.5
>=20
