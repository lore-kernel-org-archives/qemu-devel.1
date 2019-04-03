Received: from eggs.gnu.org ([209.51.188.92]:43194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBfL7-0004bM-4z
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBfL6-0003Gk-3t
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:50:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hBfL5-0003FQ-S1
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:50:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so7245467wma.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:49:59 -0700 (PDT)
References: <20190319144013.26584-1-pbonzini@redhat.com>
	<20190319144013.26584-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6baec386-3040-b84c-930a-2619fee5f32f@redhat.com>
Date: Wed, 3 Apr 2019 14:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190319144013.26584-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sun4m: obey -vga none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Hi Paolo,

On 3/19/19 3:40 PM, Paolo Bonzini wrote:
> Do not create a TCX if "-vga none" was passed on the command line.
> Remove some dead code along the way to avoid big reindentation.

Can you add:

This fixes when configuring with --without-default-devices:

  $ sparc-softmmu/qemu-system-sparc
  qemu-system-sparc: Unknown device 'SUNW,tcx' for default sysbus
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007fc78d17d895 in __GI_abort () at abort.c:79
  #2  0x0000560beaf637f3 in qdev_create (bus=bus@entry=0x0,
name=name@entry=0x560beb1be36b "SUNW,tcx") at hw/core/qdev.c:131
  #3  0x0000560beaf1392d in tcx_init (vram_size=1048576, width=1024,
height=768, depth=8, irq=0x560bed1a0230, addr=1342177280) at
hw/sparc/sun4m.c:477
  #4  0x0000560beaf1392d in sun4m_hw_init (hwdef=0x560beb1be780
<sun4m_hwdefs>, machine=0x560becf65f00) at hw/sparc/sun4m.c:943
  #5  0x0000560beaf6b15b in machine_run_board_init
(machine=0x560becf65f00) at hw/core/machine.c:1030
  #6  0x0000560beae86692 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at vl.c:4463

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sparc/sun4m.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ca1e3825d5..07d126aea8 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -850,7 +850,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      uint32_t initrd_size;
>      DriveInfo *fd[MAX_FD];
>      FWCfgState *fw_cfg;
> -    unsigned int num_vsimms;
>      DeviceState *dev;
>      SysBusDevice *s;
>  
> @@ -909,8 +908,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          error_report("Unsupported depth: %d", graphic_depth);
>          exit (1);
>      }
> -    num_vsimms = 0;
> -    if (num_vsimms == 0) {
> +    if (vga_interface_type != VGA_NONE) {
>          if (vga_interface_type == VGA_CG3) {
>              if (graphic_depth != 8) {
>                  error_report("Unsupported depth: %d", graphic_depth);
> @@ -945,7 +943,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          }
>      }
>  
> -    for (i = num_vsimms; i < MAX_VSIMMS; i++) {
> +    for (i = 0; i < MAX_VSIMMS; i++) {
>          /* vsimm registers probed by OBP */
>          if (hwdef->vsimm[i].reg_base) {
>              empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
> 
