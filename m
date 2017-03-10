Received: from eggs.gnu.org ([2001:4830:134:3::10]:45451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cmH7V-0001J7-3S
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cmH7R-0004dv-IZ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:45:56 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cmH7R-0004dZ-44
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:45:53 -0500
Received: by mail-wr0-x236.google.com with SMTP id u48so61425882wrc.0
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 01:45:52 -0800 (PST)
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-2-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170303131113.25898-2-pbonzini@redhat.com>
Date: Fri, 10 Mar 2017 09:46:02 +0000
Message-ID: <871su5ihwl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> If the first timer is exactly at the current value of the clock, the
> deadline is met and the timer should fire.  This fixes itself without icount,
> but with icount execution of instructions will stop exactly at the deadline.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

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


--
Alex Bennée
