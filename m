Received: from eggs.gnu.org ([209.51.188.92]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk3rI-0004qT-Vs
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk3rG-00088F-Vf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:08 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:45007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk3rG-0007LH-NB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:06 -0500
Received: from player794.ha.ovh.net (unknown [10.109.159.159])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id ADE3D109E6A
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:20:51 +0100 (CET)
Date: Thu, 17 Jan 2019 10:20:39 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190117102039.7199d827@bahia.lan>
In-Reply-To: <1547715649-27868-1-git-send-email-thuth@redhat.com>
References: <2e726e3f-048d-f9ce-4884-1cdebf7f0997@kaod.org>
	<1547715649-27868-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] ppc: Fix duplicated typedefs to be able
 to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Thu, 17 Jan 2019 10:00:49 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When compiling the ppc code with clang and -std=3Dgnu99, there are a
> couple of warnings/errors like this one:
>=20
>   CC      ppc64-softmmu/hw/intc/xics.o
> In file included from hw/intc/xics.c:35:
> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState' is=
 a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct ICPState ICPState;
>                         ^
> target/ppc/cpu.h:1181:25: note: previous definition is here
> typedef struct ICPState ICPState;
>                         ^
> Work around the problems by including the proper headers in spapr.h
> and by using struct forward declarations in cpu.h.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  As discussed on IRC, C=C3=A9dric's patches likely should go via David's =
ppc-
>  tree, so I'll go with this version here for my gnu99-PULL request.
>  (v6: Don't use #includes in cpu.h, use forward struct definitions instea=
d)
>=20

Yeah, now that we know where we're going, I would certainly not hold your
gnu99 work off anymore :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr.h      | 5 +++--
>  include/hw/ppc/spapr_xive.h | 2 --
>  target/ppc/cpu.h            | 9 +++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9e01a5a..a947a0a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -8,15 +8,16 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "hw/ppc/spapr_irq.h"
> +#include "hw/ppc/spapr_xive.h"  /* For sPAPRXive */
> +#include "hw/ppc/xics.h"        /* For ICSState */
> =20
>  struct VIOsPAPRBus;
>  struct sPAPRPHBState;
>  struct sPAPRNVRAM;
> +
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> -typedef struct ICSState ICSState;
> -typedef struct sPAPRXive sPAPRXive;
> =20
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7fdc250..9bec919 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -41,8 +41,6 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lis=
n, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> =20
> -typedef struct sPAPRMachineState sPAPRMachineState;
> -
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 486abaf..a62ff60 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1177,8 +1177,9 @@ do {                                            \
> =20
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> -typedef struct XiveTCTX XiveTCTX;
> -typedef struct ICPState ICPState;
> +
> +struct XiveTCTX;
> +struct ICPState;
> =20
>  /**
>   * PowerPCCPU:
> @@ -1197,8 +1198,8 @@ struct PowerPCCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> -    ICPState *icp;
> -    XiveTCTX *tctx;
> +    struct ICPState *icp;
> +    struct XiveTCTX *tctx;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
