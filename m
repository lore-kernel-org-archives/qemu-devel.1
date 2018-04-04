Received: from eggs.gnu.org ([2001:4830:134:3::10]:47326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fdp-0004Ji-P4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fdm-0003dk-ET
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:45 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:50766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fdm-0003dD-7B
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:42 -0400
Received: by mail-wm0-x234.google.com with SMTP id t67so19823817wmt.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:27:42 -0700 (PDT)
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
	<87vad8cl2v.fsf@linaro.org>
	<CAMo8BfJV-2wbx=JnudOB_+GZqQziSuuARNpiJ5rhpGH-KwEbWw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMo8BfJV-2wbx=JnudOB_+GZqQziSuuARNpiJ5rhpGH-KwEbWw@mail.gmail.com>
Date: Wed, 04 Apr 2018 11:27:39 +0100
Message-ID: <87muyjcllw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>


Max Filippov <jcmvbkbc@gmail.com> writes:

> Hi Alex,
>
> On Tue, Apr 3, 2018 at 9:26 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> Max Filippov <jcmvbkbc@gmail.com> writes:
>>
>>> cpu_copy adds newly created CPU object to container/machine/unattached,
>>> but does it w/o proper locking. As a result when multiple threads are
>>> created rapidly QEMU may abort with the following message:
>>>
>>>   GLib-CRITICAL **: g_hash_table_iter_next: assertion
>>>   'ri->version =3D=3D ri->hash_table->version' failed
>>>
>>>   ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
>>>   code should not be reached
>>>
>>> Move cpu_copy invocation under clone_lock to fix that.
>>
>> So my main concern is are we duplicating something already (should be?)
>> handled by fork_start/fork_end?
>
> clone_lock already exists, it protects state in case of thread creation,
> it just didn't protect enough of it.
>
> The work done by fork_start/fork_end appears to be heavier than
> what's needed for thread creation, because fork_start stops all
> other CPUs (to make sure that child process won't get locks owned
> by threads that no longer exist in the child process), which is not
> required for thread creation, hence thread creation uses clone_lock.

I'm wondering if it should be doing more. After all start/end_exclusive
rely on the cpu list and that isn't updated on thread creation - and
without that a bunch of other things fail like ld/st exclusive after
your first new thread is spawned.

This really needs some test cases to check.

So while I think clone_lock fixes this immediate problem I suspect there
is more to do for this case.

>
>> This serialises forks and ensures things like the cpu_list (which ~ a
>> thread list for linux-user) are updated safely.


--
Alex Benn=C3=A9e
