Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e43WQ-0000nR-Jm
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e43WN-0008Rf-9f
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:25:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1e43WN-0008R4-1P
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:25:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so2089852wmd.4
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 04:25:21 -0700 (PDT)
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<231156c8147daa1677d29d16d368030ea38adf62.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <47dfe892-3f0e-58c9-1f18-767618319f90@tuxfamily.org>
Date: Mon, 16 Oct 2017 13:25:17 +0200
MIME-Version: 1.0
In-Reply-To: <231156c8147daa1677d29d16d368030ea38adf62.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/47] hw/m68k: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 30.09.2017 02:16, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> @@ -83,7 +83,7 @@ static void an5206_init(MachineState *machine)
>          entry = KERNEL_LOAD_ADDR;
>      }
>      if (kernel_size < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
> +        error_report("qemu: could not load kernel '%s'", kernel_filename);

I just noticed: The "qemu:" prefix should also be dropped when using
error_report() now. I can change that while applying the patch.

>          exit(1);
>      }
>  
[...]
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index b9dde75106..2fb5037b72 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -6,6 +6,7 @@
>   * This code is licensed under the GPL
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -257,7 +258,7 @@ static void mcf5208evb_init(MachineState *machine)
>      mcf5208_sys_init(address_space_mem, pic);
>  
>      if (nb_nics > 1) {
> -        fprintf(stderr, "Too many NICs\n");
> +        error_report("Too many NICs");
>          exit(1);
>      }
>      if (nd_table[0].used) {
> @@ -292,7 +293,7 @@ static void mcf5208evb_init(MachineState *machine)
>          if (qtest_enabled()) {
>              return;
>          }
> -        fprintf(stderr, "Kernel image must be specified\n");
> +        error_report("Kernel image must be specified");
>          exit(1);
>      }
>  
> @@ -309,7 +310,7 @@ static void mcf5208evb_init(MachineState *machine)
>          entry = 0x40000000;
>      }
>      if (kernel_size < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
> +        error_report("qemu: could not load kernel '%s'", kernel_filename);
>          exit(1);
>      }

dito.

 Thomas
