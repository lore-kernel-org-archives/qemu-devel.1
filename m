Received: from eggs.gnu.org ([2001:4830:134:3::10]:36322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f3PTU-0007CM-96
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f3PTS-0004Ri-7A
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:12:00 -0400
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:36977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f3PTS-0004RV-2U
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 13:11:58 -0400
Received: by mail-yw0-x236.google.com with SMTP id y23so6395071ywy.4
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 10:11:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87vad8cl2v.fsf@linaro.org>
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
	<87vad8cl2v.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 3 Apr 2018 10:11:56 -0700
Message-ID: <CAMo8BfJV-2wbx=JnudOB_+GZqQziSuuARNpiJ5rhpGH-KwEbWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Hi Alex,

On Tue, Apr 3, 2018 at 9:26 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Max Filippov <jcmvbkbc@gmail.com> writes:
>
>> cpu_copy adds newly created CPU object to container/machine/unattached,
>> but does it w/o proper locking. As a result when multiple threads are
>> created rapidly QEMU may abort with the following message:
>>
>>   GLib-CRITICAL **: g_hash_table_iter_next: assertion
>>   'ri->version =3D=3D ri->hash_table->version' failed
>>
>>   ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
>>   code should not be reached
>>
>> Move cpu_copy invocation under clone_lock to fix that.
>
> So my main concern is are we duplicating something already (should be?)
> handled by fork_start/fork_end?

clone_lock already exists, it protects state in case of thread creation,
it just didn't protect enough of it.

The work done by fork_start/fork_end appears to be heavier than
what's needed for thread creation, because fork_start stops all
other CPUs (to make sure that child process won't get locks owned
by threads that no longer exist in the child process), which is not
required for thread creation, hence thread creation uses clone_lock.

> This serialises forks and ensures things like the cpu_list (which ~ a
> thread list for linux-user) are updated safely.

--=20
Thanks.
-- Max
