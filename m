Received: from eggs.gnu.org ([2001:4830:134:3::10]:45083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWOms-0004RX-HF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWOmp-0006Ke-E6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:43:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:64170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWOmp-0006K3-2p
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:42:59 -0500
References: <1485333658-23035-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b04729a5-5dd7-ddef-0752-cf240aa88885@vivier.eu>
Date: Wed, 25 Jan 2017 15:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <1485333658-23035-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] null-machine: Add support for the
 "-kernel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Max Filippov <jcmvbkbc@gmail.com>

Le 25/01/2017 à 09:40, Thomas Huth a écrit :
> We can have basic support for the "-kernel" parameter quite easily
> by using the generic loader device. This should be enough for most
> boards which do not need special machine-specific magic for loading
> a kernel (and for those that need special magic, the generic "none"
> machine is likely not suitable for using it as an instruction set
> simulator board anyway).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  PS: If we can't agree on using the generic loader here, I can also
>      prepare a patch instead that simply prints out an error message
>      if the user tried to use the "-kernel" parameter.
> 
>  hw/core/null-machine.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 27c8369..866e699 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -5,6 +5,7 @@
>   *
>   * Authors:
>   *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Thomas Huth       <thuth@redhat.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -16,6 +17,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/boards.h"
> +#include "hw/core/generic-loader.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "cpu.h"
> @@ -40,6 +42,18 @@ static void machine_none_init(MachineState *mch)
>          memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
>          memory_region_add_subregion(get_system_memory(), 0, ram);
>      }
> +
> +    /* Load kernel */
> +    if (mch->kernel_filename) {
> +        DeviceState *loader;
> +
> +        loader = qdev_create(sysbus_get_default(), TYPE_GENERIC_LOADER);
> +        qdev_prop_set_string(loader, "file", mch->kernel_filename);
> +        if (cpu) {
> +            qdev_prop_set_uint32(loader, "cpu-num", cpu->cpu_index);
> +        }
> +        qdev_init_nofail(loader);
> +    }
>  }

It seems you need to check "-cpu" is set otherwise we have a segfault in
the loader:

Thread 1 "qemu-system-m68" received signal SIGSEGV, Segmentation fault.
...
#0  0x000055555564e5f8 in generic_loader_realize (dev=<optimized out>,
errp=0x7fffffffd900) at hw/core/generic-loader.c:141

140         if (!s->force_raw) {
141             size = load_elf_as(s->file, NULL, NULL, &entry, NULL, NULL,
142                                big_endian, 0, 0, 0, s->cpu->as);
143

(gdb) p s->cpu
$2 = (CPUState *) 0x0

Laurent
