Received: from eggs.gnu.org ([208.118.235.92]:45004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf8LI-00045v-DL
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 14:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf8LH-0001vR-Mr
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 14:07:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf8LH-0001uw-9r
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 14:07:43 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so30283400otk.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 11:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
	<20181221054606.22007-36-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-36-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 19:07:30 +0000
Message-ID: <CAFEAcA9ZV0O7VohX-_S7mgerGU6Y+jAHMRgK9TB8tyBgBxbNOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 35/40] spapr: extend the sPAPR IRQ backend
 for XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, gkurz@redhat.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On Fri, 21 Dec 2018 at 05:46, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Introduce a new sPAPR IRQ handler to handle resend after migration
> when the machine is using a KVM XICS interrupt controller model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

> @@ -1758,6 +1750,11 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          }
>      }
>
> +    err =3D spapr_irq_post_load(spapr, version_id);
> +    if (err) {
> +        return err;
> +    }
> +

Hi; this change causes Coverity to complain (CID 1398591) that
we're now overwriting the setting of err in the earlier
 err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
without ever testing it. (We also do this in the existing
codepath that calls kvmppc_configure_v3_mmu().)

Should the call to spapr_rtc_import_offset() have its
own "if (err) do something" code, or should it simply
be ignoring its return value entirely, or something
more complicated ?

thanks
-- PMM
