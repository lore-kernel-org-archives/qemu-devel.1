Received: from eggs.gnu.org ([2001:4830:134:3::10]:46317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d9A00-0001LL-ML
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d99zv-000416-OB
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:48:48 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33238
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d99zv-0003qm-Ex
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:48:43 -0400
References: <1894a033.84c.15bf1938bed.Coremail.8610_28@163.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1acef20c-5331-f1a1-2886-5d158ebc82c3@ilande.co.uk>
Date: Fri, 12 May 2017 13:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <1894a033.84c.15bf1938bed.Coremail.8610_28@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] ehci: fix "int" overflow for calculation
 ehci->last_run_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5p2O5p6X?= <8610_28@163.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 10/05/17 09:57, ÀîÁÖ wrote:

>   If we experience large delays between echi timer callbacks (i.e. because other periodic handlers have taken a lot of time to complete) we get a lot of skipped frames which then delay ehci timer callback.
>  Then we will calculation  ehci->last_run_ns,but skipped_uframes is int,so "UFRAME_TIMER_NS * skipped_uframes" will be int,and if skipped_uframes is big enough ,it can overflow ,and this can not calculation the right number,then it can   raise  large amountsinterrupts;
>   Observable behaviour is qemu consuming 100% host CPU time while guest is unresponsive. This misbehavior could happen for a while and QEMU does not get out from this state automatically without the patch in Branch-master repository.
> 
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 50ef817f93..8df2f08783 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2238,7 +2238,7 @@ static void ehci_frame_timer(void *opaque)
>      int need_timer = 0;
>      int64_t expire_time, t_now;
>      uint64_t ns_elapsed;
> -    int uframes, skipped_uframes;
> +    uint64 uframes, skipped_uframes;
>      int i;
> 
> 
>      t_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> 

Adding Gerd as USB maintainer to CC.


ATB,

Mark.
