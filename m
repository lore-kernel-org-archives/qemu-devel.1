Received: from eggs.gnu.org ([208.118.235.92]:47984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfP8z-0002lU-J7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfP8y-0004rl-LO
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:04:09 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfP8y-0004pp-8k
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:04:08 -0500
Received: by mail-ot1-x32e.google.com with SMTP id a11so32003254otr.10
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:04:07 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
In-Reply-To: <bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 13:03:55 +0000
Message-ID: <CAFEAcA97LKhk_FxPbPGG3C2FpSRTpVyez77xjCJah6Gqh=bjsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 07:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I don't know... I tried running make check under "strace -e fcntl" and I
> didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).

I found this strace command worked to track down some possible
culprits:
strace -o /tmp/strace.log -e fcntl,execve,clone -e signal=none -f make
-C build/x86 V=1 check

Extracts from the logs:

29251 execve("tests/test-char", ["tests/test-char", "-q", "-p",
"/char/stdio/subprocess", "--GTestSubprocess", "--GTestLogFD", "4"],
[/* 66 vars */] <unfinished ...>
29251 <... execve resumed> )            = 0
29251 fcntl(3, F_GETFD)                 = 0
29251 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
29251 clone(child_stack=0x7f43946addf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f43946ae9d0, tls=0x7f43946ae700,
child_tidptr=0x7f43946ae9d0) = 29254
29251 fcntl(4, F_GETFD)                 = 0
29251 fcntl(4, F_SETFD, FD_CLOEXEC)     = 0
29251 fcntl(4, F_GETFL)                 = 0x2 (flags O_RDWR)
29251 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
29251 fcntl(0, F_GETFL)                 = 0x8000 (flags O_RDONLY|O_LARGEFILE)
29251 fcntl(0, F_GETFL)                 = 0x8000 (flags O_RDONLY|O_LARGEFILE)
29251 fcntl(0, F_SETFL, O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 0
29251 fcntl(1, F_GETFL)                 = 0x1 (flags O_WRONLY)
29251 fcntl(1, F_SETFL, O_WRONLY|O_NONBLOCK) = 0
29251 fcntl(0, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
29251 fcntl(0, F_SETFL, O_RDONLY|O_LARGEFILE) = -1 EBADF (Bad file descriptor)
29254 +++ exited with 0 +++
29251 +++ exited with 0 +++

(the attempt to F_SETFL a closed stdin is also interesting).

and

30300 execve("tests/hexloader-test", ["tests/hexloader-test",
"--quiet", "--keep-going", "-m
=quick", "--GTestLogFD=6"], [/* 68 vars */]) = 0
30300 fcntl(3, F_GETFD)                 = 0
30300 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
30300 fcntl(4, F_GETFD)                 = 0
30300 fcntl(4, F_SETFD, FD_CLOEXEC)     = 0
30300 clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7f26bdc09a10) = 30301
30301 execve("/bin/sh", ["sh", "-c", "exec
arm-softmmu/qemu-system-arm"...], [/* 69 vars */]) = 0
30301 execve("arm-softmmu/qemu-system-arm",
["arm-softmmu/qemu-system-arm", "-qtest",
"unix:/tmp/qtest-30300.sock,nowai"..., "-qtest-log", "/dev/null",
"-chardev", "socket,path=/tmp/qtest-30300.qmp"..., "-mon",
"chardev=char0,mode=control", "-machine", "accel=qtest", "-display",
"none", "-M", "vexpress-a9", "-nographic", ...], [/* 69 vars */]) = 0
30301 fcntl(3, F_GETFD)                 = 0
30301 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
30301 clone(child_stack=0x7f84f7614730,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f84f76179d0, tls=0x7f84f7617700,
child_tidptr=0x7f84f76179d0) = 30302
30301 fcntl(7, F_GETFD)                 = 0
30301 fcntl(7, F_SETFD, FD_CLOEXEC)     = 0
30301 fcntl(7, F_GETFL)                 = 0x2 (flags O_RDWR)
30301 fcntl(7, F_SETFL, O_RDWR|O_NONBLOCK) = 0
30301 fcntl(11, F_GETFL)                = 0x2 (flags O_RDWR)
30301 fcntl(11, F_SETFL, O_RDWR|O_NONBLOCK) = 0
30301 fcntl(12, F_GETFL)                = 0x2 (flags O_RDWR)
30301 fcntl(12, F_SETFL, O_RDWR|O_NONBLOCK) = 0
30301 clone(child_stack=0x7f84f6e13730,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f84f6e169d0, tls=0x7f84f6e16700,
child_tidptr=0x7f84f6e169d0) = 30303
30301 fcntl(0, F_GETFL)                 = 0x8000 (flags O_RDONLY|O_LARGEFILE)
30301 fcntl(0, F_GETFL)                 = 0x8000 (flags O_RDONLY|O_LARGEFILE)
30301 fcntl(0, F_SETFL, O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 0
30301 fcntl(1, F_GETFL)                 = 0x8402 (flags
O_RDWR|O_APPEND|O_LARGEFILE)
30301 fcntl(1, F_SETFL, O_RDWR|O_APPEND|O_NONBLOCK|O_LARGEFILE) = 0
30301 clone(child_stack=0x7f84f6612730,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f84f66159d0, tls=0x7f84f6615700,
child_tidptr=0x7f84f66159d0) = 30304
30303 +++ exited with 0 +++
30301 fcntl(0, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
30301 fcntl(0, F_SETFL, O_RDONLY|O_LARGEFILE) = -1 EBADF (Bad file descriptor)
30302 +++ exited with 0 +++
30301 +++ exited with 0 +++

where tests/hexloader-test starts a QEMU process which
makes stdin/stdout non-blocking.

I didn't try to also track dup/dup2/dup3 use to see whether fd 0/1/2
were duped to other fds and then set O_NONBLOCK via those, or
open to see if they were reopened with other contents.

(Test run is still in-progress, I'll update if there are any more
interesting bits of logging.)

thanks
-- PMM
