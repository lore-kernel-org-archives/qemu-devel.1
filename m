Received: from eggs.gnu.org ([2001:4830:134:3::10]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCRtm-0007PC-Ax
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCRth-0007yI-Dg
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:08:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCRth-0007xb-6M
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:08:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so26224754wrw.12
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:08:41 -0700 (PDT)
References: <20181016112232.23241-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d6e0147-2f05-e2a6-2a24-003ce8a75058@redhat.com>
Date: Tue, 16 Oct 2018 18:08:37 +0200
MIME-Version: 1.0
In-Reply-To: <20181016112232.23241-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pckbd: Convert DPRINTF->trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 16/10/2018 13:22, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/input/pckbd.c      | 19 ++++++-------------
>  hw/input/trace-events |  7 +++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 07c8801387..3d9eded323 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -30,14 +30,7 @@
>  #include "hw/input/i8042.h"
>  #include "sysemu/sysemu.h"
>  
> -/* debug PC keyboard */
> -//#define DEBUG_KBD
> -#ifdef DEBUG_KBD
> -#define DPRINTF(fmt, ...)                                       \
> -    do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
>  
>  /*	Keyboard Controller Commands */
>  #define KBD_CCMD_READ_MODE	0x20	/* Read mode bits */
> @@ -210,7 +203,7 @@ static uint64_t kbd_read_status(void *opaque, hwaddr addr,
>      KBDState *s = opaque;
>      int val;
>      val = s->status;
> -    DPRINTF("kbd: read status=0x%02x\n", val);
> +    trace_pckbd_kbd_read_status(val);
>      return val;
>  }
>  
> @@ -224,7 +217,7 @@ static void kbd_queue(KBDState *s, int b, int aux)
>  
>  static void outport_write(KBDState *s, uint32_t val)
>  {
> -    DPRINTF("kbd: write outport=0x%02x\n", val);
> +    trace_pckbd_outport_write(val);
>      s->outport = val;
>      qemu_set_irq(s->a20_out, (val >> 1) & 1);
>      if (!(val & 1)) {
> @@ -237,7 +230,7 @@ static void kbd_write_command(void *opaque, hwaddr addr,
>  {
>      KBDState *s = opaque;
>  
> -    DPRINTF("kbd: write cmd=0x%02" PRIx64 "\n", val);
> +    trace_pckbd_kbd_write_command(val);
>  
>      /* Bits 3-0 of the output port P2 of the keyboard controller may be pulsed
>       * low for approximately 6 micro seconds. Bits 3-0 of the KBD_CCMD_PULSE
> @@ -326,7 +319,7 @@ static uint64_t kbd_read_data(void *opaque, hwaddr addr,
>      else
>          val = ps2_read_data(s->kbd);
>  
> -    DPRINTF("kbd: read data=0x%02x\n", val);
> +    trace_pckbd_kbd_read_data(val);
>      return val;
>  }
>  
> @@ -335,7 +328,7 @@ static void kbd_write_data(void *opaque, hwaddr addr,
>  {
>      KBDState *s = opaque;
>  
> -    DPRINTF("kbd: write data=0x%02" PRIx64 "\n", val);
> +    trace_pckbd_kbd_write_data(val);
>  
>      switch(s->write_cmd) {
>      case 0:
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index 3965a842ae..8e53ae5bbf 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -14,6 +14,13 @@ adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x o
>  adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
>  adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>  
> +# hw/input/pckbd.c
> +pckbd_kbd_read_data(uint32_t val) "0x%02x"

I usually prefer same read/write pairs, but that doesn't matter here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +pckbd_kbd_read_status(int status) "0x%02x"
> +pckbd_outport_write(uint32_t val) "0x%02x"
> +pckbd_kbd_write_command(uint64_t val) "0x%02"PRIx64
> +pckbd_kbd_write_data(uint64_t val) "0x%02"PRIx64
> +
>  # hw/input/ps2.c
>  ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
>  ps2_keyboard_event(void *opaque, int qcode, int down, unsigned int modifier, unsigned int modifiers) "%p qcode %d down %d modifier 0x%x modifiers 0x%x"
> 
