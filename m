Received: from eggs.gnu.org ([2001:4830:134:3::10]:48134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1caOhb-0005Yz-88
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 10:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1caOhW-0006z5-U7
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 10:26:07 -0500
Received: from mo179.mail-out.ovh.net ([178.32.228.179]:39076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1caOhW-0006xd-Jl
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 10:26:02 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 45B781FE86
	for <qemu-devel@nongnu.org>; Sun,  5 Feb 2017 16:25:52 +0100 (CET)
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-2-git-send-email-fred.konrad@greensocs.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a4aa34e4-dd2b-4d0a-543e-c19e5fced1b4@kaod.org>
Date: Sun, 5 Feb 2017 16:25:45 +0100
MIME-Version: 1.0
In-Reply-To: <1485424060-12217-2-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 01/10] qemu-clk: introduce qemu-clk qom
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

ello Frederic,

On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This introduces qemu-clk qom object.
> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  Makefile.objs             |  1 +
>  include/qemu/qemu-clock.h | 40 +++++++++++++++++++++++++++++++++++++
>  qemu-clock.c              | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 include/qemu/qemu-clock.h
>  create mode 100644 qemu-clock.c
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 01cef86..de0219d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -78,6 +78,7 @@ common-obj-y += backends/
>  common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
>  
>  common-obj-$(CONFIG_FDT) += device_tree.o
> +common-obj-y += qemu-clock.o
>  
>  ######################################################################
>  # qapi
> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
> new file mode 100644
> index 0000000..e7acd68
> --- /dev/null
> +++ b/include/qemu/qemu-clock.h
> @@ -0,0 +1,40 @@
> +/*
> + * QEMU Clock
> + *
> + *  Copyright (C) 2016 : GreenSocs Ltd
> + *      http://www.greensocs.com/ , email: info@greensocs.com
> + *
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.

May be we could shorten the GPL v2 statement to something like :
 
 * This code is licensed under the GPL version 2 or later. See the
 * COPYING file in the top-level directory.

I haven't been very good at that my self, but we could save 
quite a few lines in qemu if files were not repeating the 
License statement.


> + *
> + */
> +
> +#ifndef QEMU_CLOCK_H
> +#define QEMU_CLOCK_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#define TYPE_CLOCK "qemu-clk"
> +#define QEMU_CLOCK(obj) OBJECT_CHECK(struct qemu_clk, (obj), TYPE_CLOCK)
> +
> +typedef struct qemu_clk {
> +    /*< private >*/
> +    Object parent_obj;
> +} *qemu_clk;
>

CODING_STYLE says that we should use CamelCase for typedef. Also, I don't 
think the '*' is required. What's the idea ? 

> +#endif /* QEMU_CLOCK_H */
> +
> +
> diff --git a/qemu-clock.c b/qemu-clock.c
> new file mode 100644
> index 0000000..ceea98d
> --- /dev/null
> +++ b/qemu-clock.c
> @@ -0,0 +1,50 @@
> +/*
> + * QEMU Clock
> + *
> + *  Copyright (C) 2016 : GreenSocs Ltd
> + *      http://www.greensocs.com/ , email: info@greensocs.com
> + *
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-clock.h"
> +#include "hw/hw.h"
> +#include "qemu/log.h"
> +
> +#ifndef DEBUG_QEMU_CLOCK
> +#define DEBUG_QEMU_CLOCK 0
> +#endif
> +
> +#define DPRINTF(fmt, args...) do {                                           \
> +    if (DEBUG_QEMU_CLOCK) {                                                  \
> +        qemu_log("%s: " fmt, __func__, ## args);                             \
> +    }                                                                        \
> +} while (0);

I think the trace framework should be used instead.

Thanks

C.

> +static const TypeInfo qemu_clk_info = {
> +    .name          = TYPE_CLOCK,
> +    .parent        = TYPE_OBJECT,
> +    .instance_size = sizeof(struct qemu_clk),
> +};
> +
> +static void qemu_clk_register_types(void)
> +{
> +    type_register_static(&qemu_clk_info);
> +}
> +
> +type_init(qemu_clk_register_types);
> 
