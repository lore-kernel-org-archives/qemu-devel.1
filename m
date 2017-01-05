Received: from eggs.gnu.org ([2001:4830:134:3::10]:52433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOyPF-0002Ac-4C
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOyPB-0002FO-VP
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:07:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOyPB-0002Dw-P3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:07:53 -0500
Date: Thu, 5 Jan 2017 11:07:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170105030746.GN22664@pxdev.xzpeter.org>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
	<1483438205-31110-3-git-send-email-peterx@redhat.com>
	<20170104150938.GA9029@potion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170104150938.GA9029@potion>
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
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

On Wed, Jan 04, 2017 at 04:09:39PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> 2017-01-03 18:10+0800, Peter Xu:
> > run_task.sh is getting slow. This patch is trying to make it faster b=
y
> > running the tests concurrently.
> >=20
> > We provide a new parameter "-j" for the run_tests.sh, which can be us=
ed
> > to specify how many run queues we want for the tests. Default queue
> > length is 1, which is the old behavior.
> >=20
> > Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boos=
t:
> >=20
> >    |-----------------+-----------|
> >    | command         | time used |
> >    |-----------------+-----------|
> >    | run_test.sh     | 75s       |
> >    | run_test.sh -j8 | 27s       |
> >    |-----------------+-----------|
> >=20
> > Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  run_tests.sh           | 12 ++++++++++--
> >  scripts/functions.bash | 15 ++++++++++++++-
> >  scripts/global.bash    | 11 +++++++++++
> >  3 files changed, 35 insertions(+), 3 deletions(-)
>=20
> I like this diffstat a lot more, thanks :)
>=20
> The script doesn't handle ^C well now (at least), which can be worked
> around with
>=20
>   trap exit SIGINT
>=20
> but it would be nice to know if receiving signals in `wait` can't be
> fixed.

When I send SIGINT to "run_tests.sh -j8", I see process hang dead. Not
sure whether you see the same thing:

#0  0x00007f7af2e1559a in waitpid () from /lib64/libc.so.6
#1  0x00005613edf8953e in waitchld.isra ()
#2  0x00005613edf8aae5 in wait_for ()
#3  0x00005613edf8b682 in wait_for_any_job ()
#4  0x00005613edfc7e64 in wait_builtin ()
#5  0x00005613edf616ea in execute_builtin.isra ()
#6  0x00005613edf623ee in execute_simple_command ()
#7  0x00005613edf79e77 in execute_command_internal ()
#8  0x00005613edf7b972 in execute_command ()
#9  0x00005613edf62aca in execute_while_or_until ()
#10 0x00005613edf7a156 in execute_command_internal ()
#11 0x00005613edf79d88 in execute_command_internal ()
...

If I change the "wait -n" into "wait" (this will work, but of course
slower since we'll wait for all subprocesses end before we start
another one), problem disappears. Not sure whether that means a "wait
-n" bug.

Anyway, IMHO squashing you suggestion of "trap exit SIGINT" at the
entry of for_each_unittest() is an acceptable solution - it works in
all cases.

Thanks,

-- peterx
