Received: from eggs.gnu.org ([2001:4830:134:3::10]:57140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYEAJ-00059J-VZ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYEAF-0008LH-3Q
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:51:20 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYEAE-0008KW-Vz
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 11:51:15 -0500
Received: by mail-qt0-x242.google.com with SMTP id r39so11120519qtr.13
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 08:51:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-11-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ada7b851-7191-6f53-f450-211a08b18c6f@amsat.org>
Date: Sun, 7 Jan 2018 13:51:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-11-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/16] piix4: add a i8042 keyboard/mouse
 controller as specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Hervé,

On 01/06/2018 12:37 PM, Hervé Poussineau wrote:
> Remove i8042 instanciated in malta board, to not have it twice.

Even if this works, I'm not 100% sure this is correct, since the Malta
board uses the i8042 from the FDC37M817 superio, not from the PIIX4E
southbridge.

I think the problem is this is unclear which PIIX4 is modelled in QEMU.

Apparently this code comes from the i440fx which southbridge companion
is the PIIX3 (what Virtual PC 2007 uses?).

If so, we should model the 2 devices (PIIX3 + PIIX4E for Malta).

> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/piix4.c       | 3 +++
>  hw/mips/mips_malta.c | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 3f59750e5a..1aab78cdd2 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -169,6 +169,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
>      /* DMA */
>      DMA_init(isa_bus, 0);
>  
> +    /* Super I/O */
> +    isa_create_simple(isa_bus, "i8042");
> +
>      piix4_dev = pci_dev;
>      qemu_register_reset(piix4_reset, s);
>  }
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index afe13c684f..7498fad006 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1204,8 +1204,6 @@ void mips_malta_init(MachineState *machine)
>      g_free(smbus_eeprom_buf);
>  
>      /* Super I/O */
> -    isa_create_simple(isa_bus, "i8042");
> -
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>      serial_hds_isa_init(isa_bus, 0, 2);
>      parallel_hds_isa_init(isa_bus, 1);
> 
