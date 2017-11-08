Received: from eggs.gnu.org ([2001:4830:134:3::10]:36459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCQkh-00060q-Da
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCQkd-00028b-5v
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:50:47 -0500
References: <20171108063447.2842-1-slp@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
Date: Wed, 8 Nov 2017 16:50:01 +0300
MIME-Version: 1.0
In-Reply-To: <20171108063447.2842-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On 08.11.2017 09:34, Sergio Lopez wrote:
> Commit b7a745d added a qemu_bh_cancel call to the completion function
> as an optimization to prevent it from unnecessarily rescheduling itself.
> 
> This completion function is scheduled from worker_thread, after setting
> the state of a ThreadPoolElement to THREAD_DONE.
>

Great! We are seeing the same problem, and I was describing my fix,
when I came across your patch :)

> This was considered to be safe, as the completion function restarts the
> loop just after the call to qemu_bh_cancel. But, under certain access
> patterns and scheduling conditions, the loop may wrongly use a
> pre-fetched elem->state value, reading it as THREAD_QUEUED, and ending
> the completion function without having processed a pending TPE linked at
> pool->head:

I'm not quite sure that the pre-fetched is involved in this issue,
because pre-fetch reading a certain addresses should be invalidated by
write on another core to the same addresses. In our case write
req->state = THREAD_DONE should invalidate read req->state == THREAD_DONE.
I am inclined to think that there is a memory-reordering read with
write. It's a very real case for x86 and I don't see the reasons which
can prevent it:

.text:000000000060E21E loc_60E21E:                             ; CODE 
XREF: .text:000000000060E2F4j
.text:000000000060E21E                 mov     rbx, [r12+98h]
.text:000000000060E226                 test    rbx, rbx
.text:000000000060E229                 jnz     short loc_60E238
.text:000000000060E22B                 jmp     short exit_0
.text:000000000060E22B ; 
---------------------------------------------------------------------------
.text:000000000060E22D                 align 10h
.text:000000000060E21E loc_60E21E:                             ; CODE 
XREF: .text:000000000060E2F4j
.text:000000000060E21E                 mov     rbx, [r12+98h]
.text:000000000060E226                 test    rbx, rbx
.text:000000000060E229                 jnz     short loc_60E238
.text:000000000060E22B                 jmp     short exit_0
.text:000000000060E230 loc_60E230:                             ; CODE 
XREF: .text:000000000060E240j
.text:000000000060E230                 test    rbp, rbp
.text:000000000060E233                 jz      short exit_0
.text:000000000060E235
.text:000000000060E235 loc_60E235:                             ; CODE 
XREF: .text:000000000060E289j
.text:000000000060E235                 mov     rbx, rbp
.text:000000000060E238
.text:000000000060E238 loc_60E238:                             ; CODE 
XREF: .text:000000000060E229j
.text:000000000060E238                 cmp 
[rbx+ThreadPoolElement.state], 2 ; THREAD_DONE
.text:000000000060E23C                 mov     rbp, 
[rbx+ThreadPoolElement.all.link_next]
.text:000000000060E240                 jnz     short loc_60E230
.text:000000000060E242                 mov     r15d, 
[rbx+ThreadPoolElement.ret]
.text:000000000060E246                 mov     r13, 
[rbx+ThreadPoolElement.common.opaque]
.text:000000000060E24A                 nop
.text:000000000060E24B                 lea     rax, 
trace_events_enabled_count
.text:000000000060E252                 mov     eax, [rax]
.text:000000000060E254                 test    eax, eax
.text:000000000060E256                 mov     rax, rbp
.text:000000000060E259                 jnz     loc_60E2F9
  ...

.text:000000000060E2BC loc_60E2BC:                             ; CODE 
XREF: .text:000000000060E27Cj
.text:000000000060E2BC                 mov     rdi, [r12+8]
.text:000000000060E2C1                 call    qemu_bh_schedule
.text:000000000060E2C6                 mov     rdi, [r12]
.text:000000000060E2CA                 call    aio_context_release
.text:000000000060E2CF                 mov     esi, [rbx+44h]
.text:000000000060E2D2                 mov     rdi, [rbx+18h]
.text:000000000060E2D6                 call    qword ptr [rbx+10h]
.text:000000000060E2D9                 mov     rdi, [r12]
.text:000000000060E2DD                 call    aio_context_acquire
.text:000000000060E2E2                 mov     rdi, [r12+8]
.text:000000000060E2E7                 call    qemu_bh_cancel
.text:000000000060E2EC                 mov     rdi, rbx
.text:000000000060E2EF                 call    qemu_aio_unref
.text:000000000060E2F4                 jmp     loc_60E21E


The read (req->state == THREAD_DONE) can be reordered
with qemu_bh_cancel(p->completion_bh) and then we get the same picture:

            worker thread             |            I/O thread
  ------------------------------------------------------------------------
                                      | reordered read req->state
   req->state = THREAD_DONE;          |
   qemu_bh_schedule(p->completion_bh) |
     bh->scheduled = 1;               |
                                      | qemu_bh_cancel(p->completion_bh)
                                      |   bh->scheduled = 0;
                                      | if (req->state == THREAD_DONE)
                                      |   // sees THREAD_QUEUED


> 
>           worker thread             |            I/O thread
> ------------------------------------------------------------------------
>                                     | speculatively read req->state
> req->state = THREAD_DONE;          |
> qemu_bh_schedule(p->completion_bh) |
>    bh->scheduled = 1;               |
>                                     | qemu_bh_cancel(p->completion_bh)
>                                     |   bh->scheduled = 0;
>                                     | if (req->state == THREAD_DONE)
>                                     |   // sees THREAD_QUEUED
> 
> The source of the misunderstanding was that qemu_bh_cancel is now being
> used by the _consumer_ rather than the producer, and therefore now needs
> to have acquire semantics just like e.g. aio_bh_poll.
> 
> In some situations, if there are no other independent requests in the
> same aio context that could eventually trigger the scheduling of the
> completion function, the omitted TPE and all operations pending on it
> will get stuck forever.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   util/async.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/async.c b/util/async.c
> index 355af73ee7..0e1bd8780a 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -174,7 +174,7 @@ void qemu_bh_schedule(QEMUBH *bh)
>    */
>   void qemu_bh_cancel(QEMUBH *bh)
>   {
> -    bh->scheduled = 0;
> +    atomic_mb_set(&bh->scheduled, 0);

But in the end, the patch looks correct. atomic_mb_set() is xchg:

#if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
#define atomic_mb_set(ptr, i)  ((void)atomic_xchg(ptr, i))

Reads and writes cannot be reordered with locked instructions, so it
should protect from reordering.


>   }
>   
>   /* This func is async.The bottom half will do the delete action at the finial
> 
