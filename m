Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWLEj-0001fQ-Bn
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWLEi-0004nd-4L
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:04:37 -0500
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 10 Dec 2018 14:04:28 +0100
Message-ID: <CAL1e-=jWJ_kzwrC4nkt-UQnHXh5y-i5NF0N0ToXj534ehkuGOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org

On Dec 7, 2018 9:59 AM, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
wrote:
>
> This patchset is an attempt at trying to improve the VMX (Altivec)
instruction
> performance by making use of the new TCG vector operations where possible.
>

Hello, Mark.

I just want to say that I support these efforts. Very interesting, it can
bring significant improvements for multimedia intensive emulations. But,
even more important, we can see new tcg vector interface in action,
possibly suggest improvements, extensions.

I would just like to ask you to add some performance comparisons, if
possible. Very simple tests would be sufficient.

Thanks again for this series!

Aleksandar

> In order to use TCG vector operations, the registers must be accessible
from cpu_env
> whilst currently they are accessed via arrays of static TCG globals.
Patches 1-3
> are therefore mechanical patches which introduce access helpers for FPR,
AVR and VSR
> registers using the supplied TCGv_i64 parameter.
>
> Once this is done, patch 4 enables us to remove the static TCG global
arrays and updates
> the access helpers to read/write to the relevant fields in cpu_env
directly.
>
> The final patches 5 and 6 convert the VMX logical instructions and
addition/subtraction
> instructions respectively over to the TCG vector operations.
>
> NOTE: there are a lot of instructions that cannot (yet) be optimised to
use TCG vector
> operations, however it struck me that there may be some potential for
converting
> saturating add/sub and cmp instructions if there were a mechanism to
return a set of
> flags indicating the result of the saturation/comparison.
>
> Finally thanks to Richard for taking the time to answer some of my
(mostly beginner)
> questions related to TCG.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
>
> Mark Cave-Ayland (6):
>   target/ppc: introduce get_fpr() and set_fpr() helpers for FP register
>     access
>   target/ppc: introduce get_avr64() and set_avr64() helpers for VMX
>     register access
>   target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()
>     helpers for VSR register access
>   target/ppc: switch FPR, VMX and VSX helpers to access data directly
>     from cpu_env
>   target/ppc: convert VMX logical instructions to use vector operations
>   target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
>     vector operations
>
>  target/ppc/helper.h                 |   8 -
>  target/ppc/int_helper.c             |   7 -
>  target/ppc/translate.c              |  72 ++--
>  target/ppc/translate/fp-impl.inc.c  | 492 ++++++++++++++++++-----
>  target/ppc/translate/vmx-impl.inc.c | 182 ++++++---
>  target/ppc/translate/vsx-impl.inc.c | 782
++++++++++++++++++++++++++----------
>  6 files changed, 1110 insertions(+), 433 deletions(-)
>
> --
> 2.11.0
>
>
