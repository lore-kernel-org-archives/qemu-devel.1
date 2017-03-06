Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckr0G-00062b-7i
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckr0E-0003wm-SL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:40:36 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckr0E-0003wi-Ni
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:40:34 -0500
Received: by mail-it0-x242.google.com with SMTP id 203so9207874ith.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:40:34 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1488540021-35506-1-git-send-email-yongbok.kim@imgtec.com>
References: <1488540021-35506-1-git-send-email-yongbok.kim@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 6 Mar 2017 08:40:33 -0300
Message-ID: <CAAdtpL54Y+8MDFjNG1VyfvQ8OvcriakJRqomoG=K2kX3+hUwww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, Mar 3, 2017 at 8:20 AM, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> Hold BQL when accessing timer which can cause interrupts
>
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/mips/op_helper.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index b683fcb..e5f3ea4 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
> @@ -827,7 +828,11 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *=
env)
>
>  target_ulong helper_mfc0_count(CPUMIPSState *env)
>  {
> -    return (int32_t)cpu_mips_get_count(env);
> +    int32_t count;
> +    qemu_mutex_lock_iothread();
> +    count =3D (int32_t) cpu_mips_get_count(env);
> +    qemu_mutex_unlock_iothread();
> +    return count;
>  }
>
>  target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
> @@ -1375,7 +1380,9 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_u=
long arg1)
>
>  void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_count(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
> @@ -1424,7 +1431,9 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target=
_ulong arg1)
>
>  void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_compare(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
> @@ -1475,7 +1484,9 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_u=
long arg1)
>
>  void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
>  {
> +    qemu_mutex_lock_iothread();
>      cpu_mips_store_cause(env, arg1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
> @@ -2296,12 +2307,16 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState=
 *env)
>
>  target_ulong helper_rdhwr_cc(CPUMIPSState *env)
>  {
> +    int32_t count;
>      check_hwrena(env, 2, GETPC());
>  #ifdef CONFIG_USER_ONLY
> -    return env->CP0_Count;
> +    count =3D env->CP0_Count;
>  #else
> -    return (int32_t)cpu_mips_get_count(env);
> +    qemu_mutex_lock_iothread();
> +    count =3D (int32_t)cpu_mips_get_count(env);
> +    qemu_mutex_unlock_iothread();
>  #endif
> +    return count;
>  }
>
>  target_ulong helper_rdhwr_ccres(CPUMIPSState *env)
> --
> 2.7.4
>
>
