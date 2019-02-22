Received: from eggs.gnu.org ([209.51.188.92]:54695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6GW-0007AZ-IT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6GV-0004MW-9p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:33:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gx6GU-0004K7-Q8
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:33:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1135970wmh.4
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:33:02 -0800 (PST)
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190220160628.6555-3-marcandre.lureau@redhat.com>
	<20190221080357.GC3091@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbbb45f4-520c-430b-f4ed-19a9fccd2753@redhat.com>
Date: Fri, 22 Feb 2019 09:32:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190221080357.GC3091@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] chardev: make
 qemu_chr_fe_set_handlers() context switching safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/21/19 9:03 AM, Peter Xu wrote:
> On Wed, Feb 20, 2019 at 05:06:26PM +0100, Marc-André Lureau wrote:
>> qemu_chr_fe_set_handlers() may switch the context of various
>> sources. In order to prevent dispatch races from different threads,
>> let's acquire or freeze the context, do all the source switches, and
>> then release/resume the contexts. This should help to make context
>> switching safer.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/chardev/char-fe.h |  23 +++++++++
>>  chardev/char-fe.c         | 103 +++++++++++++++++++++++++++++++++-----
>>  chardev/char-mux.c        |  14 +++---
>>  3 files changed, 121 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
>> index aa1b864ccd..4051435a1c 100644
>> --- a/include/chardev/char-fe.h
>> +++ b/include/chardev/char-fe.h
>> @@ -84,6 +84,14 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
>>   * Set the front end char handlers. The front end takes the focus if
>>   * any of the handler is non-NULL.
>>   *
>> + * A chardev may have multiple main loop sources. In order to prevent
>> + * races when switching contexts, the function will temporarily block
>> + * the contexts before the source switch to prevent them from
>> + * dispatching in different threads concurrently.
>> + *
>> + * The current and the new @context must be acquirable or
>> + * running & dispatched in a loop (the function will hang otherwise).
>> + *
>>   * Without associated Chardev, nothing is changed.
>>   */
>>  void qemu_chr_fe_set_handlers_full(CharBackend *b,
>> @@ -110,6 +118,21 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>>                                GMainContext *context,
>>                                bool set_open);
>>  
>> +/**
>> + * qemu_chr_fe_set_handlers_internal:
>> + *
>> + * Same as qemu_chr_fe_set_handlers(), without context freezing.
>> + */
>> +void qemu_chr_fe_set_handlers_internal(CharBackend *b,
>> +                                       IOCanReadHandler *fd_can_read,
>> +                                       IOReadHandler *fd_read,
>> +                                       IOEventHandler *fd_event,
>> +                                       BackendChangeHandler *be_change,
>> +                                       void *opaque,
>> +                                       GMainContext *context,
>> +                                       bool set_open,
>> +                                       bool sync_state);

Can we add this function into a new header "chardev/char-internal.h"
(internal to chardev/) rather than "include/chardev/char-fe.h" (public)?

>> +
>>  /**
>>   * qemu_chr_fe_take_focus:
>>   *
>> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>> index f3530a90e6..90cd7db007 100644
>> --- a/chardev/char-fe.c
>> +++ b/chardev/char-fe.c
>> @@ -246,15 +246,67 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>>      }
>>  }
>>  
>> -void qemu_chr_fe_set_handlers_full(CharBackend *b,
>> -                                   IOCanReadHandler *fd_can_read,
>> -                                   IOReadHandler *fd_read,
>> -                                   IOEventHandler *fd_event,
>> -                                   BackendChangeHandler *be_change,
>> -                                   void *opaque,
>> -                                   GMainContext *context,
>> -                                   bool set_open,
>> -                                   bool sync_state)
>> +struct MainContextWait {
>> +    QemuCond cond;
>> +    QemuMutex lock;
>> +};
>> +
>> +static gboolean
>> +main_context_wait_cb(gpointer user_data)
>> +{
>> +    struct MainContextWait *w = user_data;
>> +
>> +    qemu_mutex_lock(&w->lock);
>> +    qemu_cond_signal(&w->cond);
>> +    /* wait until switching is over */
>> +    qemu_cond_wait(&w->cond, &w->lock);
> 
> Could previous signal() directly wake up itself here?  Man
> pthread_cond_broadcast says:
> 
>        The pthread_cond_signal() function shall unblock at least one
>        of the threads that are blocked on the specified condition
>        variable cond (if any threads are blocked on cond).
> 
>        If more than one thread is blocked on a condition variable, the
>        scheduling policy shall determine the order in which threads
>        are unblocked.
> 
> So AFAIU it could, because neither there's a restriction on ordering
> of how waiters are waked up, nor there's a limitation on how many
> waiters will be waked up by a single signal().
> 
> Why not simply use two semaphores?  Then locks can be avoided too.
> 
> Regards,
> 
