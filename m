Received: from eggs.gnu.org ([2001:4830:134:3::10]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fB4Hk-0003Ao-3n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 16:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fB4Hg-0008TF-S8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 16:11:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:35106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fB4Hg-0008Sz-Ky
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 16:11:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fB4Hc-00069R-5n
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:11:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 700F42E80DC
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Apr 2018 19:59:56 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <1763536@bugs.launchpad.net>
Reply-To: Bug 1763536 <1763536@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152357545161.20027.863482450235173908.malonedeb@gac.canonical.com>
Message-Id: <152459999650.709.9958492196435711904.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1763536] Re: go build fails under
 qemu-ppc64le-static (qemu-user)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With QEMU from tag v2.12.0-rc4 on Fedora 27 x86_64, it works too.

muriloo@laptop$ docker run --rm -it qemutest
/go # qemu-ppc64le-static --version
qemu-ppc64le version 2.11.94 (v2.12.0-rc4)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
/go # go version
go version go1.10.1 linux/ppc64le
/go # go build hello.go
/go # ./hello
hello world
/go #

muriloo@laptop$ uname -a
Linux laptop 4.15.17-300.fc27.x86_64 #1 SMP Thu Apr 12 18:19:17 UTC 2018 x8=
6_64 x86_64 x86_64 GNU/Linux

muriloo@laptop$ rpm -q docker
docker-1.13.1-51.git4032bd5.fc27.x86_64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1763536

Title:
  go build fails under qemu-ppc64le-static (qemu-user)

Status in QEMU:
  New

Bug description:
  I am using qemu-user (built static) in a docker container environment.
  When running multi-threaded go commands in the container (go build for
  example) the process may hang, report segfaults or other errors.  I
  built qemu-ppc64le from the upstream git (master).

  I see the problem running on a multi core system with Intel i7 processors.
  # cat /proc/cpuinfo | grep "model name"
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
  model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz

  Steps to reproduce:
  1) Build qemu-ppc64le as static and copy into docker build directory name=
d it qemu-ppc64le-static.

  2) Add hello.go to docker build dir.

  package main
  import "fmt"
  func main() {
  	fmt.Println("hello world")
  }

  3) Create the Dockerfile from below:

  FROM ppc64le/golang:1.10.1-alpine3.
  COPY qemu-ppc64le-static /usr/bin/
  COPY hello.go /go

  4) Build container
  $ docker build -t qemutest -f Dockerfile ./go =


  5) Run test
  $ docker run -it qemutest

  /go # /usr/bin/qemu-ppc64le-static --version
  qemu-ppc64le version 2.11.93 (v2.12.0-rc3-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  /go # go version
  go version go1.10.1 linux/ppc64le

  /go # go build hello.go
  fatal error: fatal error: stopm holding locksunexpected signal during run=
time execution

  panic during panic
  [signal SIGSEGV: segmentation violation code=3D0x1 addr=3D0x0 pc=3D0x1003=
528c]

  runtime stack:
  runtime: unexpected return pc for syscall.Syscall6 called from 0xc42007f5=
00
  stack: frame=3D{sp:0xc4203be840, fp:0xc4203be860} stack=3D[0x4000b7ecf0,0=
x4000b928f0)

  syscall.Syscall6(0x100744e8, 0x3d, 0xc42050c140, 0x20, 0x18, 0x10422b80, =
0xc4203be968[signal , 0x10012d88SIGSEGV: segmentation violation, 0xc4205940=
00 code=3D, 0x00x1 addr=3D0x0 pc=3D0x1003528c)
  ]

  runtime stack:
  	/usr/local/go/src/syscall/asm_linux_ppc64x.s:61runtime.throw(0x10472d19,=
 0x13)
   +	/usr/local/go/src/runtime/panic.go:0x6c616 +0x68

  =

  runtime.stopm()
  	/usr/local/go/src/runtime/proc.go:1939goroutine  +10x158
   [runtime.exitsyscall0semacquire(0xc42007f500)
  	/usr/local/go/src/runtime/proc.go:3129 +]:
  0x130
  runtime.mcall(0xc42007f500)
  	/usr/local/go/src/runtime/asm_ppc64x.s:183 +0x58sync.runtime_Semacquire
  (0xc4201fab1c)
  	/usr/local/go/src/runtime/sema.go:56 +0x38

  ----
  Note the results may differ between attempts,  hangs and other faults som=
etimes happen.
  ----
  If I run "go: single threaded I don't see the problem, for example:

  /go # GOMAXPROCS=3D1 go build -p 1 hello.go =

  /go # ./hello
  hello world

  I see the same issue with arm64.  I don't think this is a go issue,
  but don't have a real evidence to prove that.  This problem looks
  similar to other problem I have seen reported against qemu running
  multi-threaded applications.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1763536/+subscriptions
