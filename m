Received: from eggs.gnu.org ([208.118.235.92]:40805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gfWFg-0005CM-4a
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gfWFd-0007Qy-1P
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:39:32 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:59412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gfWFc-0007Et-RP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:39:28 -0500
Received: from player776.ha.ovh.net (unknown [10.109.143.238])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A357120C664
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 21:39:20 +0100 (CET)
Date: Fri, 4 Jan 2019 21:39:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190104213910.215d6859@bahia.lan>
In-Reply-To: <20190104133050.7468-1-clg@kaod.org>
References: <20190104133050.7468-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: return from post_load
 method when RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri,  4 Jan 2019 14:30:50 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The error value can be squashed by the section handling radix migration.
> Simply bail out if an error occurs when the RTC offset is imported.
>=20
> This fixes the Coverity issue CID 1398591.
>=20
> Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20

Reviewed-by: Greg Kurz <groug@kaod.org>

>  Changes since v1 :
>=20
>  - Added Coverity issue CID
>=20
>  hw/ppc/spapr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f1725313e979..64397ee91ef0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1748,12 +1748,17 @@ static int spapr_post_load(void *opaque, int vers=
ion_id)
>          return err;
>      }
> =20
> -    /* In earlier versions, there was no separate qdev for the PAPR
> +    /*
> +     * In earlier versions, there was no separate qdev for the PAPR
>       * RTC, so the RTC offset was stored directly in sPAPREnvironment.
>       * So when migrating from those versions, poke the incoming offset
> -     * value into the RTC device */
> +     * value into the RTC device
> +     */
>      if (version_id < 3) {
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> +        if (err) {
> +            return err;
> +        }
>      }
> =20
>      if (kvm_enabled() && spapr->patb_entry) {
