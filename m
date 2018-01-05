Received: from eggs.gnu.org ([2001:4830:134:3::10]:53051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eXZWB-0008SN-Lk
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eXZW7-0004LH-JN
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:27:11 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eXZW7-0004KC-65
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:27:07 -0500
Received: by mail-lf0-x241.google.com with SMTP id e27so6439589lfb.9
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 13:27:06 -0800 (PST)
Date: Sat, 6 Jan 2018 00:41:05 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180106004105.281b992abcf939b0cf45b88f@gmail.com>
In-Reply-To: <1514940265-18093-13-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-13-git-send-email-mjc@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 12/21] RISC-V HART Array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed,  3 Jan 2018 13:44:16 +1300
Michael Clark <mjc@sifive.com> wrote:

> Holds the state of a heterogenous array of RISC-V hardware threads.

...

> --- /dev/null
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -0,0 +1,45 @@
> +/*
> + * QEMU RISC-V Hart Array interface
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + *
> + * Holds the state of a heterogenous array of RISC-V harts
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_RISCV_HART_H
> +#define HW_RISCV_HART_H
> +
> +#define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
> +
> +#define RISCV_HART_ARRAY(obj) \
> +    OBJECT_CHECK(RISCVHartArrayState, (obj), TYPE_RISCV_HART_ARRAY)
> +
> +typedef struct RISCVHartArrayState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    uint32_t num_harts;
> +    char *cpu_model;
> +    RISCVCPU *harts;
> +} RISCVHartArrayState;
> +
> +#endif
> --=20
> 2.7.0

Hmm, you use SysBusDevice, uint32_t and RISCVCPU types but there is no head=
er files
inclusion to define these types.

I propose this fixup:

--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -27,6 +27,10 @@
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
=20
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+
 #define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
=20
 #define RISCV_HART_ARRAY(obj) \


Some files in include/hw/riscv/ are affected by this problem (e.g. sifive_u=
art.h).

--=20
Best regards,
=A0 Antony Pavlov
