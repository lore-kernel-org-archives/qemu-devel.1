Received: from eggs.gnu.org ([209.51.188.92]:37749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3Lg-0000kX-EN
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3Lf-0005U0-0p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG3Le-0005TN-OE
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so22452115wrn.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:16:42 -0700 (PDT)
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f16cbd3d-589d-2af8-1d86-b595ef0d0255@redhat.com>
Date: Mon, 15 Apr 2019 17:16:33 +0200
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hppa: drop usage of
 memory_region_allocate_system_memory() for ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 4/15/19 3:27 PM, Igor Mammedov wrote:
> machine_hppa_init() violates memory_region_allocate_system_memory() contract
> by calling it multiple times which could break with -mem-path. Replace
> the second usage (for 'rom') with memory_region_init_ram() instead.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/hppa/machine.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d1b1d3c..b413913 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -158,9 +158,8 @@ static void machine_hppa_init(MachineState *machine)
>      g_free(firmware_filename);
>  
>      rom_region = g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
> -                                         "firmware",
> -                                         (FIRMWARE_END - FIRMWARE_START));
> +    memory_region_init_ram(rom_region, NULL, "firmware",
> +                           (FIRMWARE_END - FIRMWARE_START), &error_fatal);
>      memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
>  
>      /* Load kernel */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
