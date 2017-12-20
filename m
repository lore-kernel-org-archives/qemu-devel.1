Received: from eggs.gnu.org ([2001:4830:134:3::10]:43960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRjvd-0001zq-EA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRjvc-0003eE-6B
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:21:21 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRjvb-0003dh-WA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:21:20 -0500
Received: by mail-ot0-x242.google.com with SMTP id i1so20532974oth.9
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 11:21:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 19:20:58 +0000
Message-ID: <CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/46] First batch of misc patches for QEMU
 2.12
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

On 20 December 2017 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba=
26:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-=
18-v2' into staging (2017-12-20 13:20:48 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d01ce16cd827831145cf6a5b4a81ce3a47b537cd:
>
>   chardev: convert the socket server to QIONetListener (2017-12-20 17:18:=
19 +0100)
>
> ----------------------------------------------------------------
> * NBD and chardev conversion to QIONetListener (Daniel)
> * MTTCG fixes (David)
> * Hyper-V fixes (Roman, Evgeny)
> * share-rw option (Fam)
> * Mux chardev event bugfix (Marc-Andr=C3=A9)
> * Add systemd unit files in contrib/ (me)
> * SCSI and block/iscsi.c bugfixes (me, Peter L.)
> * unassigned_mem_ops fixes (Peter M.)
> * VEX decoding fix (Peter M.)
> * "info pic" and "info irq" improvements (Peter Xu)
> * vmport trace events (Philippe)
> * Braille chardev bugfix (Samuel)
> * Compiler warnings fix (Stefan)
> * boot-serial-test aka TCG smoke test (Thomas)
> * New CPU features (Yang)
> * Reduce startup memory usage (Yang)
> * QemuThread race fix (linhecheng)

Build failures, I'm afraid:

NetBSD, FreeBSD, OpenBSD, OSX:

  CC      util/qemu-thread-posix.o
/root/qemu/util/qemu-thread-posix.c: In function 'qemu_thread_create':
/root/qemu/util/qemu-thread-posix.c:513:5: error: unknown type name
'QemuThreadArgs'
     QemuThreadArgs *qemu_thread_args;
     ^
/root/qemu/util/qemu-thread-posix.c:513:21: warning: unused variable
'qemu_thread_args' [-Wunused-variable]
     QemuThreadArgs *qemu_thread_args;
                     ^

On the x86/sanitizer build, new runtime errors:
  GTESTER tests/test-char
/home/petmay01/linaro/qemu-for-merges/chardev/char-mux.c:119:23:
runtime error: index -1 out of bounds for type 'CharBackend *[4]'

  GTESTER check-qtest-m68k
/home/petmay01/linaro/qemu-for-merges/target/m68k/translate.c:230:12:
runtime error: index -1 out of bounds for type 'const uint8_t [11]'

and a bunch of test-hmp failures on SPARC host:

TEST: tests/test-hmp... (pid=3D112458)
  /or1k/hmp/none:                                                      OK
  /or1k/hmp/or1k-sim:
Broken pipe
FAIL
GTester: last random seed: R02S910131160952686f50f8817feb7ffa43
(pid=3D112640)
  /or1k/hmp/none+2MB:                                                  OK
FAIL: tests/test-hmp


TEST: tests/test-hmp... (pid=3D112535)
  /lm32/hmp/lm32-evr:                                                  OK
  /lm32/hmp/none:                                                      OK
  /lm32/hmp/milkymist:                                                 OK
  /lm32/hmp/lm32-uclinux:
Broken pipe
FAIL
GTester: last random seed: R02S8117b2f6f2c32eedeb45726a96bd3248
(pid=3D112826)
  /lm32/hmp/none+2MB:                                                  OK
FAIL: tests/test-hmp

...and similar fails on one or two boards on most of the other
guest architectures.

I think sparc is the only test box I run 'make check' with -j32,
so that might be the cause there. Running the test case by
hand passes, but -j32 reliably fails.

thanks
-- PMM
