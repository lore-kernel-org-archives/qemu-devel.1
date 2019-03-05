Received: from eggs.gnu.org ([209.51.188.92]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CeJ-0007nq-TQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CeJ-000159-4z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:10:35 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1CeI-000146-TN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:10:35 -0500
Received: by mail-ot1-x32c.google.com with SMTP id m1so7872101otf.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-31-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-31-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 16:10:20 +0000
Message-ID: <CAFEAcA_S+Sq_5fMbVvXnSLsWzzVxKYA2zs8QH02H_xAAb+1+kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 30/50] spapr: Generate FDT fragment for LMBs
 at configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: gkurz@kaod.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>

On Tue, 26 Feb 2019 at 04:53, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Greg Kurz <groug@kaod.org>


Hi -- Coverity points out a possible overflow here (CID 1399145):

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 00eb3b643c..b92deee771 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3333,14 +3333,26 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
>      }
>  }
>
> +int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
> +                          void *fdt, int *fdt_start_offset, Error **errp)
> +{
> +    uint64_t addr;
> +    uint32_t node;
> +
> +    addr = spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;

This multiplication is done as a 32x32, which might overflow and
be truncated before the result is put into the 64-bit result.
Casting one side or the other to uint64_t would fix this.

thanks
-- PMM
