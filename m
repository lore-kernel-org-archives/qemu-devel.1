Received: from eggs.gnu.org ([2001:4830:134:3::10]:36410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjnZX-0006ny-CQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjnZT-0004kO-FY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:48:39 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cjnZT-0004k6-86
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:48:35 -0500
Received: by mail-lf0-x243.google.com with SMTP id v2so1864649lfi.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 05:48:35 -0800 (PST)
Date: Fri, 3 Mar 2017 14:48:32 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170303134832.GA1009@toto>
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303131113.25898-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-timer: fix off-by-one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Fri, Mar 03, 2017 at 02:11:09PM +0100, Paolo Bonzini wrote:
> If the first timer is exactly at the current value of the clock, the
> deadline is met and the timer should fire.  This fixes itself without icount,
> but with icount execution of instructions will stop exactly at the deadline.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  util/qemu-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 6cf70b9..2f20151 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -199,7 +199,7 @@ bool timerlist_expired(QEMUTimerList *timer_list)
>      expire_time = timer_list->active_timers->expire_time;
>      qemu_mutex_unlock(&timer_list->active_timers_lock);
>  
> -    return expire_time < qemu_clock_get_ns(timer_list->clock->type);
> +    return expire_time <= qemu_clock_get_ns(timer_list->clock->type);
>  }
>  
>  bool qemu_clock_expired(QEMUClockType type)
> -- 
> 2.9.3
> 
> 
> 
