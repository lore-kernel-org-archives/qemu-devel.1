Received: from eggs.gnu.org ([209.51.188.92]:41584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw7rD-00085b-RD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw7rD-0005Tc-15
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:02:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw7rB-0005QF-Ud
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:02:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so9215941wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:02:50 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15b742d6-18e9-dfd6-dac2-2613c0b93e76@redhat.com>
Date: Tue, 19 Feb 2019 17:02:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, Magnus Damm <magnus.damm@gmail.com>, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/18/19 1:56 PM, Markus Armbruster wrote:
> pflash_cfi02_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
> number of blocks.  The latter happens to win.  I tried to find
> documentation on the physcial hardware, no luck.
> 
> For now, adjust the byte size passed to match the actual size created,
> and add a FIXME comment.
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/sh4/r2d.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index dcdb3728cb..ed18d1f351 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -290,7 +290,14 @@ static void r2d_init(MachineState *machine)
>  
>      /* onboard flash memory */
>      dinfo = drive_get(IF_PFLASH, 0, 0);
> -    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
> +    /*
> +     * FIXME The code is confused about the size of the flash.  It
> +     * used to pass FLASH_SIZE bytes, in FLASH_SIZE >> 16 blocks of
> +     * 16KiB each, which does not compute, but creates one of
> +     * FLASH_SIZE / 4 bytes anyway.  The current code does so too, but
> +     * whether it's the right size is anybody's guess.
> +     */
> +    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE / 4,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                            16 * KiB, FLASH_SIZE >> 16,
>                            1, 4, 0x0000, 0x0000, 0x0000, 0x0000,

Good news: when you read (0x0000, 0x0000, 0x0000, 0x0000) pflash IDs,
that means the code uses the "Virt PFlash". IOW this is not a physical
model, since the guest obviously doesn't care about checking the flash
model.
The "VirtPFlash" only has 64KiB sectors.

I suggest we add a pflash_cfi02_create_virt(reduced args) helper to make
this obvious:

  pflash_cfi02_create_virt(paddr, name, size_bytes, mapping?).
