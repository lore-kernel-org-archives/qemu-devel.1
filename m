Received: from eggs.gnu.org ([2001:4830:134:3::10]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDj8-0004Ym-5i
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDj7-0001vq-Al
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:10:18 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:39400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDj6-0001u9-Nn
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:10:17 -0400
Received: by mail-oi0-x234.google.com with SMTP id c190-v6so15873258oig.6
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:10:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180821043343.7514-26-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
	<20180821043343.7514-26-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:09:55 +0100
Message-ID: <CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>

On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> It should save us some CPU cycles as these routines perform a lot of
> checks.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Hi; Coverity points out in CID 1395183 that there's a bug in
this part of this patch:

> @@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      sPAPRMachineState *spapr =3D
>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                    TYPE_SPAPR_MACHINE);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);

This has moved the call to SPAPR_MACHINE_GET_CLASS() above
the check for "is spapr NULL", which is wrong, because it
will unconditionally dereference the pointer you pass to it.

thanks
-- PMM
