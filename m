Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czOqu-0001Qo-63
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 10:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czOqr-00069a-2C
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 10:39:04 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czOqq-00069L-Ta
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 10:39:00 -0400
Received: by mail-qt0-x241.google.com with SMTP id c45so14082456qtb.0
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 07:39:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491381329-3995-15-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <21da6ce9-8ccc-943d-b540-d49bbb1ec874@amsat.org>
Date: Sat, 15 Apr 2017 11:38:57 -0300
MIME-Version: 1.0
In-Reply-To: <1491381329-3995-15-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/14] tcx: switch to load_image_mr() and
 remove prom_addr hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04/05/2017 05:35 AM, Mark Cave-Ayland wrote:
> Previous to the existence of load_image_mr(), the only way to load in the
> FCode ROM image was to pass in its physical address via qdev properties
> and use load_image_targphys().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/tcx.c |    4 +---
>  hw/sparc/sun4m.c |    1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 3f00735..5a1115c 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -843,8 +843,7 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
>      vmstate_register_ram_global(&s->rom);
>      fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, TCX_ROM_FILE);
>      if (fcode_filename) {
> -        ret = load_image_targphys(fcode_filename, s->prom_addr,
> -                                  FCODE_MAX_ROM_SIZE);
> +        ret = load_image_mr(fcode_filename, &s->rom);
>          g_free(fcode_filename);
>          if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
>              error_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
> @@ -902,7 +901,6 @@ static Property tcx_properties[] = {
>      DEFINE_PROP_UINT16("width",    TCXState, width,     -1),
>      DEFINE_PROP_UINT16("height",   TCXState, height,    -1),
>      DEFINE_PROP_UINT16("depth",    TCXState, depth,     -1),
> -    DEFINE_PROP_UINT64("prom_addr", TCXState, prom_addr, -1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 7a0922b..5f022cc 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -491,7 +491,6 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
>      qdev_prop_set_uint16(dev, "width", width);
>      qdev_prop_set_uint16(dev, "height", height);
>      qdev_prop_set_uint16(dev, "depth", depth);
> -    qdev_prop_set_uint64(dev, "prom_addr", addr);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
>
>
