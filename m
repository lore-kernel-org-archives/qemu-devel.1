Received: from eggs.gnu.org ([2001:4830:134:3::10]:52327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6fdb-0001gE-DF
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6fdY-0004Qr-5h
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:23 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6fdX-0004PA-Sm
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:20 -0400
Received: by mail-wr0-x22c.google.com with SMTP id z52so6316300wrc.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:59:19 -0700 (PDT)
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
	<9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
Date: Fri, 05 May 2017 16:59:58 +0100
Message-ID: <87pofnmgzl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add
 qemu_lock, locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org, "stefanha@redhat.com" <stefanha@redhat.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/05/2017 12:38, Alex Bennée wrote:
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> Can you look at the patch I just sent a pull request for?  It only has
> locked and unlocked trace events, you can add lock on top.

Cool - great minds think alike ;-)

I'll re-spin my trace analysis script and the lock trace point once that
pull request is merged. I would be nice if we could associate locks with
names though as the QemuMutex * is basically just an anonymous handle.
Would it be overly extravagant to add a const char * to QemuMutex to can
be init'ed with a human readable name?

Stefan,

Does the trace sub-system have any way to register a human readable
string to a given pointer value? I guess this is something that could be
added to the trace pre-amble?

>
> Paolo
>
>> ---
>>  include/qemu/thread.h    |  7 +++++--
>>  util/qemu-thread-posix.c | 11 +++++++++--
>>  util/trace-events        |  5 +++++
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
>> index 9910f49b3a..ddea4990c0 100644
>> --- a/include/qemu/thread.h
>> +++ b/include/qemu/thread.h
>> @@ -22,9 +22,12 @@ typedef struct QemuThread QemuThread;
>>
>>  void qemu_mutex_init(QemuMutex *mutex);
>>  void qemu_mutex_destroy(QemuMutex *mutex);
>> -void qemu_mutex_lock(QemuMutex *mutex);
>>  int qemu_mutex_trylock(QemuMutex *mutex);
>> -void qemu_mutex_unlock(QemuMutex *mutex);
>> +void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
>> +void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
>> +
>> +#define qemu_mutex_lock(mutex) qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
>> +#define qemu_mutex_unlock(mutex) qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
>>
>>  /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
>>  void qemu_rec_mutex_init(QemuRecMutex *mutex);
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 73e3a0edf5..9da1c9e756 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -14,6 +14,7 @@
>>  #include "qemu/thread.h"
>>  #include "qemu/atomic.h"
>>  #include "qemu/notify.h"
>> +#include "trace.h"
>>
>>  static bool name_threads;
>>
>> @@ -53,13 +54,17 @@ void qemu_mutex_destroy(QemuMutex *mutex)
>>          error_exit(err, __func__);
>>  }
>>
>> -void qemu_mutex_lock(QemuMutex *mutex)
>> +void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
>>  {
>>      int err;
>>
>> +    trace_qemu_mutex_lock(mutex, file, line);
>> +
>>      err = pthread_mutex_lock(&mutex->lock);
>>      if (err)
>>          error_exit(err, __func__);
>> +
>> +    trace_qemu_mutex_locked(mutex, file, line);
>>  }
>>
>>  int qemu_mutex_trylock(QemuMutex *mutex)
>> @@ -67,13 +72,15 @@ int qemu_mutex_trylock(QemuMutex *mutex)
>>      return pthread_mutex_trylock(&mutex->lock);
>>  }
>>
>> -void qemu_mutex_unlock(QemuMutex *mutex)
>> +void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
>>  {
>>      int err;
>>
>>      err = pthread_mutex_unlock(&mutex->lock);
>>      if (err)
>>          error_exit(err, __func__);
>> +
>> +    trace_qemu_mutex_unlock(mutex, file, line);
>>  }
>>
>>  void qemu_rec_mutex_init(QemuRecMutex *mutex)
>> diff --git a/util/trace-events b/util/trace-events
>> index b44ef4f895..972d7e1786 100644
>> --- a/util/trace-events
>> +++ b/util/trace-events
>> @@ -34,6 +34,11 @@ qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
>>  qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
>>  qemu_co_mutex_unlock_return(void *mutex, void *self) "mutex %p self %p"
>>
>> +# util/qemu-thread.c
>> +qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting on mutex %p (%s:%d)"
>> +qemu_mutex_locked(void *mutex, const char *file, const int line) "taken mutex %p (%s:%d)"
>> +qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex %p (%s:%d)"
>> +
>>  # util/oslib-win32.c
>>  # util/oslib-posix.c
>>  qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu size %zu ptr %p"
>>


--
Alex Bennée
