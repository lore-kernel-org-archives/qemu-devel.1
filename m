Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fY5Cd-0000q3-KH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fY5CY-0004g2-Kc
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:49:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:44839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fY5CY-0004eo-A1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:49:18 -0400
Date: Wed, 27 Jun 2018 09:49:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180625222718.4488-1-mail@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1806270945590.79722@zero.eik.bme.hu>
References: <20180625222718.4488-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] ehci: Don't fetch a NULL current qtd but
 advance the queue instead.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Tue, 26 Jun 2018, Sebastian Bauer wrote:
> Fetching qtd with the NULL address most likely makes no sense so from now
> on, we handle it this case similarly as if the terminate (T) bit is not
> set, which is already an exception as according to section 3.6 of the EHCI
> spec there is no T bit defined for the current_qtd field.
>
> The spec is a bit vague on how an EHCI driver should initialize these
> fields: "The general operational model is that the host controller can
> detect whether the overlay area contains a description of an active
> transfer" (p. 49). QEMU primarily uses the QTD_TOKEN_ACTIVE bit of the
> queue header to infer the activity state but there are other ways
> conceivable.
>
> This change allows QEMU to boot further into AmigaOS. The public available
> version of the EHCI driver recycles queue heads in some rare conditions but
> only clears the current_qtd field but not the status field. This works with
> many available EHCI PCI cards but e.g., not with the Freescale USB
> controller's found on the P5040. On the emulated EHCI controller of QEMU
> the consequence is that some garbage was read in, which resulted in a
> reset of the controller. This change fixes the problem.
>
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

This fixes mouse and keyboard for AmigaOS on sam460ex. It would be 
appreciated if this could be merged before the freeze. I guess it could be 
removed again before the release if found to cause any problems or fixed 
if needed but if it's not merged now then we can't make QEMU 3.0 support 
AmigaOS.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
>
> The fix is probably not the best solution. However, it is one that is very
> small.
>
> QEMU still warns that an active qh will be changed if the qh is recycled,
> so more changes could be done. But I didn't notice any negative
> consequences implied by the warning so I would leave a possible fix to this
> problem to a further patch.
> ---
> hw/usb/hcd-ehci.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 0134232627..e5acfc5ba5 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1672,7 +1672,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>         ehci_set_state(ehci, async, EST_HORIZONTALQH);
>
>     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&
> -               (NLPTR_TBIT(q->qh.current_qtd) == 0)) {
> +               (NLPTR_TBIT(q->qh.current_qtd) == 0) &&
> +               (q->qh.current_qtd != 0)) {
>         q->qtdaddr = q->qh.current_qtd;
>         ehci_set_state(ehci, async, EST_FETCHQTD);
>
>
