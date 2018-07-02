Received: from eggs.gnu.org ([2001:4830:134:3::10]:45887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0MT-0006bA-3E
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0MQ-0003c9-0c
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0MP-0003bn-QJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:03:25 -0400
Date: Mon, 2 Jul 2018 17:03:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180702150323.ext4p462m444p7qj@sirius.home.kraxel.org>
References: <20180625222718.4488-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625222718.4488-1-mail@sebastianbauer.info>
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
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu

On Tue, Jun 26, 2018 at 12:27:18AM +0200, Sebastian Bauer wrote:
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

Added to usb queue.

thanks,
  Gerd
