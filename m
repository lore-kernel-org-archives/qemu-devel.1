Received: from eggs.gnu.org ([2001:4830:134:3::10]:33243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1g0rMU-0007N4-T8
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1g0rMR-0004n7-JA
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:54:30 -0400
Received: from mail-sn1nam01on0139.outbound.protection.outlook.com
	([104.47.32.139]:23624
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1g0rMQ-0004ky-VV
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:54:27 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 14 Sep 2018 16:54:24 +0000
Message-ID: <MWHPR21MB018954067574FC9D27C535389E190@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <5aae1837-f6b9-a48b-7401-3aa623a084b2@adacore.com>
	<MWHPR21MB0189D5FC1EA87DBDB0F040409E1A0@MWHPR21MB0189.namprd21.prod.outlook.com>
	<526ea449-6a67-605f-70c5-b90f2bacd280@adacore.com>,
	<53a9113b-62a0-a7fe-7c08-3edab38cfebc@adacore.com>
In-Reply-To: <53a9113b-62a0-a7fe-7c08-3edab38cfebc@adacore.com>
Content-Language: en-AU
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] crashes with win2008 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, Andrey Shedel <ashedel@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Thanks for digging into this Fred, and sorry -- it seems Andrey and I both =
missed that subtlety with TryAcquireSRWLockExclusive when we first made thi=
s change.



On the other hand, since these OSes are a decade old (mainstream support en=
ded; will drop out of extended support in just over a year from now), and y=
ou are the first person to report a problem in 1.5 years since the patch we=
nt in, I wonder if we could =93fix=94 the problem by updating the required =
OS versions for QEMU on Windows to Windows 7 / Server 2008 R2...



Paolo, do you have any opinion? Note that backing out the patch isn=92t a g=
reat idea either =96 it fixed a deadlock.



Andrew



________________________________
From: KONRAD Frederic <frederic.konrad@adacore.com>
Sent: Friday, September 14, 2018 4:17:36 AM
To: Andrew Baumann; Andrey Shedel
Cc: Paolo Bonzini; QEMU Developers
Subject: Re: [Qemu-devel] crashes with win2008 host

Ok finally got it,

The SRWL API seems to be available since Vista and Server 2008
except the 'TryAcquireSRWLockExclusive' function which is
available starting Seven and Server 2008 *R2*. Hence the error
message.

So basically that means QEMU is not compatible with version older
than Seven or 2008 R2.

Cheers,
Fred

Le 09/14/2018 =E0 10:29 AM, KONRAD Frederic a =E9crit :
>
>
> Le 09/13/2018 =E0 07:29 PM, Andrew Baumann a =E9crit :
>> Does this crash always happen at startup? Is it deterministic?
>>
>
> Hi Andrew,
>
> Thanks for your reactivity! Yes it crashes all the time..
>
>>
>>
>> c0000135 is STATUS_DLL_NOT_FOUND. I suspect ntdll is trying to
>> demand-load another DLL to provide that API, and it is missing
>> or corrupt on your Windows installation
>
> Actually that helps! Compiling in debug mode gave me this
> errors.. But it wasn't the error I was chasing..
>
> The initial error I was chasing is the following:
>    gdb: unknown target exception 0xc0000139 at 0x77636698
>
> When I execute it in graphic mode I get the following issue:
>
>    The procedure entry point TryAcquireSRWLockExclusive could not
>    be located in the dynamic link library KERNEL32.dll.
>
> It seems that there was the same issue raised with MySQL on
> Windows server 2008:
>    https://forums.mysql.com/read.php?11,642417,642417
>
> Is there anything I can do appart swaping back locally to the CS?
>
> Thanks,
> Fred
>
>>
>>
>>
>> BTW, you=92ll probably get a better stack trace from a native
>> debugger (windbg, etc.) in this scenario.
>>
>>
>>
>> Cheers,
>>
>> Andrew
>>
>>
>>
>>
>>
>> ________________________________
>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>> Sent: Thursday, September 13, 2018 10:02:56 AM
>> To: Andrey Shedel
>> Cc: Andrew Baumann; Paolo Bonzini; QEMU Developers
>> Subject: crashes with win2008 host
>>
>> Hi Andrey,
>>
>> I've strange crashes since this commit: (yes its old)
>>
>> commit 12f8def0e02232d7c6416ad9b66640f973c531d1
>> Author: Andrey Shedel <ashedel@microsoft.com>
>> Date:   Fri Mar 24 15:01:41 2017 -0700
>>
>>       win32: replace custom mutex and condition variable with
>>              native primitives
>>
>> Basically it just crashes.. (exception 0xc0000135) like this:
>>
>> (gdb) run
>> Starting program: C:\home\konrad\temp\qemu-system-sparc --version
>> [New Thread 5324.0xdf8]
>> gdb: unknown target exception 0xc0000135 at 0x77636698
>> gdb: unknown target exception 0xc0000135 at 0x77636698
>>
>> Program received signal ?, Unknown signal.
>> 0x0000000077636698 in ntdll!RtlRaiseStatus ()
>>      from C:\Windows\system32\ntdll.dll
>> (gdb) bt
>> #0  0x0000000077636698 in ntdll!RtlRaiseStatus ()
>>      from C:\Windows\system32\ntdll.dll
>> #1  0x00000000775dcbf7 in ntdll!LdrGetProcedureAddress ()
>>      from C:\Windows\system32\ntdll.dll
>> #2  0x00000000775a536e in ntdll!LdrInitializeThunk ()
>>      from C:\Windows\system32\ntdll.dll
>> #3  0x0000000000000000 in ?? ()
>> Backtrace stopped: previous frame inner to this frame (corrupt
>> stack?)
>> (gdb)
>>
>> Sorry the backtrace is not really helpful..
>>
>> I can reproduce the same behavior with v3.0.0.. and only with
>> the Windows 2008 server host..
>>
>> If I partially revert the patch, eg: using CriticalSection
>> instead of SRWL it seems to work.. But I don't understand why
>> because SRWL should be supported on 2008 Server..
>>
>> Here is the change I did (which is wrongly making qemu_mutex
>> recursive for now):
>>
>> diff --git a/include/qemu/thread-win32.h
>> b/include/qemu/thread-win32.h
>> index d668d789b4..b335687604 100644
>> --- a/include/qemu/thread-win32.h
>> +++ b/include/qemu/thread-win32.h
>> @@ -4,7 +4,8 @@
>>    #include <windows.h>
>>
>>    struct QemuMutex {
>> -    SRWLOCK lock;
>> +    CRITICAL_SECTION lock;
>> +    LONG owner;
>>    #ifdef CONFIG_DEBUG_MUTEX
>>        const char *file;
>>        int line;
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index b303188a36..09ce4fd957 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -45,7 +45,7 @@ static void error_exit(int err, const char *msg)
>>
>>    void qemu_mutex_init(QemuMutex *mutex)
>>    {
>> -    InitializeSRWLock(&mutex->lock);
>> +    InitializeCriticalSection(&mutex->lock);
>>        qemu_mutex_post_init(mutex);
>>    }
>>
>> @@ -53,14 +53,14 @@ void qemu_mutex_destroy(QemuMutex *mutex)
>>    {
>>        assert(mutex->initialized);
>>        mutex->initialized =3D false;
>> -    InitializeSRWLock(&mutex->lock);
>> +    DeleteCriticalSection(&mutex->lock);
>>    }
>>
>>    void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file,
>> const int line)
>>    {
>>        assert(mutex->initialized);
>>        qemu_mutex_pre_lock(mutex, file, line);
>> -    AcquireSRWLockExclusive(&mutex->lock);
>> +    EnterCriticalSection(&mutex->lock);
>>        qemu_mutex_post_lock(mutex, file, line);
>>    }
>>
>> @@ -69,7 +69,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex,
>> const char *file, const int line)
>>        int owned;
>>
>>        assert(mutex->initialized);
>> -    owned =3D TryAcquireSRWLockExclusive(&mutex->lock);
>> +    owned =3D TryEnterCriticalSection(&mutex->lock);there
>>        if (owned) {
>>            qemu_mutex_post_lock(mutex, file, line);
>>            return 0;
>> @@ -81,7 +81,7 @@ void qemu_mutex_unlock_impl(QemuMutex *mutex,
>> const char *file, const int line)
>>    {
>>        assert(mutex->initialized);
>>        qemu_mutex_pre_unlock(mutex, file, line);
>> -    ReleaseSRWLockExclusive(&mutex->lock);
>> +    LeaveCriticalSection(&mutex->lock);
>>    }
>>
>>    void qemu_rec_mutex_init(QemuRecMutex *mutex)
>> @@ -141,11 +141,12 @@ void qemu_cond_broadcast(QemuCond *cond)
>>        WakeAllConditionVariable(&cond->var);
>>    }
>>
>> -void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const
>> char *file, const int line)
>> +void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const
>> char *file,
>> +                         const int line)
>>    {
>>        assert(cond->initialized);
>>        qemu_mutex_pre_unlock(mutex, file, line);
>> -    SleepConditionVariableSRW(&cond->var, &mutex->lock,
>> INFINITE, 0);
>> +    SleepConditionVariableCS(&cond->var, &mutex->lock, INFINITE);
>>        qemu_mutex_post_lock(mutex, file, line);
>>    }
>>
>> --
>> 2.16.2
>>
>> Do you have any idea of what's happening?
>>
>> Regards,
>> Fred
>>
>
