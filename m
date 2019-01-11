Received: from eggs.gnu.org ([209.51.188.92]:58660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwNz-0001Sc-2B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwNx-0005AW-FF
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghwNx-0005AB-9F
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2276815wmf.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 04:58:05 -0800 (PST)
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-2-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ebbd119e-0b51-127b-e26b-feda45010101@redhat.com>
Date: Fri, 11 Jan 2019 13:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <1547194672-24169-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] ppc: Move spapr-related prototypes
 from xics.h into a seperate header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On 1/11/19 9:17 AM, Thomas Huth wrote:
> When compiling with Clang in -std=gnu99 mode, there is a warning/error:
> 
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
> In file included from /home/thuth/devel/qemu/hw/intc/xics_spapr.c:34:
> /home/thuth/devel/qemu/include/hw/ppc/xics.h:203:34: error: redefinition of typedef 'sPAPRMachineState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> /home/thuth/devel/qemu/include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> 
> We have to remove the duplicated typedef here and include "spapr.h" instead.
> But "spapr.h" should not be included for the pnv machine files. So move
> the spapr-related prototypes into a new file called "xics_spapr.h" instead.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/intc/xics_kvm.c          |  1 +
>  hw/intc/xics_spapr.c        |  1 +
>  hw/ppc/spapr_irq.c          |  1 +
>  include/hw/ppc/xics.h       |  7 -------
>  include/hw/ppc/xics_spapr.h | 37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 40 insertions(+), 7 deletions(-)
>  create mode 100644 include/hw/ppc/xics_spapr.h
> 
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index ac94594..dff1330 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/kvm.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/xics_spapr.h"
>  #include "kvm_ppc.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 9c1a90d..de6cc15 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -32,6 +32,7 @@
>  #include "qemu/timer.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/xics_spapr.h"
>  #include "hw/ppc/fdt.h"
>  #include "qapi/visitor.h"
>  
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 5fce72f..1da7a32 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -14,6 +14,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_xive.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/xics_spapr.h"
>  #include "sysemu/kvm.h"
>  
>  #include "trace.h"
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 07508cb..fad786e 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -200,13 +200,6 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon);
>  void ics_resend(ICSState *ics);
>  void icp_resend(ICPState *ss);
>  
> -typedef struct sPAPRMachineState sPAPRMachineState;
> -
> -void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
> -                   uint32_t phandle);
> -int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> -void xics_spapr_init(sPAPRMachineState *spapr);
> -
>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
>                     Error **errp);
>  
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> new file mode 100644
> index 0000000..b1ab27d
> --- /dev/null
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -0,0 +1,37 @@
> +/*
> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
> + *
> + * PAPR Virtualized Interrupt System, aka ICS/ICP aka xics
> + *
> + * Copyright (c) 2010, 2011 David Gibson, IBM Corporation.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef XICS_SPAPR_H
> +#define XICS_SPAPR_H
> +
> +#include "hw/ppc/spapr.h"
> +
> +void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
> +                   uint32_t phandle);
> +int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> +void xics_spapr_init(sPAPRMachineState *spapr);
> +
> +#endif /* XICS_SPAPR_H */
> 
