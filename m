Received: from eggs.gnu.org ([2001:4830:134:3::10]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKjtL-0006TV-1Q
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKjtK-0002wT-2J
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:26:19 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKjtJ-0002w1-Uk
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:26:18 -0400
Received: by mail-ot0-x234.google.com with SMTP id m11-v6so16632154otf.3
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 05:26:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180521122100.22602-3-michael@walle.cc>
References: <20180521122100.22602-1-michael@walle.cc>
	<20180521122100.22602-3-michael@walle.cc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 13:25:56 +0100
Message-ID: <CAFEAcA-Q6c7Z49uxup1HdyaEvWt+er_B8eYcJn0UYDiXShz1eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/lm32: hold BQL in gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 21 May 2018 at 13:21, Michael Walle <michael@walle.cc> wrote:
> Changing the IP/IM registers may cause interrupts, so hold the BQL.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  target/lm32/gdbstub.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
> index cf929dd392..dac9418a2b 100644
> --- a/target/lm32/gdbstub.c
> +++ b/target/lm32/gdbstub.c
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "exec/gdbstub.h"
> @@ -82,10 +83,14 @@ int lm32_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>              env->ie = tmp;
>              break;
>          case 37:
> +            qemu_mutex_lock_iothread();
>              lm32_pic_set_im(env->pic_state, tmp);
> +            qemu_mutex_unlock_iothread();
>              break;
>          case 38:
> +            qemu_mutex_lock_iothread();
>              lm32_pic_set_ip(env->pic_state, tmp);
> +            qemu_mutex_unlock_iothread();
>              break;
>          }
>      }

Are you sure this is necessary? I would have expected the gdbstub to
be operating under the qemu lock anyway.

thanks
-- PMM
