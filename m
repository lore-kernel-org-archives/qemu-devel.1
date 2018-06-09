Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fRaym-0005bm-8Z
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 06:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fRayl-0000Ku-CX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 06:20:16 -0400
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-7-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3b205fec-5b93-dc46-6787-77472f806457@ilande.co.uk>
Date: Sat, 9 Jun 2018 11:19:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 06/13] ESP: add pseudo-DMA as used by
 Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 08/06/18 21:05, Laurent Vivier wrote:

> From: Laurent Vivier <Laurent@Vivier.EU>
> 
> Signed-off-by: Laurent Vivier <Laurent@Vivier.EU>
> ---
>   hw/mips/mips_jazz.c   |   2 +-
>   hw/scsi/esp.c         | 330 +++++++++++++++++++++++++++++++++++++++++++++-----
>   include/hw/scsi/esp.h |  15 ++-
>   3 files changed, 313 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 90cb306f53..87118f2d03 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -282,7 +282,7 @@ static void mips_jazz_init(MachineState *machine,
>   
>       /* SCSI adapter */
>       esp = esp_init(0x80002000, 0, rc4030_dma_read, rc4030_dma_write, dmas[0],
> -                   qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
> +                   qdev_get_gpio_in(rc4030, 5), NULL, &esp_reset, &dma_enable);
>       scsi_bus_legacy_handle_cmdline(&esp->bus);
>   
>       /* Floppy */

A quick note here: last year I removed esp_init() from all of the SPARC 
code which means that mips/jazz is the last remaining user.

If we can switch this over to using qdev properties similar to how I did 
in 7f773ff5d0: sparc32_dma: make esp device child of espdma device then 
we can remove this function completely.

Hervé, is this something that you could take a quick look at?


ATB,

Mark.
