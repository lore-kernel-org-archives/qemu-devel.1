Received: from eggs.gnu.org ([2001:4830:134:3::10]:52542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edZPV-0007q7-3v
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edZPU-0007Mc-3j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:33:05 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:46291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edZPT-0007ME-TA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:33:04 -0500
Received: by mail-oi0-x235.google.com with SMTP id d124so5574242oib.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 02:33:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516392192-6491-1-git-send-email-jcmvbkbc@gmail.com>
References: <1516392192-6491-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 10:32:42 +0000
Message-ID: <CAFEAcA-r9uO9kUMJ7zztpwFsOqByaKmH-cv8kG_76KcuF9QBpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2018 at 20:03, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
>
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180119-xtensa
>
> for you to fetch changes up to 8030ed759be52b2517356c3d0291c45cedc65fd9:
>
>   target/xtensa: disas/xtensa: fix coverity warnings (2018-01-18 10:27:04 -0800)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - make mini-bootloader independent of the initial CPU state;
> - add noMMU XTFPGA variants;
> - add two noMMU cores: de212 and sample_controller;
> - fix issues reported by coverity against xtensa translator and disassembler.
>
> ----------------------------------------------------------------

This merge fails make check (all hosts):

QTEST_QEMU_BINARY=xtensaeb-softmmu/qemu-system-xtensaeb
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick
tests/qmp-test tests/device-introspect-test tests/qom-test
tests/test-hmp
[...]

TEST: tests/qom-test... (pid=28150)
  /xtensaeb/qom/lx60:                                                  OK
  /xtensaeb/qom/ml605:                                                 OK
  /xtensaeb/qom/kc705:                                                 OK
  /xtensaeb/qom/lx60-nommu:                                            **
ERROR:/home/peter.maydell/qemu/qom/object.c:488:object_new_with_type:
assertion failed: (type != NULL)
Broken pipe
FAIL
GTester: last random seed: R02S503ca4c02ea3c0d048fa6ddad7f72d6b
(pid=28164)
  /xtensaeb/qom/lx200:                                                 OK
  /xtensaeb/qom/none:                                                  OK
  /xtensaeb/qom/lx200-nommu:                                           **
ERROR:/home/peter.maydell/qemu/qom/object.c:488:object_new_with_type:
assertion failed: (type != NULL)
Broken pipe
FAIL
GTester: last random seed: R02S354e3434cb9a78bcc813c3a564053150
(pid=28174)
  /xtensaeb/qom/ml605-nommu:                                           **
ERROR:/home/peter.maydell/qemu/qom/object.c:488:object_new_with_type:
assertion failed: (type != NULL)
Broken pipe
FAIL
GTester: last random seed: R02S15ab1f19833d9f4724ff6a760af17841
(pid=28179)
  /xtensaeb/qom/sim:                                                   OK
  /xtensaeb/qom/kc705-nommu:                                           **
ERROR:/home/peter.maydell/qemu/qom/object.c:488:object_new_with_type:
assertion failed: (type != NULL)
Broken pipe
FAIL
GTester: last random seed: R02Sfbce6559af977ed9aaa201d5f8525f99
(pid=28187)
FAIL: tests/qom-test

All the -nommu machines seem to fail qom-test with this assertion.
(Possibly the just-applied machine.next pullreq included something
that means your queue needs fixes?)

thanks
-- PMM
