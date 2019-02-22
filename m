Received: from eggs.gnu.org ([209.51.188.92]:51784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4SV-0001Ak-FJ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4SU-0003gB-1Q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:37:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gx4ST-0003eB-BI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:37:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id v139so530335qkb.12
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
In-Reply-To: <20190222031413.20250-5-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 Feb 2019 07:37:02 +0100
Message-ID: <CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] iothread: push gcontext earlier in the
 thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

Hi

On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
>
> We were pushing the context until right before running the gmainloop.
> Now since we have everything unconditionally, we can move this
> earlier.
>
> One benefit is that now it's done even before init_done_sem, so as
> long as the iothread user calls iothread_create() and completes, we
> know that the thread stack is ready.
>

This will change the default context in the iothread, for code running
there. This may not be a good idea. Until now, only sources dispatched
from iothread_get_g_main_context() would have default context
associated to it.

I don't know if the current behaviour is intentional, but it has some
logic. With this change, you may create hidden races, by changing the
default context of sources to the iothread.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  iothread.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/iothread.c b/iothread.c
> index 9abdbace66..7b7cba5d04 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -53,7 +53,7 @@ static void *iothread_run(void *opaque)
>      IOThread *iothread = opaque;
>
>      rcu_register_thread();
> -
> +    g_main_context_push_thread_default(iothread->worker_context);
>      my_iothread = iothread;
>      iothread->thread_id = qemu_get_thread_id();
>      qemu_sem_post(&iothread->init_done_sem);
> @@ -66,12 +66,11 @@ static void *iothread_run(void *opaque)
>           * changed in previous aio_poll()
>           */
>          if (iothread->running && atomic_read(&iothread->run_gcontext)) {
> -            g_main_context_push_thread_default(iothread->worker_context);
>              g_main_loop_run(iothread->main_loop);
> -            g_main_context_pop_thread_default(iothread->worker_context);
>          }
>      }
>
> +    g_main_context_pop_thread_default(iothread->worker_context);
>      rcu_unregister_thread();
>      return NULL;
>  }
> --
> 2.17.1
>
