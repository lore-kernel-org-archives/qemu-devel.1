Received: from eggs.gnu.org ([2001:4830:134:3::10]:46244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fa1-0000yO-Th
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fZx-0000if-U1
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:23:49 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fZx-0000iP-JW
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:23:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id z73so21749711wrb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:23:45 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519324303-5674-4-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 04 Apr 2018 11:23:42 +0100
Message-ID: <87tvsrclsh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/mips_int: hold BQL for all
 interrupt requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> Make sure BQL is held for all interrupt requests.
>
> For MTTCG-enabled configurations, handling soft and hard interrupts
> between vCPUs must be properly locked. By acquiring BQL, make sure
> all paths triggering an IRQ are synchronized.
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/mips/mips_int.c      | 12 ++++++++++++
>  target/mips/op_helper.c | 21 +++------------------
>  2 files changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 48192d2..5ddeb15 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -21,6 +21,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "hw/hw.h"
>  #include "hw/mips/cpudevs.h"
>  #include "cpu.h"
> @@ -32,10 +33,17 @@ static void cpu_mips_irq_request(void *opaque, int ir=
q, int level)
>      MIPSCPU *cpu =3D opaque;
>      CPUMIPSState *env =3D &cpu->env;
>      CPUState *cs =3D CPU(cpu);
> +    bool locked =3D false;
>
>      if (irq < 0 || irq > 7)
>          return;
>
> +    /* Make sure locking works even if BQL is already held by the caller=
 */
> +    if (!qemu_mutex_iothread_locked()) {
> +        locked =3D true;
> +        qemu_mutex_lock_iothread();
> +    }
> +
>      if (level) {
>          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
>
> @@ -56,6 +64,10 @@ static void cpu_mips_irq_request(void *opaque, int irq=
, int level)
>      } else {
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>      }
> +
> +    if (locked) {
> +        qemu_mutex_unlock_iothread();
> +    }
>  }
>
>  void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 44a9b06..6bd8e59 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -17,7 +17,6 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "internal.h"
>  #include "qemu/host-utils.h"
> @@ -809,11 +808,7 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *=
env)
>
>  target_ulong helper_mfc0_count(CPUMIPSState *env)
>  {
> -    int32_t count;
> -    qemu_mutex_lock_iothread();
> -    count =3D (int32_t) cpu_mips_get_count(env);
> -    qemu_mutex_unlock_iothread();
> -    return count;
> +    return (int32_t)cpu_mips_get_count(env);
>  }
>
>  target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
> @@ -1388,9 +1383,7 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_u=
long arg1)
>
>  void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
>  {
> -    qemu_mutex_lock_iothread();
>      cpu_mips_store_count(env, arg1);
> -    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
> @@ -1439,9 +1432,7 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target=
_ulong arg1)
>
>  void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
>  {
> -    qemu_mutex_lock_iothread();
>      cpu_mips_store_compare(env, arg1);
> -    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
> @@ -1495,9 +1486,7 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_u=
long arg1)
>
>  void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
>  {
> -    qemu_mutex_lock_iothread();
>      cpu_mips_store_cause(env, arg1);
> -    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
> @@ -2339,16 +2328,12 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState=
 *env)
>
>  target_ulong helper_rdhwr_cc(CPUMIPSState *env)
>  {
> -    int32_t count;
>      check_hwrena(env, 2, GETPC());
>  #ifdef CONFIG_USER_ONLY
> -    count =3D env->CP0_Count;
> +    return env->CP0_Count;
>  #else
> -    qemu_mutex_lock_iothread();
> -    count =3D (int32_t)cpu_mips_get_count(env);
> -    qemu_mutex_unlock_iothread();
> +    return (int32_t)cpu_mips_get_count(env);
>  #endif
> -    return count;
>  }
>
>  target_ulong helper_rdhwr_ccres(CPUMIPSState *env)


--
Alex Benn=C3=A9e
