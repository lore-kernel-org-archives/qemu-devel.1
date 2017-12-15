Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePrQL-00067x-0r
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePrQK-0005a4-2P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:57:17 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePrQJ-0005Zh-T0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:57:15 -0500
Received: by mail-oi0-x242.google.com with SMTP id l6so6312452oih.11
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 06:57:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171214151906.3250-1-andrew.smirnov@gmail.com>
References: <20171214151906.3250-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 14:56:54 +0000
Message-ID: <CAFEAcA-Chirj4y_YhK7Na_gf5504VNKUGZnfNTN6CHXN9gfZPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc: Add code to emulate PFUZE3000 PMIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.orgn, Andrey Yurovsky <yurovsky@gmail.com>

On 14 December 2017 at 15:19, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Add trivial code to emulate PFUZE3000 PMIC.
>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.orgn
> Cc: yurovsky@gmail.com
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Integrating this into a build system via "obj-y" might not be the best
> way. Does this code need a dedicated CONFIG_ symbol?

Yes, it ought to have a CONFIG_something symbol and be enabled
via the whatever.mak for whatever guest architecture needs this
device.

Is there a board which needs this device? We usually
only add devices together with whatever's using them.

> diff --git a/hw/misc/pfuze3000.c b/hw/misc/pfuze3000.c
> new file mode 100644
> index 0000000000..f414b7c0ba
> --- /dev/null
> +++ b/hw/misc/pfuze3000.c
> @@ -0,0 +1,212 @@
> +/*
> + *
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.

The .h file is "v2 or later", but the .c file is "v2 or v3".
Is that an intentional difference? Generally we go with "v2 or later".

> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

> +static void pfuze3000_reset(DeviceState *ds)
> +{
> +    PFuze3000State *s = PFUZE3000(ds);
> +
> +    s->reg = PFUZE100_INVAL;

This function needs to reset all the device state
(all the fields that the guest can modify).

Code looks OK otherwise.

thanks
-- PMM
