Received: from eggs.gnu.org ([2001:4830:134:3::10]:60562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRw6u-0007kL-Ba
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRw6t-0007Sm-3L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:26:20 -0500
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-4-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7291a08c-a291-c2b4-f520-71a516b391d7@redhat.com>
Date: Wed, 28 Nov 2018 10:26:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180921161939.822-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/11] hw/arm/aspeed: Add an Aspeed
 machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

On 2018-09-21 18:19, C=C3=A9dric Le Goater wrote:
> The code looks better, it removes duplicated lines and it will ease
> the introduction of common properties for the Aspeed machines.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/aspeed.h |  46 +++++++++
>  hw/arm/aspeed.c         | 212 +++++++++++++---------------------------
>  2 files changed, 116 insertions(+), 142 deletions(-)
>  create mode 100644 include/hw/arm/aspeed.h
>=20
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> new file mode 100644
> index 000000000000..325c091d09e4
> --- /dev/null
> +++ b/include/hw/arm/aspeed.h
> @@ -0,0 +1,46 @@
> +/*
> + * Aspeed Machines
> + *
> + * Copyright 2018 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef ARM_ASPEED_H
> +#define ARM_ASPEED_H
> +
> +#include "hw/boards.h"
> +
> +typedef struct AspeedBoardState AspeedBoardState;

 Hi C=C3=A9dric,

this patch breaks compiling with clang v3.4.2 here:

 CC      aarch64-softmmu/hw/arm/aspeed.o
hw/arm/aspeed.c:36:3: error: redefinition of typedef 'AspeedBoardState' i=
s a C11
      feature [-Werror,-Wtypedef-redefinition]
} AspeedBoardState;
  ^
include/hw/arm/aspeed.h:14:33: note: previous definition is here
typedef struct AspeedBoardState AspeedBoardState;
                                ^
1 error generated.
make[1]: *** [hw/arm/aspeed.o] Error 1
make: *** [subdir-aarch64-softmmu] Error 2

Seems like it can be fixed like this:

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -29,11 +29,11 @@ static struct arm_boot_info aspeed_board_binfo =3D {
     .nb_cpus =3D 1,
 };
=20
-typedef struct AspeedBoardState {
+struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram;
     MemoryRegion max_ram;
-} AspeedBoardState;
+};

... does that look OK for you, too?

> +typedef struct AspeedBoardConfig {
> +    const char *name;
> +    const char *desc;
> +    const char *soc_name;
> +    uint32_t hw_strap1;
> +    const char *fmc_model;
> +    const char *spi_model;
> +    uint32_t num_cs;
> +    void (*i2c_init)(AspeedBoardState *bmc);
> +} AspeedBoardConfig;
> +
> +#define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> +#define ASPEED_MACHINE(obj) \
> +    OBJECT_CHECK(AspeedMachine, (obj), TYPE_ASPEED_MACHINE)
> +
> +typedef struct AspeedMachine {
> +    MachineState parent_obj;
> +} AspeedMachine;
> +
> +#define ASPEED_MACHINE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(AspeedMachineClass, (klass), TYPE_ASPEED_MACHI=
NE)
> +#define ASPEED_MACHINE_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(AspeedMachineClass, (obj), TYPE_ASPEED_MACHINE)
> +
> +typedef struct AspeedMachineClass {
> +    MachineClass parent_obj;
> +    const AspeedBoardConfig *board;
> +} AspeedMachineClass;
> +
> +
> +#endif

 Thomas
