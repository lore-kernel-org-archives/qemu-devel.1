Received: from eggs.gnu.org ([209.51.188.92]:58157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0iu1-0001Ft-S4
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0iu1-0000XZ-22
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:24:49 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h0iu0-0000Ww-Qu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:24:48 -0500
Date: Mon, 4 Mar 2019 09:24:46 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190304082446.GB4629@t470p.stackframe.org>
References: <20190217113717.7077-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217113717.7077-1-svens@stackframe.org>
Subject: Re: [Qemu-devel] [PATCH] lsi: check if SIGP bit is already set in
 Wait reselect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>

Hi List,

is this patch going to be accepted?

Thanks
Sven

On Sun, Feb 17, 2019 at 12:37:17PM +0100, Sven Schnelle wrote:
> If SIGP is set, the 'Wait for Reselection' command should jump
> immediately to the address stored in the second DWORD of the
> instruction. This fixes spurious hangs in the HP-UX 11.11
> installer when the SIGP bit gets set by the kernel before the
> 'Wait for Reselection' command is executed by SCRIPTS.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Tested-by: Helge Deller <deller@gmx.de>
> ---
>  hw/scsi/lsi53c895a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 8ba07f8756..bcff859bac 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1297,8 +1297,10 @@ again:
>                  }
>                  break;
>              case 2: /* Wait Reselect */
> -                if (!lsi_irq_on_rsl(s)) {
> -                    lsi_wait_reselect(s);
> +                if (s->istat0 & LSI_ISTAT0_SIGP) {
> +                    s->dsp = s->dnad;
> +                } else if (!lsi_irq_on_rsl(s)) {
> +                        lsi_wait_reselect(s);
>                  }
>                  break;
>              case 3: /* Set */
> -- 
> 2.20.1
> 
> 
