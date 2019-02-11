Received: from eggs.gnu.org ([209.51.188.92]:59819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtF9h-0001zh-0i
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtEuC-0006ua-EZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:58:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtEuA-0006qI-6I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:58:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id f14so1181793wrg.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:57:55 -0800 (PST)
References: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1549902684-21740-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1549902684-21740-5-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Feb 2019 16:57:52 +0000
Message-ID: <871s4ew9db.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/mips: hold BQL in
 mips_vpe_wake()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, pburton@wavecomp.com, cota@braap.org


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Goran Ferenc <goran.ferenc@imgtec.com>
>
> Hold BQL whenever mips_vpe_wake() is invoked.
>
> Without this patch, MIPS MT with MTTCG enabled triggers an abort in
> tcg_handle_interrupt() due to an unlocked access to cpu_interrupt().
> This patch makes sure that the BQL is held in this case.

Just a reminder that this can go away in with Emilio's per-CPU locks patch.

>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/mips/op_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 8c53b3b..0f272a5 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "internal.h"
>  #include "qemu/host-utils.h"
> @@ -638,7 +639,9 @@ static inline void mips_vpe_wake(MIPSCPU *c)
>      /* Don't set ->halted =3D 0 directly, let it be done via cpu_has_work
>         because there might be other conditions that state that c should
>         be sleeping.  */
> +    qemu_mutex_lock_iothread();
>      cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  static inline void mips_vpe_sleep(MIPSCPU *cpu)


--
Alex Benn=C3=A9e
