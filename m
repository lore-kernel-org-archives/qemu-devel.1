Received: from eggs.gnu.org ([2001:4830:134:3::10]:48861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9Et-00050I-3d
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9Ep-0001Js-3r
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:25:43 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9Eo-0001Ji-VQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:25:39 -0400
Received: by mail-vk0-x244.google.com with SMTP id 191so185296vko.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:25:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <786267f5-88fa-aabf-9981-452101d23fd9@amsat.org>
Date: Wed, 14 Jun 2017 11:25:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170614140209.29847-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Fixes for TCG hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org

On the aarch64 kernels I have it works!

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 06/14/2017 11:02 AM, Alex Bennée wrote:
> Hi,
>
> This is an alternative approach to fixing the hang that Emilio zeroed
> in on with:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03224.html
>
> Instead of forcing the front-end to treat any MSRs differently we
> shortcut the lookup_tb_ptr by checking for icount_decr and
> cpu->interrupt_request conditions.
>
> Fundamentally the problem was that an interrupt was pending
> (interrupt_request was set) but the "msr daifclr" operations when the
> kernel did local_irq/fiq_enable() never got handled because the
> cpu_idle loop was being very efficiently chained. As a result we never
> got around to exiting the TCG code and calling arm_cpu_do_interrupt
> which would then raise the IRQ to move things on.
>
> Emilio's fix is also correct - we should exit the loop whenever the
> IRQ conditions may have changed. However by checking in the lookup_ptr
> function we avoid churn in figuring out all the other cases in the
> front ends. This may have a potential cost for code with lots of
> calculated jumps although I would argue its fairly minimal given we've
> already sucked up the cost of a helper function and I don't think the
> difference between the helper function and a full exit is that
> marginal.
>
> I've also included Thomas's thread fix as it has yet to be merged.
>
> I humbly submit my patches to the TCG gods to decide which is the best
> approach ;-)
>
> Alex Bennée (2):
>   tcg-runtime: light re-factor of lookup_tb_ptr
>   tcg-runtime: short-circuit lookup_tb_ptr on IRQs
>
> Thomas Huth (1):
>   vl: Fix broken thread=xxx option of the --accel parameter
>
>  tcg-runtime.c | 52 +++++++++++++++++++++++++++++++---------------------
>  vl.c          | 13 +++++--------
>  2 files changed, 36 insertions(+), 29 deletions(-)
>
