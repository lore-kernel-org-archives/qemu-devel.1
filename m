Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f4QmQ-00057r-1H
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f4QmP-0003Z7-0Z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:47:46 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180406123838.21249-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <09df8088-4afe-5642-d6dd-12ca0afb8a62@twiddle.net>
Date: Fri, 6 Apr 2018 22:47:10 +1000
MIME-Version: 1.0
In-Reply-To: <20180406123838.21249-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] cpus.c: ensure running CPU
 recalculates icount deadlines on timer expiry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

On 04/06/2018 10:38 PM, Peter Maydell wrote:
> When we run in TCG icount mode, we calculate the number of instructions
> to execute using tcg_get_icount_limit(), which ensures that we stop
> execution at the next timer deadline. However there is a bug where
> currently we do not recalculate that limit if the guest reprograms
> a timer so that the next deadline moves closer, and so we will
> continue execution until the original limit and fire the timer
> later than we should.
> 
> Fix this bug in qemu_timer_notify_cb(): if we are currently running
> a VCPU in icount mode, we simply need to kick it out of the main
> loop and back to tcg_cpu_exec(), where it will recalculate the
> icount limit. If we are not currently running a VCPU, then we
> retain the existing logic for waking up a halted CPU.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: https://bugs.launchpad.net/qemu/+bug/1754038
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Thanks to Paolo for tracking down which function needed fixing!

Seconded.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
