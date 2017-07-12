Received: from eggs.gnu.org ([2001:4830:134:3::10]:50761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV7ex-0001qC-5h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 22:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV7es-00022J-D8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 22:45:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV7es-00021i-4f
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 22:45:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV7ep-0000VO-Pv
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BD53D2E80E8
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jul 2017 02:33:31 -0000
From: Nick Craig-Wood <nick@craig-wood.com>
Reply-To: Bug 1696353 <1696353@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149682692221.8383.2186201709283317126.malonedeb@gac.canonical.com>
Message-Id: <149982681198.6717.13847187240890640368.malone@gac.canonical.com>
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

You can also apply this patch to go - I don't have an opinion on the
correct course of action though!

diff --git a/src/runtime/os_linux.go b/src/runtime/os_linux.go
index a6efc0e3d1..64218e3f7e 100644
--- a/src/runtime/os_linux.go
+++ b/src/runtime/os_linux.go
@@ -132,7 +132,8 @@ const (
 		_CLONE_FS | /* share cwd, etc */
 		_CLONE_FILES | /* share fd table */
 		_CLONE_SIGHAND | /* share sig handler table */
-		_CLONE_THREAD /* revisit - okay for now */
+		_CLONE_THREAD | /* revisit - okay for now */
+		_CLONE_SYSVSEM
 )
 =

 //go:noescape


** Bug watch added: github.com/golang/go/issues #20763
   https://github.com/golang/go/issues/20763

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696353

Title:
  golang binaries fail to start under linux-user

Status in QEMU:
  New

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
