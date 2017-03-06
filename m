Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckq6h-0005kw-UU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckq6d-0003HR-OB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:43:11 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ckq6d-0003HK-Hk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:43:07 -0500
Received: by mail-wm0-x229.google.com with SMTP id n11so60642631wma.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:43:07 -0800 (PST)
References: <1488540021-35506-1-git-send-email-yongbok.kim@imgtec.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1488540021-35506-1-git-send-email-yongbok.kim@imgtec.com>
Date: Mon, 06 Mar 2017 10:43:11 +0000
Message-ID: <87mvcyit34.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/mips: hold BQL for timer interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Yongbok Kim <yongbok.kim@imgtec.com> writes:

> Hold BQL when accessing timer which can cause interrupts
>
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>

Thanks, applied to my tree.

> ---
>  target/mips/op_helper.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index b683fcb..e5f3ea4 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
> @@ -827,7 +828,11 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
>
>  target_ulong helper_mfc0_count(CPUMIPSState *env)
>  {
> -    return (int32_t)cpu_mips_get_count(env);
> +    int32_t count;
> +    qemu_mutex_lock_iothread();
> +    count = (int32_t) cpu_mips_get_count(env);
> +    qemu_mutex_unlock_iothread();
> +    return count;
>  }
>
>  target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
> @@ -1375,7 +1380,9 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
>
>  void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_count(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
> @@ -1424,7 +1431,9 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>
>  void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_compare(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
> @@ -1475,7 +1484,9 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
>
>  void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_cause(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
> @@ -2296,12 +2307,16 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState *env)
>
>  target_ulong helper_rdhwr_cc(CPUMIPSState *env)
>  {
> +    int32_t count;
>      check_hwrena(env, 2, GETPC());
>  #ifdef CONFIG_USER_ONLY
> -    return env->CP0_Count;
> +    count = env->CP0_Count;
>  #else
> -    return (int32_t)cpu_mips_get_count(env);
> +    qemu_mutex_lock_iothread();
> +    count = (int32_t)cpu_mips_get_count(env);
> +    qemu_mutex_unlock_iothread();
>  #endif
> +    return count;
>  }
>
>  target_ulong helper_rdhwr_ccres(CPUMIPSState *env)


--
Alex Bennée
