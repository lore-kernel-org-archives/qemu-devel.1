Received: from eggs.gnu.org ([2001:4830:134:3::10]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fcUHz-0002Ni-DH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fcUHt-0007Wb-Lw
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:25:07 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35892)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fcUHt-0007Vp-8W
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:25:01 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180703085250.28380.33220.stgit@pasha-VirtualBox>
In-Reply-To: <20180703085250.28380.33220.stgit@pasha-VirtualBox>
Date: Mon, 9 Jul 2018 14:24:59 +0300
Message-ID: <004001d41777$78daa890$6a8ff9b0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] replay: wake up vCPU when replaying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, maria.klimushenkova@ispras.ru

There are some situations when this patch still doesn't help.
I think this happens due to the race condition in qemu_tcg_rr_wait_io_event

static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
{
    while (all_cpu_threads_idle()) {
        stop_tcg_kick_timer();
        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
    }

    start_tcg_kick_timer();

    qemu_wait_io_event_common(cpu);
}

all_cpu_threads_idle() returns true when there is no queued work.
But between this call and qemu_cond_wait() iothread may add queued work
and the vCPU thread will sleep infinitely.

Does anyone have an idea how to fix this?

Pavel Dovgalyuk

> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> Sent: Tuesday, July 03, 2018 11:53 AM
> To: qemu-devel@nongnu.org
> Cc: alex.bennee@linaro.org; pbonzini@redhat.com; maria.klimushenkova@ispras.ru;
> dovgaluk@ispras.ru; pavel.dovgaluk@ispras.ru
> Subject: [PATCH] replay: wake up vCPU when replaying
> 
> In record/replay icount mode vCPU thread and iothread synchronize
> the execution using the checkpoints.
> vCPU thread processes the virtual timers and iothread processes all others.
> When iothread wants to wake up sleeping vCPU thread, it sends dummy queued
> work. Therefore it could be the following sequence of the events in
> record mode:
>  - IO: sending dummy work
>  - IO: processing timers
>  - CPU: wakeup
>  - CPU: clearing dummy work
>  - CPU: processing virtual timers
> 
> But due to the races in replay mode the sequence may change:
>  - IO: sending dummy work
>  - CPU: wakeup
>  - CPU: clearing dummy work
>  - CPU: sleeping again because nothing to do
>  - IO: Processing timers
>  - CPU: zzzz
> 
> In this case vCPU will not wake up, because dummy work is not to be set up
> again.
> 
> This patch tries to wake up the vCPU when it sleeps and the icount warp
> checkpoint isn't met. It means that vCPU has something to do, because
> there are no other reasons of non-matching warp checkpoint.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  cpus.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 181ce33..bad6a33 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -539,11 +539,6 @@ void qemu_start_warp_timer(void)
>          return;
>      }
> 
> -    /* warp clock deterministically in record/replay mode */
> -    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
> -        return;
> -    }
> -
>      if (!all_cpu_threads_idle()) {
>          return;
>      }
> @@ -553,6 +548,16 @@ void qemu_start_warp_timer(void)
>          return;
>      }
> 
> +    /* warp clock deterministically in record/replay mode */
> +    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
> +        /* vCPU is sleeping and warp can't be started.
> +           It is probably a race condition: notification sent
> +           to vCPU was processed in advance and vCPU went to sleep.
> +           Therefore we have to wake it up for doing someting. */
> +        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
> +        return;
> +    }
> +
>      /* We want to use the earliest deadline from ALL vm_clocks */
>      clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
>      deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
