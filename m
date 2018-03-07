Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete2C-0006VZ-VM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete29-0006ae-NN
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:43:29 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45392
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ete29-0006aS-FD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:43:25 -0500
References: <1520415568-19070-1-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c902a158-1d19-d271-ea49-f5a2f72347bd@ilande.co.uk>
Date: Wed, 7 Mar 2018 18:43:11 +0000
MIME-Version: 1.0
In-Reply-To: <1520415568-19070-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc/sun4m: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 07/03/18 09:39, Thomas Huth wrote:

> The global hack for creating SCSI devices has recently been removed,
> but this apparently broke SCSI devices on some boards that were not
> ready for this change yet. For the sun4m machines you now get:
> 
> $ sparc-softmmu/qemu-system-sparc -boot d -cdrom x.iso
> qemu-system-sparc: -cdrom x.iso: machine type does not support if=scsi,bus=0,unit=2
> 
> Fix it by calling scsi_bus_legacy_handle_cmdline() after creating the
> corresponding SCSI controller.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: 1454509726719e0933c800fad00d6999752688ea
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/sparc/sun4m.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 61eb424..0f5804b 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -324,6 +324,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
>   
>       esp = ESP_STATE(object_resolve_path_component(OBJECT(espdma), "esp"));
>       sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> +    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>   
>       ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>                                    OBJECT(dma), "ledma"));
> 

Hi Thomas,

Thanks for the patch - I can confirm that it resolves the issue with 
qemu-system-sparc.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I presume it makes sense for this to go through a tree along with the 
other patches in the set rather than me taking this via my qemu-sparc 
branch?


ATB,

Mark.
