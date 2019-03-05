Received: from eggs.gnu.org ([209.51.188.92]:42516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EBU-0004oR-Sx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EBU-0008CN-2x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:48:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1EBT-00089s-9x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:48:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so10463513wrx.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:48:53 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-9-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71bfd7e6-abda-d26d-b3d3-e4c2ed9e98f8@redhat.com>
Date: Tue, 5 Mar 2019 18:48:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] r2d: Flash memory creation is
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

On 2/26/19 8:34 PM, Markus Armbruster wrote:
> pflash_cfi02_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
> number of blocks.  The latter happens to win.  I tried to find
> documentation on the physical hardware, no luck.
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

NAck, please see suggestion on v1:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01206.html

>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                            16 * KiB, FLASH_SIZE >> 16,
>                            1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
> 
