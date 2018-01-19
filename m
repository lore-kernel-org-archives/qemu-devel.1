Received: from eggs.gnu.org ([2001:4830:134:3::10]:50425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecZqI-0001FW-8g
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecZqF-0006K7-5u
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:48:38 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ecZqE-0006IN-Ut
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:48:35 -0500
Received: by mail-wr0-x243.google.com with SMTP id e41so2119777wre.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:48:34 -0800 (PST)
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1516377391-25945-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1516377391-25945-4-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Jan 2018 16:48:32 +0000
Message-ID: <87h8rhokv3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] Revert "target/mips: hold BQL for
 timer interrupts"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> This reverts commit d394698d73836d1c50545bdb32dc58d09708fcfb.
>
> Ther revert is needed in order not to cause overlap with subsequent
> patches related to handling synchronization of interrupt code paths.

Hmm I'm fairly sure you should merge this with the follow-up patch to
add BQL locking to the appropriate place. Otherwise you break
bi-section.

>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  target/mips/op_helper.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index a429987..3830ee8 100644
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
