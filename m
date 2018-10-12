Received: from eggs.gnu.org ([2001:4830:134:3::10]:54435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAqUo-0001Mx-Kg
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAqUh-0002Sx-O6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41340 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAqUd-0002Pk-Cw
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:00:13 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-8-fli@suse.com>
	<87sh1c38by.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <729466c9-cf02-23ce-1f26-d1a498685f65@suse.com>
Date: Fri, 12 Oct 2018 14:00:05 +0800
MIME-Version: 1.0
In-Reply-To: <87sh1c38by.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v5 7/7] qemu_thread_create: propagate
 the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, famz@redhat.com



On 10/11/2018 09:45 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> Make qemu_thread_create() return a Boolean to indicate if it succeeds
>> rather than failing with an error. And add an Error parameter to hold
>> the error message and let the callers handle it.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
> [...]
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 289af4fab5..3a2a0cb3c1 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu/atomic.h"
>>   #include "qemu/notify.h"
>>   #include "qemu-thread-common.h"
>> +#include "qapi/error.h"
>>   
>>   static bool name_threads;
>>   
>> @@ -504,9 +505,9 @@ static void *qemu_thread_start(void *args)
>>       return start_routine(arg);
>>   }
>>   
>> -void qemu_thread_create(QemuThread *thread, const char *name,
>> -                       void *(*start_routine)(void*),
>> -                       void *arg, int mode)
>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>> +                        void *(*start_routine)(void *),
>> +                        void *arg, int mode, Error **errp)
>>   {
>>       sigset_t set, oldset;
>>       int err;
>> @@ -515,7 +516,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>>   
>>       err = pthread_attr_init(&attr);
>>       if (err) {
>> -        error_exit(err, __func__);
>> +        error_setg(errp, "pthread_attr_init failed: %s", strerror(err));
>> +        return false;
> The commit message claims this function was "failing with an error".
> Not true; error_exit() abort()s.  It exit()ed until commit 53380ac37f2,
> v1.0.  The name error_exit() became misleading then.  The bad name is
> not this patch's problem, but its commit message needs to be corrected.
Ok, thanks. I will amend the message to "instead of abort() directly"
>
>>       }
>>   
>>       if (mode == QEMU_THREAD_DETACHED) {
> [...]
>
> I think David Gilbert added the bite-sized task you took on.  David,
> please review.
>
Thanks!

Have a nice day
Fei
