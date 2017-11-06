Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7Q-000174-5r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7N-0004v1-7W
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBn7N-0004uW-1T
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBn7J-0007TC-3V
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:31:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C56A52E81B8
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:25:12 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1696353 <1696353@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149682692221.8383.2186201709283317126.malonedeb@gac.canonical.com>
Message-Id: <150999631231.3874.3767631805193375598.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696353] Re: golang binaries fail to start under
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since this has been fixed/worked around on the go side (thanks for
following up with that!) I'm going to close this as "wontfix" on QEMU's
side. It would be nice to support clone() with non-standard flags but
since we can't do that while we still link with libc there's no way we
can do this without a massive (and massively painful!) redesign to
remove our libc dependency so that all of QEMU's linux-user code runs
bare on the kernel.


** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696353

Title:
  golang binaries fail to start under linux-user

Status in QEMU:
  Won't Fix

Bug description:
  With current master golang binaries fail when run under linux-user,
  for example:

  [will@localhost qemu]$ ./arm-linux-user/qemu-arm glide =

  runtime: failed to create new OS thread (have 2 already; errno=3D22)
  fatal error: newosproc

  runtime stack:
  runtime.throw(0x45f879, 0x9)
  	/usr/lib/golang/src/runtime/panic.go:566 +0x78
  runtime.newosproc(0x1092c000, 0x1093bfe0)
  	/usr/lib/golang/src/runtime/os_linux.go:160 +0x1b0
  runtime.newm(0x4ae1e8, 0x0)
  	/usr/lib/golang/src/runtime/proc.go:1572 +0x12c
  runtime.main.func1()
  	/usr/lib/golang/src/runtime/proc.go:126 +0x24
  runtime.systemstack(0x5ef900)
  	/usr/lib/golang/src/runtime/asm_arm.s:247 +0x80
  runtime.mstart()
  	/usr/lib/golang/src/runtime/proc.go:1079

  goroutine 1 [running]:
  runtime.systemstack_switch()
  	/usr/lib/golang/src/runtime/asm_arm.s:192 +0x4 fp=3D0x109287ac sp=3D0x10=
9287a8
  runtime.main()
  	/usr/lib/golang/src/runtime/proc.go:127 +0x5c fp=3D0x109287d4 sp=3D0x109=
287ac
  runtime.goexit()
  	/usr/lib/golang/src/runtime/asm_arm.s:998 +0x4 fp=3D0x109287d4 sp=3D0x10=
9287d4

  The reason for this is that the golang runtime does not pass the
  CLONE_SYSVMEM flag to clone so the clone flags checks fail:

  https://github.com/golang/go/blob/master/src/runtime/os_linux.go#L155

  The attached patch allows golang binaries to start under linux-user.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696353/+subscriptions
