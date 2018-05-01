Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDcY5-0005uW-Sj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDcY3-0000dw-8C
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:10:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:38032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fDcY3-0000dX-29
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:10:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fDcY1-0006kR-VZ
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 21:10:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED81D2E80C9
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 21:10:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 May 2018 21:04:44 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
	<87fu3b9ytz.fsf@linaro.org>
Message-Id: <62e7854a-d325-2a06-8296-04ae500a9c41@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1768246] [NEW] cpu-exec.c:648:
 cpu_loop_exec_tb: Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 05/01/2018 05:31 PM, Alex Benn=C3=A9e wrote:
>> Haven't bi-sected the issue yet, but will do so later.
> =

> Hmm that's ominous - arguably the assert should be inside the
> CONFIG_USER but I'm not sure how you get to the point where icount isn't
> < 0 after receiving a TB_EXIT_REQUESTED.

git bisect yielded this:

4834871bc95b67343248100e2a75ae0d287bc08b is the first bad commit
commit 4834871bc95b67343248100e2a75ae0d287bc08b
Author: Richard Henderson <rth@twiddle.net>
Date:   Thu Sep 7 11:50:54 2017 -0700

    target/sh4: Convert to DisasJumpType

    Signed-off-by: Richard Henderson <rth@twiddle.net>
    Message-Id: <20170907185057.23421-3-richard.henderson@linaro.org>
    [aurel32: fix whitespace]
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

:040000 040000 6e0e67cc5d0eb5ef461510d314c6af43eecc08bb
aa3399c893c49e6fafda157181cf10f8fbcd0a72 M      target

-- =

 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  New

Bug description:
  OpenJDK no longer works on qemu-sh4, it previously did after #1735384
  was fixed.

  Crash indicates an assertion failure:

  (sid-sh4-sbuild)root@nofan:/# java --version
  qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:648: cpu_loop_exec_tb: A=
ssertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  (sid-sh4-sbuild)root@nofan:/#

  Haven't bi-sected the issue yet, but will do so later.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1768246/+subscriptions
