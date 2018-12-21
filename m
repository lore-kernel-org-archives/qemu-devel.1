Received: from eggs.gnu.org ([2001:4830:134:3::10]:49431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gaHF0-0001FS-JV
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gaHEw-00080Q-Tq
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:37:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49498 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gaHEw-0007z1-Am
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:37:06 -0500
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<3645fb54-3651-f63b-c416-b22634e1f992@suse.com>
	<87zht1keso.fsf@dusky.pond.sub.org>
	<cc510f12-e94c-bd90-ce01-4ad5d143420f@suse.com>
From: Fei Li <fli@suse.com>
Message-ID: <1d626d01-e503-f554-3af8-0706830f245d@suse.com>
Date: Fri, 21 Dec 2018 17:36:57 +0800
MIME-Version: 1.0
In-Reply-To: <cc510f12-e94c-bd90-ce01-4ad5d143420f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


On 12/19/2018 08:14 PM, Fei Li wrote:
>
> On 12/19/2018 06:10 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> On 12/13/2018 03:26 PM, Markus Armbruster wrote:
>>>> There's a question for David Gibson inline.=C2=A0 Please search for =
/ppc/.
>>>>
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> Make qemu_thread_create() return a Boolean to indicate if it succee=
ds
>>>>> rather than failing with an error. And add an Error parameter to ho=
ld
>>>>> the error message and let the callers handle it.
>>>> The "rather than failing with an error" is misleading. Before the
>>>> patch, we report to stderr and abort().=C2=A0 What about:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-thread: Make qemu_thread_create(=
) handle errors properly
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create() abort()s on erro=
r.=C2=A0 Not nice. Give it a
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return value and an Error ** argument=
, so it can return=20
>>>> success /
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 failure.
>>> A nice commit-amend! Thanks!
>>>> Still missing from the commit message then: how you update the=20
>>>> callers.
>>> Yes, agree. I think the-how should also be noted here, like
>>> - propagating the err to callers whose call trace already have the
>>> Error paramater;
>>> - just add an &error_abort for qemu_thread_create() and make it a
>>> "TODO: xxx";
>>>> Let's see below.
>>>>
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 cpus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 45=20
>>>>> ++++++++++++++++++++++++-------------
>>>>> =C2=A0=C2=A0 dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++--
>>>>> =C2=A0=C2=A0 hw/misc/edu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++--
>>>>> =C2=A0=C2=A0 hw/ppc/spapr_hcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++++--
>>>>> =C2=A0=C2=A0 hw/rdma/rdma_backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 +++-
>>>>> =C2=A0=C2=A0 hw/usb/ccid-card-emulated.c | 16 ++++++++++----
>>>>> =C2=A0=C2=A0 include/qemu/thread.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
>>>>> =C2=A0=C2=A0 io/task.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3=
 ++-
>>>>> =C2=A0=C2=A0 iothread.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++-=
----
>>>>> =C2=A0=C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 54=20
>>>>> +++++++++++++++++++++++++++++----------------
>>>>> =C2=A0=C2=A0 migration/postcopy-ram.c=C2=A0=C2=A0=C2=A0 | 14 ++++++=
++++--
>>>>> =C2=A0=C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++++++++++---------
>>>>> =C2=A0=C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 ++++++---
>>>>> =C2=A0=C2=A0 tests/atomic_add-bench.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +=
+-
>>>>> =C2=A0=C2=A0 tests/iothread.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 tests/qht-bench.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>>>> =C2=A0=C2=A0 tests/rcutorture.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>>>> =C2=A0=C2=A0 tests/test-aio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 tests/test-rcu-list.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 ++-
>>>>> =C2=A0=C2=A0 ui/vnc-jobs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++-----
>>>>> =C2=A0=C2=A0 ui/vnc-jobs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 ui/vnc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 4 +++-
>>>>> =C2=A0=C2=A0 util/compatfd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++--
>>>>> =C2=A0=C2=A0 util/oslib-posix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 ++++++++++----
>>>>> =C2=A0=C2=A0 util/qemu-thread-posix.c=C2=A0=C2=A0=C2=A0 | 24 ++++++=
+++++++-------
>>>>> =C2=A0=C2=A0 util/qemu-thread-win32.c=C2=A0=C2=A0=C2=A0 | 16 ++++++=
++++----
>>>>> =C2=A0=C2=A0 util/rcu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>>>> =C2=A0=C2=A0 util/thread-pool.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>>>>> =C2=A0=C2=A0 28 files changed, 243 insertions(+), 101 deletions(-)
>>>>>
...snip, and only leave the three uncertain small topics...
>>>
>>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>>> index 658dfa88a3..6e0cccf066 100644
>>>>> --- a/migration/ram.c
>>>>> +++ b/migration/ram.c
>>>>> @@ -473,6 +473,7 @@ static void compress_threads_save_cleanup(void)
>>>>> =C2=A0=C2=A0 static int compress_threads_save_setup(void)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, thread_count;
>>>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate_use_c=
ompression()) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 0;
>>>>> @@ -502,9 +503,12 @@ static int compress_threads_save_setup(void)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp_p=
aram[i].quit =3D false;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_m=
utex_init(&comp_param[i].mutex);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_c=
ond_init(&comp_param[i].cond);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create(comp=
ress_threads + i, "compress",
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 do_data_compress, comp_param + i,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 QEMU_THREAD_JOINABLE);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_thread_create=
(compress_threads + i, "compress",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_data_compress, comp_para=
m + i,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_THREAD_JOINABLE, &loca=
l_err)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_reportf_err(local_err, "failed to create=20
>>>>> do_data_compress: ");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto exit;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> Reviewing the migration changes is getting tiresome...
>>> Yes, indeed, the migration involves a lot! Thanks so much for helping
>>> to review!
>>>> =C2=A0=C2=A0 Is reporting the
>>>> error appropriate here, and why?
>>> I think the qemu monitor should display the obvious and exact failing
>>> reason for administrators, esp considering that qemu_thread_create()
>>> itself does not print any message thus we have no idea which direct
>>> function fails if gdb is not enabled.
>>> IOW, I think David's answer to that ppc's error_reportf_err() also
>>> apply here:
>>>
>>> "The error returns are for the guest, the reported errors are for the
>>> guest administrator or management layers."
>> There could well be an issue with the "management layers" part. Should
>> this error be sent to the management layer via QMP somehow? Migration
>> maintainers should be able to assist with this question.
Kindly ping migration maintainers. :)
>
>>>>> diff --git a/util/compatfd.c b/util/compatfd.c
>>>>> index 980bd33e52..886aa249f9 100644
>>>>> --- a/util/compatfd.c
>>>>> +++ b/util/compatfd.c
>>>>> @@ -16,6 +16,7 @@
>>>>> =C2=A0=C2=A0 #include "qemu/osdep.h"
>>>>> =C2=A0=C2=A0 #include "qemu-common.h"
>>>>> =C2=A0=C2=A0 #include "qemu/thread.h"
>>>>> +#include "qapi/error.h"
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #include <sys/syscall.h>
>>>>> =C2=A0=C2=A0 @@ -70,6 +71,7 @@ static int qemu_signalfd_compat(cons=
t sigset_t
>>>>> *mask)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sigfd_compat_info *info=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuThread thread;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fds[2];
>>>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D malloc(si=
zeof(*info));
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (info =3D=3D NULL) {
>>>>> @@ -88,8 +90,14 @@ static int qemu_signalfd_compat(const sigset_t=20
>>>>> *mask)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&info->mask, mask, size=
of(*mask));
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->fd =3D fds[1];
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 qemu_thread_create(&thread, "signa=
lfd_compat",
>>>>> sigwait_compat, info,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_T=
HREAD_DETACHED);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!qemu_thread_create(&thread, "signalfd_comp=
at",=20
>>>>> sigwait_compat,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info, QEMU_THREAD_DETACHED,=20
>>>>> &local_err)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local=
_err, "failed to create=20
>>>>> sigwait_compat: ");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fds[0]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fds[1]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(info);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fds[0];
>>>>> =C2=A0=C2=A0 }
>>>> This function is implements signalfd() when the kernel doesn't provi=
de
>>>> it.
>>>>
>>>> signalfd() sets errno on failure.=C2=A0 The replacement's existing f=
ailure
>>>> modes set errno.=C2=A0 You add a failure mode that doesn't set errno=
.=C2=A0=20
>>>> That's
>>>> a bug.=C2=A0 To fix it, you can either make qemu_thread_create() set=
 errno,
>>>> or you can make it return a value you can use to set errno. The comm=
on
>>>> way to do the latter is returning a *negated* errno value.
>>> Oops, I forgot setting the errno for Linux implementation! My fault..
>>> I will set errno inside qemu_thread_create() as follows:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pthread_attr_init(&attr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -e=
rr, "pthread_attr_init failed: %s",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 strerror(err));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, er=
rno, "pthread_attr_init failed");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Make sure to set errno on all failures, not just this one.
> Actually, this code update is changed for qemu_thread_create() itself,
> I think if the errno is set in this function, no callers' errno need=20
> to be set.
> Please correct me if I understand wrong. :)
>> Also add a function comment.=C2=A0 I suspect returning negated errno w=
ould
>> lead to a shorter function comment.
> Actually only one caller needs the errno, that is the above=20
> qemu_signalfd_compat().
> For the returning value, I remember there's once a email thread=20
> talking about it:
> returning a bool (and let the passed errp hold the error message) is=20
> to keep the
> consistency with glib. IMO, returning a bool or returning the -errno=20
> is equal to
> me if we do not use the return value again in the callers, it just=20
> involves the
> judgement. But if we want to reuse the return value, like:
> =C2=A0 ret =3D qemu_thread_create(xx, xx, &local_err);
> I do not think it is much needed. What do you think?
One place needs to be confirmed. :)
>> =C2=A0 Yet another reason to write
>> function comments!=C2=A0 Making myself document the mess I made has ma=
de me
>> clean it up before I submit it many times :)
> Ok, thanks for the experience. Will add the comment. :)
>>
>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>> index 865e476df5..81b40a1ece 100644
>>>>> --- a/util/qemu-thread-posix.c
>>>>> +++ b/util/qemu-thread-posix.c
>>>>> @@ -15,6 +15,7 @@
>>>>> =C2=A0=C2=A0 #include "qemu/atomic.h"
>>>>> =C2=A0=C2=A0 #include "qemu/notify.h"
>>>>> =C2=A0=C2=A0 #include "qemu-thread-common.h"
>>>>> +#include "qapi/error.h"
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 static bool name_threads;
>>>>> =C2=A0=C2=A0 @@ -500,9 +501,9 @@ static void *qemu_thread_start(voi=
d *args)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
>>>>> =C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -void qemu_thread_create(QemuThread *thread, const cha=
r *name,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *=
(*start_routine)(void*),
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *=
arg, int mode)
>>>>> +bool qemu_thread_create(QemuThread *thread, const char *name,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *(*start_routine)(void *),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *arg, int mode, Error **errp)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigset_t set, oldset;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>>> @@ -511,7 +512,9 @@ void qemu_thread_create(QemuThread *thread,=20
>>>>> const char *name,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pthread_at=
tr_init(&attr);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_exit(err, __func_=
_);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, =
-err, "pthread_attr_init failed: %s",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 strerror(err));
>> -err is actually wrong: pthread_attr_init() returns a *positive* errno
>> code on failure.
> Yes, a definite wrong code.. :( Actually, pthread_attr_init() returns=20
> a nonzero error
> number, thus I do the below update by assigning the return err to errno=
.
>
> =C2=A0=C2=A0=C2=A0=C2=A0 err =3D pthread_attr_init(&attr);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_exit(err, __func__);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D err;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, errn=
o, "pthread_attr_init failed");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
Another place needs to be confirmed. :)
>
Have a nice day, thanks
Fei
