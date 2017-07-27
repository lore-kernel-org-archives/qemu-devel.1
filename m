Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daiy9-0004M1-Qm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daiy5-0007qi-RQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:36:49 -0400
References: <20170727123710.29817-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79d4cecf-3f84-2727-9f73-b3588ec6db9d@redhat.com>
Date: Thu, 27 Jul 2017 15:36:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170727123710.29817-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-system-tricore: segfault when
 entering "x 0" on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>

 Hi Eduardo,

Meta comment: Please always put the maintainer(s) and qemu-devel on CC:

On 27.07.2017 14:37, Eduardo Otubo wrote:
> Starting Qemu with "qemu-system-tricore -nographic -M tricore_testboard
> -S" and entering "x 0" at the monitor prompt leads to Segmentation
> fault. This happens because tricore_cpu_get_phys_page_debug() is not
> implemented yet, this is a temporary workaround to avoid the crash do
> just abort the execution with exit(1).
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  target/tricore/cpu.c | 10 ++++++++++
>  target/tricore/cpu.h |  3 +++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 08f50e2ba7..822c7f4092 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -22,6 +22,15 @@
>  #include "cpu.h"
>  #include "qemu-common.h"
>  #include "exec/exec-all.h"
> +#include "qemu/error-report.h"
> +
> +hwaddr tricore_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr=
,
> +                                         MemTxAttrs *attrs)
> +{
> +    error_report("function cpu_get_phys_page_attrs_debug not"
> +                    "implemented, aborting");
> +    exit(1);

Looking at the description in include/qom/cpu.h and the callers in
exec.c, it seems like it is OK if these functions return -1 if the page
could not be found. I think you should do that here, too, instead of
exiting - it's always a little bit annoying for the users if QEMU exits
unexpectedly, so we should try to avoid that if possible.

> +}
> =20
>  static inline void set_feature(CPUTriCoreState *env, int feature)
>  {
> @@ -176,6 +185,7 @@ static void tricore_cpu_class_init(ObjectClass *c, =
void *data)
>      cc->dump_state =3D tricore_cpu_dump_state;
>      cc->set_pc =3D tricore_cpu_set_pc;
>      cc->synchronize_from_tb =3D tricore_cpu_synchronize_from_tb;
> +    cc->get_phys_page_attrs_debug =3D tricore_cpu_get_phys_page_attrs_=
debug;
>  }
> =20
>  static void cpu_register(const TriCoreCPUInfo *info)
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index a3493a123c..c374ed3213 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -224,6 +224,9 @@ static inline TriCoreCPU *tricore_env_get_cpu(CPUTr=
iCoreState *env)
>  #define ENV_OFFSET offsetof(TriCoreCPU, env)
> =20
>  hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);

I think you could also remove that prototype above now - since there is
no implementation for this.

> +hwaddr tricore_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr=
,
> +                                         MemTxAttrs *attrs);
> +
>  void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
>                              fprintf_function cpu_fprintf, int flags);
> =20
>=20

 Thomas
