Received: from eggs.gnu.org ([2001:4830:134:3::10]:33878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cPDxK-0003Kf-Ol
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 14:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cPDxH-00045n-Lr
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 14:44:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cPDxH-00045T-Ck
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 14:44:07 -0500
Date: Thu, 5 Jan 2017 20:44:02 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170105194401.GD29430@potion>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
	<1483438205-31110-3-git-send-email-peterx@redhat.com>
	<20170104150938.GA9029@potion>
	<20170105030746.GN22664@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105030746.GN22664@pxdev.xzpeter.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

2017-01-05 11:07+0800, Peter Xu:
> On Wed, Jan 04, 2017 at 04:09:39PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>> 2017-01-03 18:10+0800, Peter Xu:
>> > run_task.sh is getting slow. This patch is trying to make it faster =
by
>> > running the tests concurrently.
>> >=20
>> > We provide a new parameter "-j" for the run_tests.sh, which can be u=
sed
>> > to specify how many run queues we want for the tests. Default queue
>> > length is 1, which is the old behavior.
>> >=20
>> > Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boo=
st:
>> >=20
>> >    |-----------------+-----------|
>> >    | command         | time used |
>> >    |-----------------+-----------|
>> >    | run_test.sh     | 75s       |
>> >    | run_test.sh -j8 | 27s       |
>> >    |-----------------+-----------|
>> >=20
>> > Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  run_tests.sh           | 12 ++++++++++--
>> >  scripts/functions.bash | 15 ++++++++++++++-
>> >  scripts/global.bash    | 11 +++++++++++
>> >  3 files changed, 35 insertions(+), 3 deletions(-)
>>=20
>> I like this diffstat a lot more, thanks :)
>>=20
>> The script doesn't handle ^C well now (at least), which can be worked
>> around with
>>=20
>>   trap exit SIGINT
>>=20
>> but it would be nice to know if receiving signals in `wait` can't be
>> fixed.
>=20
> When I send SIGINT to "run_tests.sh -j8", I see process hang dead. Not
> sure whether you see the same thing:
>=20
> #0  0x00007f7af2e1559a in waitpid () from /lib64/libc.so.6
> #1  0x00005613edf8953e in waitchld.isra ()
> #2  0x00005613edf8aae5 in wait_for ()
> #3  0x00005613edf8b682 in wait_for_any_job ()
> #4  0x00005613edfc7e64 in wait_builtin ()
> #5  0x00005613edf616ea in execute_builtin.isra ()
> #6  0x00005613edf623ee in execute_simple_command ()
> #7  0x00005613edf79e77 in execute_command_internal ()
> #8  0x00005613edf7b972 in execute_command ()
> #9  0x00005613edf62aca in execute_while_or_until ()
> #10 0x00005613edf7a156 in execute_command_internal ()
> #11 0x00005613edf79d88 in execute_command_internal ()
> ...

I do.  And sometimes, I also caught it in a signal handler:

  #0  0x00007f7461bcd637 in kill () at ../sysdeps/unix/syscall-template.S=
:84
  #1  0x00000000004476b9 in wait_sigint_handler (sig=3D<optimized out>) a=
t jobs.c:2504
  #2  <signal handler called>
  #3  0x00007f7461c674ca in __GI___waitpid (pid=3Dpid@entry=3D-1, stat_lo=
c=3Dstat_loc@entry=3D0x7ffdb49dfbd8,=20
      options=3Doptions@entry=3D0) at ../sysdeps/unix/sysv/linux/waitpid.=
c:29
  #4  0x0000000000449cfb in waitchld (block=3Dblock@entry=3D1, wpid=3D-1)=
 at jobs.c:3474
  #5  0x000000000044b2eb in wait_for (pid=3Dpid@entry=3D-1) at jobs.c:271=
8
  #6  0x000000000044becd in wait_for_any_job () at jobs.c:3015
  #7  0x000000000048c38b in wait_builtin (list=3D0x0) at ./wait.def:154
  ...

>=20
> If I change the "wait -n" into "wait" (this will work, but of course
> slower since we'll wait for all subprocesses end before we start
> another one), problem disappears.

Yeah, and just `wait` doesn't work with -j1 ... using `jobs -r` gets rid
of it.

>                                   Not sure whether that means a "wait
> -n" bug.

Most likely a bash bug:
 - doesn't happen if you SIGINT before the first job has finished
 - doesn't happen with normal wait

> Anyway, IMHO squashing you suggestion of "trap exit SIGINT" at the
> entry of for_each_unittest() is an acceptable solution - it works in
> all cases.

Seems like the best solution at this time ...
We actually want to "exit 130", as it would when using normal wait does,
and maybe it could be improved a bit by adding a wait:

  trap 'wait; exit 130' SIGINT
