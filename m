Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3faz-0001bI-8p
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fav-00019u-Ak
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:24:49 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fav-00019R-2x
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:24:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id p53so21741655wrc.10
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:24:44 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519324303-5674-5-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 04 Apr 2018 11:24:42 +0100
Message-ID: <87sh8bclqt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/mips: hold BQL in
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
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Goran Ferenc <goran.ferenc@mips.com>
>
> Hold BQL whenever mips_vpe_wake() is invoked.
>
> Without this patch, MIPS MT with MTTCG enabled triggers an abort in
> tcg_handle_interrupt() due to an unlocked access to cpu_interrupt().
> This patch makes sure that the BQL is held in this case.
>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/mips/op_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 6bd8e59..d71d916 100644
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
> @@ -542,7 +543,9 @@ static inline void mips_vpe_wake(MIPSCPU *c)
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
