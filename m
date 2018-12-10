Received: from eggs.gnu.org ([2001:4830:134:3::10]:42158)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <jaap@jcz.nl>)
	id 1gWSdg-00039g-5B
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaap@jcz.nl>) id 1gWSdc-0008Q0-0u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:58:52 -0500
Received: from [2a01:7c8:fffd:340:5054:ff:fefb:99] (port=58487
	helo=mail.jcz.nl)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jaap@jcz.nl>) id 1gWSda-0008Mz-Dl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:58:47 -0500
Reply-To: jaap@jcz.nl
References: <20181207155911.12710-1-peter.maydell@linaro.org>
From: Jaap Crezee <jaap@jcz.nl>
Message-ID: <2163773a-f826-d713-a29c-c425403505d8@jcz.nl>
Date: Mon, 10 Dec 2018 21:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181207155911.12710-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: nl-NL
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Hi again,

On 12/7/18 4:59 PM, Peter Maydell wrote:
> We use cpu_stop_current() to ensure the current CPU has stopped
> from places like qemu_system_reset_request(). Unfortunately its
> current implementation has a race. It calls qemu_cpu_stop(),
> which sets cpu->stopped to true even though the CPU hasn't
> actually stopped yet. The main thread will look at the flags
> set by qemu_system_reset_request() and call pause_all_vcpus().
> pause_all_vcpus() waits for every cpu to have cpu->stopped true,
> so it can continue (and we will start the system reset operation)
> before the vcpu thread has got back to its top level loop.
> 
> Instead, just set cpu->stop and call cpu_exit(). This will
> cause the vcpu to exit back to the top level loop, and there
> (as part of the wait_io_event code) it will call qemu_cpu_stop().
> 
> This fixes bugs where the reset request appeared to be ignored
> or the CPU misbehaved because the reset operation started
> to change vcpu state while the vcpu thread was still using it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We discussed this a little while back:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00154.html
> and Jaap reported a bug which I suspect of being the same thing:
> https://lists.gnu.org/archive/html/qemu-discuss/2018-10/msg00014.html
> 
> Annoyingly I have lost the test case that demonstrated this
> race, but I analysed it at the time and this should definitely
> fix it. I have opted not to try to address any of the other
> possible cleanup here (eg vm_stop() has a potential similar
> race if called from a vcpu thread I suspect), since it gets
> pretty tangled.
> 
> Jaap: could you test whether this patch fixes the issue you
> were seeing, please?
> ---
>  cpus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 0ddeeefc14f..b09b7027126 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
>  void cpu_stop_current(void)
>  {
>      if (current_cpu) {
> -        qemu_cpu_stop(current_cpu, true);
> +        current_cpu->stop = true;
> +        cpu_exit(current_cpu);
>      }
>  }
>  
> 


The patch also fixed the issue on my production system. Thanks!

regards,


Jaap
