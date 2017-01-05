Received: from eggs.gnu.org ([2001:4830:134:3::10]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cPEha-0002Wz-IK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cPEhX-0002M6-Gf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:31:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cPEhX-0002Ly-Bu
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:31:55 -0500
Date: Thu, 5 Jan 2017 21:31:51 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170105203150.GE29430@potion>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<1483266886-25050-3-git-send-email-peterx@redhat.com>
	<20170102201824.GA2892@potion>
	<20170103024501.GA22664@pxdev.xzpeter.org>
	<20170104145541.GI2395@potion>
	<20170105023539.GM22664@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105023539.GM22664@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

2017-01-05 10:35+0800, Peter Xu:
> On Wed, Jan 04, 2017 at 03:55:42PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>> > I didn't notice the "-n" parameter for "wait", otherwise I won't
>> > bother using SIGUSR1 at all. :)
>>=20
>> (Btw. why couldn't you use SIGCHLD?)
>=20
> My understanding:
>=20
> SIGCHLD is used by internal bash. For every command we write (like a
> "ls" in the script), we should have forked another process to load the
> "/bin/ls" binary, and when this command (in this case "ls") finishes,
> it'll send one SIGCHLD to the main process. This should happen for
> each non-builtin bash commands, and bash program is managing these
> SIGCHLDs internally by default. So, we should not be able to trap
> SIGCHLD in bash.
>=20
> There is one way to trap it, only if we provide:
>=20
>   set -m
>=20
> to turn off the job controls of bash.

I think that "-m" enables job control, but I didn't know it can be
disabled.  I don't understand what bash does with +m -- bg/fg/&/^Z work
just as one would expect of job control, but not SIGCHLD.

>                                       However if with that, we'll
> trigger the SIGCHLD handler for *every* task we run, even for the
> normal commands like "ls". I suppose that's not what we want (we want
> to only trap those background $QEMU processes). That's why I used
> SIGUSR1 instead of SIGCHLD.

I see, it is a more robust, but signals can race, so we couldn't depend
on their count anyway.  And wow, we really get SIGCHLD for foreground
processes ... it wouldn't matter because the loop only uses builtins,
but it is stupid.  (I confess I don't usually use POSIX shells.)

> Of course, after I know "wait -n", it becomes clumsy. :-)

"clumsy" is still a praise for bash code. :)
