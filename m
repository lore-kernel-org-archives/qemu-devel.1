Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOxu8-0005QS-JJ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOxu4-0000IO-Jm
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOxu4-0000I9-8K
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:35:44 -0500
Date: Thu, 5 Jan 2017 10:35:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170105023539.GM22664@pxdev.xzpeter.org>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<1483266886-25050-3-git-send-email-peterx@redhat.com>
	<20170102201824.GA2892@potion>
	<20170103024501.GA22664@pxdev.xzpeter.org>
	<20170104145541.GI2395@potion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170104145541.GI2395@potion>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 2/2] run_tests: allow run
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

On Wed, Jan 04, 2017 at 03:55:42PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:

[...]

> >>   done
> >>   run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$a=
rch" "$check" "$accel" "$timeout" &
> >=20
> > I think this might work, however it has assumption that these $cmd
> > tasks are the only jobs that is running in the background.
>=20
> Yes, but run_task is already in a sub shell, so its jobs don't matter
> and we can easily guarantee that for_each_unit_test won't spawn more.

Agree. After a second thought, I think it's okay we use "jobs" here as
long as we make sure we don't spawn background tasks other than these
test cases.

>=20
> > I didn't notice the "-n" parameter for "wait", otherwise I won't
> > bother using SIGUSR1 at all. :)
>=20
> (Btw. why couldn't you use SIGCHLD?)

My understanding:

SIGCHLD is used by internal bash. For every command we write (like a
"ls" in the script), we should have forked another process to load the
"/bin/ls" binary, and when this command (in this case "ls") finishes,
it'll send one SIGCHLD to the main process. This should happen for
each non-builtin bash commands, and bash program is managing these
SIGCHLDs internally by default. So, we should not be able to trap
SIGCHLD in bash.

There is one way to trap it, only if we provide:

  set -m

to turn off the job controls of bash. However if with that, we'll
trigger the SIGCHLD handler for *every* task we run, even for the
normal commands like "ls". I suppose that's not what we want (we want
to only trap those background $QEMU processes). That's why I used
SIGUSR1 instead of SIGCHLD.

Of course, after I know "wait -n", it becomes clumsy. :-)

-- peterx
