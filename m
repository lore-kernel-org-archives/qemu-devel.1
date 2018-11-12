Received: from eggs.gnu.org ([2001:4830:134:3::10]:39976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM0A3-0004jO-M5
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM0A3-0000Q7-0t
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:33:03 -0500
MIME-Version: 1.0
References: <20181109173553.22341-1-peter.maydell@linaro.org>
In-Reply-To: <20181109173553.22341-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 01:32:43 +0100
Message-ID: <CAAdtpL4UorO9DbcBWL07cLzvgiBb616u8ikbxq_pwM0884AZQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] Fix the last Hyp mode bug
 and turn it on for A7, A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, adam.lackorzynski@kernkonzept.com, Patch Tracking <patches@linaro.org>

Hi Peter,

On Fri, Nov 9, 2018 at 6:36 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes the last serious bug in our implementation
> of Hyp mode (aka EL2 for AArch32), and turns the feature bit
> on for the Cortex-A7 and Cortex-A15 CPUs.
>
> The bug is that Hyp mode is an exception to the previous
> general rule that every AArch32 mode (except SYS, which
> always shares with USR) has its own banked r13, r14 and
> SPSR. Instead Hyp has a banked r13 and SPSR, but r14 is
> shared with USR and SYS. We were accidentally implementing
> it as banked, which results in remarkably nonobvious
> failure modes.
>
> With this fix, I can boot an AArch32 guest that uses KVM to
> boot an AArch32 nested guest, and I can also boot an L4Re/
> Fiasco guest successfully.

Nice!
More acceptance tests to add :)

>
> Not entirely sure what to do about this for 3.1 -- maybe
> put in the bugfix patch but hold off on actually setting
> the feature bit til 4.0?

The bugfix surely fits.

Do you think enabling the feature isn't well tested and might trigger
unexpected side effects?
It is certainly not tested... except by you. But if you include it, it
might be more tested :)

>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   target/arm: Hyp mode R14 is shared with User and System
>   target/arm/cpu: Give Cortex-A15 and -A7 the EL2 feature
>
>  target/arm/internals.h | 16 ++++++++++++++++
>  target/arm/cpu.c       |  2 ++
>  target/arm/helper.c    | 29 +++++++++++++++--------------
>  target/arm/kvm32.c     |  4 ++--
>  target/arm/op_helper.c |  2 +-
>  5 files changed, 36 insertions(+), 17 deletions(-)
>
> --
> 2.19.1
>
>
