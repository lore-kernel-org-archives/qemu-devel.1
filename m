Received: from eggs.gnu.org ([2001:4830:134:3::10]:52230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamvh-0001gS-UZ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamvd-00052P-11
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:22:49 -0500
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:39213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamvc-00052E-SH
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:22:44 -0500
Received: by mail-qk0-x22e.google.com with SMTP id c69so5301316qkg.6
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 10:22:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180108024558.17983-1-f4bug@amsat.org>
	<20180108024558.17983-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40ab8186-dddc-39cc-2514-077c941d72a6@amsat.org>
Date: Sun, 14 Jan 2018 15:22:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180108024558.17983-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/29] hw/isa: add a generic
 isa_superio_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 01/07/2018 11:45 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/isa/superio.h | 17 +++++++++++++++++
>  hw/isa/isa-superio.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS              |  2 ++
>  hw/isa/Makefile.objs     |  1 +
>  4 files changed, 65 insertions(+)
>  create mode 100644 include/hw/isa/superio.h
>  create mode 100644 hw/isa/isa-superio.c
> 
> diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
> new file mode 100644
> index 0000000000..e685b96653
> --- /dev/null
> +++ b/include/hw/isa/superio.h
> @@ -0,0 +1,17 @@
> +/*
> + * Generic ISA Super I/O
> + *
> + * Copyright (c) 2018 Philippe Mathieu-Daudé
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef HW_ISA_SUPERIO_H
> +#define HW_ISA_SUPERIO_H
> +
> +#include "hw/isa/isa.h"
> +
> +ISADevice *isa_superio_init(ISABus *isa_bus, int serial_count,
> +                            int parallel_count, int drive_count);

This approach is simple enough, but how Hervé wrote hw/isa/pc87312.c is
way cleaner, so I'll respin using it.

> +
> +#endif
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> new file mode 100644
> index 0000000000..93d8457c6b
> --- /dev/null
> +++ b/hw/isa/isa-superio.c
> @@ -0,0 +1,45 @@
> +/*
> + * Generic ISA Super I/O
> + *
> + * Copyright (c) 2018 Philippe Mathieu-Daudé
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/blockdev.h"
> +#include "hw/isa/superio.h"
> +#include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
> +#include "hw/block/fdc.h"
> +#include "hw/input/i8042.h"
> +
> +ISADevice *isa_superio_init(ISABus *isa_bus, int serial_count,
> +                            int parallel_count, int drive_count)
> +{
> +    serial_hds_isa_init(isa_bus, 0, serial_count);
> +
> +    parallel_hds_isa_init(isa_bus, parallel_count);
> +
> +    if (drive_count) {
> +        DriveInfo **fd;
> +        int i;
> +
> +        if (drive_count > MAX_FD) {
> +            warn_report("superio: ignoring %d floppy controllers",
> +                        drive_count - MAX_FD);
> +            drive_count = MAX_FD;
> +        }
> +        fd = g_new(DriveInfo *, drive_count);
> +
> +        for (i = 0; i < drive_count; i++) {
> +            fd[i] = drive_get(IF_FLOPPY, 0, i);
> +        }
> +        fdctrl_init_isa(isa_bus, fd);
> +
> +        g_free(fd); /* FIXME */
> +    }
> +
> +    return isa_create_simple(isa_bus, TYPE_I8042);
> +}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f9e98a046..6f867da743 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -875,6 +875,7 @@ F: hw/input/pckbd.c
>  F: hw/intc/apic*
>  F: hw/intc/ioapic*
>  F: hw/intc/i8259*
> +F: hw/isa/isa-superio.c
>  F: hw/misc/debugexit.c
>  F: hw/misc/pc-testdev.c
>  F: hw/timer/hpet*
> @@ -885,6 +886,7 @@ F: include/hw/display/vga.h
>  F: include/hw/char/parallel.h
>  F: include/hw/dma/i8257.h
>  F: include/hw/i2c/pm_smbus.h
> +F: include/hw/isa/superio.h
>  F: include/hw/input/i8042.h
>  F: include/hw/timer/hpet.h
>  F: include/hw/timer/i8254*
> diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
> index fb37c55cf2..cac655ba58 100644
> --- a/hw/isa/Makefile.objs
> +++ b/hw/isa/Makefile.objs
> @@ -1,4 +1,5 @@
>  common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
> +common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
>  common-obj-$(CONFIG_APM) += apm.o
>  common-obj-$(CONFIG_I82378) += i82378.o
>  common-obj-$(CONFIG_PC87312) += pc87312.o
> 
