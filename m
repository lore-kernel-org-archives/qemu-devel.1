Received: from eggs.gnu.org ([209.51.188.92]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghxvz-0004go-LN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghxvy-0004ug-GP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:37:19 -0500
References: <20190109110144.18633-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bf9a0c7-c04c-0c12-e58d-6a2e41b0af4f@redhat.com>
Date: Fri, 11 Jan 2019 15:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190109110144.18633-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>

On 09/01/19 12:01, Stefan Hajnoczi wrote:
>      g_free(data);
> +
> +    tgm->restart_pending--;
> +    aio_wait_kick();
>  }
>  
>  static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
> @@ -430,6 +433,8 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
>       * be no timer pending on this tgm at this point */
>      assert(!timer_pending(tgm->throttle_timers.timers[is_write]));
>  
> +    tgm->restart_pending++;
> +
>      co = qemu_coroutine_create(throttle_group_restart_queue_entry, rd);
>      aio_co_enter(tgm->aio_context, co);
>  }
> @@ -538,6 +543,7 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
>  
>      tgm->throttle_state = ts;
>      tgm->aio_context = ctx;
> +    tgm->restart_pending = 0;
>  
>      qemu_mutex_lock(&tg->lock);
>      /* If the ThrottleGroup is new set this ThrottleGroupMember as the token */
> @@ -584,6 +590,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
>          return;
>      }
>  
> +    /* Wait for throttle_group_restart_queue_entry() coroutines to finish */
> +    AIO_WAIT_WHILE(tgm->aio_context, tgm->restart_pending > 0);
> +

Could you change this to atomic_inc/dec, and atomic_read here?  It would
be nice to avoid more uses of the AioContext lock.

Paolo
