Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw8H-0002AM-BG
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw8D-0003qf-1o
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:04:09 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUw8C-0003pq-OT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:04:04 -0500
Received: by mail-oi1-x241.google.com with SMTP id x202so765752oif.13
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 08:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-15-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-15-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 16:03:51 +0000
Message-ID: <CAFEAcA8Tt3ygYCZO7ZYkZPwmPQniBu6fLnr+RjNUAmgZdTT0kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 14/14] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Wed, 5 Dec 2018 at 13:44, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> Setup a QEMUTimer to get a callback when we expect counters to next
> overflow and trigger an interrupt at that time.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.c    |  12 +++++
>  target/arm/cpu.h    |   7 +++
>  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 139 insertions(+), 6 deletions(-)
>
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -733,6 +733,8 @@ struct ARMCPU {
>
>      /* Timers used by the generic (architected) timer */
>      QEMUTimer *gt_timer[NUM_GTIMERS];
> +    /* Timer used by the PMU */
> +    QEMUTimer *pmu_timer;

We don't seem to migrate this timer state. Is that OK? If so,
a brief comment somewhere with the rationale would be helpful.

thanks
-- PMM
