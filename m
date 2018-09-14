Received: from eggs.gnu.org ([2001:4830:134:3::10]:47336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1g0m6b-0000iE-B5
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1g0m6Y-0000Py-2o
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:17:45 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:45624
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1g0m6W-0000OZ-Tp
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:17:42 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
References: <5aae1837-f6b9-a48b-7401-3aa623a084b2@adacore.com>
	<MWHPR21MB0189D5FC1EA87DBDB0F040409E1A0@MWHPR21MB0189.namprd21.prod.outlook.com>
	<526ea449-6a67-605f-70c5-b90f2bacd280@adacore.com>
Message-ID: <53a9113b-62a0-a7fe-7c08-3edab38cfebc@adacore.com>
Date: Fri, 14 Sep 2018 13:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <526ea449-6a67-605f-70c5-b90f2bacd280@adacore.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
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
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Shedel <ashedel@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Ok finally got it,

The SRWL API seems to be available since Vista and Server 2008
except the 'TryAcquireSRWLockExclusive' function which is
available starting Seven and Server 2008 *R2*. Hence the error
message.

So basically that means QEMU is not compatible with version older
than Seven or 2008 R2.

Cheers,
Fred

Le 09/14/2018 =E0 10:29 AM, KONRAD Frederic a =E9crit=A0:
>=20
>=20
> Le 09/13/2018 =E0 07:29 PM, Andrew Baumann a =E9crit=A0:
>> Does this crash always happen at startup? Is it deterministic?
>>
>=20
> Hi Andrew,
>=20
> Thanks for your reactivity! Yes it crashes all the time..
>=20
>>
>>
>> c0000135 is STATUS_DLL_NOT_FOUND. I suspect ntdll is trying to=20
>> demand-load another DLL to provide that API, and it is missing=20
>> or corrupt on your Windows installation
>=20
> Actually that helps! Compiling in debug mode gave me this
> errors.. But it wasn't the error I was chasing..
>=20
> The initial error I was chasing is the following:
>  =A0 gdb: unknown target exception 0xc0000139 at 0x77636698
>=20
> When I execute it in graphic mode I get the following issue:
>=20
>  =A0 The procedure entry point TryAcquireSRWLockExclusive could not
>  =A0 be located in the dynamic link library KERNEL32.dll.
>=20
> It seems that there was the same issue raised with MySQL on
> Windows server 2008:
>  =A0 https://forums.mysql.com/read.php?11,642417,642417
>=20
> Is there anything I can do appart swaping back locally to the CS?
>=20
> Thanks,
> Fred
>=20
>>
>>
>>
>> BTW, you=92ll probably get a better stack trace from a native=20
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
>> Date:=A0=A0 Fri Mar 24 15:01:41 2017 -0700
>>
>> =A0=A0=A0=A0=A0 win32: replace custom mutex and condition variable wit=
h
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 native primitives
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
>> =A0=A0=A0=A0 from C:\Windows\system32\ntdll.dll
>> (gdb) bt
>> #0=A0 0x0000000077636698 in ntdll!RtlRaiseStatus ()
>> =A0=A0=A0=A0 from C:\Windows\system32\ntdll.dll
>> #1=A0 0x00000000775dcbf7 in ntdll!LdrGetProcedureAddress ()
>> =A0=A0=A0=A0 from C:\Windows\system32\ntdll.dll
>> #2=A0 0x00000000775a536e in ntdll!LdrInitializeThunk ()
>> =A0=A0=A0=A0 from C:\Windows\system32\ntdll.dll
>> #3=A0 0x0000000000000000 in ?? ()
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
>> =A0=A0 #include <windows.h>
>>
>> =A0=A0 struct QemuMutex {
>> -=A0=A0=A0 SRWLOCK lock;
>> +=A0=A0=A0 CRITICAL_SECTION lock;
>> +=A0=A0=A0 LONG owner;
>> =A0=A0 #ifdef CONFIG_DEBUG_MUTEX
>> =A0=A0=A0=A0=A0=A0 const char *file;
>> =A0=A0=A0=A0=A0=A0 int line;
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index b303188a36..09ce4fd957 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -45,7 +45,7 @@ static void error_exit(int err, const char *msg)
>>
>> =A0=A0 void qemu_mutex_init(QemuMutex *mutex)
>> =A0=A0 {
>> -=A0=A0=A0 InitializeSRWLock(&mutex->lock);
>> +=A0=A0=A0 InitializeCriticalSection(&mutex->lock);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_post_init(mutex);
>> =A0=A0 }
>>
>> @@ -53,14 +53,14 @@ void qemu_mutex_destroy(QemuMutex *mutex)
>> =A0=A0 {
>> =A0=A0=A0=A0=A0=A0 assert(mutex->initialized);
>> =A0=A0=A0=A0=A0=A0 mutex->initialized =3D false;
>> -=A0=A0=A0 InitializeSRWLock(&mutex->lock);
>> +=A0=A0=A0 DeleteCriticalSection(&mutex->lock);
>> =A0=A0 }
>>
>> =A0=A0 void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file,
>> const int line)
>> =A0=A0 {
>> =A0=A0=A0=A0=A0=A0 assert(mutex->initialized);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_pre_lock(mutex, file, line);
>> -=A0=A0=A0 AcquireSRWLockExclusive(&mutex->lock);
>> +=A0=A0=A0 EnterCriticalSection(&mutex->lock);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_post_lock(mutex, file, line);
>> =A0=A0 }
>>
>> @@ -69,7 +69,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex,
>> const char *file, const int line)
>> =A0=A0=A0=A0=A0=A0 int owned;
>>
>> =A0=A0=A0=A0=A0=A0 assert(mutex->initialized);
>> -=A0=A0=A0 owned =3D TryAcquireSRWLockExclusive(&mutex->lock);
>> +=A0=A0=A0 owned =3D TryEnterCriticalSection(&mutex->lock);there
>> =A0=A0=A0=A0=A0=A0 if (owned) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_mutex_post_lock(mutex, file, line)=
;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> @@ -81,7 +81,7 @@ void qemu_mutex_unlock_impl(QemuMutex *mutex,
>> const char *file, const int line)
>> =A0=A0 {
>> =A0=A0=A0=A0=A0=A0 assert(mutex->initialized);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_pre_unlock(mutex, file, line);
>> -=A0=A0=A0 ReleaseSRWLockExclusive(&mutex->lock);
>> +=A0=A0=A0 LeaveCriticalSection(&mutex->lock);
>> =A0=A0 }
>>
>> =A0=A0 void qemu_rec_mutex_init(QemuRecMutex *mutex)
>> @@ -141,11 +141,12 @@ void qemu_cond_broadcast(QemuCond *cond)
>> =A0=A0=A0=A0=A0=A0 WakeAllConditionVariable(&cond->var);
>> =A0=A0 }
>>
>> -void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const
>> char *file, const int line)
>> +void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const
>> char *file,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 const int line)
>> =A0=A0 {
>> =A0=A0=A0=A0=A0=A0 assert(cond->initialized);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_pre_unlock(mutex, file, line);
>> -=A0=A0=A0 SleepConditionVariableSRW(&cond->var, &mutex->lock,
>> INFINITE, 0);
>> +=A0=A0=A0 SleepConditionVariableCS(&cond->var, &mutex->lock, INFINITE=
);
>> =A0=A0=A0=A0=A0=A0 qemu_mutex_post_lock(mutex, file, line);
>> =A0=A0 }
>>
>> --=20
>> 2.16.2
>>
>> Do you have any idea of what's happening?
>>
>> Regards,
>> Fred
>>
>=20
