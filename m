Received: from eggs.gnu.org ([209.51.188.92]:57847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghHPn-0002KB-GA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghHPm-0006KG-Cb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:15 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:55337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ghHPm-0006Ir-77
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:14 -0500
Received: from player787.ha.ovh.net (unknown [10.109.143.209])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 01D1844B37
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 18:13:11 +0100 (CET)
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
Date: Wed, 9 Jan 2019 18:13:01 +0100
MIME-Version: 1.0
In-Reply-To: <1547051976-13982-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 1/9/19 5:39 PM, Thomas Huth wrote:
> When compiling with Clang and -std=3Dgnu99, I get the following errors:
>=20
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
> In file included from hw/intc/xics_spapr.c:34:
> include/hw/ppc/xics.h:46:25: error: redefinition of typedef 'ICSState' =
is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct ICSState ICSState;
>                         ^
> include/hw/ppc/spapr.h:18:25: note: previous definition is here
> typedef struct ICSState ICSState;
>                         ^
> In file included from hw/intc/xics_spapr.c:34:
> include/hw/ppc/xics.h:203:34: error: redefinition of typedef 'sPAPRMach=
ineState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
>   CC      ppc64-softmmu/hw/intc/spapr_xive.o
> In file included from hw/intc/spapr_xive.c:19:
> include/hw/ppc/spapr_xive.h:38:3: error: redefinition of typedef 'sPAPR=
Xive' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> } sPAPRXive;
>   ^
> include/hw/ppc/spapr.h:20:26: note: previous definition is here
> typedef struct sPAPRXive sPAPRXive;
>                          ^
> In file included from hw/intc/spapr_xive.c:19:
> include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef 'sPAP=
RMachineState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
>   CC      ppc64-softmmu/hw/char/spapr_vty.o
> In file included from hw/char/spapr_vty.c:8:
> In file included from include/hw/ppc/spapr.h:12:
> include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef 'sPAP=
RMachineState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
>=20
> Since we're going to make -std=3Dgnu99 mandatory, fix these issues
> by including the right header files indead of typedeffing stuff twice.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/ppc/spapr.h      | 4 ++--
>  include/hw/ppc/spapr_xive.h | 2 +-
>  include/hw/ppc/xics.h       | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2c77a8b..6a5ae4f 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -8,6 +8,8 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "hw/ppc/spapr_irq.h"
> +#include "hw/ppc/xics.h"
> +#include "hw/ppc/spapr_xive.h"
> =20
>  struct VIOsPAPRBus;
>  struct sPAPRPHBState;
> @@ -15,8 +17,6 @@ struct sPAPRNVRAM;
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> -typedef struct ICSState ICSState;
> -typedef struct sPAPRXive sPAPRXive;
> =20
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 728735d..aff4366 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -42,7 +42,7 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t li=
sn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>  qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
> =20
> -typedef struct sPAPRMachineState sPAPRMachineState;
> +#include "hw/ppc/spapr.h"  /* for sPAPRMachineState */

so both files include each other, how nice ...

>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 14afda1..a7f49a4 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -47,6 +47,8 @@ typedef struct ICSState ICSState;
>  typedef struct ICSIRQState ICSIRQState;
>  typedef struct XICSFabric XICSFabric;
> =20
> +#include "hw/ppc/spapr.h"
> +

and again ... I *really really* prefer forward declarations.



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Grumbles,

C.


>  #define TYPE_ICP "icp"
>  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
> =20
> @@ -200,8 +202,6 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon=
);
>  void ics_resend(ICSState *ics);
>  void icp_resend(ICPState *ss);
> =20
> -typedef struct sPAPRMachineState sPAPRMachineState;
> -
>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
>                     uint32_t phandle);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>=20
