Received: from eggs.gnu.org ([2001:4830:134:3::10]:39322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRakl-0005Ck-Bx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRakg-00084Y-C3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:38:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRakf-0007ZL-31
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:37:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so22107883wrx.9
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:37:56 -0800 (PST)
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
	<1543312923-3074-2-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff6a7b36-b9ce-cb45-4aef-57e7cb325665@redhat.com>
Date: Tue, 27 Nov 2018 11:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <1543312923-3074-2-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw: pc: use TYPE_XXX instead of
 constant strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, armbru@redhat.com, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org

On 27/11/18 11:02, Li Qiang wrote:
> TYPE_VMMOUSE is defined in vmmouse.c currently, move it
> to pc.h in order to use it in pc.c.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
> 
> Change since v1: remove the unnecessary change
> 
>  hw/i386/pc.c         | 6 +++---
>  hw/i386/vmmouse.c    | 1 -
>  include/hw/i386/pc.h | 3 +++
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f095725dba..73c7b777a0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1543,10 +1543,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>          fdctrl_init_isa(isa_bus, fd);
>      }
>  
> -    i8042 = isa_create_simple(isa_bus, "i8042");
> +    i8042 = isa_create_simple(isa_bus, TYPE_I8042);
>      if (!no_vmport) {
>          vmport_init(isa_bus);
> -        vmmouse = isa_try_create(isa_bus, "vmmouse");
> +        vmmouse = isa_try_create(isa_bus, TYPE_VMMOUSE);
>      } else {
>          vmmouse = NULL;
>      }
> @@ -1555,7 +1555,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>          qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
>          qdev_init_nofail(dev);
>      }
> -    port92 = isa_create_simple(isa_bus, "port92");
> +    port92 = isa_create_simple(isa_bus, TYPE_PORT92);

Reminds me of
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06710.html ;)

>  
>      a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
>      i8042_setup_a20_line(i8042, a20_line[0]);
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 5d2d278be4..4412eaf604 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -52,7 +52,6 @@
>  #define DPRINTF(fmt, ...) do { } while (0)
>  #endif
>  
> -#define TYPE_VMMOUSE "vmmouse"
>  #define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
>  
>  typedef struct VMMouseState
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 136fe497b6..c708ac9265 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -169,6 +169,9 @@ void gsi_handler(void *opaque, int n, int level);
>  #define TYPE_VMPORT "vmport"
>  typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
>  
> +/* vmmouse.c */
> +#define TYPE_VMMOUSE "vmmouse"
> +
>  static inline void vmport_init(ISABus *bus)
>  {
>      isa_create_simple(bus, TYPE_VMPORT);
> 
