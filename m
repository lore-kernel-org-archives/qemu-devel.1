Received: from eggs.gnu.org ([2001:4830:134:3::10]:45888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCTP-0004NJ-Ad
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCTL-00056F-6E
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:46:52 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccCTK-00055s-Ua
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:46:51 -0500
Received: by mail-wm0-x230.google.com with SMTP id 196so65286960wmm.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 06:46:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209170904.5713-21-alex.bennee@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
	<20170209170904.5713-21-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 14:46:29 +0000
Message-ID: <CAFEAcA8XFYaMibPkVUg8cYifn1+v=2X8HoMha67OoPnO_wBpiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 20/24] target-arm/powerctl: defer cpu
 reset work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 9 February 2017 at 17:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> When switching a new vCPU on we want to complete a bunch of the setup
> work before we start scheduling the vCPU thread. To do this cleanly we
> defer vCPU setup to async work which will run the vCPUs execution
> context as the thread is woken up. The scheduling of the work will kick
> the vCPU awake.
>
> This avoids potential races in MTTCG system emulation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
> ---
> v7
>   - add const to static mode_for_el[] array
>   - fix checkpatch long lines
> v10
>   - use async work for arm_set_cpu_off, arm_reset_cpu as well
>   - model ON_PENDING to deal with racing arm_set_cpu_on
> v11
>   - move to single cpu->power_state protected by BQL
>   - bump migration format
> ---
>  target/arm/arm-powerctl.c | 202 +++++++++++++++++++++++++++++++---------=
------
>  target/arm/arm-powerctl.h |   2 +
>  target/arm/cpu.c          |   4 +-
>  target/arm/cpu.h          |  13 ++-
>  target/arm/kvm.c          |   7 +-
>  target/arm/machine.c      |   6 +-
>  target/arm/psci.c         |  16 +++-
>  7 files changed, 174 insertions(+), 76 deletions(-)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index fbb7a15daa..3b4c51978c 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -14,6 +14,7 @@
>  #include "internals.h"
>  #include "arm-powerctl.h"
>  #include "qemu/log.h"
> +#include "qemu/main-loop.h"
>  #include "exec/exec-all.h"
>
>  #ifndef DEBUG_ARM_POWERCTL
> @@ -48,11 +49,93 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
>      return NULL;
>  }
>
> +struct cpu_on_info {

Since you'll need to respin this anyway, our coding
style likes CamelCase for struct names.

> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index fa5ec76090..15619a0430 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -286,8 +286,8 @@ static int cpu_post_load(void *opaque, int version_id=
)
>
>  const VMStateDescription vmstate_arm_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 22,
> -    .minimum_version_id =3D 22,
> +    .version_id =3D 23,
> +    .minimum_version_id =3D 23,

Sorry, you can't do this, it will break migration. You need
to do something cleverer with a subsection or other trick.

David Gilbert's recent patch on list to docs/migration.txt
should have some examples of how to do this.

>      .pre_save =3D cpu_pre_save,
>      .post_load =3D cpu_post_load,
>      .fields =3D (VMStateField[]) {
> @@ -329,7 +329,7 @@ const VMStateDescription vmstate_arm_cpu =3D {
>          VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
> -        VMSTATE_BOOL(powered_off, ARMCPU),
> +        VMSTATE_UINT32(power_state, ARMCPU),
>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription*[]) {

I think the rest is OK.

thanks
-- PMM
